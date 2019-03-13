Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D55C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F257D2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 11:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FaQ0yIVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfCMLDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:03:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19138 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfCMLDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 07:03:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c88e3670001>; Wed, 13 Mar 2019 04:03:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 13 Mar 2019 04:03:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 13 Mar 2019 04:03:15 -0700
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 13 Mar
 2019 11:03:14 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 13 Mar 2019 11:03:14 +0000
Received: from linux.nvidia.com (Not Verified[10.24.34.185]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c88e36c0003>; Wed, 13 Mar 2019 04:03:14 -0700
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
Subject: [PATCH 5/5] irqchip/gic-pm: fix suspend handling
Date:   Wed, 13 Mar 2019 16:32:36 +0530
Message-ID: <1552474956-25513-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
References: <1552474956-25513-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552474983; bh=/c8dBXdCBjgWpy/eL9d436j0fbetwt7w7YVIz7Xrtf0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:Content-Type;
        b=FaQ0yIVwXWq0SFhKb4i6mZ9HKEWaNC0anRSwckcz6vABVkATxO0vX/AIEw5uTEFjs
         iIMChNL4cFa1Nhw6GQc4zXZF2qvd6R3yLtXAUTb005LEnU7FntXS6evYV8b6XJZqME
         sJGSGk/JWgEmHt9MBsNutLmaRWbSv2pEfxdI7YpaqY8jGC70zeTMCCc/mE1COLkHpp
         SAV777tyzSQM7r9Px2hmdF5c5trOCsxZCpXdEk2F+DjMxNC3eMFGNnfZgTnf8kNA+K
         WBSs2rWm7F96IbRbAjr1HuLnuifWZUysjy22d9+ddIN9dmlespHFMZCpIqp6eG3P5v
         h97AY04noaTNA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If interrupts are enabled for a non-root GIC device that uses the
gic-pm driver, when system suspend occurs, the current interrupt
state is not saved and restored correctly and so interrupts do not
work again on resuming the system. Add a late suspend handler to
save and restore the state for these devices.

Suggested-by: Jonathan Hunter <jonathanh@nvidia.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 drivers/irqchip/irq-gic-pm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-pm.c b/drivers/irqchip/irq-gic-pm.c
index b5405df..583858d 100644
--- a/drivers/irqchip/irq-gic-pm.c
+++ b/drivers/irqchip/irq-gic-pm.c
@@ -180,6 +180,8 @@ static int gic_remove(struct platform_device *pdev)
 static const struct dev_pm_ops gic_pm_ops = {
 	SET_RUNTIME_PM_OPS(gic_runtime_suspend,
 			   gic_runtime_resume, NULL)
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				     pm_runtime_force_resume)
 };
 
 static const char * const gic400_clocks[] = {
-- 
2.7.4

