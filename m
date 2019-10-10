Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7480C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABA020B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570720901;
	bh=9ecEDd8xBU24OkqlZvNTRKYd8UG4+RHVv1jo8KgNQcI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=c6jAjwuRp5rmQJcPI5zTQchkgWA6Wr3I43Txv+jmOjdxRGYRXe6oFhd5Dzxdzh7uK
	 fGIu9juzu9GK7UPxZjN58UkuXUgBjCzl5klI62YFdWn1NQni0or3taUYr6xdtgONSo
	 cFHS4w50oNklSgIrYAB5WwmCmOxdqal7lkBhxGk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfJJPVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:21:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42990 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfJJPVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:21:39 -0400
Received: by mail-pf1-f196.google.com with SMTP id q12so4112697pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJ0bdDzYh0lxFK9AeeKMP0j0WGOxu0ifEP2yMEIR13Q=;
        b=uplxbTeuvNXnuCU8R/Ocyq1MEfTaAw4hd9XM4pYTzr2xPjME6dZy5IS7xWFPtYcPeS
         2PzzqS1XBNyvOxgeG8XoZxGupCW4ml0D70Aj/Tftmehzz7c2RedhUcryHqXU2ZkG7+CF
         5x4wv2MQW4Z5CmpsztgpwO7a7mxGKYEfluVi6kJN5v8xz9xvnXAEbVUVHF/MXxL/4b0P
         a+frqmj9pdfXgr9nA2ieosL5pN3Xzl4jEDYCJy7Rlc5f62T6qRlNxFNbyWpetQH66leg
         QCSaRYFGH3LgLp94xuLNw7TLHwS2li4y2R/VDe6XSt8PuQ5o2TQ3xMl0muPKE6tMC37E
         9arQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GJ0bdDzYh0lxFK9AeeKMP0j0WGOxu0ifEP2yMEIR13Q=;
        b=da4d0hY2iIJllCat39rnN5At72u6ND4B/z/GU23BPgwbnchc2Ln767iYlhtzM2MFk1
         vFld1qJ9isVcYFaWtbm7U/Ao32TsHEg4DzrLDYYn7rn6fNSLAR+mWBaqxTX7G4N4SOCe
         p3GWzYIFfJmYDhP530S/DN0X6r/pigoKvIapX4Li+wj1nvyapLRTENzdzMIQhypBr9p8
         7anzW03pje1hpCbTA+aazWiI+0CxlHxo2iONh9Bwjr+c+202LkbKlHcPk+QvVwdtg/80
         yc2quGikXcjZ8wust/x9YXX+qVewqWZ+3nOvweuJvKdw7RTLiFWEt+rMty06TUkjHt6o
         rFdg==
X-Gm-Message-State: APjAAAXBoKUh7fELuxxndTQ2/vnwJ/0mYl21CRU/0h7ah7KP6KnyxPaY
        FZQnYVI/c/Xg5s/U8OA/xjWI1u84
X-Google-Smtp-Source: APXvYqx6ZefpzHnRz7hI7XMQ6e6TPPO/smbkd5wKvsUxVhoN8VrPkcXqCq3VJcCbEj9oRuuLBbkT0g==
X-Received: by 2002:a63:6142:: with SMTP id v63mr11886432pgb.110.1570720898777;
        Thu, 10 Oct 2019 08:21:38 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d1sm6999772pfc.98.2019.10.10.08.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 08:21:37 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Sahkeel Butt <shakeelb@google.com>,
        Minchan Kim <minchan@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] mm: annotate refault stalls from swap_readpage
Date:   Thu, 10 Oct 2019 08:21:34 -0700
Message-Id: <20191010152134.38545-1-minchan@kernel.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minchan Kim <minchan@google.com>

If block device supports rw_page operation, it doesn't submit bio
so annotation in submit_bio for refault stall doesn't work.
It happens with zram in android, especially swap read path which
could consume CPU cycle for decompress. It is also a problem for
zswap which uses frontswap.

Annotate swap_readpage() to account the synchronous IO overhead
to prevent underreport memory pressure.

Cc: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Minchan Kim <minchan@google.com>
---
 mm/page_io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 24ee600f9131..20147473d4a5 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -22,6 +22,7 @@
 #include <linux/writeback.h>
 #include <linux/frontswap.h>
 #include <linux/blkdev.h>
+#include <linux/psi.h>
 #include <linux/uio.h>
 #include <linux/sched/task.h>
 #include <asm/pgtable.h>
@@ -354,10 +355,14 @@ int swap_readpage(struct page *page, bool synchronous)
 	struct swap_info_struct *sis = page_swap_info(page);
 	blk_qc_t qc;
 	struct gendisk *disk;
+	unsigned long pflags;
 
 	VM_BUG_ON_PAGE(!PageSwapCache(page) && !synchronous, page);
 	VM_BUG_ON_PAGE(!PageLocked(page), page);
 	VM_BUG_ON_PAGE(PageUptodate(page), page);
+
+	psi_memstall_enter(&pflags);
+
 	if (frontswap_load(page) == 0) {
 		SetPageUptodate(page);
 		unlock_page(page);
@@ -371,7 +376,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		ret = mapping->a_ops->readpage(swap_file, page);
 		if (!ret)
 			count_vm_event(PSWPIN);
-		return ret;
+		goto out;
 	}
 
 	ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
@@ -382,7 +387,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		}
 
 		count_vm_event(PSWPIN);
-		return 0;
+		goto out;
 	}
 
 	ret = 0;
@@ -418,6 +423,7 @@ int swap_readpage(struct page *page, bool synchronous)
 	bio_put(bio);
 
 out:
+	psi_memstall_leave(&pflags);
 	return ret;
 }
 
-- 
2.23.0.581.g78d2f28ef7-goog

