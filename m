Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13CBC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACE66206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="SAME1HQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNLDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:03:02 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35121 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfKNLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:03:00 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so4718557lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 03:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U/A2f9kHIFOCYbqEWyI5d4hToF+Uq4/YnGy8bo4uWSk=;
        b=SAME1HQB5rY5pUNyNZsdPmdctskGsxNP86PGXuOQvqwHZitiEqwgM65CFboMlUfOo7
         Gze5msi1z8T9q8JRe5/BrQDm8YBynytpYR6QM5e8fYB/UknphcTyNeBUHn54xd8JiffI
         yHJWSOWGah1xzsTPJCxnZENQecaEXAsjxr/pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/A2f9kHIFOCYbqEWyI5d4hToF+Uq4/YnGy8bo4uWSk=;
        b=J/0rTnGtcQAvgULwWNoQacOA7qcZxsnxBUZ9kO/yzRNDXCI3Z55ZzafZNU7suQTImw
         3tAL8gstWGegKaujZIggiVzvDK1C2eyKPf+8QaKUo2jYfux1BZdnfb2TjEYCTBfb7u/f
         QjaU1V56iSESbyvbx/2icP6AzTDc4KoKrwSR4V1VoVXFZnsnaOm1gGXaxaHVtOetY3vh
         ISeZu5somytGM+893D51D07XgRuOwQDo7sSPnTXJioKZ8sujn0+dEszIpUcLhRZaLvDp
         qK2sNytcS3Kkfm5EfuFINBYH4YRn7+jjzTTlzdHTmPQixBgRgeQHeojwQEawo8CjpuCC
         wQnw==
X-Gm-Message-State: APjAAAXeG1kAfLbxIlP34U+LLUNHjY6HRX0bKxQJag/M5Au2EmNIJ3Sq
        u6jViWdozgtRMLszEm7NLNlZAw==
X-Google-Smtp-Source: APXvYqzB4yFz8S9GHrqN6tQYSP0UPmZB/NTgSy3LzN9JkcH/Eac/vwCv+RlwvWV4nerw2f/zHfGdvA==
X-Received: by 2002:a19:ee17:: with SMTP id g23mr6353744lfb.121.1573729378062;
        Thu, 14 Nov 2019 03:02:58 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x5sm2498795lfg.71.2019.11.14.03.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 03:02:57 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>, Marc Zyngier <maz@kernel.org>,
        netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: ls1021a: add node describing external interrupt lines
Date:   Thu, 14 Nov 2019 12:02:52 +0100
Message-Id: <20191114110254.32171-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191114110254.32171-1-linux@rasmusvillemoes.dk>
References: <20191114110254.32171-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a node describing the six external interrupt lines IRQ0-IRQ5
with configurable polarity.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 arch/arm/boot/dts/ls1021a.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 2f6977ada447..0855b1fe98e0 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -216,6 +216,25 @@
 			compatible = "fsl,ls1021a-scfg", "syscon";
 			reg = <0x0 0x1570000 0x0 0x10000>;
 			big-endian;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x0 0x1570000 0x10000>;
+
+			extirq: interrupt-controller@1ac {
+				compatible = "fsl,ls1021a-extirq";
+				#interrupt-cells = <2>;
+				#address-cells = <0>;
+				interrupt-controller;
+				reg = <0x1ac 4>;
+				interrupt-map =
+					<0 0 &gic GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-map-mask = <0xffffffff 0x0>;
+			};
 		};
 
 		crypto: crypto@1700000 {
-- 
2.23.0

