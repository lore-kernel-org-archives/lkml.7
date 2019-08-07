Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0946C32754
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 04:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FE421743
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 04:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfHGENJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 00:13:09 -0400
Received: from inva021.nxp.com ([92.121.34.21]:59956 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfHGENI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 00:13:08 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4D1E2200064;
        Wed,  7 Aug 2019 06:13:06 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CC4D92001EF;
        Wed,  7 Aug 2019 06:13:00 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id C6FEB402B5;
        Wed,  7 Aug 2019 12:12:53 +0800 (SGT)
From:   fugang.duan@nxp.com
To:     srinivas.kandagatla@linaro.org
Cc:     robh@kernel.org, mark.rutland@arm.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, fugang.duan@nxp.com, kernel@pengutronix.de,
        gregkh@linuxfoundation.org, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH nvmem v2 1/2] nvmem: imx: add i.MX8QM platform support
Date:   Wed,  7 Aug 2019 12:03:19 +0800
Message-Id: <20190807040320.1760-2-fugang.duan@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190807040320.1760-1-fugang.duan@nxp.com>
References: <20190807040320.1760-1-fugang.duan@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fugang Duan <fugang.duan@nxp.com>

i.MX8QM efuse table has some difference with i.MX8QXP platform,
so add i.MX8QM platform support.

Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
---
 drivers/nvmem/imx-ocotp-scu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvmem/imx-ocotp-scu.c b/drivers/nvmem/imx-ocotp-scu.c
index be2f5f0..0d78ab4 100644
--- a/drivers/nvmem/imx-ocotp-scu.c
+++ b/drivers/nvmem/imx-ocotp-scu.c
@@ -16,6 +16,7 @@
 
 enum ocotp_devtype {
 	IMX8QXP,
+	IMX8QM,
 };
 
 struct ocotp_devtype_data {
@@ -39,6 +40,11 @@ static struct ocotp_devtype_data imx8qxp_data = {
 	.nregs = 800,
 };
 
+static struct ocotp_devtype_data imx8qm_data = {
+	.devtype = IMX8QM,
+	.nregs = 800,
+};
+
 static int imx_sc_misc_otp_fuse_read(struct imx_sc_ipc *ipc, u32 word,
 				     u32 *val)
 {
@@ -118,6 +124,7 @@ static struct nvmem_config imx_scu_ocotp_nvmem_config = {
 
 static const struct of_device_id imx_scu_ocotp_dt_ids[] = {
 	{ .compatible = "fsl,imx8qxp-scu-ocotp", (void *)&imx8qxp_data },
+	{ .compatible = "fsl,imx8qm-scu-ocotp", (void *)&imx8qm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, imx_scu_ocotp_dt_ids);
-- 
2.7.4

