Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CD3ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A837D21906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbfJASG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:06:26 -0400
Received: from baptiste.telenet-ops.be ([195.130.132.51]:48676 "EHLO
        baptiste.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfJASGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:06:25 -0400
Received: from ramsan ([84.194.98.4])
        by baptiste.telenet-ops.be with bizsmtp
        id 8J6P2100H05gfCL01J6Pmp; Tue, 01 Oct 2019 20:06:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iFMXX-0008KX-7p; Tue, 01 Oct 2019 20:06:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iFMXX-0000Dl-5H; Tue, 01 Oct 2019 20:06:23 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] iommu/ipmmu-vmsa: Only call platform_get_irq() when interrupt is mandatory
Date:   Tue,  1 Oct 2019 20:06:22 +0200
Message-Id: <20191001180622.806-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As platform_get_irq() now prints an error when the interrupt does not
exist, calling it gratuitously causes scary messages like:

    ipmmu-vmsa e6740000.mmu: IRQ index 0 not found

Fix this by moving the call to platform_get_irq() down, where the
existence of the interrupt is mandatory.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix for v5.4-rc1.
---
 drivers/iommu/ipmmu-vmsa.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9da8309f71708f21..237103465b824c51 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -1086,8 +1086,6 @@ static int ipmmu_probe(struct platform_device *pdev)
 
 	mmu->num_ctx = min(IPMMU_CTX_MAX, mmu->features->number_of_contexts);
 
-	irq = platform_get_irq(pdev, 0);
-
 	/*
 	 * Determine if this IPMMU instance is a root device by checking for
 	 * the lack of has_cache_leaf_nodes flag or renesas,ipmmu-main property.
@@ -1106,6 +1104,7 @@ static int ipmmu_probe(struct platform_device *pdev)
 
 	/* Root devices have mandatory IRQs */
 	if (ipmmu_is_root(mmu)) {
+		irq = platform_get_irq(pdev, 0);
 		if (irq < 0) {
 			dev_err(&pdev->dev, "no IRQ found\n");
 			return irq;
-- 
2.17.1

