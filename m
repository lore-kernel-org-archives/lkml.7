Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA3FC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D202084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 19:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="upvPhQDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730880AbfDBT0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 15:26:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33038 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfDBT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 15:26:18 -0400
Received: by mail-io1-f65.google.com with SMTP id b6so11982539iog.0;
        Tue, 02 Apr 2019 12:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B46Cw1qbzXMWjWSpcrXmhPTWBXWbXfsMBCb1Y6DHbr0=;
        b=upvPhQDm5sP/kjtLd5stvhgLBMwDInWdl7C3oDjbc+Djy7w+ZapNIbwJ3dGDJoNPeW
         NhjqEdDibNkxzdIB+nZ3KW9vtNOdgpbYspo/mc2Kn9J0gTOAR4W4TFSZmk5TzW4FVaSB
         04boZBIl+GPSGeP/BZpG8Z09a//vqxpzpC8rtBhg1PSSm7aftRnTY9/s1e0fUxppA7V7
         iPEkeBUkhlr+NquKkPpf53+tYqlZ207Ke5tt1QPut+MIGd/SFdAJWSuGi7j2pnRMI8WB
         ZPRDhgK4lrGGm1L5XrGfsayDiGMR/o5YfzKIeAS8zZ1Jv5dKKYPwxO4xOU+IDCRf+kLP
         dr1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B46Cw1qbzXMWjWSpcrXmhPTWBXWbXfsMBCb1Y6DHbr0=;
        b=o5jZ9pO13L/3bmEqHeODVU2PbUS6Zft59+XodRIUJGkby8O4aNOKjNZu+3IgrMgCTA
         oxtHPB66ftfyzup44AWesf8Fb9LgHt1AKXWFzY2tnk5KVLESBkaQMKNpmJ6yFKDBGyVT
         995AxI1X0Q/tcCkf3loium4ptQDYvCEw3zuoS4OKKLGTNSpuoV8NqTjKuOYO//lqF/YE
         wSEGRod7xkR26JiWJzwzrMdXNqpGktuhjwloiLfI5pulQ/35x+PeSnpOtX1Klc9yuHWH
         S6ko6fPwbCNbe+yNinw70DwtMpf296umul4+iuhZ2+hErXc8D004ef3R39RoQVrDKg9m
         ydXw==
X-Gm-Message-State: APjAAAWFFrl81eqBw14i4+y5AquvKGBlkADNSzxZpKsCE8ek0/g4pt80
        pZSbH0Xsx5bV7SgW5Y++2Ic=
X-Google-Smtp-Source: APXvYqyZfLZceO4asegvsNkno1BwSIVOTnldfR0reSklPB0sO3eb98HGifXRugnn19HXzmunN0tzgA==
X-Received: by 2002:a6b:f211:: with SMTP id q17mr54110309ioh.242.1554233177551;
        Tue, 02 Apr 2019 12:26:17 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id 139sm7328400itk.28.2019.04.02.12.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 12:26:16 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] ARM: dts: imx6q-logicpd: Shutdown LCD regulator during suspend
Date:   Tue,  2 Apr 2019 14:25:46 -0500
Message-Id: <20190402192547.4538-2-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190402192547.4538-1-aford173@gmail.com>
References: <20190402192547.4538-1-aford173@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LCD power sequencer is very finicky.  The backlight cannot
be driven until after the sequencer is done.  Until now, the
regulators were marked with 'regulator-always-on' to make sure
it came up before the backlight.  This patch allows the LCD
regulators to power down and prevent the backlight from being
used again until the sequencer is ready.  This reduces
standby power consumption by ~100mW.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V2: Remove 'fixes' reference per Shawn's request

diff --git a/arch/arm/boot/dts/imx6q-logicpd.dts b/arch/arm/boot/dts/imx6q-logicpd.dts
index 45eb0b7f75f8..d96ae54be338 100644
--- a/arch/arm/boot/dts/imx6q-logicpd.dts
+++ b/arch/arm/boot/dts/imx6q-logicpd.dts
@@ -21,6 +21,8 @@
 
 	panel-lvds0 {
 		compatible = "okaya,rs800480t-7x0gp";
+		power-supply = <&reg_lcd_reset>;
+		backlight = <&backlight>;
 
 		port {
 			panel_in_lvds0: endpoint {
@@ -38,7 +40,6 @@
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio4 17 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-always-on;
 		vin-supply = <&reg_3v3>;
 		startup-delay-us = <500000>;
 	};
@@ -52,7 +53,6 @@
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio5 2 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
-		regulator-always-on;
 		vin-supply = <&reg_lcd>;
 	};
 };
-- 
2.17.1

