Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE40BC606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB1C20665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391336AbfGHPrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:47:52 -0400
Received: from foss.arm.com ([217.140.110.172]:52386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391308AbfGHPrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:47:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABE591509;
        Mon,  8 Jul 2019 08:47:48 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A948A3F59C;
        Mon,  8 Jul 2019 08:47:47 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: [PATCH 06/11] firmware: arm_scmi: Add mechanism to unpack message headers
Date:   Mon,  8 Jul 2019 16:47:25 +0100
Message-Id: <20190708154730.16643-7-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708154730.16643-1-sudeep.holla@arm.com>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
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
index eb5a2f271806..b384c818d8dd 100644
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
@@ -216,6 +222,18 @@ static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
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

