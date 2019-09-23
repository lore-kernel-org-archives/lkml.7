Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ECDC4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3DF2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 16:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569255290;
	bh=LTvLyPkZ7lh2IDczYfBNwnxnXfly/CnHg9F9GnaeWnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wmz3QWQQ3rStOimui+DPNsloxtqKRxe3O/p6QJdL0OHoz39FddL+t6cThtMNLcWlj
	 4ZRv9rXBA22crgBH+0sVIV7IEouesUtVQvJm0o79cjjsD2BmZhoBDnqoOXxhD5ayKq
	 DqkHzaEXxtXFfVvd0Uu1vbPWI4J7gxADoQfbLI7k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395348AbfIWQOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 12:14:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:58954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395003AbfIWQOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 12:14:44 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F375A20B7C;
        Mon, 23 Sep 2019 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569255284;
        bh=LTvLyPkZ7lh2IDczYfBNwnxnXfly/CnHg9F9GnaeWnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRKJm6V/awTf/tmnqOaszbM5rG1JhwHYeZnXY9EUidxEzzOuR2hZKAkjuqK99cuPk
         SeD7gSGrj+ODNf6ZAeJp2f3o+bAvP1Q7vt0HIrTfCfFkgmuKrNOekYZDWhofu2hqho
         E3f2b4cKCNv77kPCxe7DcS/Q6RbjLeKjO8e+FyZ8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>
Subject: [RFT v4 5/8] ARM: dts: exynos: Remove MCT subnode for interrupt map on Exynos4412
Date:   Mon, 23 Sep 2019 18:14:08 +0200
Message-Id: <20190923161411.9236-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923161411.9236-1-krzk@kernel.org>
References: <20190923161411.9236-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi Core Timer node has interrupts routed to two different parents -
GIC and combiner.  This was modeled with a interrupt-map within a
subnode but can be expressed in an easier and more common way, directly
in the node itself.

Tested on Odroid U3 (Exynos4412).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Use interrupts-extended instead of interrupts-map.
---
 arch/arm/boot/dts/exynos4412.dtsi | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 8b6d5875c75d..9b5fb4e54d7c 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -246,22 +246,13 @@
 		timer@10050000 {
 			compatible = "samsung,exynos4412-mct";
 			reg = <0x10050000 0x800>;
-			interrupt-parent = <&mct_map>;
-			interrupts = <0>, <1>, <2>, <3>, <4>;
 			clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
 			clock-names = "fin_pll", "mct";
-
-			mct_map: mct-map {
-				#interrupt-cells = <1>;
-				#address-cells = <0>;
-				#size-cells = <0>;
-				interrupt-map =
-					<0 &gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
-					<1 &combiner 12 5>,
-					<2 &combiner 12 6>,
-					<3 &combiner 12 7>,
-					<4 &gic 1 12 IRQ_TYPE_LEVEL_HIGH>;
-			};
+			interrupts-extended = <&gic 0 57 IRQ_TYPE_LEVEL_HIGH>,
+					      <&combiner 12 5>,
+					      <&combiner 12 6>,
+					      <&combiner 12 7>,
+					      <&gic 1 12 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
 		watchdog: watchdog@10060000 {
-- 
2.17.1

