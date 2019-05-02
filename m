Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF65C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7517921670
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 15:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556811081;
	bh=Yt9Edj4rhlk7vk5skBbHLEaw0mAB1f+MfM/VMJP/mYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mkkpq2WE1RJ8II5EfANyZNsyxERD24AkfUd6tHy7kjqxXimFlVvIMqYTr1B1go8FY
	 5vxC+LmuK0gv4+O4CJhW72yqOj3C720xA9pZSdj7qZ6l/vPFQaI13QMShbnonMLot0
	 5/L0gIizByjqFR8h7GJ9dAO88msu2nAniDhuFw2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfEBPbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 11:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfEBPbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 11:31:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58BED214DA;
        Thu,  2 May 2019 15:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556811074;
        bh=Yt9Edj4rhlk7vk5skBbHLEaw0mAB1f+MfM/VMJP/mYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rtF5Wv6Nf/NiSzbUJqFy2i3Sr5S+HWm/4yW1Y/pjjTB4BlIihuQgv5S5quMZF08s7
         aDKDKACvCoogNJzXE1foU5M7l2dyK86h2n77HR60+IpkqXSGDcn73ZYuEJ9Hb1IMp7
         QQdPuDl9I/GYjKVTqG2MKr9np/S2QKdKdpZhd4Gc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        David Lechner <david@lechnology.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Sasha Levin (Microsoft)" <sashal@kernel.org>
Subject: [PATCH 5.0 063/101] ARM: davinci: fix build failure with allnoconfig
Date:   Thu,  2 May 2019 17:21:05 +0200
Message-Id: <20190502143344.096467736@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190502143339.434882399@linuxfoundation.org>
References: <20190502143339.434882399@linuxfoundation.org>
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
index 26524b75970a..e5d56d9b712c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -593,6 +593,7 @@ config ARCH_DAVINCI
 	select HAVE_IDE
 	select PM_GENERIC_DOMAINS if PM
 	select PM_GENERIC_DOMAINS_OF if PM && OF
+	select REGMAP_MMIO
 	select RESET_CONTROLLER
 	select USE_OF
 	select ZONE_DMA
-- 
2.19.1



