Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C32C3434C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CAF24784
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXre7i2Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfLMTve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:51:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37508 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfLMTvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:51:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id q127so22626pga.4;
        Fri, 13 Dec 2019 11:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Tc6p/vzIYhyddj7vHAkwwUtjdL96r1yW+buff2VY9JA=;
        b=cXre7i2Yv1FmRcR8LuhXxbhP8wV/cMwiFulKdK9Dhll3/FBXVSXlQapj5Ybtnys6e8
         4mbFWzNgAO2j4ziHuT8yBWKelNubnrTDSd5NYNx7cCctJYfN+5g9L9CJDq0vXf7YEaY4
         d0jbFE2A3NFC6XOmhLgFOCCP327E8rj4m4KFcFXzHVjp4mituDLRPI+NR+t1mXgPhkCj
         M7ZIIRVKfgfrUOneBqGil6nu/ST7x6uV5zKSh4NtT/z/8dIwnd7UlCuLDsj1Gjmzeja8
         P8HVhkjJSbGBuvIU0UfrXICm/usY0hHl9OL/9Leb6+0XaIznggXXeBB8fgYE5IPb/Xua
         RiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Tc6p/vzIYhyddj7vHAkwwUtjdL96r1yW+buff2VY9JA=;
        b=jcXYIV+VbRSShzULLONV+DskUBESSZCFMx2UrlSoACZ1UBhWzsRxwrh7dGgFnKi9T9
         KZE5wD9G1drL1cGSvurAoY7IpKceyMlgdgXcwdE+LH6MJKA9anY6p2coXQP0GzXuZWdR
         qQbR9fscgeauNI+kUWpj3KHo0qbDjdppoDAMxgCWy81wWFEI90CDIVpchm2rGupLV2QQ
         D/13Wv5BiFbr+mG3fCS5j5e0J2VwbyXIFfemxub29dxZKCUErWZoE2NS/PlNt7wgK2pj
         FT8ovsuNvtB15k9GOZubuxUtAxYEOLrB4NKN90w1HxSY/TnHABltTsifsGHyrBghPzg9
         CyHA==
X-Gm-Message-State: APjAAAXzETxsXY2e94L+JrckWftumyn2q01gc2j+sWiJgtTgZjdDXvzo
        ohx6hooVpqJIhPrTGVOkEPc=
X-Google-Smtp-Source: APXvYqx98LWsP2NEgocpB6/0UXE+Z2zVCQCD4PJc++G98WekMVHcmQlpxjEhXTaDOG9/4zmYD7kpDw==
X-Received: by 2002:a63:31cf:: with SMTP id x198mr1321442pgx.272.1576266692563;
        Fri, 13 Dec 2019 11:51:32 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p186sm12417117pfp.56.2019.12.13.11.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:51:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: NSP: Use hardware I2C for BCM958625HR
Date:   Fri, 13 Dec 2019 11:51:02 -0800
Message-Id: <20191213195102.23789-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the i2c-bcm-iproc driver has been fixed to permit reading more
than 63 bytes in a single transaction with commit fd01eecdf959 ("i2c:
iproc: Fix i2c master read more than 63 bytes") we no longer need to
bitbang i2c over GPIOs which was necessary before to allow the
PHYLINK/SFP subsystems to read SFP modules.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm958625hr.dts | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index a2c9de35ddfb..536fb24f38bb 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -55,18 +55,9 @@
 		priority = <200>;
 	};
 
-	/* Hardware I2C block cannot do more than 63 bytes per transfer,
-	 * which would prevent reading from a SFP's EEPROM (256 byte).
-	 */
-	i2c1: i2c {
-		compatible = "i2c-gpio";
-		sda-gpios = <&gpioa 5 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-		scl-gpios = <&gpioa 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
-	};
-
 	sfp: sfp {
 		compatible = "sff,sfp";
-		i2c-bus = <&i2c1>;
+		i2c-bus = <&i2c0>;
 		mod-def0-gpios = <&gpioa 28 GPIO_ACTIVE_LOW>;
 		los-gpios = <&gpioa 24 GPIO_ACTIVE_HIGH>;
 		tx-fault-gpios = <&gpioa 30 GPIO_ACTIVE_HIGH>;
@@ -74,6 +65,10 @@
 	};
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &amac0 {
 	status = "okay";
 };
-- 
2.17.1

