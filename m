Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E056C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420692339D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 07:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfIDHOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 03:14:12 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47746 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfIDHOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 03:14:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 85BFE1A0063;
        Wed,  4 Sep 2019 09:14:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC30A1A0194;
        Wed,  4 Sep 2019 09:14:05 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 09A5540296;
        Wed,  4 Sep 2019 15:13:59 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, daniel.baluta@nxp.com, aisheng.dong@nxp.com,
        abel.vesa@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] soc: imx: imx-scu: Getting UID from SCU should have response
Date:   Wed,  4 Sep 2019 15:13:14 -0400
Message-Id: <1567624394-25023-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCU firmware API for getting UID should have response,
otherwise, the message stored in function stack could be
released and then the response data received from SCU will be
stored into that released stack and cause kernel NULL pointer
dump.

Fixes: 73feb4d0f8f1 ("soc: imx-scu: Add SoC UID(unique identifier) support")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/soc/imx/soc-imx-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/imx/soc-imx-scu.c b/drivers/soc/imx/soc-imx-scu.c
index 50831eb..c68882e 100644
--- a/drivers/soc/imx/soc-imx-scu.c
+++ b/drivers/soc/imx/soc-imx-scu.c
@@ -46,7 +46,7 @@ static ssize_t soc_uid_show(struct device *dev,
 	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
 	hdr->size = 1;
 
-	ret = imx_scu_call_rpc(soc_ipc_handle, &msg, false);
+	ret = imx_scu_call_rpc(soc_ipc_handle, &msg, true);
 	if (ret) {
 		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
 		return ret;
-- 
2.7.4

