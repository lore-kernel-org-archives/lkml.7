Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933AAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7647B2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 03:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfHEDOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 23:14:20 -0400
Received: from inva021.nxp.com ([92.121.34.21]:53928 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726765AbfHEDOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 23:14:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9BA032001B1;
        Mon,  5 Aug 2019 05:14:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 389702001C7;
        Mon,  5 Aug 2019 05:14:13 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 84111402DD;
        Mon,  5 Aug 2019 11:14:07 +0800 (SGT)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        daniel.baluta@nxp.com, aisheng.dong@nxp.com
Cc:     linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 2/4] mailbox: imx: Clear the right interrupts at shutdown
Date:   Mon,  5 Aug 2019 10:51:29 +0800
Message-Id: <1564973491-18286-3-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564973491-18286-1-git-send-email-hongxing.zhu@nxp.com>
References: <1564973491-18286-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to only clear enabled interrupts keeping count
of the connection type.

Suggested-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/mailbox/imx-mailbox.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index 1eeabc5..afe625e 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -219,8 +219,19 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
 		return;
 	}
 
-	imx_mu_xcr_rmw(priv, 0,
-		   IMX_MU_xCR_TIEn(cp->idx) | IMX_MU_xCR_RIEn(cp->idx));
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_TIEn(cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_RIEn(cp->idx));
+		break;
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_GIEn(cp->idx));
+		break;
+	default:
+		break;
+	}
 
 	free_irq(priv->irq, chan);
 }
-- 
2.7.4

