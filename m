Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A7DC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762672186A
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 20:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNvJTE4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbfHZUpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 16:45:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54653 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731058AbfHZUpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 16:45:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id p74so787889wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 13:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EeoSOO9P8rB2c6o2qSam9CM8ucP9QSVXMBjzLutJqVA=;
        b=eNvJTE4RS20+765BWxr4qe19suSF23z2UcHRM3AOrys6MDLHN7seyrjTkBXKualyDL
         H4H+5KMRmxeb55kiRpo3D3K0OiWg3SDSjn18KIQM+qfWDAp7wy0uj4mNxbI/e5b/yRsw
         a67FEb7F11WCDa2Z45OSKrK6/KXYUDWuRi89/1FNCNNT1lpgYmLedf+iqNuHe0iCpRki
         Dy2wDRxRpAaX//+99l5cHV9hXbHxB+ObDivOuFF20d5li47VVi1/Ioup+ZLLWgfZvi4d
         XCpnpvhFWSh8PlP418NyLf3wfdgaWNR/PD+8Q926I5s0OgB9c8REYkvA0AXDAwWc/0wB
         FLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EeoSOO9P8rB2c6o2qSam9CM8ucP9QSVXMBjzLutJqVA=;
        b=fJeLV0zzWWMJC78jUKqVfvd55CnlxhKGA2cxekJwjR9ZB2ApoWHvcdJ0gK3hYXEb47
         33b0iSgzUCVpvSb/gikpOvqWeJEhxaXd6dX7GhGPHBFHusstGHn87/vp0TVeEz39p0YD
         lWjnyTSQbZQTP1scpTmeFNE6CmQhbu9ma9Nj3MWsJYavoQVeLu5sSlZBVRuLH+rrbMwO
         vZ6cqg42da6TEE2jbHWQRYzLeZZ11VUL/wwOgFcOLBOBCE2Z8p8AjrZUE10MbuUyo3Ev
         y9Cvd0wsPhQnCzuGRarY/+4ZHT4iB0yn7vWzSmYCl7zmdId599qTNYiq04ley7Qh3LsS
         Hk9A==
X-Gm-Message-State: APjAAAXUuy0iiG0lOgmDMgpY2eq7kX4WX4tqDJh1pvOBFugvNemNdyrj
        WBitSPVDBwSkjLqf3nDA4hPDQQ==
X-Google-Smtp-Source: APXvYqzCaQcqfRjUVEK6f/KlqGWwQzrm1CEta8su/KPZxHXkcmAMWTMFnEyazerSjVJpd+RLtVBDFg==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr22665714wmf.160.1566852297896;
        Mon, 26 Aug 2019 13:44:57 -0700 (PDT)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:f881:f5ed:b15d:96ab])
        by smtp.gmail.com with ESMTPSA id 20sm549557wmk.34.2019.08.26.13.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 13:44:57 -0700 (PDT)
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
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE)
Subject: [PATCH 08/20] arm64: dts: imx8mm: Add system counter node
Date:   Mon, 26 Aug 2019 22:43:55 +0200
Message-Id: <20190826204407.17759-8-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190826204407.17759-1-daniel.lezcano@linaro.org>
References: <df27caba-d9f8-e64d-0563-609f8785ecb3@linaro.org>
 <20190826204407.17759-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

Add i.MX8MM system counter node to enable timer-imx-sysctr
broadcast timer driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 232a7412755a..89ef22a8f81e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -510,6 +510,14 @@
 				#pwm-cells = <2>;
 				status = "disabled";
 			};
+
+			system_counter: timer@306a0000 {
+				compatible = "nxp,sysctr-timer";
+				reg = <0x306a0000 0x20000>;
+				interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&osc_24m>;
+				clock-names = "per";
+			};
 		};
 
 		aips3: bus@30800000 {
-- 
2.17.1

