Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6630BC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A3AB22CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388518AbfGZNwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:52:00 -0400
Received: from foss.arm.com ([217.140.110.172]:44494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbfGZNvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:51:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39BC615A2;
        Fri, 26 Jul 2019 06:51:54 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 01ABC3F694;
        Fri, 26 Jul 2019 06:51:52 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 05/10] firmware: arm_scmi: Add mechanism to unpack message headers
Date:   Fri, 26 Jul 2019 14:51:33 +0100
Message-Id: <20190726135138.9858-6-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726135138.9858-1-sudeep.holla@arm.com>
References: <20190726135138.9858-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to identify the message type when a response arrives, we need
a mechanism to unpack the message header similar to packing. Let's
add one.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 97618220ea02..9a670918b050 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -30,8 +30,14 @@
 #include "common.h"
 
 #define MSG_ID_MASK		GENMASK(7, 0)
+#define MSG_XTRACT_ID(hdr)	FIELD_GET(MSG_ID_MASK, (hdr))
 #define MSG_TYPE_MASK		GENMASK(9, 8)
+#define MSG_XTRACT_TYPE(hdr)	FIELD_GET(MSG_TYPE_MASK, (hdr))
+#define MSG_TYPE_COMMAND	0
+#define MSG_TYPE_DELAYED_RESP	2
+#define MSG_TYPE_NOTIFICATION	3
 #define MSG_PROTOCOL_ID_MASK	GENMASK(17, 10)
+#define MSG_XTRACT_PROT_ID(hdr)	FIELD_GET(MSG_PROTOCOL_ID_MASK, (hdr))
 #define MSG_TOKEN_ID_MASK	GENMASK(27, 18)
 #define MSG_XTRACT_TOKEN(hdr)	FIELD_GET(MSG_TOKEN_ID_MASK, (hdr))
 #define MSG_TOKEN_MAX		(MSG_XTRACT_TOKEN(MSG_TOKEN_ID_MASK) + 1)
@@ -214,6 +220,18 @@ static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 		FIELD_PREP(MSG_PROTOCOL_ID_MASK, hdr->protocol_id);
 }
 
+/**
+ * unpack_scmi_header() - unpacks and records message and protocol id
+ *
+ * @msg_hdr: 32-bit packed message header sent from the platform
+ * @hdr: pointer to header to fetch message and protocol id.
+ */
+static inline void unpack_scmi_header(u32 msg_hdr, struct scmi_msg_hdr *hdr)
+{
+	hdr->id = MSG_XTRACT_ID(msg_hdr);
+	hdr->protocol_id = MSG_XTRACT_PROT_ID(msg_hdr);
+}
+
 /**
  * scmi_tx_prepare() - mailbox client callback to prepare for the transfer
  *
-- 
2.17.1

