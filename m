Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE06C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5453206A3
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 13:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2eiVdE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfGGNXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 09:23:31 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46332 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbfGGNXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 09:23:30 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so9602160wru.13;
        Sun, 07 Jul 2019 06:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/gM1Cn1FoiamDNCiMz/MtN94v9T5GO29x/2+fXZ9JqI=;
        b=E2eiVdE2E96RFcBV9l+RuYgS5g+FZf9Wsvzf5K+BhmwGfvPQHslK6V69u0+ulfqA/B
         SUumPXD96KwTUlmivng9yiaRtbvkkyjVy3lHexkqnRuunQK1EtXcgSqHQvvbQUSBjxjN
         XGJCQ+Jhr5Xs/wsEWsBjQ979x1yCysw9zdY6lp0Wfte+B0pHijSVr+gNsVG7mG8RzLxC
         bmeBZ8O04lwotsKSHZUfR4iOqayfv1joHAS8opcdA77PNBR7pQIN5JXRhWDMNGjQudw9
         OlomOfmcBy1hiL02rsyJ0hx9ZtcjetyGuQpPuARqugzYQA4WGP8UqN3dV6jQs+pU4qzw
         iaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/gM1Cn1FoiamDNCiMz/MtN94v9T5GO29x/2+fXZ9JqI=;
        b=tj0/HzrLmApLmiLJrTWGwzYOB53wAeIZ5oU/R+88/7twtfhSIBR/NRcYRgifl74QEI
         yATvEW+La3jrVUjibv5QMSmUJL9x0ajQyCt4CA1yc+vuLk912smG6C5601tnGMUqTkS4
         xKGXKCDQZZDq85u0x5LORNhicb/M3Uv3kP9f7vCAng8TmvRGtpK9YSy8V8wV4lPx8bNq
         uxgRoDGXaF42juG5LOhE0yi4KxlaS+wLe+p2VE0PVkNB09H2KtL2D5KdgIv2bLwDk8AK
         LB/S5iYgv2x2yMh4zHJpzVtfuWoZha3lwGqlnqWKGbJQ2e4u4WjE+2SxLKVM94ZqIcAR
         MYeA==
X-Gm-Message-State: APjAAAXZIdeITIuKxQupY4+xCrsTW5L/eBYSMhyAJM8J46Pl/jawyg33
        QKJdlbqNHDmih37NmYDW7r8=
X-Google-Smtp-Source: APXvYqwf797DK+OmySVwPFquD4vMHQf7L6s/P5WImTsm6ZajfhogqaJ+Ut33Pst7Etxe780UODx3Qg==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr13687369wre.205.1562505808556;
        Sun, 07 Jul 2019 06:23:28 -0700 (PDT)
Received: from arks.localdomain (179.red-83-58-138.dynamicip.rima-tde.net. [83.58.138.179])
        by smtp.gmail.com with ESMTPSA id v12sm4294147wrr.87.2019.07.07.06.23.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 07 Jul 2019 06:23:28 -0700 (PDT)
Date:   Sun, 7 Jul 2019 15:23:25 +0200
From:   Aleix Roca Nonell <kernelrocks@gmail.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] arm64: dts: realtek: Add realtek intc to RTD129x
Message-ID: <20190707132325.GE13340@arks.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add realtek's interrupt controller node and interrupt lines
to UART0

Signed-off-by: Aleix Roca Nonell <kernelrocks@gmail.com>
---
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 9009db909fab..6f61b9858aa0 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -29,8 +29,18 @@
 		/* Exclude up to 2 GiB of RAM */
 		ranges = <0x80000000 0x80000000 0x80000000>;
 
+		mux1_intc: intc@98007000 {
+			compatible = "realtek,rtd129x-intc-iso";
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <0x98007000 0x4 0x98007040 0x4 0x98007004 0x4>;
+			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		uart0: serial@98007800 {
 			compatible = "snps,dw-apb-uart";
+			interrupt-parent = <&mux1_intc>;
+			interrupts = <2>;
 			reg = <0x98007800 0x400>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-- 
2.21.0

