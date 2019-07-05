Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA7FC5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D47420843
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfGEJEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:04:08 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:55016 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727982AbfGEJEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:04:07 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 823F65DFFAA7B06D2835;
        Fri,  5 Jul 2019 17:04:00 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x6591Fw5033077;
        Fri, 5 Jul 2019 17:01:15 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070517014955-2109273 ;
          Fri, 5 Jul 2019 17:01:49 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: fix use-after-free on fixup_port_irq()
Date:   Fri, 5 Jul 2019 16:59:36 +0800
Message-Id: <1562317176-13317-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-05 17:01:49,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-05 17:01:21,
        Serialize complete at 2019-07-05 17:01:21
X-MAIL: mse-fl1.zte.com.cn x6591Fw5033077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a possible use-after-free issue in the fixup_port_irq():

460 static void __init fixup_port_irq(int index,
461                                   struct device_node *np,
462                                   struct plat_serial8250_port *port)
463 {
...
469         if (!virq && legacy_serial_infos[index].irq_check_parent) {
470                 np = of_get_parent(np);  --> modified here.
...
474                 of_node_put(np); ---> released here
475         }
...
481 #ifdef CONFIG_SERIAL_8250_FSL
482   if (of_device_is_compatible(np, "fsl,ns16550")) --> dereferenced here
...
484 #endif
485 }

We solve this problem by introducing a new parent_np variable.

Fixes: 9deaa53ac7fa ("serial: add irq handler for Freescale 16550 errata.")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Rob Herring <robh@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/kernel/legacy_serial.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
index 7cea597..0105f3e 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -461,17 +461,18 @@ static void __init fixup_port_irq(int index,
 				  struct device_node *np,
 				  struct plat_serial8250_port *port)
 {
+	struct device_node *parent_np;
 	unsigned int virq;
 
 	DBG("fixup_port_irq(%d)\n", index);
 
 	virq = irq_of_parse_and_map(np, 0);
 	if (!virq && legacy_serial_infos[index].irq_check_parent) {
-		np = of_get_parent(np);
-		if (np == NULL)
+		parent_np = of_get_parent(np);
+		if (parent_np == NULL)
 			return;
-		virq = irq_of_parse_and_map(np, 0);
-		of_node_put(np);
+		virq = irq_of_parse_and_map(parent_np, 0);
+		of_node_put(parent_np);
 	}
 	if (!virq)
 		return;
-- 
2.9.5

