Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CACC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0033220B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442925;
	bh=sHADWGUPQqNbjXSBg+4H00WHxEJrL3D+tUJRZA3Xohg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TxLA+ZwHLueGSD+awIDdMO7Oq+S7kw0dpbLyWfhGpz2ScKAswBLL7kID1XbPZWMjI
	 Xncmsl8R0X8Mpk4qvRVdRln8u0J2L8KjnDbcZwmySxH6q/gvI+s0GfTYlAuz+c0n1D
	 9DpnqdA6x5JOZIKdPJVivJa0VQHkKjKHvBoa8W7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392068AbfFMQWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:22:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731050AbfFMIi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:38:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2419121473;
        Thu, 13 Jun 2019 08:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415108;
        bh=sHADWGUPQqNbjXSBg+4H00WHxEJrL3D+tUJRZA3Xohg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DcpCdouhIWESfFEqqL3bWZnZvkJIt9iGycH8yFbVQReyT5fegzifYK5cqunZ1Voyy
         UpoFa6jHHiyW2d9ssNOmVQ6kkWLRbhjIx71oIAaHr6Co53VZsofEyIWh7G0zmTx2Kt
         hAzS3gSuF0lqwxtvPOmwoK6Q9zVA4+Pc7OnVAVG0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 73/81] ARM: dts: exynos: Always enable necessary APIO_1V8 and ABB_1V8 regulators on Arndale Octa
Date:   Thu, 13 Jun 2019 10:33:56 +0200
Message-Id: <20190613075654.315334538@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5ab99cf7d5e96e3b727c30e7a8524c976bd3723d ]

The PVDD_APIO_1V8 (LDO2) and PVDD_ABB_1V8 (LDO8) regulators were turned
off by Linux kernel as unused.  However they supply critical parts of
SoC so they should be always on:

1. PVDD_APIO_1V8 supplies SYS pins (gpx[0-3], PSHOLD), HDMI level shift,
   RTC, VDD1_12 (DRAM internal 1.8 V logic), pull-up for PMIC interrupt
   lines, TTL/UARTR level shift, reset pins and SW-TACT1 button.
   It also supplies unused blocks like VDDQ_SRAM (for SROM controller) and
   VDDQ_GPIO (gpm7, gpy7).
   The LDO2 cannot be turned off (S2MPS11 keeps it on anyway) so
   marking it "always-on" only reflects its real status.

2. PVDD_ABB_1V8 supplies Adaptive Body Bias Generator for ARM cores,
   memory and Mali (G3D).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/exynos5420-arndale-octa.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index ee1bb9b8b366..38538211a967 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -109,6 +109,7 @@
 				regulator-name = "PVDD_APIO_1V8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
 			};
 
 			ldo3_reg: LDO3 {
@@ -147,6 +148,7 @@
 				regulator-name = "PVDD_ABB_1V8";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
 			};
 
 			ldo9_reg: LDO9 {
-- 
2.20.1



