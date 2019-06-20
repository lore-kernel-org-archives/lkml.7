Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BD1C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B48B20644
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GZwPdAGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729563AbfFTP56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:57:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17197 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfFTP55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:57:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0bad030000>; Thu, 20 Jun 2019 08:57:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 08:57:56 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 08:57:56 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 15:57:54 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 15:57:54 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 15:57:54 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0bad000000>; Thu, 20 Jun 2019 08:57:54 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <marc.zyngier@arm.com>, <jason@lakedaemon.net>,
        <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Sameer Pujar" <spujar@nvidia.com>
Subject: [PATCH] irqchip/gic-pm: remove PM_CLK dependency
Date:   Thu, 20 Jun 2019 21:27:48 +0530
Message-ID: <1561046268-16329-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561046275; bh=n33wFqXZv0UKRiVi48DIlQovddNrTF9DbG2kNBg2VC4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=GZwPdAGUxrZRZGrNs9jKDeeZ3e7hD5RClv09q5D4Lbeh71MOex0VR2BqwdDgLHW5g
         /SB5sfNAaSYqO2pA8IZYFhTCROkauHohPcbAU1SD3TPaL6JSoL9qSx0+UAjHQL0xbh
         mCsHlpXzCQrUZQVnQw176gDPbh2rP6tYtqUmUtdwQWeKDnhF6EVhGXchkkT/eETh4v
         Hs2WR5tWCtoKx6wDuTXN4Z3Ki2hzXkmenfe2X87Q7eB0BeEfIyUshwDuY1F2m6/bba
         8Kg+KuZw35j8hUHl8Tmgv2A+R8ri+6p/BPex1LZz8sABgum938BpWZQ3ppsgfCn2fB
         OaRLYCuUK8oDg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gic-pm driver does not use pm-clk interface now and hence the dependency
is removed from Kconfig.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/irqchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 2d3b5a2..6346d6f 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -15,7 +15,6 @@ config ARM_GIC_PM
 	bool
 	depends on PM
 	select ARM_GIC
-	select PM_CLK
 
 config ARM_GIC_MAX_NR
 	int
-- 
2.7.4

