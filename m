Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B592DC10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D3E2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 18:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lyq3znX4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfDNSgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 14:36:05 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36867 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDNSgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 14:36:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id w23so7468063ply.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2019 11:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0+WFUhfHh8Y3rOmE5iCyW7yCgxYjduenscPtoIwkoQ=;
        b=Lyq3znX43/qDICRqQTRf7O4XxDdffCSmKQ08uvguTY4Hg3B4b3HkjUJvo8T8Rtg33C
         LskaaT5vaunxt8xEtkZMdEXBDB38FHh9BzmllgV0icTWoT6IJTodGiGbJ6NhoP5YhS8r
         sJ5e6h33x3WaaqI1PJBo5eS8sQTcZCOBzjlk7f4SH5KhEeuLEhgKdXn/Hj6wOHR4Z0RW
         CSMVnwDhLcy3jHSC2plNo1/dwobjqjAdcpz9N9yoeBmoYDnTliyzNDuCaSWKT+a5VHzF
         9P7oNfzBg/kQu3yyx4Q++/O3yKgIxt15dP7Bm/BlNUvPpT3IXmqUYePsKr2W+1NGXPfK
         JUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0+WFUhfHh8Y3rOmE5iCyW7yCgxYjduenscPtoIwkoQ=;
        b=ah6c6BYqNZ/NeNvMkRMHRfUcSpZc3w6Shqc+6xHpIbevH6+LMtKNj2mQ/bQRHWJq9c
         3rHiKmOpeDuN7R9K2PHWsJlx/h5cIoWHSGMkmzJIQMy0FdghDoUhI8mYHVBPmboysiJ+
         LVNhJOR4lSxm5mzp/grNKdeUwDZj7rfXJygT4n+BN4awcAl90C2LKCFMShviSMK7AZOF
         8H2vY/HYtVqCwFlO5IgXyD884gc0lLu1uOagXB7IX68cQPQ1OQyWwl4r6Tc6KP74uZ7C
         BwWH00ItAWplUJ0M324VM5oVNuwxdtyemTOlDhyYodcUNDPPn5wVR8ux6LNx3nQ+/Ulc
         uKVg==
X-Gm-Message-State: APjAAAW2DzzXuejcpcnPWmu5MVFUj+6+E5at6PfeSFkNgfCEHGr+NNKm
        FXzsv7yFLNh3QwwiuWdwyQOVnk3k
X-Google-Smtp-Source: APXvYqzy/wq5Bj7R0WoBkRqvutVbP7tceha4LYIrxv+dhzK0xj6NudSld0HoGLoqZOENX0Y1PPw1Kw==
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr69900452pll.163.1555266964211;
        Sun, 14 Apr 2019 11:36:04 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id v43sm45473300pgn.57.2019.04.14.11.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 11:36:03 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: vf610-zii-dev: Mark i2c0 SCL as GPIO_OPEN_DRAIN
Date:   Sun, 14 Apr 2019 11:35:57 -0700
Message-Id: <20190414183558.25750-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark i2c0 SCL as GPIO_OPEN_DRAIN to fix the following warning:

gpio-36 (scl): enforced open drain please flag it properly in DT/ACPI DSDT/board file

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/boot/dts/vf610-zii-dev.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 19eb4a849efb..2d1e9b3203fa 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -138,7 +138,7 @@
 	pinctrl-names = "default", "gpio";
 	pinctrl-0 = <&pinctrl_i2c0>;
 	pinctrl-1 = <&pinctrl_i2c0_gpio>;
-	scl-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
+	scl-gpios = <&gpio1 4 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 	sda-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
-- 
2.20.1

