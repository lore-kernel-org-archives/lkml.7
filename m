Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2283EC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECFF9214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nXaidQyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730506AbfFSShr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:37:47 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33580 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbfFSShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:37:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id c14so182808plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UHrTE7B5XpI1WvMqZiW3y+ZVgQqpXieqgBOuUL3YDY=;
        b=nXaidQykLu0h3v+pNAwd13wc4DhE5worNOflID9Mf2valzfpNLEoz/00pn7rrU7Dmn
         FxeUrAO5yA7lCOSKq1jd1jzQ4O1aY0TxEMX08ip6aEoG4HxpImTpVC6VSk+69Kpzm6Ys
         gmqahyhRmADeRLd6d+ldLEDrNFb2uHKhQjwM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2UHrTE7B5XpI1WvMqZiW3y+ZVgQqpXieqgBOuUL3YDY=;
        b=P30y76aUTVSLLw9RtfTGk7dtQJMMRvOXVaae75qvWRuaJpR1ApJRbkR8u4Zo9mgzrU
         3oc9ga4Rjx1xKmpMYVslz1QPl3Jp9RTPUkX0cv3/8KnBNtlmGX/4LT0n0hiarE8JrMZK
         CMJYf2ZkwAyGkacv3RhJxQu2/xj9Zri2b0zSqorkHllVAPpoc5Y3NPzQ01WFEITcOfm2
         pMOHbcf0mIet55fflVI8ccY55ZU2zIXntrxAW/RZO2XhGMo9lg9TY2sl+nYx1Ot9rJWc
         PSy7676yR6WqbdGh8NkmdHQF8LnrGa7avvxNJteAq1ZlUnluICLifoe/zPuNkcp+Obl3
         zHuQ==
X-Gm-Message-State: APjAAAW7BrMKgHRJSAJp2O1nxKGSg7mIjMK0fWi0pooBlubpAoMr8zbw
        TmCkYG4BBEQg6KJPOXBmtuUx0gwfUBE=
X-Google-Smtp-Source: APXvYqw3w3u7xuqL2IUmlLYdr5iRpyNBWMi+c4rhFrkhqFLsCOFAK3UzXw/uPna24Mybo1ZWf+lnpA==
X-Received: by 2002:a17:902:7e0e:: with SMTP id b14mr96610234plm.257.1560969466479;
        Wed, 19 Jun 2019 11:37:46 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id j16sm2681463pjz.31.2019.06.19.11.37.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 11:37:46 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     heiko@sntech.de
Cc:     linux-rockchip@lists.infradead.org, mka@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: rockchip: Configure BT_DEV_WAKE in on rk3288-veyron
Date:   Wed, 19 Jun 2019 11:34:25 -0700
Message-Id: <20190619183425.149470-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the other half of the hacky solution from commit f497ab6b4bb8
("ARM: dts: rockchip: Configure BT_HOST_WAKE as wake-up signal on
veyron").  Specifically the LPM driver that the Broadcom Bluetooth
expects to have (but is missing in mainline) has two halves of the
equation: BT_HOST_WAKE and BT_DEV_WAKE.  The BT_HOST_WAKE (which was
handled in the previous commit) is the one that lets the Bluetooth
wake the system up.  The BT_DEV_WAKE (this patch) tells the Bluetooth
that it's OK to go into a low power mode.  That means we were burning
a bit of extra power in S3 without this patch.  Measurements are a bit
noisy, but it appears to be a few mA worth of difference.

NOTE: Though these pins don't do much on systems with Marvell
Bluetooth, downstream kernels set it on all veyron boards so we'll do
the same.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../boot/dts/rk3288-veyron-chromebook.dtsi    |  2 ++
 arch/arm/boot/dts/rk3288-veyron.dtsi          | 20 +++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
index 5727017f34b2..1cadb522fd0d 100644
--- a/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi
@@ -237,6 +237,7 @@
 
 		/* Wake only */
 		&suspend_l_wake
+		&bt_dev_wake_awake
 	>;
 	pinctrl-1 = <
 		/* Common for sleep and wake, but no owners */
@@ -246,6 +247,7 @@
 
 		/* Sleep only */
 		&suspend_l_sleep
+		&bt_dev_wake_sleep
 	>;
 
 	backlight {
diff --git a/arch/arm/boot/dts/rk3288-veyron.dtsi b/arch/arm/boot/dts/rk3288-veyron.dtsi
index e2635ad574e7..53d2f2452868 100644
--- a/arch/arm/boot/dts/rk3288-veyron.dtsi
+++ b/arch/arm/boot/dts/rk3288-veyron.dtsi
@@ -485,12 +485,18 @@
 		&ddr0_retention
 		&ddrio_pwroff
 		&global_pwroff
+
+		/* Wake only */
+		&bt_dev_wake_awake
 	>;
 	pinctrl-1 = <
 		/* Common for sleep and wake, but no owners */
 		&ddr0_retention
 		&ddrio_pwroff
 		&global_pwroff
+
+		/* Sleep only */
+		&bt_dev_wake_sleep
 	>;
 
 	pcfg_pull_none_drv_8ma: pcfg-pull-none-drv-8ma {
@@ -596,6 +602,20 @@
 		sdio0_clk: sdio0-clk {
 			rockchip,pins = <4 RK_PD1 1 &pcfg_pull_none_drv_8ma>;
 		};
+
+		/*
+		 * These pins are only present on very new veyron boards; on
+		 * older boards bt_dev_wake is simply always high.  Note that
+		 * gpio4_D2 is a NC on old veyron boards, so it doesn't hurt
+		 * to map this pin everywhere
+		 */
+		bt_dev_wake_sleep: bt-dev-wake-sleep {
+			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+
+		bt_dev_wake_awake: bt-dev-wake-awake {
+			rockchip,pins = <4 RK_PD2 RK_FUNC_GPIO &pcfg_output_high>;
+		};
 	};
 
 	tpm {
-- 
2.22.0.410.gd8fdbe21b5-goog

