Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624F0C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FCB2081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIU4VhIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgAFTKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:10:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34323 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:10:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so20522639pfc.1;
        Mon, 06 Jan 2020 11:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fn2//En0NgtGPijhIqqwb8TihozuX1XJnjpZUHvZ4zc=;
        b=nIU4VhIxZOhYy39o1sjc1QjE5btWTxIyooXi5l878+gLXV8ZCfYhxWa3hYa5D12SXR
         ZNdVZOrxue+qeZJMJ5APJbAcunA1BsGXDxz6pOdbz8TNL4G6s4vJ4Krqd3fqIeEgXT5c
         uzZqy0+wqOCFEzr2f0LuH4nxqbgUxnyBI/0G07C1qRpKmhKbv857d4asnMGTzLzu+iCz
         kuxejP+XvlvHS1CqbU8EqKNLUrrarQcqQIS09gjejl3Aufj62biJFjlgxPt+CQIPl6Qb
         ShK6cOXmuJSw4ozd7adNW7xoA3sPl3upBPqROGXM99WHK8to5PaIqFU3PWhR0zbJfeHH
         u+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fn2//En0NgtGPijhIqqwb8TihozuX1XJnjpZUHvZ4zc=;
        b=Xd0Cn7tUryrINQ/9Z/xl6fTuGKm8zqHVAzJMRCxgo07xvhh7m+qGvBKiR+k/4V+ARn
         Q4MFyE/iH12YS4Zr/0HV3bog1i9NFI/ne3yDmaD3JucvhxpP4Of+zWna88A2aadSYffU
         gDKmZKY+uPal93UX2JKFiNTip2eCORrHG24qyqOpZ8z4jU9vUTlSyMziGFsdH9hBrEe+
         C5nXzPO770LhQVnwRbF21YgwEuqGcrFb1XvGEnCCkMs8ZZnD1ioYSL2BLPZ2aMCVtwIJ
         vElR1ffHH++N7uI8PUU5ZvmH+k7v0aPA+A3qXcdiXf9YdfOo/plVT9YUlihQvbIGtXJe
         pKyg==
X-Gm-Message-State: APjAAAXu9E1IUgz+L6o+LHR5uS3GdEpKxwhG1+icwmW/1p9GayvM1wta
        L37yhjmNtrQ+cxhSPoA0AZ4=
X-Google-Smtp-Source: APXvYqzsKEDnC2EKtm0Ia2SyM+OMxaIbFAQ6+lS8DUu8VWdLD/BN8rQ9KdvdCNdNNOfmTymk5wR8Gw==
X-Received: by 2002:a63:f64a:: with SMTP id u10mr109381095pgj.16.1578337806306;
        Mon, 06 Jan 2020 11:10:06 -0800 (PST)
Received: from localhost ([2001:19f0:6001:12c8:5400:2ff:fe72:6403])
        by smtp.gmail.com with ESMTPSA id g21sm6425496pfo.126.2020.01.06.11.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 11:10:05 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, kgene@kernel.org,
        krzk@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 1/2] ARM: dts: exynos: tiny4412: add fimd node
Date:   Mon,  6 Jan 2020 19:10:02 +0000
Message-Id: <20200106191003.21584-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch adds fimd node for tiny4412 device.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm/boot/dts/exynos4412-tiny4412.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 01f37b5ac9c4..2b62cb27420c 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -68,6 +68,14 @@
 	};
 };
 
+&fimd {
+	pinctrl-0 = <&lcd_clk>, <&lcd_data24>;
+	pinctrl-names = "default";
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.17.1

