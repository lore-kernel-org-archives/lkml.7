Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DAAC49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 13:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156122080F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 13:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEQ/uRYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394128AbfIUNPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 09:15:15 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55755 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389497AbfIUNPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 09:15:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id a6so5187805wma.5;
        Sat, 21 Sep 2019 06:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CUIiObmZUoLOjlcmGuE4Z8qsrk1peXb9nnaXkFScf1o=;
        b=aEQ/uRYvCsbX944pwrZC5Zi5+pI6s/P143IvpXdlQXMblp/gr0TEwvb4/jIY8KcTPb
         h+OCadPSshMmMPvaxG+aDklS4bI+8UV1JUuif5+/cH6ND7u1pCPlRypNjKUUSwZlcfVY
         fmOmGc8jEjdrmt2rxdLStr2mvlAdNsGDr/SrNSboflvindXVGUKuxoMwkhXbfAgD7kXD
         ds2xaFd7dONWCaZm0mLYpGcfY18vZi6cbUNr7JCDZAZ7y8bfR+bZaJZLCL3MaN0W9/8b
         tqoH4C7+jAVoy4HWXeff+DTBMlGe4VHPROBfJn0KzOOWdKjEpBrMct/Vjc06IqQSo+hy
         Tt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CUIiObmZUoLOjlcmGuE4Z8qsrk1peXb9nnaXkFScf1o=;
        b=hUOwraT4lbTUFS6aNrfbjM1SZ4BL2cbGbao6vbsmzUqbxzlBeocHgDlqP+Ela9dKDk
         i3VF3y/glfzCwX6+0sju/htBGlpexK78vSwedTby2TNX2co5fflIbMtkrgHqE9UqcEs2
         CPvRzQW4/4q21E/sQXVS5QpySgS8nBsp6z3sy3Dlji+Lz9avOLs4cKdWlLKd70Rkd2Kr
         jeCNxDq9hl1dUOGOZGePSUcARIFlX78MvYzFShcxT5VvP/uMZdXqnNT6ZYZ+HWoaMHVT
         s363UtIoNjwZG+juRixGLl/Srn/I/ug6AISprvtePdT1qIV6/vX/eIKzdbemD1NxL+1R
         Nbyg==
X-Gm-Message-State: APjAAAWldX3f3coGyQJTAnEu7hjgcEM7AbBwGPg/7DjfWGw6twpXUVAu
        rzD+EzdiN1lqEBt/CLa8tpacgHWi0eLtBA==
X-Google-Smtp-Source: APXvYqwjrERzxUIeZTPWyTYAXdg1ZTPDKGaLOeQoXI2vdua+67gV4Ml3mGFKjPE7ijQS8GUVUSa4Hw==
X-Received: by 2002:a05:600c:295d:: with SMTP id n29mr6713359wmd.36.1569071712994;
        Sat, 21 Sep 2019 06:15:12 -0700 (PDT)
Received: from apple.sigmaris.info ([84.93.172.212])
        by smtp.gmail.com with ESMTPSA id g11sm5676349wmh.45.2019.09.21.06.15.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 Sep 2019 06:15:12 -0700 (PDT)
From:   Hugh Cole-Baker <sigmaris@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hugh Cole-Baker <sigmaris@gmail.com>
Subject: [PATCH] arm64: dts: rockchip: fix Rockpro64 RK808 interrupt line
Date:   Sat, 21 Sep 2019 14:14:57 +0100
Message-Id: <20190921131457.36258-1-sigmaris@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the pinctrl and interrupt specifier for RK808 to use GPIO3_B2. On the
Rockpro64 schematic [1] page 16, it shows GPIO3_B2 used for the interrupt
line PMIC_INT_L from the RK808, and there's a note which translates as:
"PMU termination GPIO1_C5 changed to this".

Tested by setting an RTC wakealarm and checking /proc/interrupts counters.
Without this patch, neither the rockchip_gpio_irq counter for the RK808,
nor the RTC alarm counter increment when the alarm time is reached.
With this patch, both interrupt counters increment by 1 as expected.

[1] http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf

Fixes: e4f3fb4 ("arm64: dts: rockchip: add initial dts support for Rockpro64")
Signed-off-by: Hugh Cole-Baker <sigmaris@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index 0401d4ec1f45..c27d8a6ae1c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -247,8 +247,8 @@
 	rk808: pmic@1b {
 		compatible = "rockchip,rk808";
 		reg = <0x1b>;
-		interrupt-parent = <&gpio1>;
-		interrupts = <21 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <10 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <1>;
 		clock-output-names = "xin32k", "rk808-clkout2";
 		pinctrl-names = "default";
@@ -574,7 +574,7 @@
 
 	pmic {
 		pmic_int_l: pmic-int-l {
-			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 
 		vsel1_gpio: vsel1-gpio {
-- 
2.17.2 (Apple Git-113)

