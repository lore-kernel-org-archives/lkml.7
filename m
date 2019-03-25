Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29872087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 08:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfCYIsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 04:48:31 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:38888 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729618AbfCYIsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 04:48:30 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 8AC019DAEF393E055D82;
        Mon, 25 Mar 2019 16:48:28 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x2P8mHFU051832;
        Mon, 25 Mar 2019 16:48:17 +0800 (GMT-8)
        (envelope-from peng.hao2@zte.com.cn)
Received: from localhost.localdomain.localdomain ([10.74.120.59])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019032516482393-6244021 ;
          Mon, 25 Mar 2019 16:48:23 +0800 
From:   Peng Hao <peng.hao2@zte.com.cn>
To:     vitb@kernel.crashing.org, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     Wen Yang <wen.yang99@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] powerpc/8xx: fix possible object reference leak
Date:   Tue, 26 Mar 2019 01:11:59 +0800
Message-Id: <1553533919-75527-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-25 16:48:24,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-25 16:48:16,
        Serialize complete at 2019-03-25 16:48:16
X-MAIL: mse01.zte.com.cn x2P8mHFU051832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wen Yang <wen.yang99@zte.com.cn>

The call to of_find_compatible_node returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.
irq_domain_add_linear also calls of_node_get to increase refcount,
so irq_domain will not be affected when it is released.

Detected by coccinelle with the following warnings:
./arch/powerpc/platforms/8xx/pic.c:158:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 136, but without a corresponding object release within this function.

Fixes: a8db8cf0d894 ("irq_domain: Replace irq_alloc_host() with
revmap-specific initializers")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Peng Hao <peng.hao2@zte.com.cn>
Cc: Vitaly Bordug <vitb@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 arch/powerpc/platforms/8xx/pic.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
index 8d5a25d..4453df6 100644
--- a/arch/powerpc/platforms/8xx/pic.c
+++ b/arch/powerpc/platforms/8xx/pic.c
@@ -153,9 +153,7 @@ int mpc8xx_pic_init(void)
 	if (mpc8xx_pic_host == NULL) {
 		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
 		ret = -ENOMEM;
-		goto out;
 	}
-	return 0;
 
 out:
 	of_node_put(np);
-- 
2.9.5

