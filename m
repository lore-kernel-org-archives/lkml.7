Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2C8C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D8CD218EA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555351528;
	bh=7hv2kP6brU9XNcTkJi86MYS3tbj18lGacS0PfuehhZM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OCO85914FwkfgSzug27j+ue/pL6TnCxANv+ylHXgUcr5gkLJWTMxkDx6WnHmp4P9e
	 Rq2t8Y9CFD/7O3Rhy/QduFUlN2chbEdks1D57atpT/40U5ox5rP7szAKH4NY9bcqtM
	 jOft0qCMZA2ccKXQ8s7USeG0UN4KIcNNBegRyOHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfDOSF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfDOSF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:05:26 -0400
Received: from localhost.localdomain (unknown [194.230.158.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D0F218D3;
        Mon, 15 Apr 2019 18:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555351525;
        bh=7hv2kP6brU9XNcTkJi86MYS3tbj18lGacS0PfuehhZM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=p+wAuBkXD63xYhSe7J2f6URuEIg+P4F77QniZJiMtbUMo1ANgjVT/vWNZ2AtZt23k
         4kVMWXhxzkAQYMtmxhkHvKwLC29+iHDPV6yjDX5VoP30OkRgbTbx06TH/mSeVpbjkz
         dnjsZw4sP2Gr+mbIrXgqfhTCeGsr6KuSPZ59Zo2Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 2/4] ARM: dts: exynos: Remove unneeded address/size cells from fixed-clock on Exynos3250
Date:   Mon, 15 Apr 2019 20:05:08 +0200
Message-Id: <20190415180510.6044-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190415180510.6044-1-krzk@kernel.org>
References: <20190415180510.6044-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xusbxti fixed-clock should not have address/size cells because it does
not have any children.  This also fixes DTC W=1 warning:

    arch/arm/boot/dts/exynos3250.dtsi:112.21-139.5:
        Warning (simple_bus_reg): /soc/fixed-rate-clocks: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos3250.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
index af54b306204b..6e74e6815b01 100644
--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -115,8 +115,6 @@
 
 			xusbxti: clock@0 {
 				compatible = "fixed-clock";
-				#address-cells = <1>;
-				#size-cells = <0>;
 				reg = <0>;
 				clock-frequency = <0>;
 				#clock-cells = <0>;
-- 
2.17.1

