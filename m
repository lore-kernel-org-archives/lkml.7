Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92DBC43215
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8178920409
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co1B+/+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfKNK0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:26:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37277 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfKNK0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:26:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so5263939wmj.2;
        Thu, 14 Nov 2019 02:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QQkiyfzZO2O0Kn6D38HEznmusWSb/9VZvRrhnG4JLA=;
        b=co1B+/+ltAMnsmoBwd4JgvR/KtXsDV8+5+UxJFQOW8QNurGkzGwXyx1U9DUuvVXqa4
         zrU4kxD10p3llVczeauQFnatEE1dcTYITHp8eQkRGHlVjo6plnlPbRFEKeXsJno4bRWt
         frrJYScCJY2qe5U2mMAgiA3p9e/lcKlaSYtbY7G3f2LQOUqqb20mZJbyLvvY87/2EojP
         oB5clBhqIIreSQq/0IlPm3oBBvlinEK60Q+YAYIux7W65UQBYrfMvwe1nvrLSqyg3CXz
         qDAlyphz0sonJrZCDBSmYyne0HIbak400tgHqAnE6NSmjNdymIw9XgueA4PULyLMkFFg
         BLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5QQkiyfzZO2O0Kn6D38HEznmusWSb/9VZvRrhnG4JLA=;
        b=OTFwmBCzvnxHlDS03Uo/Q2tF+Ww0zT5+j8dLGDzpoS3+YUX2fiA8RfJ3+Us6xNdvwj
         3f534zPhc4T+ztNjKmr+krNnbMbJQsv7Cf4A43ItYLXNYDj2uCbyQgAxu60XtzK6DFs4
         miS0BitePjFaPQDVGh7hR6eCMj4XzwO7hlmDJxDOD/W/xzCpgpsYVNyRZuKDdO6fUtjI
         fMvSAws69Y2nD6Lqh5QsNjrlgfa4Gelg2qy1A8NU+yD1ujnt3kWeBT11kCFZbB8gkgmT
         dZVjbuHfNK7PRjah3xpyDSbmqqTj8F8NIWCosejJ3JQ/ld8h+SHdlcOMjfXt9mhIzcpJ
         Y99g==
X-Gm-Message-State: APjAAAWxgJnrumaKNlw+Ui2cCgaHO6ccyHIvLgFzj+xTazp+T49JMDOV
        z0i0WhogVtslArDViJ+2uwc=
X-Google-Smtp-Source: APXvYqwGumQBol47N7qad3Jy0q4/6MzSwtzAuP1DUrwstDzDwNUQ7a3eb1WO2niC+5ixCUFNyNVauw==
X-Received: by 2002:a7b:cbc4:: with SMTP id n4mr6848002wmi.118.1573727157443;
        Thu, 14 Nov 2019 02:25:57 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id r2sm2964832wma.44.2019.11.14.02.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 02:25:56 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: h6: Enable USB 3.0 host for Beelink GS1 and Tanix TX6
Date:   Thu, 14 Nov 2019 11:25:41 +0100
Message-Id: <20191114102541.27361-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable USB 3.0 phy and host controller.

VBUS is directly connected to DCIN 5V and doesn't
require to be switched on.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 8 ++++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts   | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index e5ed1d4bfef8..dbf353cd26c1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -76,6 +76,10 @@
 	status = "okay";
 };
 
+&dwc3 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -291,3 +295,7 @@
 	usb0_vbus-supply = <&reg_vcc5v>;
 	status = "okay";
 };
+
+&usb3phy {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index bccfe1e65b6a..0b6361a5c172 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -45,6 +45,10 @@
 	status = "okay";
 };
 
+&dwc3 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
@@ -102,3 +106,7 @@
 &usb2phy {
 	status = "okay";
 };
+
+&usb3phy {
+	status = "okay";
+};
-- 
2.20.1

