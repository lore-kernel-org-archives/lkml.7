Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D2F4C41517
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E39122CED
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388712AbfGZNq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:46:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44078 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388656AbfGZNqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:46:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7671C15BF;
        Fri, 26 Jul 2019 06:46:11 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B7613F694;
        Fri, 26 Jul 2019 06:46:10 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 5/6] firmware: arm_scmi: Use the term 'message' instead of 'command'
Date:   Fri, 26 Jul 2019 14:45:30 +0100
Message-Id: <20190726134531.8928-6-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726134531.8928-1-sudeep.holla@arm.com>
References: <20190726134531.8928-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to adding support for other two types of messages that
SCMI specification mentions, let's replace the term 'command' with the
correct term 'message'.

As per the specification the messages are of 3 types:
commands(synchronous or asynchronous), delayed responses and notifications.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/common.h | 10 +++++-----
 drivers/firmware/arm_scmi/driver.c |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index 44fd4f9404a9..a9eee62c7142 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -48,11 +48,11 @@ struct scmi_msg_resp_prot_version {
 /**
  * struct scmi_msg_hdr - Message(Tx/Rx) header
  *
- * @id: The identifier of the command being sent
- * @protocol_id: The identifier of the protocol used to send @id command
- * @seq: The token to identify the message. when a message/command returns,
- *	the platform returns the whole message header unmodified including
- *	the token
+ * @id: The identifier of the message being sent
+ * @protocol_id: The identifier of the protocol used to send @id message
+ * @seq: The token to identify the message. When a message returns, the
+ *	platform returns the whole message header unmodified including the
+ *	token
  * @status: Status of the transfer once it's complete
  * @poll_completion: Indicate if the transfer needs to be polled for
  *	completion or interrupt mode is used
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index cac255c418b2..69bf85fea967 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -182,7 +182,7 @@ static inline int scmi_to_linux_errno(int errno)
 static inline void scmi_dump_header_dbg(struct device *dev,
 					struct scmi_msg_hdr *hdr)
 {
-	dev_dbg(dev, "Command ID: %x Sequence ID: %x Protocol: %x\n",
+	dev_dbg(dev, "Message ID: %x Sequence ID: %x Protocol: %x\n",
 		hdr->id, hdr->seq, hdr->protocol_id);
 }
 
@@ -241,7 +241,7 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
  * @hdr: pointer to header containing all the information on message id,
  *	protocol id and sequence id.
  *
- * Return: 32-bit packed command header to be sent to the platform.
+ * Return: 32-bit packed message header to be sent to the platform.
  */
 static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 {
@@ -280,7 +280,7 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
  *
  * @handle: Pointer to SCMI entity handle
  *
- * Helper function which is used by various command functions that are
+ * Helper function which is used by various message functions that are
  * exposed to clients of this driver for allocating a message traffic event.
  *
  * This function can sleep depending on pending requests already in the system
-- 
2.17.1

