Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463FAC10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A4521721
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 07:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfDMHUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Apr 2019 03:20:50 -0400
Received: from www.osadl.org ([62.245.132.105]:36387 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbfDMHUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Apr 2019 03:20:50 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x3D7JfAW003435;
        Sat, 13 Apr 2019 09:20:24 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ARM: u300: add missing check for kmalloc
Date:   Sat, 13 Apr 2019 09:14:20 +0200
Message-Id: <1555139666-948-9-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1555139666-948-1-git-send-email-hofrat@osadl.org>
References: <1555139666-948-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 kmalloc return for bigrxbuf_virtual was not being checked - in case
of failure set status, cleanup bigtxbuf_virtual and baile out.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: c7c8c78fdf6e ("ARM: 5667/3: U300 SSP/SPI board setup and test")
---

Issue found with experimental coccinelle script

Not sure about the checkpatch message: 
CHECK: Comparison to NULL could be written "!bigrxbuf_virtual"
#32: FILE: arch/arm/mach-u300/dummyspichip.c:67:
+       if (bigrxbuf_virtual == NULL) {
As the current check for bigtxbuf_virtual uses == NULL that 
was retained for consistency here.

Patch was compile tested with: u300_defconfig (implies MACH_U300_SPIDUMMY=y)

Patch is against 4.18 (localversion-next is next-20180824)

 arch/arm/mach-u300/dummyspichip.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-u300/dummyspichip.c b/arch/arm/mach-u300/dummyspichip.c
index 68fe986..ff293ee 100644
--- a/arch/arm/mach-u300/dummyspichip.c
+++ b/arch/arm/mach-u300/dummyspichip.c
@@ -62,7 +62,13 @@ static ssize_t dummy_looptest(struct device *dev,
 		status = -ENOMEM;
 		goto out;
 	}
+
 	bigrxbuf_virtual = kmalloc(DMA_TEST_SIZE, GFP_KERNEL);
+	if (bigrxbuf_virtual == NULL) {
+		kfree(bigtxbuf_virtual);
+		status = -ENOMEM;
+		goto out;
+	}
 
 	/* Fill TXBUF with some happy pattern */
 	memset(bigtxbuf_virtual, 0xAA, DMA_TEST_SIZE);
-- 
2.1.4

