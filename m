Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1717C20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554139998;
	bh=nQ/bgaX1FMWhaK0Oh9lXZyCW5bIFukFSMFRGdBLk9w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PgokLkefxNVMcd5lCNIPL3V/awQ4Tvx6rNa6veRYHfyBBhk3VWrMj7VrUWiSzMJ4K
	 ApFdYdjJhr0wGrRQfSK39C98JI7r5jOtbipNUTEC3SkTicTHVh8+rUVrXO4pt0WDHG
	 a2dD+rgPp7zCEjvo+iX6WbU5nNuwg50XQebED7Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387606AbfDARdQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387410AbfDARdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96CD82070B;
        Mon,  1 Apr 2019 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554139993;
        bh=nQ/bgaX1FMWhaK0Oh9lXZyCW5bIFukFSMFRGdBLk9w4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Q46uhZroslZgzsmLZwmhZj6/kg6lWGxTRtUynwUQIynMhvRRFmFHLgMlQXseT2Ua
         EB1vgpv9r0W/KrT4+tX2cJtboYaMzmNQiV0xOZch9TM+rLd0qgh2ec1O/6UyKTNk+O
         DqW8L8qdBLTlpfiZiL0ggHZys9imOCdroNKa96bg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 073/131] ARM: 8510/1: rework ARM_CPU_SUSPEND dependencies
Date:   Mon,  1 Apr 2019 19:02:23 +0200
Message-Id: <20190401170058.235729540@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170051.645954551@linuxfoundation.org>
References: <20190401170051.645954551@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 1b9bdf5c1661873a10e193b8cbb803a87fe5c4a1 ]

The code enabled by the ARM_CPU_SUSPEND config option is used by
kernel subsystems for purposes that go beyond system suspend so its
config entry should be augmented to take more default options into
account and avoid forcing its selection to prevent dependencies
override.

To achieve this goal, this patch reworks the ARM_CPU_SUSPEND config
entry and updates its default config value (by adding the BL_SWITCHER
option to it) and its dependencies (ARCH_SUSPEND_POSSIBLE), so that the
symbol is still selected by default by the subsystems requiring it and
at the same time enforcing the dependencies correctly.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Nicolas Pitre <nico@fluxnic.net>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4cc908ee107f..737c8b0dda84 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1423,7 +1423,6 @@ config BIG_LITTLE
 config BL_SWITCHER
 	bool "big.LITTLE switcher support"
 	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU && ARM_GIC
-	select ARM_CPU_SUSPEND
 	select CPU_PM
 	help
 	  The big.LITTLE "switcher" provides the core functionality to
@@ -2141,7 +2140,8 @@ config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 
 config ARM_CPU_SUSPEND
-	def_bool PM_SLEEP
+	def_bool PM_SLEEP || BL_SWITCHER
+	depends on ARCH_SUSPEND_POSSIBLE
 
 config ARCH_HIBERNATION_POSSIBLE
 	bool
-- 
2.19.1



