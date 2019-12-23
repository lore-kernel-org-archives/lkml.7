Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE28EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D68D2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="JueXquKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfLWQgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:36:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35778 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLWQf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:35:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id g17so17197709wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 08:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bJVh8WsGr3CI8B2tc3c0W8dsIPUnbHIuVomMDM1yxMw=;
        b=JueXquKjYAzw369ZDgQeg6ZhcnZzvfjoaA0K89EUCS5KZ0VFh33wOgTKQKFjRDrT8u
         uwLAIQAUrO0DJF9nHIG7QmYYzGtyZLp5RZa+E5M2OHTUFpeexZn+22NAZZrBer4mMVqp
         vh/k08bEwUZtdUSciU5JyDJZNPc1V9oj5wqD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bJVh8WsGr3CI8B2tc3c0W8dsIPUnbHIuVomMDM1yxMw=;
        b=Wn2RK/o4BJWfTazuq7r8vhjQHJDOjwceR58yvqIVhWrHT24GyyAS/BGwygDlGb9Mfn
         lUlMd3a6NMNLJnLJ9IYYzdAdavvlqjO5S5Fjh7wKeYu4TOA+Q1SVxcSJ5qKfTZtRDLHO
         Kps7v/CUE82+Jv0gXv4k+pZUXQ75ucQsvEKwHcIwalI+qSs+CsYJaTSM8fijhtCMWSw9
         YayLO4+xc1U8oFaGiTkVyXT6Z4ldUpe3b3QH+aRcjsLIlERsOpK7noewOzzaMkOK4/OK
         euNq4VLF4reko1dL7REFfNPXElbo0QFluvOKro4UjyU2eArgmIaO5+tOukrACdCuOl8J
         tFww==
X-Gm-Message-State: APjAAAUXSzX7OPthGEnRfX1KaUM3xnMjNuPmasJUn8dlosi+DABA3zVa
        +D4ljzIeXLT/m35foybW3/ZUpA==
X-Google-Smtp-Source: APXvYqxZtuqE8FktXe/h2KgteDfao2o2HcXVpMbTU/NwW++DbgqIE8sZSmcm+xFmkLeBYG+AcTmJZA==
X-Received: by 2002:a5d:4281:: with SMTP id k1mr32062692wrq.72.1577118954457;
        Mon, 23 Dec 2019 08:35:54 -0800 (PST)
Received: from localhost.localdomain ([37.160.152.81])
        by smtp.gmail.com with ESMTPSA id s8sm20412498wrt.57.2019.12.23.08.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 08:35:54 -0800 (PST)
From:   Michael Trimarchi <michael@amarulasolutions.com>
To:     Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org
Subject: [PATCH 3/3] arm: dts: imx6qdl: Move the phy reset at device level
Date:   Mon, 23 Dec 2019 17:35:46 +0100
Message-Id: <20191223163546.29637-4-michael@amarulasolutions.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191223163546.29637-1-michael@amarulasolutions.com>
References: <20191223163546.29637-1-michael@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LAN8720 needs a reset of every clock enable. The reset needs
to be done at device level, due the flag PHY_RST_AFTER_CLK_EN

Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
---
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
2.17.1

