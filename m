Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFAEFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDA321D7B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239929;
	bh=SnSrBVejywLMeyE9C0F/6AVkXlcUCkdN+mdYWqUZVu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NdrqfYi4rUv3A8FRxugj4NWC2TaDyum0AOWZoyS6aIPq+NUy9xuSb47d4qS3XVy5p
	 E4/eaTOL5ZjbyJ2bechZkfTlWoxHSNgbHNqroIcxulIh0HDotliw2Kxg2smP9CCZnA
	 IOHT5O8pNAWBOH4wWmvGDns99nW16kk3323fSdJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390077AbfKHTF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:05:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388576AbfKHTFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:05:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C57F620650;
        Fri,  8 Nov 2019 19:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239924;
        bh=SnSrBVejywLMeyE9C0F/6AVkXlcUCkdN+mdYWqUZVu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y5JyML/dwbG4UOZLhHNM5oFZ3aDNWguArjCZHrTQ4Zp7fjzQiKlFuKEiSKcHfkVXi
         I+Ng5YL6R1xTqmkE8BlYweMwpVZosU3s4anadyI8Ucao9ur778okwO0x8a4PvR1j3K
         h+OsQZKADgKsCz+6SzLl3KmO5BOexocv8Hnqzku0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Harald Geyer <harald@ccbib.org>,
        "Jared D. McNeill" <jmcneill@NetBSD.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Emmanuel Vadot <manu@FreeBSD.org>,
        Maxime Ripard <mripard@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 007/140] arm64: dts: allwinner: a64: Drop PMU node
Date:   Fri,  8 Nov 2019 19:48:55 +0100
Message-Id: <20191108174901.368958757@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174900.189064908@linuxfoundation.org>
References: <20191108174900.189064908@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Khoruzhick <anarsoul@gmail.com>

[ Upstream commit ed3e9406bcbc32f84dc4aa4cb4767852e5ab086c ]

Looks like PMU in A64 is broken, it generates no interrupts at all and
as result 'perf top' shows no events.

Tested on Pine64-LTS.

Fixes: 34a97fcc71c2 ("arm64: dts: allwinner: a64: Add PMU node")
Cc: Harald Geyer <harald@ccbib.org>
Cc: Jared D. McNeill <jmcneill@NetBSD.org>
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
Reviewed-by: Emmanuel Vadot <manu@FreeBSD.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 9cc9bdde81ac2..cd92f546c4838 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -142,15 +142,6 @@
 		clock-output-names = "ext-osc32k";
 	};
 
-	pmu {
-		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>,
-			     <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
-	};
-
 	psci {
 		compatible = "arm,psci-0.2";
 		method = "smc";
-- 
2.20.1



