Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFD9C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39B2218AE
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 08:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfCAI5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 03:57:12 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:11802 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfCAI5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 03:57:11 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 0BD96B86D0BDC44FF4DF;
        Fri,  1 Mar 2019 16:57:09 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x218uwJa086664;
        Fri, 1 Mar 2019 16:56:58 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030116573748-2498957 ;
          Fri, 1 Mar 2019 16:57:37 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     liviu.dudau@arm.com
Cc:     sudeep.holla@arm.com, lorenzo.pieralisi@arm.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kgene@kernel.org, krzk@kernel.org,
        linux-samsung-soc@vger.kernel.org, michal.simek@xilinx.com,
        afaerber@suse.de, manivannan.sadhasivam@linaro.org,
        dinguyen@kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, linus.walleij@linaro.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, venture@google.com,
        yuenn@google.com, brendanhiggins@google.com,
        openbmc@lists.ozlabs.org, xuwei5@hisilicon.com,
        maxime.ripard@bootlin.com, wens@csie.org, catalin.marinas@arm.com,
        will.deacon@arm.com, horms@verge.net.au, magnus.damm@gmail.com,
        linux-renesas-soc@vger.kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de,
        fabio.estevam@nxp.com, linux-imx@nxp.com, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 04/15] ARM: hisi: fix a leaked reference by addingmissing of_node_put
Date:   Fri, 1 Mar 2019 16:56:45 +0800
Message-Id: <1551430616-42014-4-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551430616-42014-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-01 16:57:37,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-01 16:56:43,
        Serialize complete at 2019-03-01 16:56:43
X-MAIL: mse01.zte.com.cn x218uwJa086664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-hisi/platsmp.c:74:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
./arch/arm/mach-hisi/platsmp.c:78:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 66, but without a corresponding object release within this function.
./arch/arm/mach-hisi/platmcpm.c:337:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 275, but without a corresponding object release within this function.
./arch/arm/mach-hisi/platmcpm.c:347:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 275, but without a corresponding object release within this function.
./arch/arm/mach-hisi/platmcpm.c:337:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 284, but without a corresponding object release within this function.
./arch/arm/mach-hisi/platmcpm.c:347:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 284, but without a corresponding object release within this function.
./arch/arm/mach-hisi/platmcpm.c:337:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 287, but without a corresponding object release within this function.
./arch/arm/mach-hisi/platmcpm.c:347:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 287, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/mach-hisi/platmcpm.c | 12 ++++++++++--
 arch/arm/mach-hisi/platsmp.c  |  7 +++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-hisi/platmcpm.c b/arch/arm/mach-hisi/platmcpm.c
index f66815c..695423c 100644
--- a/arch/arm/mach-hisi/platmcpm.c
+++ b/arch/arm/mach-hisi/platmcpm.c
@@ -277,6 +277,7 @@ static int __init hip04_smp_init(void)
 		goto err;
 	ret = of_property_read_u32_array(np, "boot-method",
 					 &hip04_boot_method[0], 4);
+	of_node_put(np);
 	if (ret)
 		goto err;
 
@@ -285,12 +286,14 @@ static int __init hip04_smp_init(void)
 	if (!np_sctl)
 		goto err;
 	np_fab = of_find_compatible_node(NULL, NULL, "hisilicon,hip04-fabric");
-	if (!np_fab)
+	if (!np_fab) {
+		of_node_put(np_sctl);
 		goto err;
+	}
 
 	ret = memblock_reserve(hip04_boot_method[0], hip04_boot_method[1]);
 	if (ret)
-		goto err;
+		goto err_put_node;
 
 	relocation = ioremap(hip04_boot_method[2], hip04_boot_method[3]);
 	if (!relocation) {
@@ -334,6 +337,8 @@ static int __init hip04_smp_init(void)
 	iounmap(relocation);
 
 	smp_set_ops(&hip04_smp_ops);
+	of_node_put(np_fab);
+	of_node_put(np_sctl);
 	return ret;
 err_table:
 	iounmap(fabric);
@@ -343,6 +348,9 @@ static int __init hip04_smp_init(void)
 	iounmap(relocation);
 err_reloc:
 	memblock_free(hip04_boot_method[0], hip04_boot_method[1]);
+err_put_node:
+	of_node_put(np_fab);
+	of_node_put(np_sctl);
 err:
 	return ret;
 }
diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index da5689a..ecc68fa 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -71,14 +71,17 @@ static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
 		ctrl_base = of_iomap(np, 0);
 		if (!ctrl_base) {
 			pr_err("failed to map address\n");
-			return;
+			goto out_put_node;
 		}
 		if (of_property_read_u32(np, "smp-offset", &offset) < 0) {
 			pr_err("failed to find smp-offset property\n");
-			return;
+			goto out_put_node;
 		}
 		ctrl_base += offset;
 	}
+
+out_put_node:
+	of_node_put(np);
 }
 
 static int hi3xxx_boot_secondary(unsigned int cpu, struct task_struct *idle)
-- 
2.9.5

