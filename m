Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A389C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F1021479
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QwSZ8tNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbfEVQVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:21:07 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58954 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729588AbfEVQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:21:07 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKdLq034797;
        Wed, 22 May 2019 11:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558542039;
        bh=f/DgD/v6sg4vKR8gO+PKcIYXb0uoL9WzlNtRu2fAVGs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QwSZ8tNLIZhHkt1FkibkCscS+PFBk//Fa9yuLADIU3W+r08+zttFroi8V6AmiXfFG
         5UYhYQNfvvGhGmrY3x2IcBuNqLPehtMmfBfRLJnLjFV2Z1LsuyLVU7SbZpva850iXD
         WWl/jHM44naz7aTWPOgUlGxACy56ZiplBPJ9u8hA=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4MGKd56080388
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 May 2019 11:20:39 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 22
 May 2019 11:20:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 22 May 2019 11:20:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKceB104536;
        Wed, 22 May 2019 11:20:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/6] soc: ti: Add Support for J721E SoC config option
Date:   Wed, 22 May 2019 11:19:19 -0500
Message-ID: <20190522161921.20750-5-nm@ti.com>
X-Mailer: git-send-email 2.21.0.777.g83232e38648b
In-Reply-To: <20190522161921.20750-1-nm@ti.com>
References: <20190522161921.20750-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add option to build J721E SoC specific components

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/soc/ti/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
index dbd6c60b81db..a51beac6751f 100644
--- a/drivers/soc/ti/Kconfig
+++ b/drivers/soc/ti/Kconfig
@@ -8,6 +8,11 @@ config ARCH_K3_AM6_SOC
 	help
 	  Enable support for TI's AM6 SoC Family support
 
+config ARCH_K3_J721E_SOC
+	bool "K3 J721E SoC"
+	help
+	  Enable support for TI's J721E SoC Family support
+
 endif
 
 endif
-- 
2.21.0.777.g83232e38648b

