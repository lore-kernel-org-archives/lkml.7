Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E023BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB6520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140021;
	bh=hpxPCv7z+UxtvYx1vi3wB6bqqgjHe5JZF6SMuqsy+8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h9QKT7mCEF9Mc9rKcrUyoHNC8YB0lNJ+VRhtOkcXWzlPBClcA+AQ5q5EJKykM6d2D
	 bqiUdDi3gvlykorl4H2iIrHrwS8zef3N5YYPeFXGRPp+rY9gd7xKvloB5x0lfB1U3r
	 PIR2OfIVjI/JgkcjUznOUXlxlJubpnlgcOo18S8c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbfDARdk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:33:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730671AbfDARdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9034E20856;
        Mon,  1 Apr 2019 17:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140017;
        bh=hpxPCv7z+UxtvYx1vi3wB6bqqgjHe5JZF6SMuqsy+8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wf2ateGtMdLS1HkYThTh4SjEPLiEjRkHPPmkoMLXGuGiKWuz7cLjiIZMLEMYOIkNZ
         I24Rsz654S0baW6dlmCiaAsZKPm4Lm1QV3dExrwzhp9zjkStFO524FhQPB37SyKjsX
         KqA8dMCPIK8bXbfU3CFPHatn7AdRxyq5TUiXfLO8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Nicolas Pitre <nico@linaro.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 044/131] ARM: 8458/1: bL_switcher: add GIC dependency
Date:   Mon,  1 Apr 2019 19:01:54 +0200
Message-Id: <20190401170055.997964743@linuxfoundation.org>
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

[ Upstream commit 6c044fecdf78be3fda159a5036bb33700cdd5e59 ]

It is not possible to build the bL_switcher code if the GIC
driver is disabled, because it relies on calling into some
gic specific interfaces, and that would result in this build
error:

arch/arm/common/built-in.o: In function `bL_switch_to':
:(.text+0x1230): undefined reference to `gic_get_sgir_physaddr'
:(.text+0x1244): undefined reference to `gic_send_sgi'
:(.text+0x1268): undefined reference to `gic_migrate_target'
arch/arm/common/built-in.o: In function `bL_switcher_enable.part.4':
:(.text.unlikely+0x2f8): undefined reference to `gic_get_cpu_id'

This adds a Kconfig dependency to ensure we only build the big-little
switcher if the GIC driver is present as well.

Almost all ARMv7 platforms come with a GIC anyway, but it is possible
to build a kernel that disables all platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Nicolas Pitre <nico@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3a0277c6c060..4cc908ee107f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1422,7 +1422,7 @@ config BIG_LITTLE
 
 config BL_SWITCHER
 	bool "big.LITTLE switcher support"
-	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU
+	depends on BIG_LITTLE && MCPM && HOTPLUG_CPU && ARM_GIC
 	select ARM_CPU_SUSPEND
 	select CPU_PM
 	help
-- 
2.19.1



