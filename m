Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40488C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 02:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4AD2089F
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 02:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6bdzcJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbfINCue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 22:50:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54711 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388221AbfINCud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 22:50:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so4520760wmp.4;
        Fri, 13 Sep 2019 19:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GS7w/y6KJAb3XTE0KF7ABnXR9mrrpjuRKRosNLWca4k=;
        b=R6bdzcJT8EwKY5tWap4/olAlQ7hs1E4s+GBJLbiuDt4EwM8gP7LvCkx6jEPrtlhJye
         DaakYeAmQT6pj9+gFqb596LidBMo+Ee6hnZEyYARU7XpnYjMco3qws+rJQ9W0DA4qgGR
         08+eGs9wqW1Hl2JuQ9mA9tGvRc8ctkDkVGTFKcsokJ81rXbmqzy8xhlB14gzs0gzG9uv
         jfly2I6yezhVPIUGOnBJhVPUEZXiixmz5Vga/aRnXsebEN+OSgXyIhebmjvH8QssVXlQ
         y6e5DxPcZBirYV7sC1Azs3dvoKVCOEOlDsJDViV0SlFz7G0Uu0s7ulr8awdJ8Lu5kBPv
         bWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GS7w/y6KJAb3XTE0KF7ABnXR9mrrpjuRKRosNLWca4k=;
        b=Gg0a/3/63ro/+AXNiO8xKplzzvWQFab6GtejVnP/irNXCV4gRJSUUDuGx711jbltwj
         V/OaHPhZGZlU/v1hk611BEzquf521YMxcbPCrAX7jVWcX8WVdbz+m0a/nQ9BCtKiE5p6
         239W+jU2+Af9LLHIBbHhOtMHc33i/YcCxPitZ3lkbXkNqp382xlaC8kNTRjWloV+zhIJ
         ff55uWkkCLcuZGj1cxpaUg3taaZeIWmJ6uIHhY0sY2sw0Uvjxyen2wingpse7uzzNE+E
         1p4ufMT5rUgunhiebBxfxGTPXBDQwQq1Ws7SACEKVWAsjLI4Dgrl8tkO/dwX0+sQDriZ
         kRXw==
X-Gm-Message-State: APjAAAXYpG+aVqkeuUBCYW+S+B6B/nb+6FxwdY5YKlYoWlGWpiM/38AV
        ByNgNcAz7btfJxMuYv9+F/4=
X-Google-Smtp-Source: APXvYqwB05poL5fOL99ZeWfMh78cUbx0D7bxu+a2Q3PAAqYMlYAVR+BCMsAYJWeMmExJeouvuihnEA==
X-Received: by 2002:a7b:c045:: with SMTP id u5mr5588396wmc.139.1568429431295;
        Fri, 13 Sep 2019 19:50:31 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id h26sm2345320wrc.13.2019.09.13.19.50.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Sep 2019 19:50:30 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Frank Hartung <supervisedthinking@gmail.com>,
        Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: Add capacity-dmips-mhz attributes to G12B
Date:   Sat, 14 Sep 2019 06:49:40 +0400
Message-Id: <1568429380-3231-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Hartung <supervisedthinking@gmail.com>

From: Frank Hartung <supervisedthinking@gmail.com>

Meson G12B SoCs (S922X and A311D) are a big-little design where not all CPUs
are equal; the A53s cores are weaker than the A72s.

Include capacity-dmips-mhz properties to tell the OS there is a difference
in processing capacity. The dmips values are based on similar submissions for
other A53/A72 SoCs: HiSilicon 3660 [1] and Rockchip RK3399 [2].

This change is particularly beneficial for use-cases like retro gaming where
emulators often run on a single core. The OS now chooses an A72 core instead
of an A53 core.

[1] https://lore.kernel.org/patchwork/patch/862742/
[2] https://patchwork.kernel.org/patch/10836577/

Signed-off-by: Frank Hartung <supervisedthinking@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
index 5628ccd..7f78d88 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b.dtsi
@@ -49,6 +49,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <592>;
 			next-level-cache = <&l2>;
 		};
 
@@ -57,6 +58,7 @@
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <592>;
 			next-level-cache = <&l2>;
 		};
 
@@ -65,6 +67,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2>;
 		};
 
@@ -73,6 +76,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2>;
 		};
 
@@ -81,6 +85,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2>;
 		};
 
@@ -89,6 +94,7 @@
 			compatible = "arm,cortex-a73";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
+			capacity-dmips-mhz = <1024>;
 			next-level-cache = <&l2>;
 		};
 
-- 
2.7.4

