Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D991ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CC3215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731330AbfJASLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:11:13 -0400
Received: from andre.telenet-ops.be ([195.130.132.53]:46620 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbfJASLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:11:13 -0400
Received: from ramsan ([84.194.98.4])
        by andre.telenet-ops.be with bizsmtp
        id 8JBA2100705gfCL01JBAMM; Tue, 01 Oct 2019 20:11:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iFMcA-0008Mo-C6; Tue, 01 Oct 2019 20:11:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iFMcA-0000Md-Ab; Tue, 01 Oct 2019 20:11:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] phy: renesas: rcar-gen3-usb2: Use platform_get_irq_optional() for optional irq
Date:   Tue,  1 Oct 2019 20:11:09 +0200
Message-Id: <20191001181109.1355-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As platform_get_irq() now prints an error when the interrupt does not
exist, a scary warning may be printed for an optional interrupt:

    phy_rcar_gen3_usb2 ee0a0200.usb-phy: IRQ index 0 not found

Fix this by calling platform_get_irq_optional() instead.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix for v5.4-rc1.
---
 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index b7f6b132439521ea..49ec67d46ccc5a37 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -614,7 +614,7 @@ static int rcar_gen3_phy_usb2_probe(struct platform_device *pdev)
 		return PTR_ERR(channel->base);
 
 	/* call request_irq for OTG */
-	irq = platform_get_irq(pdev, 0);
+	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
 		INIT_WORK(&channel->work, rcar_gen3_phy_usb2_work);
 		irq = devm_request_irq(dev, irq, rcar_gen3_phy_usb2_irq,
-- 
2.17.1

