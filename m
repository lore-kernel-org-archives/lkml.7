Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD3BC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E149B208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 15:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bhhLkqXD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfE1PzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 11:55:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:42472 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfE1PzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 11:55:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4SFtFge103342;
        Tue, 28 May 2019 10:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1559058915;
        bh=+NgYfxUsl+/S1qBjCgofRs3wWPj5l2N7wsBxQgsNdh8=;
        h=From:To:CC:Subject:Date;
        b=bhhLkqXDojiv/vFxEahn9B1grt68m0378psEQ2SWRcICH4ErnHfxNLQusS7mH9HX0
         tTDLCAz++xtfRtrtTTJZXVl5217Xfapr2ODUBHJ4pj3Z/sLE48NGSdtlTIZaZ3RHCl
         bFRLr3Yrj3KWN3wjiZy+9wLwERfpxwC7YK3mJ3tg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4SFtFf7017420
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 May 2019 10:55:15 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 28
 May 2019 10:55:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 28 May 2019 10:55:15 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4SFtFKB023447;
        Tue, 28 May 2019 10:55:15 -0500
Received: from localhost ([10.250.196.255])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id x4SFtDm06242;
        Tue, 28 May 2019 10:55:13 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH v2] firmware: ti_sci: Always request response from firmware
Date:   Tue, 28 May 2019 11:55:10 -0400
Message-ID: <20190528155510.373-1-afd@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TI-SCI firmware will only respond to messages when the
TI_SCI_FLAG_REQ_ACK_ON_PROCESSED flag is set. Most messages already do
this, set this for the ones that do not.

This will be enforced in future firmware that better match the TI-SCI
specifications, this patch will not break users of existing firmware.

Fixes: aa276781a64a ("firmware: Add basic support for TI System Control Interface (TI-SCI) protocol")
Signed-off-by: Andrew F. Davis <afd@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
Tested-by: Alejandro Hernandez <ajhernandez@ti.com>
---

Changes from v1:
 - Rebased on v5.2-rc2

 drivers/firmware/ti_sci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index ef93406ace1b..36ce11a67235 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -466,9 +466,9 @@ static int ti_sci_cmd_get_revision(struct ti_sci_info *info)
 	struct ti_sci_xfer *xfer;
 	int ret;
 
-	/* No need to setup flags since it is expected to respond */
 	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_VERSION,
-				   0x0, sizeof(struct ti_sci_msg_hdr),
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(struct ti_sci_msg_hdr),
 				   sizeof(*rev_info));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
@@ -596,9 +596,9 @@ static int ti_sci_get_device_state(const struct ti_sci_handle *handle,
 	info = handle_to_ti_sci_info(handle);
 	dev = info->dev;
 
-	/* Response is expected, so need of any flags */
 	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_GET_DEVICE_STATE,
-				   0, sizeof(*req), sizeof(*resp));
+				   TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				   sizeof(*req), sizeof(*resp));
 	if (IS_ERR(xfer)) {
 		ret = PTR_ERR(xfer);
 		dev_err(dev, "Message alloc failed(%d)\n", ret);
-- 
2.17.1

