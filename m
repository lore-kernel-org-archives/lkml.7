Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889C0C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591E92184D
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4oVhmR+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfHZUpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37776 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729700AbfHZUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id d16so789348wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46OI48aknCO8xnHiNKqbTqHhcC3QBVezddPBiW79IL8=;
        b=t4oVhmR+oEEVFvTBVetR2kz0/3Vk+qOebroB6rEXmXbS3C5c7DmvoLtkR/XNcYPLes
         zRljos8wGxhV5FMc917+mc3iMPQHHDfyYh755S+nYbyMGDbMYc2jJSUEdkwn7lLlu4lb
         aqfJlwnYyiBuMcwpF9BrlSQ6XbvFE+X6y1ffhp9fgHrtU0vif8r5YGwd/r9efZYKcL//
         GTgiIzAieaWGJTQMsho97OqfgtL0BArhkgD+YIpT3WxKEuuW3hKWD4PlFj5QsrM+8sl1
         BPCxWcg52FcmVNt5sU2eiav3lxk3sjSHs1tw3unGZRUXBEPfRD+jbX8TYcucYmvla/Wm
         G96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=46OI48aknCO8xnHiNKqbTqHhcC3QBVezddPBiW79IL8=;
        b=E6y35vronsrTxbVKfqdSNE3RoHpaR6FrWkZIYJlfGxKCrJBxlPndw8CErrPCRlWjEe
         GN5hokiTkgGbnFPYw/rP11h90QfZYAXEyZQ8GiurZaSZMxHRix8AcxhxrdKVfot0ISo1
         Uz16q5Dr8kcQ2wdphJ9gPSAgxCRRRvKJW6vlCqMWbPhM/1ttJgTOsXubBFiyfqjIfpvQ
         w/3RAQvUdphC9bvNSU7zwOPh8tX3EoZLkX4i4Y9Ms27lN/16tHaRqZjeQp8JmSBzEdX6
         k5QEBBoEvj4YuRyDHRO7gC4EBsqk3Pa3zcbaBcuNdEy+Xn3qSiZKZ/XeIUgXWrntU6OT
         fx6w==
X-Gm-Message-State: APjAAAUfQs7Yr0zLRwlyvM5xfvprsmUQbZ/soTK/CyV/tIBI0BMzUfqy
        iFeTZ9/jGWtm77WINlidcU+qQw==
X-Google-Smtp-Source: APXvYqy/MOnLdsZqPivoqO1dTZcmcuw9cOf0HcH7tX9csv0OGT8Z+QaquXD03St2y9wJ6nH2wxfRDg==
X-Received: by 2002:a7b:c244:: with SMTP id b4mr23459241wmj.125.1566852302984;
        Mon, 26 Aug 2019 13:45:02 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:45:02 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 09/20] arm64: dts: imx8mq: Add system counter node
Date:   Mon, 26 Aug 2019 22:43:56 +0200
Message-Id: <20190826204407.17759-9-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX8MQ system counter node to enable timer-imx-sysctr
broadcast timer driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index d09b808eff87..b4529773af51 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -635,6 +635,14 @@
 				#pwm-cells = <2>;
 				status = "disabled";
 			};
+
+			system_counter: timer@306a0000 {
+				compatible = "nxp,sysctr-timer";
+				reg = <0x306a0000 0x20000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc_25m>;
+				clock-names = "per";
+			};
 		};
 
 		bus@30800000 { /* AIPS3 */
-- 
2.17.1

