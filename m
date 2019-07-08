Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF09C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C98921743
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391234AbfGHPo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:44:28 -0400
Received: from foss.arm.com ([217.140.110.172]:52064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403861AbfGHPoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:44:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50670360;
        Mon,  8 Jul 2019 08:44:14 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D5A23F59C;
        Mon,  8 Jul 2019 08:44:13 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 6/6] firmware: arm_scmi: Check if platform has released shmem before using
Date:   Mon,  8 Jul 2019 16:43:58 +0100
Message-Id: <20190708154358.16227-7-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154358.16227-1-sudeep.holla@arm.com>
References: <20190708154358.16227-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes platfom may take too long to respond to the command and OS
might timeout before platform transfer the ownership of the shared
memory region to the OS with the response.

Since the mailbox channel associated with the channel is freed and new
commands are dispatch on the same channel, OS needs to wait until it
gets back the ownership. If not, either OS may end up overwriting the
platform response for the last command(which is fine as OS timed out
that command) or platform might overwrite the payload for the next
command with the response for the old.

The latter is problematic as platform may end up interpretting the
response as the payload. In order to avoid such race, let's wait until
the OS gets back the ownership before we prepare the shared memory with
the payload for the next command.

Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 69bf85fea967..765573756987 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -265,6 +265,14 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
 	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
 	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
+	/*
+	 * Ideally channel must be free by now unless OS timeout last
+	 * request and platform continued to process the same, wait
+	 * until it releases the shared memory, otherwise we may endup
+	 * overwriting it's response with new command payload or vice-versa
+	 */
+	spin_until_cond(ioread32(&mem->channel_status) &
+			SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 	/* Mark channel busy + clear error */
 	iowrite32(0x0, &mem->channel_status);
 	iowrite32(t->hdr.poll_completion ? 0 : SCMI_SHMEM_FLAG_INTR_ENABLED,
-- 
2.17.1

