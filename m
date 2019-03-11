Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B62EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FEC2084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nelint.com header.i=@nelint.com header.b="V5o9aUuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfCKQCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:02:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33925 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbfCKQCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:02:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id v12so1377247pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nelint.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EjUIGhEGEd7Dj1Kpy3c3/JS0Yrqe2Lx4oj5hSTSPp2A=;
        b=V5o9aUuUTfwx0Dm0mZyITz73KCedzIC0TibLeDLgUhRhjLlEIdGI9CV+u3a9EjJsfk
         HK+LGjF+IiIyjxHO7MwCJFGK4uyo8Bjc0l3bAvCl3NtbVAWkxwvvzO+gYoiTOr6XLbo1
         SDCkWPWaUjz6Ka6wC8zFXqgR+P68ms4S/+kcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EjUIGhEGEd7Dj1Kpy3c3/JS0Yrqe2Lx4oj5hSTSPp2A=;
        b=FSzPByOThU2kTs4ENCoyyuADvxpx4eSabnJgBXAvQNQsCwWil4k5UvKN8NHhUnLW0D
         7Jhj9fpSKGlqA1K++OwZG6JjO31mGsCsyg1rD1h4fm0mTVcGzMeBTTVkuafSTh3aEUAI
         KgNoXbojetnlxCdEOEk0kM7/nQFM01WUbrgl8D/9zNVfysdEpQ7l7GodsZmZ/8XZGZVG
         gFv8S3RQQ3KrCB6Uf4884Y63qMJ5hdAxNwMvbLUvxJ5Um6tIt4nUrUca7ZgnX3jOVabn
         LqoUXJFkuUJ+UADKqudJt/xx2tV7+vc343WN3ynbVur9tTnn4nabZ1Do1j/vbkhApmYU
         xobA==
X-Gm-Message-State: APjAAAUyWk31usUmkZ0yYLuviOB50zklf5PuuBp6SaljKvbV06PF9YPJ
        lkX2uolvcWXuoEIIwBjOnFcCDA==
X-Google-Smtp-Source: APXvYqw7Y9drv1h+iOu136SJXXX5U6XwHj5T51xLNSMwlAbmJn+rZiXw5bXrKukk92M4E58I2vL4Qg==
X-Received: by 2002:a62:20d2:: with SMTP id m79mr34522801pfj.135.1552320125233;
        Mon, 11 Mar 2019 09:02:05 -0700 (PDT)
Received: from localhost.localdomain ([2600:8800:1301:2190:cc32:ad00:b1c0:818c])
        by smtp.gmail.com with ESMTPSA id v8sm8319722pfm.174.2019.03.11.09.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 09:02:04 -0700 (PDT)
From:   Eric Nelson <eric@nelint.com>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     anson.huang@nxp.com, colin.didier@devialet.com, festevam@gmail.com,
        kernel@pengutronix.de, l.stach@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, sboyd@kernel.org, shawnguo@kernel.org,
        tiny.windzz@gmail.com, Eric Nelson <eric@nelint.com>
Subject: [PATCH 2/2] ARM: dts: imx6q: remove references to PLL4_AUDIO_DIV
Date:   Mon, 11 Mar 2019 08:59:57 -0700
Message-Id: <1552319997-24622-3-git-send-email-eric@nelint.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552319997-24622-1-git-send-email-eric@nelint.com>
References: <1552304271.2453.12.camel@pengutronix.de>
 <1552319997-24622-1-git-send-email-eric@nelint.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we removed the PLL4_AUDIO_DIV clock, we need to replace
any references to it in the device tree with PLL4_POST_DIV to
keep the proper parents.

Signed-off-by: Eric Nelson <eric@nelint.com>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts       | 4 ++--
 arch/arm/boot/dts/imx6q-novena.dts       | 2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index cab9e92..ef2cce5 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -448,8 +448,8 @@
 
 &ssi2 {
 	assigned-clocks = <&clks IMX6QDL_CLK_SSI2_SEL>,
-			<&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
+			<&clks IMX6QDL_CLK_PLL4_POST_DIV>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_POST_DIV>;
 	assigned-clock-rates = <0>, <786432000>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 61347a5..82cf8a7 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -418,7 +418,7 @@
 				  <&clks IMX6QDL_CLK_PLL4_AUDIO>,
 				  <&clks IMX6QDL_CLK_CKO1>;
 		assigned-clock-parents = <&clks IMX6QDL_CLK_CKO1>,
-					 <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>,
+					 <&clks IMX6QDL_CLK_PLL4_POST_DIV>,
 					 <&clks IMX6QDL_CLK_OSC>,
 					 <&clks IMX6QDL_CLK_CKO1_PODF>;
 		assigned-clock-rates = <0 0 722534400 22579200>;
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 1280de5..9d4bd57 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -284,7 +284,7 @@
 	pinctrl-0 = <&pinctrl_esai>;
 	assigned-clocks = <&clks IMX6QDL_CLK_ESAI_SEL>,
 			  <&clks IMX6QDL_CLK_ESAI_EXTAL>;
-	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL4_POST_DIV>;
 	assigned-clock-rates = <0>, <24576000>;
 	status = "okay";
 };
-- 
2.7.4

