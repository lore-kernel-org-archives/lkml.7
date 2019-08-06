Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E499C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 702352070C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 08:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f3hrVj8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfHFIAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 04:00:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37509 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728975AbfHFIAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 04:00:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id d1so8335155pgp.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2019 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VPlLXY0wXzdcZsw+gwjQql0L/1vV4IXahw59/Pbnezs=;
        b=f3hrVj8ZgSrkyz6mbiTGMtbGJs5//kmK0LanZLxVWpezH8VpgJt8y1ox4rbd5P+7Xu
         rzgSCTmtRAEF7TnsRnCMRtWtnaxg/idNjkjI98rTH/vcVoKdlRfMtcn+GTAVn9u5nrbY
         /kXvVE+IL6jIN3PrJOjEjy2+1PFE9ioV7h3oak9qXBxVb3sVGREH58rI+mP/pBGg9T1W
         dSGuAXe3gUK4/mKwGZhLSa6+q0H8YIiD5gO4WY1k9Liar/mnk7rLB2o2y49Q6Ee68fry
         dmqFLhb6R1cXymhQ7T2tOsaMakcuCNSQbzfwW8Unea6HJvVUNiD4Iic21I5EDOenle3t
         h1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VPlLXY0wXzdcZsw+gwjQql0L/1vV4IXahw59/Pbnezs=;
        b=CqjHP7SptOimi6dplMpNcVLQ0qczt5wThIPhZ6sk44Xd/uL82TygFX4X8J1QcHTmGh
         Exita/KCAknCIBzqWfukYtCgOrvKgrYDLTy9/OilYxQoRnF0ocILVv3MQ/8PdMIehT/p
         77XHf2xajQ7k/pL4I+IJ0VEj5wdCVIypeSzrZUAUo0B4H2czpODpYbJl0tvMYez052vo
         oCX0M/kyFKM561S3f4cE9dc94jfuVCDW6khsw6AIj4b1M7PVUfucEfXCkNRiapwWyvXM
         z6EZxl3ccP8cPo5fz6FRGAuyAAIhAaN973DEDDXiRgZFoLr5JaRFhgav7/8cs6ZzXvoB
         iOiQ==
X-Gm-Message-State: APjAAAXyYQi18BJM/J3LLKHRyUwBM+Ws0REBykWnZStbTRSe4djf+E8U
        WTuYHN8YZOUnJ/g0woIFmw==
X-Google-Smtp-Source: APXvYqyiwHAHgTc4msK2mvodCQr/+/YaQdZ92NMfmgPYPCboKZknrpOFM/qqY3qhKWJuKDfTi9GXsQ==
X-Received: by 2002:a62:5c47:: with SMTP id q68mr2350903pfb.205.1565078444317;
        Tue, 06 Aug 2019 01:00:44 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p7sm96840679pfp.131.2019.08.06.01.00.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 01:00:43 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm/migrate: remove the duplicated code migrate_vma_collect_hole()
Date:   Tue,  6 Aug 2019 16:00:11 +0800
Message-Id: <1565078411-27082-3-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
References: <1565078411-27082-1-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the previous patch which sees hole as invalid source,
migrate_vma_collect_hole() has the same code as migrate_vma_collect_skip().
Removing the duplicated code.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Jan Kara <jack@suse.cz>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/migrate.c | 22 +++-------------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 832483f..95e038d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2128,22 +2128,6 @@ struct migrate_vma {
 	unsigned long		end;
 };
 
-static int migrate_vma_collect_hole(unsigned long start,
-				    unsigned long end,
-				    struct mm_walk *walk)
-{
-	struct migrate_vma *migrate = walk->private;
-	unsigned long addr;
-
-	for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE) {
-		migrate->src[migrate->npages] = 0;
-		migrate->dst[migrate->npages] = 0;
-		migrate->npages++;
-	}
-
-	return 0;
-}
-
 static int migrate_vma_collect_skip(unsigned long start,
 				    unsigned long end,
 				    struct mm_walk *walk)
@@ -2173,7 +2157,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 again:
 	if (pmd_none(*pmdp))
-		return migrate_vma_collect_hole(start, end, walk);
+		return migrate_vma_collect_skip(start, end, walk);
 
 	if (pmd_trans_huge(*pmdp)) {
 		struct page *page;
@@ -2206,7 +2190,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 				return migrate_vma_collect_skip(start, end,
 								walk);
 			if (pmd_none(*pmdp))
-				return migrate_vma_collect_hole(start, end,
+				return migrate_vma_collect_skip(start, end,
 								walk);
 		}
 	}
@@ -2337,7 +2321,7 @@ static void migrate_vma_collect(struct migrate_vma *migrate)
 
 	mm_walk.pmd_entry = migrate_vma_collect_pmd;
 	mm_walk.pte_entry = NULL;
-	mm_walk.pte_hole = migrate_vma_collect_hole;
+	mm_walk.pte_hole = migrate_vma_collect_skip;
 	mm_walk.hugetlb_entry = NULL;
 	mm_walk.test_walk = NULL;
 	mm_walk.vma = migrate->vma;
-- 
2.7.5

