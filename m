Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45028C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130E42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732071AbfCZXxz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:53:55 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:29376 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbfCZXxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:53:54 -0400
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id AB747C5A897CABFF39CF;
        Wed, 27 Mar 2019 07:53:52 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x2QNrl8G092847;
        Wed, 27 Mar 2019 07:53:47 +0800 (GMT-8)
        (envelope-from huang.zijiang@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019032707540574-6463506 ;
          Wed, 27 Mar 2019 07:54:05 +0800 
From:   Huang Zijiang <huang.zijiang@zte.com.cn>
To:     dinguyen@kernel.org
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Huang Zijiang <huang.zijiang@zte.com.cn>
Subject: [PATCH] ARM: socfpga: Fix object reference leaks in socfpga_setup_ocram_self_refresh
Date:   Wed, 27 Mar 2019 07:53:42 +0800
Message-Id: <1553644422-42950-1-git-send-email-huang.zijiang@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-03-27 07:54:06,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-03-27 07:53:39,
        Serialize complete at 2019-03-27 07:53:39
X-MAIL: mse01.zte.com.cn x2QNrl8G092847
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

Signed-off-by: Huang Zijiang <huang.zijiang@zte.com.cn>
---
 arch/arm/mach-socfpga/pm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
index d486678..8d7ca14 100644
--- a/arch/arm/mach-socfpga/pm.c
+++ b/arch/arm/mach-socfpga/pm.c
@@ -53,7 +53,7 @@ static int socfpga_setup_ocram_self_refresh(void)
 	if (!pdev) {
 		pr_warn("%s: failed to find ocram device!\n", __func__);
 		ret = -ENODEV;
-		goto put_node;
+		goto fail;
 	}
 
 	ocram_pool = gen_pool_get(&pdev->dev, NULL);
@@ -94,6 +94,9 @@ static int socfpga_setup_ocram_self_refresh(void)
 
 put_node:
 	of_node_put(np);
+	put_device(&np->dev);
+fail:
+	of_node_put(np);
 
 	return ret;
 }
-- 
1.8.3.1

