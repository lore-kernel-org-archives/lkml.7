Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB6BC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F2C621924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931603;
	bh=soc01mXklDNkUZ7gXsZ0FDUQFGQ4y6UxA6Moa5SC2cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+1SD2t/Y7I2ChfKc3OaPqe946hWTLBRhj3sezMNos+MqBPPb4LC0TEmxfNOFcM0J
	 b9VG1RGr75vrx3U8n91GZ65xchuBfM2OP84YguVO3aziAdRZuFL/UfbmO4UTzBAqN7
	 5ftCFn08CUWcTIIEX8OmvP/6rfOOPN5lyG5agv7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbfISWUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:20:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:33710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732513AbfISWTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:19:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B6F217D6;
        Thu, 19 Sep 2019 22:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931594;
        bh=soc01mXklDNkUZ7gXsZ0FDUQFGQ4y6UxA6Moa5SC2cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0NjKUoOVjqBLcHe9cWyU8Md9LSeYO5MCyD7TWqum8Qk0fMpjW/v3qIP8+hKTYpGim
         uo0BWdCzxXVnE1QygEOPuKU365H2/ujpr2uDQVx0ydEWNjwGYnZPilpc1s2B6/92tj
         bhF+V3VQncHWw8zGxbbxUuO1OiOKHnaK6UWqjDTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 44/74] ARM: OMAP2+: Fix missing SYSC_HAS_RESET_STATUS for dra7 epwmss
Date:   Fri, 20 Sep 2019 00:03:57 +0200
Message-Id: <20190919214809.102314830@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit afd58b162e48076e3fe66d08a69eefbd6fe71643 ]

TRM says PWMSS_SYSCONFIG bit for SOFTRESET changes to zero when
reset is completed. Let's configure it as otherwise we get warnings
on boot when we check the data against dts provided data. Eventually
the legacy platform data will be just dropped, but let's fix the
warning first.

Reviewed-by: Suman Anna <s-anna@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 1ab7096af8e23..f850fc3a91e82 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -387,7 +387,8 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
 static struct omap_hwmod_class_sysconfig dra7xx_epwmss_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x4,
-	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			  SYSC_HAS_RESET_STATUS,
 	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
 	.sysc_fields	= &omap_hwmod_sysc_type2,
 };
-- 
2.20.1



