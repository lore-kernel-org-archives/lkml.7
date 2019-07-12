Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89328C742D7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56263208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 20:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFsPT/Cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfGLUnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 16:43:23 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38815 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727921AbfGLUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 16:43:22 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so23260565ioa.5;
        Fri, 12 Jul 2019 13:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0YO9X8JrVMhxS3C8ry3P1NpNE6uCJVJpb/vpFCRQayg=;
        b=YFsPT/CbCO1LYM1qhpMoKr6yhOs70HOyZxWiAG04T809bxgw3U/rSVm6+OJCWo3/cW
         Nu8hPOb34VukBWTpMKr3Mg4MG2b48byWj4eT6FSODq0k3+HJnV/YX3oDjoaAMnPdvcs0
         PW+Iiq/XxaJHg0n5CZbLmrhMYGel/fLkar8lRQiWprQlMZnpnoAN6VU3FRxAuM2yNYIZ
         X74+KB5GrKTBV1HI3OWGXUsirgVu+flnGc4YnMZZTCFd+U6nIkwedcf08xS0TSS1eB13
         5BSmF77HrzE/1Bq+SVi5h3Iqw0qViCMn/JsnWiQwhgr7fdTCc+nPbVbqFYrtnWnZ2Up/
         an1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0YO9X8JrVMhxS3C8ry3P1NpNE6uCJVJpb/vpFCRQayg=;
        b=DwxUpn+R6XU7ZFJ7N3gu06F/pS7Ck+Ticy/9Dz0XnwIuYoQTrGNStDD/w6q5o8Q+oH
         /5F1AMZmqRzvC/KoUIjt7Bz1XX7Y/Nsk2HQ9zCW11kpCOujasedqEjVxp54LFhXfrP68
         S22Wd+u1TyBQSYlwTAeJ5lNJ984P+CV8ln/k4o82HGQLkENU2yZVbfJln0Zg985GSyoW
         3DErYgWjKWW+fV3c/3AfIal+81CfX3UH+c4ri0S+Vr1Ac9R3k2qFoii/d1TTN3D2uTdf
         CiCN1q23fQBZmcJaiun9LlwzVooeqU4+8iK5jW2sftyRaRhEft89zc3Y1Q5gbShmlOfU
         3ARQ==
X-Gm-Message-State: APjAAAVNgUmKYMIuVim9zIdUF3E6Y27bodOLkJvbZDFGxkUasNgQU1JM
        R1XihyCOSyq0FV/TM5SD40c=
X-Google-Smtp-Source: APXvYqxL6GxakGiydUYH7NlDpEoU/Uu55hmMkr19MRFB1ktpzJaP36AAZU5i0ateJw4T+t+kQFk8tg==
X-Received: by 2002:a5d:8702:: with SMTP id u2mr13323425iom.228.1562964201758;
        Fri, 12 Jul 2019 13:43:21 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id l14sm9725013iob.1.2019.07.12.13.43.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 13:43:21 -0700 (PDT)
From:   Sven Van Asbroeck <thesven73@gmail.com>
X-Google-Original-From: Sven Van Asbroeck <TheSven73@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/2] bus: imx-weim: optionally enable burst clock mode
Date:   Fri, 12 Jul 2019 16:43:15 -0400
Message-Id: <20190712204316.16783-1-TheSven73@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable burst clock mode, add the fsl,burst-clk-enable
property to the weim bus's devicetree node.

Example:
weim: weim@21b8000 {
	compatible = "fsl,imx6q-weim";
	reg = <0x021b8000 0x4000>;
	clocks = <&clks 196>;
	#address-cells = <2>;
	#size-cells = <1>;
	ranges = <0 0 0x08000000 0x08000000>;
	fsl,weim-cs-gpr = <&gpr>;
	fsl,burst-clk-enable;

	client-device@0,0 {
		compatible = "something";
		reg = <0 0 0x02000000>;
		#address-cells = <1>;
		#size-cells = <1>;
		bank-width = <2>;
		fsl,weim-cs-timing = <0x00620081 0x00000001 0x1c022000
				0x0000c000 0x1404a38e 0x00000000>;
	};
};

Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
---
 drivers/bus/imx-weim.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/bus/imx-weim.c b/drivers/bus/imx-weim.c
index db74334ca5ef..cb7d5504a22a 100644
--- a/drivers/bus/imx-weim.c
+++ b/drivers/bus/imx-weim.c
@@ -19,6 +19,8 @@ struct imx_weim_devtype {
 	unsigned int	cs_count;
 	unsigned int	cs_regs_count;
 	unsigned int	cs_stride;
+	unsigned int	wcr_offset;
+	unsigned int	wcr_bcm;
 };
 
 static const struct imx_weim_devtype imx1_weim_devtype = {
@@ -37,6 +39,8 @@ static const struct imx_weim_devtype imx50_weim_devtype = {
 	.cs_count	= 4,
 	.cs_regs_count	= 6,
 	.cs_stride	= 0x18,
+	.wcr_offset	= 0x90,
+	.wcr_bcm	= BIT(0),
 };
 
 static const struct imx_weim_devtype imx51_weim_devtype = {
@@ -192,6 +196,7 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 	struct device_node *child;
 	int ret, have_child = 0;
 	struct cs_timing_state ts = {};
+	u32 reg;
 
 	if (devtype == &imx50_weim_devtype) {
 		ret = imx_weim_gpr_setup(pdev);
@@ -199,6 +204,17 @@ static int __init weim_parse_dt(struct platform_device *pdev,
 			return ret;
 	}
 
+	if (of_property_read_bool(pdev->dev.of_node, "fsl,burst-clk-enable")) {
+		if (devtype->wcr_bcm) {
+			reg = readl(base + devtype->wcr_offset);
+			writel(reg | devtype->wcr_bcm,
+				base + devtype->wcr_offset);
+		} else {
+			dev_err(&pdev->dev, "burst clk mode not supported.\n");
+			return -EINVAL;
+		}
+	}
+
 	for_each_available_child_of_node(pdev->dev.of_node, child) {
 		ret = weim_timing_setup(&pdev->dev, child, base, devtype, &ts);
 		if (ret)
-- 
2.17.1

