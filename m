Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F06C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B33B218A2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CF56dwRc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbfCTUOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:14:33 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39615 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfCTUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:14:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so2585442pgp.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwAL0mV+1FttEgIOQakV729npRqitV7Qq6VFlsH1DAc=;
        b=CF56dwRc0kcExLqpNMLtJKAUCzMYeRDxEQMIzB66UrEA/ByceK4PsHTU0bd7wHd/Ol
         tPOJcmMMjfOGo2ZGnVzoP12wpYOrZgdndFwVxj9vUo4zadcejK8LV4eB4wRlo14V+L0p
         XH1zkOURjB/UuoBhcOXRTnA8hpH2TpKqKdznM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BwAL0mV+1FttEgIOQakV729npRqitV7Qq6VFlsH1DAc=;
        b=sPKwGJnCa2egv+LJlzAowhQ8oLQAl0cdxTqksYjZuCftB4blmV0FTedxKAOVWMEwNn
         57cM83PR+s1SX8xVc3wCmRsmDsdub/V6hswFq3CZc2qe/y+yNcHiPZchTon1Au4H88Dq
         ykqJU/feOP8exH1KykFGBaM0Idjm0yjAlTAJU1wcRPV1t4BsFw0g0yG52T5ANyIEx3a2
         PTEFSNqw5eJusovL09fK5JyWf/ilTC41aD1hoXxiBO1pIyrhCOFHRvB8335xUhgvk+rz
         WmL/v+XbG+JU0XsOy8rQCgigsKbnUqbLe67I0ABb5yk5s0s589nEvhE6kvBI7xlG7rW3
         5WtQ==
X-Gm-Message-State: APjAAAW99rhBDnGLwHfL7qQT/kbL2YJg0/+kSUZrtfM62aXXtftjlx9X
        lYq+E3smhdOKniOM69IDKntfxg==
X-Google-Smtp-Source: APXvYqzksDF0LWorAWmcuK1UEWcOmUQthtXTn+RXcid15g5LEqsvQA+1tZqZUcwTc7XhW6Opq/045Q==
X-Received: by 2002:a63:7c07:: with SMTP id x7mr9292968pgc.284.1553112871771;
        Wed, 20 Mar 2019 13:14:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id z77sm6220388pfi.155.2019.03.20.13.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:14:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: dts: rockchip: Fix gic/efuse sort ordering for rk3288
Date:   Wed, 20 Mar 2019 13:13:59 -0700
Message-Id: <20190320201402.114309-1-dianders@chromium.org>
X-Mailer: git-send-email 2.21.0.225.g810b269d1ac-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It can be seen that 0xffb40000 < 0xffc01000, thus efuse comes first.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm/boot/dts/rk3288.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 09868dcee34b..e9f454248398 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1378,19 +1378,6 @@
 		reg = <0x0 0xffaf0080 0x0 0x20>;
 	};
 
-	gic: interrupt-controller@ffc01000 {
-		compatible = "arm,gic-400";
-		interrupt-controller;
-		#interrupt-cells = <3>;
-		#address-cells = <0>;
-
-		reg = <0x0 0xffc01000 0x0 0x1000>,
-		      <0x0 0xffc02000 0x0 0x2000>,
-		      <0x0 0xffc04000 0x0 0x2000>,
-		      <0x0 0xffc06000 0x0 0x2000>;
-		interrupts = <GIC_PPI 9 0xf04>;
-	};
-
 	efuse: efuse@ffb40000 {
 		compatible = "rockchip,rk3288-efuse";
 		reg = <0x0 0xffb40000 0x0 0x20>;
@@ -1404,6 +1391,19 @@
 		};
 	};
 
+	gic: interrupt-controller@ffc01000 {
+		compatible = "arm,gic-400";
+		interrupt-controller;
+		#interrupt-cells = <3>;
+		#address-cells = <0>;
+
+		reg = <0x0 0xffc01000 0x0 0x1000>,
+		      <0x0 0xffc02000 0x0 0x2000>,
+		      <0x0 0xffc04000 0x0 0x2000>,
+		      <0x0 0xffc06000 0x0 0x2000>;
+		interrupts = <GIC_PPI 9 0xf04>;
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3288-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.21.0.225.g810b269d1ac-goog

