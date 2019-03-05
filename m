Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C7DCC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7484720842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfCELeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:34:12 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:41466 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfCELdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:33:04 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 6181D86964BA3369A5EA;
        Tue,  5 Mar 2019 19:33:02 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x25BWv81072314;
        Tue, 5 Mar 2019 19:32:57 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030519331333-3291555 ;
          Tue, 5 Mar 2019 19:33:13 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/15] ARM: hisi: fix a leaked reference by adding missing of_node_put
Date:   Tue, 5 Mar 2019 19:33:55 +0800
Message-Id: <1551785646-46173-4-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-05 19:33:13,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-05 19:32:53,
        Serialize complete at 2019-03-05 19:32:53
X-MAIL: mse01.zte.com.cn x25BWv81072314
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
v2->v1: add a missing space between "adding" and "missing"

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

