Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45093C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B68620675
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="F9LVNyD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfFTPwS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:52:18 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5596 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTPwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:52:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0babb00000>; Thu, 20 Jun 2019 08:52:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 08:52:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 08:52:16 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Jun
 2019 15:52:16 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Thu, 20 Jun 2019 15:52:16 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d0babae0001>; Thu, 20 Jun 2019 08:52:15 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH] bus: tegra-aconnect: remove PM_CLK dependency
Date:   Thu, 20 Jun 2019 21:21:59 +0530
Message-ID: <1561045919-15449-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561045936; bh=iSxjPdPZNkQOarWsq5J5T0iyWq6tQ6oEzE6ETixXATk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=F9LVNyD/80NrUVG45fMJpTIRvnB3NcGs0yE+sbzihlBnEBlOlLx6zmaio4UHl+W6W
         0hiv2kCxsbBkAOizfGUD08mwtgzg/cNTwAJiXrjPN5f/VFEgpBS+yYD5ba0u1XdOT3
         yrSvgj6j+YuRNjvAEzPiV4QC7O3pRlhkeVhsrvdBhge+pcu6Qm3zFEyOHZaw0WAazx
         feshpTDYkAVAgfADTO5c56jPLHSPor5ROtdOVFOlS53niaFPstsiGvrYJI4o0ks7eJ
         JNfu+K9JB0h0R8t9fNKPJM4PfkU1Wy3pLD+JSv6FAl+gc4kJqPqwCehgQ7M+eeyaku
         ck+hR4uuYaDiQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aconnect bus driver does not use pm-clk interface now and hence the
dependency is removed from Kconfig.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/bus/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index 1851112..4587ef2 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -128,7 +128,6 @@ config TEGRA_ACONNECT
 	tristate "Tegra ACONNECT Bus Driver"
 	depends on ARCH_TEGRA_210_SOC
 	depends on OF && PM
-	select PM_CLK
 	help
 	  Driver for the Tegra ACONNECT bus which is used to interface with
 	  the devices inside the Audio Processing Engine (APE) for Tegra210.
-- 
2.7.4

