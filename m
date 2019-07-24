Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D9BC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C012189F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 09:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TogNfouA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfGXJEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 05:04:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36573 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfGXJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 05:04:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id r7so20616440pfl.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 02:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=DPEJMwzbJAL7mef7lqRPjDu2obAzxcY1YJinZ/gcTbM=;
        b=TogNfouA4B2x0/Q3sDRcUS1SKIYDBejwr2Wfalf2jw00n6TspIVeFzrQJYFU1r9rT8
         Di3gId0w+N3KIdd3rLbjOQbDNxtV0orotUsGAlEOOEr9KYTRFeQ6Be4QxPxhnudqT/kV
         Zr01MltnXcHentZnqMjuUwAJpe2U9G2Jc3RH2Uyu3Ksytf0wU40gx1YuHmNvpuioY0cD
         EQHd2lthZ2jcXTAghIlqbX8lD/rKQtIGei2n4srIQa7Wbe3oOVE0E4wNFlu14/PpJumJ
         tgB4nngrSHLAQA+ZDJUvTqOTt6VQ95t4czFd45Kn2lrdOzoPA/UKALZfOJE3kDT0Ha2A
         NMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DPEJMwzbJAL7mef7lqRPjDu2obAzxcY1YJinZ/gcTbM=;
        b=lxxNIt3GrGWNput2sDGkWi1BxRSFewZLXDaP2HCGljL6vEHp500wdL0PO99sU1aSZF
         rEdK5+Gssgyxory6+om+6OChicla04NWf5jT1P3pt5fHvLTsFBs0Qcx6TcVmxkyaDmTa
         7baHjyJXotxUUmIdasqhIFwXF+mE0YOQCkvk4E/MvybuaxlcMcQDPJuRefZfrKs7Zkws
         +rKms9AMe28lVNWPaIzAPBpjTPsVCz17w5+Rf6upDG+qikBENZ+P2fZLfqmvlKy2p6dU
         AP2J/j+tJ1BDyMBNwu+/lADOuYVWTsx+GkfkXOOpXubjn80ZWMs9G/ENPSyG1f+DyZZv
         /lUg==
X-Gm-Message-State: APjAAAWkIrcugdNYZ3SLqkA0GPiEbInPlTva8A46PxHKxSdNObsfk9V4
        q/d5VnNgv6f8MIzE8Q7IDZYTa6T1Bdw=
X-Google-Smtp-Source: APXvYqwB/cPZeqqgk5/HQe9sK+9YFBCH26NX8jJAdLkIgtkkTfxYO0Rlm9/Va5VURS9e/3L8vyw/Yw==
X-Received: by 2002:a63:10a:: with SMTP id 10mr81416955pgb.281.1563959073546;
        Wed, 24 Jul 2019 02:04:33 -0700 (PDT)
Received: from oslab.tsinghua.edu.cn ([2402:f000:4:72:808::3ca])
        by smtp.gmail.com with ESMTPSA id r6sm36362680pgl.74.2019.07.24.02.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2019 02:04:33 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] char: ppdev: Fix a possible null-pointer dereference in pp_release()
Date:   Wed, 24 Jul 2019 17:04:26 +0800
Message-Id: <20190724090426.1401-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In pp_release(), there is an if statement on line 730 to check whether
pp->pdev is NULL:
    else if ((pp->flags & PP_CLAIMED) && pp->pdev && ...)

When pp->pdev is NULL, it is used on line 743:
    info = &pp->pdev->port->ieee1284;
and on line 748:
    parport_release(pp->pdev);

Thus, a possible null-pointer dereference may occur.

To fix this bug, pp->pdev is checked on line 740.

This bug is found by a static analysis tool STCheck written by us.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/char/ppdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
index f0a8adca1eee..c86f18aa8985 100644
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -737,7 +737,7 @@ static int pp_release(struct inode *inode, struct file *file)
 			"negotiated back to compatibility mode because user-space forgot\n");
 	}
 
-	if (pp->flags & PP_CLAIMED) {
+	if ((pp->flags & PP_CLAIMED) && pp->pdev) {
 		struct ieee1284_info *info;
 
 		info = &pp->pdev->port->ieee1284;
-- 
2.17.0

