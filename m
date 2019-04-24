Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096CFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8FC220652
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfDXTZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:25:03 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:36736 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfDXTZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:25:03 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 090583C00D1;
        Wed, 24 Apr 2019 21:25:01 +0200 (CEST)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c08LAztIh0ZG; Wed, 24 Apr 2019 21:24:53 +0200 (CEST)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id ECE203C0034;
        Wed, 24 Apr 2019 21:24:52 +0200 (CEST)
Received: from vmlxhi-102.adit-jv.com (10.72.93.184) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 24 Apr
 2019 21:24:52 +0200
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Christian Gromm <christian.gromm@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     Andrey Shvetsov <andrey.shvetsov@k2l.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Takashi Iwai <tiwai@suse.de>,
        Marcin Ciupak <marcin.s.ciupak@gmail.com>,
        Suresh Udipi <sudipi@jp.adit-jv.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: [PATCH] staging: most: cdev: fix chrdev_region leak in mod_exit
Date:   Wed, 24 Apr 2019 21:23:43 +0200
Message-ID: <20190424192343.15418-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.72.93.184]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suresh Udipi <sudipi@jp.adit-jv.com>

It looks like v4.18-rc1 commit [0] which upstreams mld-1.8.0
commit [1] missed to fix the memory leak in mod_exit function.

Do it now.

[0] aba258b7310167 ("staging: most: cdev: fix chrdev_region leak")
[1] https://github.com/microchip-ais/linux/commit/a2d8f7ae7ea381
    ("staging: most: cdev: fix leak for chrdev_region")

Signed-off-by: Suresh Udipi <sudipi@jp.adit-jv.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 drivers/staging/most/cdev/cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/most/cdev/cdev.c b/drivers/staging/most/cdev/cdev.c
index f2b347cda8b7..d5f236889021 100644
--- a/drivers/staging/most/cdev/cdev.c
+++ b/drivers/staging/most/cdev/cdev.c
@@ -549,7 +549,7 @@ static void __exit mod_exit(void)
 		destroy_cdev(c);
 		destroy_channel(c);
 	}
-	unregister_chrdev_region(comp.devno, 1);
+	unregister_chrdev_region(comp.devno, CHRDEV_REGION_SIZE);
 	ida_destroy(&comp.minor_id);
 	class_destroy(comp.class);
 }
-- 
2.21.0

