Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28A5C04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71FF204EC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811710;
	bh=7v1BeYu2wyp5sZIlcIHXzFbRN1Twg/ra8ChEFniQ45g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vx5ZcvncSMt1SN3auVNoVryDPetotH8urwd4RfX+keT3rtxW1PuYDuE9Gr5yEQvqm
	 2yW3pdxQyV9D1uqL/FJhcGqcvx00oO9YgfD8ABTSN9BHn30KMiPY5VpRkp7u68R8R3
	 XR1yP7+sOQKe6h4WRWmjeqwt7ZtMTom1OetEW/qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfEBP2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbfEBP20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:28:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 930F1214DA;
        Thu,  2 May 2019 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556810906;
        bh=7v1BeYu2wyp5sZIlcIHXzFbRN1Twg/ra8ChEFniQ45g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rl6k0nooyAaEYaERYD8pS2se2lwJLffB/eV9Up+4tdMUIx5vOYXT00/3akO0gK1jZ
         v129E9I4PRTF7Vi9Gj759i7M3d3ITMrWqXRmDOwna91ONCOGUwDJyK6mEHz1qe6OlZ
         4psPCSQznRWGXLQqbAwlBNRYcafDLkSfZ/73FLwo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 4.19 53/72] ARM: davinci: fix build failure with allnoconfig
Date:   Thu,  2 May 2019 17:21:15 +0200
Message-Id: <20190502143337.621159192@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143333.437607839@linuxfoundation.org>
References: <20190502143333.437607839@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2dbed152e2d4c3fe2442284918d14797898b1e8a ]

allnoconfig build with just ARCH_DAVINCI enabled
fails because drivers/clk/davinci/* depends on
REGMAP being enabled.

Fix it by selecting REGMAP_MMIO when building in
DaVinci support.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Reviewed-by: David Lechner <david@lechnology.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cd4c74daf71e..51794c7fa6d5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -612,6 +612,7 @@ config ARCH_DAVINCI
 	select HAVE_IDE
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select REGMAP_MMIO
 	select RESET_CONTROLLER
 	select USE_OF
 	select ZONE_DMA
-- 
2.19.1



