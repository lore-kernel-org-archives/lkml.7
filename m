Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2213C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869F72054F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569180466;
	bh=iupxWFpcY6/cgaLlrAWuYCcnrImMYlOV5CQiGwgF2WE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zOE9zYuY2olHFNzr40QIvzzpvR1CYOgeibK+/fdvQ4R0T3jEdBOhpJYT/F/DBAZd3
	 8+zGW5YQv3QhQArAfDpqW0LPGix9u+hbG7z+bMQCIn0OGmA002cB5FDwIjGHlq/rP4
	 Dlta772On685AsfWD5qeZ90LTYdpdo00GnznJChw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404840AbfIVT1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729178AbfIVSvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:51:07 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6144B21D79;
        Sun, 22 Sep 2019 18:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178267;
        bh=iupxWFpcY6/cgaLlrAWuYCcnrImMYlOV5CQiGwgF2WE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o3PTa4Sx/xDtZJQp95sKECAcRfeuvF/J0Sf0VzxeY266bighM+nsMCOpefuZyOJ/b
         exJHBc/oovFDUH+xayMtt3Fc4U7psOO4eSdc04ibp93iA+p61YlA5pWXixJkArIbXj
         xH5xCEuylzPD8KAamabfkJCU7ye8VVUvKfGnb30M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.2 054/185] firmware: arm_scmi: Check if platform has released shmem before using
Date:   Sun, 22 Sep 2019 14:47:12 -0400
Message-Id: <20190922184924.32534-54-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922184924.32534-1-sashal@kernel.org>
References: <20190922184924.32534-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 9dc34d635c67e57051853855c43249408641a5ab ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/driver.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index b5bc4c7a8fab2..b49c9e6f4bf10 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -271,6 +271,14 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
 	struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
 	struct scmi_shared_mem __iomem *mem = cinfo->payload;
 
+	/*
+	 * Ideally channel must be free by now unless OS timeout last
+	 * request and platform continued to process the same, wait
+	 * until it releases the shared memory, otherwise we may endup
+	 * overwriting its response with new message payload or vice-versa
+	 */
+	spin_until_cond(ioread32(&mem->channel_status) &
+			SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE);
 	/* Mark channel busy + clear error */
 	iowrite32(0x0, &mem->channel_status);
 	iowrite32(t->hdr.poll_completion ? 0 : SCMI_SHMEM_FLAG_INTR_ENABLED,
-- 
2.20.1

