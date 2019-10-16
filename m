Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF272FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2508218DE
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394109AbfJPObq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:31:46 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:33196 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390135AbfJPObq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:31:46 -0400
Received: from ramsan ([84.194.98.4])
        by laurent.telenet-ops.be with bizsmtp
        id EEXk2100105gfCL01EXkit; Wed, 16 Oct 2019 16:31:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iKkL1-0003n0-Sl; Wed, 16 Oct 2019 16:31:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1iKkL1-0007W7-Pz; Wed, 16 Oct 2019 16:31:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] of: unittest: Use platform_get_irq_optional() for non-existing interrupt
Date:   Wed, 16 Oct 2019 16:31:42 +0200
Message-Id: <20191016143142.28854-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As platform_get_irq() now prints an error when the interrupt
does not exist, a scary warning may be printed for a non-existing
interrupt:

    platform testcase-data:testcase-device2: IRQ index 0 not found

Fix this by calling platform_get_irq_optional() instead.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix for v5.4.
---
 drivers/of/unittest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 9efae29722588a35..34da22f8b0660989 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -1121,7 +1121,7 @@ static void __init of_unittest_platform_populate(void)
 		np = of_find_node_by_path("/testcase-data/testcase-device2");
 		pdev = of_find_device_by_node(np);
 		unittest(pdev, "device 2 creation failed\n");
-		irq = platform_get_irq(pdev, 0);
+		irq = platform_get_irq_optional(pdev, 0);
 		unittest(irq < 0 && irq != -EPROBE_DEFER,
 			 "device parsing error failed - %d\n", irq);
 	}
-- 
2.17.1

