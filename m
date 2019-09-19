Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D1C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FDBD21907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931359;
	bh=1hjpLjdFnleXPVsjkwIlMm3goH7mRfAhm1zbSJYjR7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rXd8Vf1sPIVQ6/l6U8M7OLWU1vET6DDgmysxXzC7GFt4xFJXMexBrDj2S7eNtuFh7
	 58v6/HZdmsL/fzmqDgwb6BxTD9cj60Rytg5VIbvwBCb5Xe4crqqBsjTV3Bl3d9zv3h
	 wQrVl+iGZq/IUs/+N6kuR2XKZSLcuORy01YcZ8lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406234AbfISWP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390535AbfISWPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:15:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960C7217D6;
        Thu, 19 Sep 2019 22:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931351;
        bh=1hjpLjdFnleXPVsjkwIlMm3goH7mRfAhm1zbSJYjR7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oa9yxWlEIbhBk94iP65wD26M+J4nLD922YcWw/K8X78LvQ2zr5N0QcIIizpgVENdw
         N2Ym17wXbBuY/8i3dYxKFIxUfUKf0sHJMsKd2Twx8hYH7C7ud5aV9eBz0tD6ff6eKi
         1i3vtQlXb9/WFvA6vI9cYHr08eRVlvRVncLisjDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Keerthy <j-keerthy@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 15/59] ARM: OMAP2+: Fix missing SYSC_HAS_RESET_STATUS for dra7 epwmss
Date:   Fri, 20 Sep 2019 00:03:30 +0200
Message-Id: <20190919214800.125880999@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214755.852282682@linuxfoundation.org>
References: <20190919214755.852282682@linuxfoundation.org>
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
index 2f4f7002f38d0..87b0c38b7ca59 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -389,7 +389,8 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
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



