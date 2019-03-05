Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B3DC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B64A20842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 11:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfCELb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 06:31:58 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:40562 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727305AbfCELb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 06:31:57 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id EC47D1D4CC034625443C;
        Tue,  5 Mar 2019 19:31:55 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x25BVpff071141;
        Tue, 5 Mar 2019 19:31:51 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019030519320448-3290744 ;
          Tue, 5 Mar 2019 19:32:04 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] ARM: mvebu: fix a leaked reference by adding missing of_node_put
Date:   Tue, 5 Mar 2019 19:32:55 +0800
Message-Id: <1551785577-45896-2-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn>
References: <1551785577-45896-1-git-send-email-wen.yang99@zte.com.cn>
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-05 19:32:04,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-05 19:31:47,
        Serialize complete at 2019-03-05 19:31:47
X-MAIL: mse01.zte.com.cn x25BVpff071141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_get_next_child returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./arch/arm/mach-mvebu/pm-board.c:135:2-8: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 88, but without a corresponding object release within this functio

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 arch/arm/mach-mvebu/pm-board.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm-board.c b/arch/arm/mach-mvebu/pm-board.c
index db17121..1e2c17c 100644
--- a/arch/arm/mach-mvebu/pm-board.c
+++ b/arch/arm/mach-mvebu/pm-board.c
@@ -79,7 +79,7 @@ static void mvebu_armada_pm_enter(void __iomem *sdram_reg, u32 srcmd)
 static int __init mvebu_armada_pm_init(void)
 {
 	struct device_node *np;
-	struct device_node *gpio_ctrl_np;
+	struct device_node *gpio_ctrl_np = NULL;
 	int ret = 0, i;
 
 	if (!of_machine_is_compatible("marvell,axp-gp"))
@@ -126,18 +126,23 @@ static int __init mvebu_armada_pm_init(void)
 			goto out;
 		}
 
+		if(gpio_ctrl_np)
+			of_node_put(gpio_ctrl_np);
 		gpio_ctrl_np = args.np;
 		pic_raw_gpios[i] = args.args[0];
 	}
 
 	gpio_ctrl = of_iomap(gpio_ctrl_np, 0);
-	if (!gpio_ctrl)
-		return -ENOMEM;
+	if (!gpio_ctrl) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
 	mvebu_pm_suspend_init(mvebu_armada_pm_enter);
 
 out:
 	of_node_put(np);
+	of_node_put(gpio_ctrl_np);
 	return ret;
 }
 
-- 
2.9.5

