Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4185C2D0CE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8877206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 12:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jnDiCxSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfL3MAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 07:00:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38907 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3MAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 07:00:50 -0500
Received: by mail-pl1-f195.google.com with SMTP id f20so14551659plj.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Dec 2019 04:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=loK+/2QBNqR4qI1aKCHvxn+umU8QIBnua/KHI6KiyXg=;
        b=jnDiCxSk1c87KihAaXtSKthEobvCB6cNk3t6zBEjYl77hfXDNXqmlmu4IGveLG5F4F
         iy11U7whJDdTG48Kqz2u7IivLRQu8tj1Mr3FQgUXQ0Hx7FE4XSMpFp3MOp1Nwk/zN0t8
         zPPay9PUqOEdJeBD2ztRaSKQGgH6FIguxcvKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=loK+/2QBNqR4qI1aKCHvxn+umU8QIBnua/KHI6KiyXg=;
        b=kINSnQyeOjx7fBkyFcIQaM8xMPruDx+dkIS1i+xEMAgrQvvNJXC8nLjVUajyraQ8FJ
         am8aHgzo+qXzHk0Zo83c0uWeK2GgElyhOd5/UmGLwkIhHgi80nU5HYUEOrX0Ca727EA7
         ZRdHWt1N5U2oH8Yvk+7X17U1lzILAT+XRWTrOz9nA5MPZCPBvO+nj4ZC4HDzLKC6k8Rf
         JypEtCirGVxKtopHsPqLGMQ5q0svDm2kp+Mr2NtNIyayj98751mUTinOLJ3XWLaU2kvQ
         FcN8J6uzWBd67L5HP1Q8sew1sLzeSauHYgCNFtofzNAs755ikhmSVt4sXJPj0JlAT8GR
         J+EA==
X-Gm-Message-State: APjAAAUjFA4vPjUZ/7i6BQVDB6XKsnsgw3TQn92PYgIy3LuahZlm0kLW
        pPWjNmRDzO2B1Gmi7SQE47eCJA==
X-Google-Smtp-Source: APXvYqyKEwtlxrFaPIwook1+VfY0lSYSMcZTJ6WguwicU9oNLpY+et1Gxbqgky3XvCnScNe13ALFJQ==
X-Received: by 2002:a17:902:7c0f:: with SMTP id x15mr28595069pll.267.1577707249818;
        Mon, 30 Dec 2019 04:00:49 -0800 (PST)
Received: from localhost.localdomain ([49.206.202.131])
        by smtp.gmail.com with ESMTPSA id 7sm41894122pfx.52.2019.12.30.04.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 04:00:49 -0800 (PST)
From:   Jagan Teki <jagan@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH v2 3/3] ARM: dts: imx6qdl-icore: Add fec phy-handle
Date:   Mon, 30 Dec 2019 17:30:21 +0530
Message-Id: <20191230120021.32630-3-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.18.0.321.gffc6fa0e3
In-Reply-To: <20191230120021.32630-1-jagan@amarulasolutions.com>
References: <20191230120021.32630-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Trimarchi <michael@amarulasolutions.com>

LAN8720 needs a reset of every clock enable. The reset needs
to be done at device level, due the flag PHY_RST_AFTER_CLK_EN.

So, add phy-handle by creating mdio child node inside fec.
This will eventually move the phy-reset-gpio which is defined
in fec node.

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v2:
- new patch.

 arch/arm/boot/dts/imx6qdl-icore.dtsi | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index 7814f1ef0804..756f3a9f1b4f 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -150,10 +150,23 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
-	phy-reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clks IMX6QDL_CLK_ENET>, <&clks IMX6QDL_CLK_ENET>, <&rmii_clk>;
 	phy-mode = "rmii";
+	phy-handle = <&eth_phy>;
 	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		eth_phy: ethernet-phy@0 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			reg = <0>;
+			reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <4000>;
+			reset-deassert-us = <4000>;
+		};
+	};
 };
 
 &gpmi {
-- 
2.18.0.321.gffc6fa0e3

