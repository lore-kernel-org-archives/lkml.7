Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB81C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8FBB20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbfCELdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:33:15 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:41662 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfCELdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:33:14 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 7EDDDD58223DA31DDDB1;
        Tue,  5 Mar 2019 19:33:12 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x25BX5pD072493;
        Tue, 5 Mar 2019 19:33:05 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030519332133-3291629 ;
          Tue, 5 Mar 2019 19:33:21 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 11/15] ARM: versatile: fix a leaked reference by adding missing of_node_put
Date:   Tue, 5 Mar 2019 19:34:02 +0800
Message-Id: <1551785646-46173-11-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551785646-46173-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-05 19:33:21,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-05 19:33:01,
        Serialize complete at 2019-03-05 19:33:01
X-MAIL: mse01.zte.com.cn x25BX5pD072493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-versatile/versatile_dt.c:315:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 302, but without a corresponding object release within this function.
./arch/arm/mach-versatile/versatile_dt.c:320:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 302, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
v2->v1: add a missing space between "adding" and "missing"

 arch/arm/mach-versatile/versatile_dt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index e9d6068..028463a 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -312,12 +312,12 @@ static void __init versatile_dt_pci_init(void)
 		 * driver had it so we will keep it.
 		 */
 		writel(1, versatile_sys_base + VERSATILE_SYS_PCICTL_OFFSET);
-		return;
+		goto out_put_node;
 	}
 
 	newprop = kzalloc(sizeof(*newprop), GFP_KERNEL);
 	if (!newprop)
-		return;
+		goto out_put_node;
 
 	newprop->name = kstrdup("status", GFP_KERNEL);
 	newprop->value = kstrdup("disabled", GFP_KERNEL);
@@ -325,6 +325,9 @@ static void __init versatile_dt_pci_init(void)
 	of_update_property(np, newprop);
 
 	pr_info("Not plugged into PCI backplane!\n");
+
+out_put_node:
+	of_node_put(np);
 }
 
 static void __init versatile_dt_init(void)
-- 
2.9.5

