Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04C2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LcD0ne8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfCMLDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:03:01 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19097 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMLDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:03:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88e3580002>; Wed, 13 Mar 2019 04:02:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 04:03:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 13 Mar 2019 04:03:00 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 11:02:59 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 11:02:59 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 11:02:59 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c88e35d0002>; Wed, 13 Mar 2019 04:02:59 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <will.deacon@arm.com>,
        <catalin.marinas@arm.com>, <heiko@sntech.de>,
        <horms+renesas@verge.net.au>, <maxime.ripard@bootlin.com>,
        <andy.gross@linaro.org>, <olof@lixom.net>,
        <bjorn.andersson@linaro.org>, <jagan@amarulasolutions.com>,
        <enric.balletbo@collabora.com>, <stefan.wahren@i2se.com>,
        <ezequiel@collabora.com>, <marc.w.gonzalez@free.fr>,
        <christoffer.dall@arm.com>, <drjones@redhat.com>,
        <julien.thierry@arm.com>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 3/5] arm64: defconfig: build gic-pm driver as module
Date:   Wed, 13 Mar 2019 16:32:34 +0530
Message-ID: <1552474956-25513-3-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
References: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552474968; bh=dX1CFIjV6nmWcCJsPOw/jCgm0mcSzYSZ4cyIVrLYs18=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=LcD0ne8vHj1W4DYpQuXiPPbj3jt+7w0fptqoC4tXui01jWE6sBoVlshccEaUHgHRR
         l6WbOFvntEymyX+cTYzk0r2+HkjxibwYmX04i77sSOpN4KeBTpghAU2/4Z7hmuE+au
         WNPolimgTGfqZ5yYGI3Gf+/rcZrNtvKqDJrsvzwOr+Qm2/XhOBbIvpG9zzUfOJfKFA
         /sVroridhe55Tsej9OezJkRqZJ6wbEdfiuxDAnyf4hJT6epRDg4hC+NS20CDWGhNBf
         1LJ9j6Yl1tnOISuGnmzauHzet3ef9Kjnji5liTeQnuo1smzujq4CdPvZVe1nYFMJRf
         wFIwkrVqGYFqA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following config/driver is enabled as module,
 - ARM_GIC_PM (drivers/irqchip/irq-gic-pm.c)

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e9d514c..e919804 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -715,6 +715,7 @@ CONFIG_PWM_ROCKCHIP=y
 CONFIG_PWM_SAMSUNG=y
 CONFIG_PWM_SUN4I=m
 CONFIG_PWM_TEGRA=m
+CONFIG_ARM_GIC_PM=m
 CONFIG_RESET_TI_SCI=y
 CONFIG_PHY_XGENE=y
 CONFIG_PHY_SUN4I_USB=y
-- 
2.7.4

