Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E686C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB4D20872
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 10:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbfIYKJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 06:09:30 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39274 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfIYKJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 06:09:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CCC431A0824;
        Wed, 25 Sep 2019 12:09:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B6C71A00DD;
        Wed, 25 Sep 2019 12:09:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 2FE40402ED;
        Wed, 25 Sep 2019 18:09:18 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] firmware: imx: Skip return value check for some special SCU firmware APIs
Date:   Wed, 25 Sep 2019 18:07:46 +0800
Message-Id: <1569406066-16626-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCU firmware does NOT always have return value stored in message
header's function element even the API has response data, those special
APIs are defined as void function in SCU firmware, so they should be
treated as return success always.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
	- This patch is based on the patch of https://patchwork.kernel.org/patch/11129553/
---
 drivers/firmware/imx/imx-scu.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 869be7a..ced5b12 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -78,6 +78,11 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] = {
 	-EIO,	 /* IMX_SC_ERR_FAIL */
 };
 
+static const struct imx_sc_rpc_msg whitelist[] = {
+	{ .svc = IMX_SC_RPC_SVC_MISC, .func = IMX_SC_MISC_FUNC_UNIQUE_ID },
+	{ .svc = IMX_SC_RPC_SVC_MISC, .func = IMX_SC_MISC_FUNC_GET_BUTTON_STATUS },
+};
+
 static struct imx_sc_ipc *imx_sc_ipc_handle;
 
 static inline int imx_sc_to_linux_errno(int errno)
@@ -157,11 +162,24 @@ static int imx_scu_ipc_write(struct imx_sc_ipc *sc_ipc, void *msg)
 	return 0;
 }
 
+static bool imx_scu_call_skip_return_value_check(uint8_t svc, uint8_t func)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(whitelist); i++)
+		if (svc == whitelist[i].svc &&
+			func == whitelist[i].func)
+			return true;
+
+	return false;
+}
+
 /*
  * RPC command/response
  */
 int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 {
+	uint8_t saved_svc, saved_func;
 	struct imx_sc_rpc_msg *hdr;
 	int ret;
 
@@ -171,8 +189,11 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 	mutex_lock(&sc_ipc->lock);
 	reinit_completion(&sc_ipc->done);
 
-	if (have_resp)
+	if (have_resp) {
 		sc_ipc->msg = msg;
+		saved_svc = ((struct imx_sc_rpc_msg *)msg)->svc;
+		saved_func = ((struct imx_sc_rpc_msg *)msg)->func;
+	}
 	sc_ipc->count = 0;
 	ret = imx_scu_ipc_write(sc_ipc, msg);
 	if (ret < 0) {
@@ -190,7 +211,16 @@ int imx_scu_call_rpc(struct imx_sc_ipc *sc_ipc, void *msg, bool have_resp)
 
 		/* response status is stored in hdr->func field */
 		hdr = msg;
-		ret = hdr->func;
+		/*
+		 * Some special SCU firmware APIs do NOT have return value
+		 * in hdr->func, but they do have response data, those special
+		 * APIs are defined as void function in SCU firmware, so they
+		 * should be treated as return success always.
+		 */
+		if (!imx_scu_call_skip_return_value_check(saved_svc, saved_func))
+			ret = hdr->func;
+		else
+			ret = 0;
 	}
 
 out:
-- 
2.7.4

