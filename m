Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A029C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EA52086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 15:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbfIIPVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 11:21:38 -0400
Received: from foss.arm.com ([217.140.110.172]:52526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbfIIPVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 11:21:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48A44169E;
        Mon,  9 Sep 2019 08:21:37 -0700 (PDT)
Received: from usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0DEAC3F59C;
        Mon,  9 Sep 2019 08:21:35 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        Etienne Carriere <etienne.carriere@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH -next] firmware: arm_scmi: reset: fix reset_state assignment in scmi_domain_reset
Date:   Mon,  9 Sep 2019 16:21:30 +0100
Message-Id: <20190909152130.5021-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the copy paste typo that incorrectly assigns domain_id with the
passed 'state' parameter instead of reset_state.

Fixes: 95a15d80aa0d ("firmware: arm_scmi: Add RESET protocol in SCMI v2.0")
Reported-by: Etienne Carriere <etienne.carriere@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 64cc81915581..ab42c21c5517 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -150,7 +150,7 @@ static int scmi_domain_reset(const struct scmi_handle *handle, u32 domain,
 	dom = t->tx.buf;
 	dom->domain_id = cpu_to_le32(domain);
 	dom->flags = cpu_to_le32(flags);
-	dom->domain_id = cpu_to_le32(state);
+	dom->reset_state = cpu_to_le32(state);

 	if (rdom->async_reset)
 		ret = scmi_do_xfer_with_response(handle, t);
--
2.17.1

