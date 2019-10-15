Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B555C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3233120640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 15:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ss9p+80Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbfJOP1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 11:27:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33517 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJOP1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 11:27:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so12723013pfl.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ht5w3WErN3ZWYQclG5fL/Luiq/R/+94kXfroCBCb638=;
        b=ss9p+80ZfJXC5FyuE7OqcA6ywFpKwWr55KF72jHOALCaliIlb19fYH/orwdNzb/otS
         c95W6RE7S87SUaimNOUxVRn5tK6StFzoncuB3RGK/N6PLasd1u1S8BIu522g121aZ9+6
         Y2hfY2Oi2Vgl6mePVTxlpxpAtw+HwwovmvAinYj+y4m1mnT8jHKx9vxeh8KkJwAfoCO4
         rkhylSh+eJbZZWMC/Hz8jnoHxpCS+cYlXbtnH7p/sX6rMz7qmUw1wOgO2cH0/2qoy+hF
         mHlQQE+5MqG1/PYbFIZm2j+U0uSze55KBklyH4d7PxUE7TY1awKDejCKygKIuaCK6FXs
         zQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ht5w3WErN3ZWYQclG5fL/Luiq/R/+94kXfroCBCb638=;
        b=PIdbYRCXldFJPJvrUbWoNQNVt6uX2ZDV/w83ubGRAnkmOiaZhR8G/yDB6A6+gfeYtw
         49+vDScGq9cnUnErpHR0qCa0e3vP55F0OhrilvgRAVbTrbcdP1ZSK4YtKF15eSV5izBU
         XY2XKIwm4mjHso6hlSiMh18v+RjKtDTve5lXX6pnRVS/XFzn6HHFTyBOyZZIgyB1RyO/
         vaoVvxjMnZMHf5WirQga2sEpdRpPyfNDKuRhDIKh3G1mJp2+gBFr7lzZ3Yu2+jih37P8
         GYdJx5HsfbQSLkiW1UKWEdNw4QihR9y0C8xY6GrQA95jTOJIwqeXI/hPKw4Brf4qjO25
         1Leg==
X-Gm-Message-State: APjAAAVAcfu3wKGhCA0I6Qad/C9gD8+uqcqz0rViMAAyhepiRM+kgeoe
        xQrvYO7Fh7mdu7x1grY1OMhqrBU2oC0=
X-Google-Smtp-Source: APXvYqxV1TEeLG1NI+A4mOFbmd4nvkN2wl2dG8PAFrOked1Td0or3Znwh2ckTxsnEH4yaU/oVwFASA==
X-Received: by 2002:a17:90a:f986:: with SMTP id cq6mr44224653pjb.17.1571153242882;
        Tue, 15 Oct 2019 08:27:22 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id w11sm21158957pgl.82.2019.10.15.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 08:27:22 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: zii-ultra: Fix regulator-3p3-main's name
Date:   Tue, 15 Oct 2019 08:26:52 -0700
Message-Id: <20191015152654.26726-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191015152654.26726-1-andrew.smirnov@gmail.com>
References: <20191015152654.26726-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's 3V3_MAIN, not 3V3V_MAIN on schematic. Fix it.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
Cc: linux-kernel@vger.kernel.org
---
 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 5d7a8f09f1ab..21eb52341ba8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -62,7 +62,7 @@
 	reg_3p3_main: regulator-3p3-main {
 		compatible = "regulator-fixed";
 		vin-supply = <&reg_12p0_main>;
-		regulator-name = "3V3V_MAIN";
+		regulator-name = "3V3_MAIN";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
-- 
2.21.0

