Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 126D0C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62BA2081B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 15:37:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WceqsJKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCIPgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 10:36:45 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46818 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbfCIPgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 10:36:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id g6so340103pfh.13;
        Sat, 09 Mar 2019 07:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mKX7nHl0E3bMBOEvjq+9ioWsVbmR1gncT6svDrCMxtE=;
        b=WceqsJKWUuiMUYqcaTNzQO97FxsQq/tB/yyJ62Pe+fS8OlO9qEJ9fZug2x3ZW4UUit
         m0MiXdzFHsP30Id7IGBr+HIxfwvTp8de6Gd4FtgcQ6LpH1VYUu2DG36xp0PsXd5VhAS5
         skaZQdPZ6xeR6/VjJtBJn61rA8ndG8QIAEm4Rf3WBq9yhUWgq9S5Ad73xqQrS+GvH6N/
         rmHXV6Dx++TA9IK5nhPp7928zW8V99iqvlx/124lYWNQYJ+qiHCJVHlDNzjBidxxx4qv
         R5hfkXdSEzso3/Yj+X0mDzT8LBrQpcT8dW+9V49JyXKLTssXvnoMv3bYDWnM9P5RuQf1
         94cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mKX7nHl0E3bMBOEvjq+9ioWsVbmR1gncT6svDrCMxtE=;
        b=FM0/k+KjDqmrFoX6Zn3qK/4ejhSgvQgAu+Kq2TWPezSSTuLOXBwT6Dh33Cxo5O9HVK
         4QJBdSlFiOfco0z5GxhRuJDnwqCBF1EIugdZZcNrud5eo0ZnPRr1wsPnmgrPjM1NWN1O
         iT5L9PHT4P5Od6vcPqy6A0ijkwqWqF01H7aklvikwPKmYe9gHTP3hJ5jTYIVFQWiBdBv
         FXZX5KMRXeR3hbd8esjaOTku3hjKvaKZfCnblwyhz/5uFP2Ldol2hbbppiRxN6lRimpY
         sjm5Ei+PEoX3xBVYQs7/igqZUXKjOTpZzoWFocG+fGIur0hbBlrze/lkgXAIszfjmTLP
         cXyA==
X-Gm-Message-State: APjAAAWjUriWPGNbj504KW3GRWKAZtBoIEKfFf5IOmJ3CiV/u7O54aYk
        /htb5FMuQHzQTUpLNIJxx+M=
X-Google-Smtp-Source: APXvYqxMtWjukEf6d+X/QbV9+JFo3FM1bEsvicC1/OMRQwh+qLUmygvcPi7STHcq7OxjeVeNhv91TQ==
X-Received: by 2002:a63:b242:: with SMTP id t2mr22032518pgo.451.1552145804430;
        Sat, 09 Mar 2019 07:36:44 -0800 (PST)
Received: from localhost (www.xihetech.top. [159.203.232.101])
        by smtp.gmail.com with ESMTPSA id r131sm1317822pgr.65.2019.03.09.07.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Mar 2019 07:36:44 -0800 (PST)
From:   Sean Fu <fxinrong@gmail.com>
To:     darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Fu <fxinrong@gmail.com>
Subject: [PATCH] xfs: Use kmem_zalloc for bp->b_pages.
Date:   Sat,  9 Mar 2019 23:36:36 +0800
Message-Id: <20190309153636.14154-1-fxinrong@gmail.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the allocation of bp->b_pages to use kmem_zalloc instead of
kmem_alloc.
Remove unnecessary memset for bp->b_pages.

This reduces text size by 42 bytes.
Before:
   text	   data	    bss	    dec	    hex	filename
  23335	    588	      8	  23931	   5d7b	./fs/xfs/xfs_buf.o
After:
   text	   data	    bss	    dec	    hex	filename
  23293	    588	      8	  23889	   5d51	./fs/xfs/xfs_buf.o

Signed-off-by: Sean Fu <fxinrong@gmail.com>
---
 fs/xfs/xfs_buf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 4f5f2ff3f70f..be4f740b97c1 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -289,12 +289,11 @@ _xfs_buf_get_pages(
 		if (page_count <= XB_PAGES) {
 			bp->b_pages = bp->b_page_array;
 		} else {
-			bp->b_pages = kmem_alloc(sizeof(struct page *) *
+			bp->b_pages = kmem_zalloc(sizeof(struct page *) *
 						 page_count, KM_NOFS);
 			if (bp->b_pages == NULL)
 				return -ENOMEM;
 		}
-		memset(bp->b_pages, 0, sizeof(struct page *) * page_count);
 	}
 	return 0;
 }
-- 
2.16.4

