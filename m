Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01188C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C545520842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfCELb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:31:58 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:58986 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfCELb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:31:58 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 4693789E01186A5FB42F;
        Tue,  5 Mar 2019 19:31:55 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x25BVpfe071141;
        Tue, 5 Mar 2019 19:31:51 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030519320223-3290722 ;
          Tue, 5 Mar 2019 19:32:02 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Russell King <linux@armlinux.org.uk>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: brcmstb: fix a leaked reference by adding missing of_node_put
Date:   Tue, 5 Mar 2019 19:32:54 +0800
Message-Id: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-05 19:32:02,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-05 19:31:47,
        Serialize complete at 2019-03-05 19:31:47
X-MAIL: mse01.zte.com.cn x25BVpfe071141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-bcm/platsmp-brcmstb.c:337:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 329, but without a corresponding object release within this function.
./arch/arm/mach-bcm/platsmp-brcmstb.c:341:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 329, but without a corresponding object release within this functio
./arch/arm/mach-bcm/bcm63xx_smp.c:150:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 130, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: Russell King <linux@armlinux.org.uk>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Gregory Fong <gregory.0xf0@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/mach-bcm/bcm63xx_smp.c     | 1 +
 arch/arm/mach-bcm/platsmp-brcmstb.c | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-bcm/bcm63xx_smp.c b/arch/arm/mach-bcm/bcm63xx_smp.c
index f5fb10b..1cb4ce8 100644
--- a/arch/arm/mach-bcm/bcm63xx_smp.c
+++ b/arch/arm/mach-bcm/bcm63xx_smp.c
@@ -142,6 +142,7 @@ static int bcm63138_smp_boot_secondary(unsigned int cpu,
 	 * return
 	 */
 	ret = bcm63xx_pmb_power_on_cpu(dn);
+	of_node_put(dn);
 	if (ret)
 		goto out;
 out:
diff --git a/arch/arm/mach-bcm/platsmp-brcmstb.c b/arch/arm/mach-bcm/platsmp-brcmstb.c
index 1237996..4555f21 100644
--- a/arch/arm/mach-bcm/platsmp-brcmstb.c
+++ b/arch/arm/mach-bcm/platsmp-brcmstb.c
@@ -334,11 +334,14 @@ static void __init brcmstb_cpu_ctrl_setup(unsigned int max_cpus)
 
 	rc = setup_hifcpubiuctrl_regs(np);
 	if (rc)
-		return;
+		goto out_put_node;
 
 	rc = setup_hifcont_regs(np);
 	if (rc)
-		return;
+		goto out_put_node;
+
+out_put_node:
+	of_node_put(np);
 }
 
 static int brcmstb_boot_secondary(unsigned int cpu, struct task_struct *idle)
-- 
2.9.5

