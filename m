Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1E7C2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C06321D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="zMuS2dgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfLTO0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:26:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39795 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLTO0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:26:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id l2so10197405lja.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 06:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WqhstskUuONOhk/w+gyZwreQrEykNzgK1l1VnxD33s=;
        b=zMuS2dgvlkKxVxxI8JtGHSQUeKku32DXHsiX4HgwhvWFUTUQrOcWey2c7sxjWbQcb2
         Lya2wZ2LgrMRnub1NYNq4lVqtPR7GXOZUNAxFJuWiQhzRgXz/bYw6QG+tOzMRQuxyD2d
         UidurIjM5hB5JSOahBqyYlwsq4VXOY9h2zJm6ACP7qLvGL34gFlLYX9z0N05hgsM9PDc
         NU+Fb1mzJA5EPJePj5fdiFzLdskrmz/sodj5LpO+WGGaoiQ/pdyZEfMar4KWDiR6VDbw
         DGsCfhoAYdBk1HjdXUjFq1lRHnGF0bXEHXGE5wSgPd0jizemwt6aBoJRo4a/fSzl1eOR
         xn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WqhstskUuONOhk/w+gyZwreQrEykNzgK1l1VnxD33s=;
        b=EM/yHoc0B1qvaLQch7e/PaPuUi3wFLJnAQe+vXrHUotTrgWqI36AsTX44tCnbqWiVR
         t9LQvS5JvicEOHqGB1gJem79st1OfprU2FlfkhuvanN4ZP4A0faH3aNNoMB6OP7yV2vG
         gkAmyyxmP78my/ya5WHkf7nGDqLmjhVoWNQHEYGRDdJXK0smDu9c5zZX5g22WyeJNgOU
         xRCsmBped8D7PB7qKqOq/woNLB4SzBKdHfSXfY7OghcZ3KIOeAInHYJJXZJ6RmNQTGOW
         tbt6dNUvXstaFSxuqYHNWloL/daXveACrXBGUz5mXXqtWinF6Vzb4GQ6nXKnACkvQeab
         4mjQ==
X-Gm-Message-State: APjAAAW50Y4CC/cLQIsSwnHV14gHpuyfr7T7qAHk9Gkkfh6hpL0+/ubF
        Tb/m9QYdB+FjYmwJmWnd9BxqTA==
X-Google-Smtp-Source: APXvYqy1P1YNJauGj7NRz5haqIY7txUzCE4ENcU904LzYlGyPRf3lLLbOhOcL3xZoZexkkXT/5uXpQ==
X-Received: by 2002:a2e:a0d5:: with SMTP id f21mr10236743ljm.106.1576851958001;
        Fri, 20 Dec 2019 06:25:58 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w17sm4083642lfn.22.2019.12.20.06.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 06:25:56 -0800 (PST)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id 3E3631012A8; Fri, 20 Dec 2019 17:25:59 +0300 (+03)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Willhalm, Thomas" <thomas.willhalm@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Bruggeman, Otto G" <otto.g.bruggeman@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH 2/2] thp, shmem: Fix conflict of above-47bit hint address and PMD alignment
Date:   Fri, 20 Dec 2019 17:25:48 +0300
Message-Id: <20191220142548.7118-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
References: <20191220142548.7118-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shmem/tmpfs tries to provide THP-friendly mappings if huge pages are
enabled. But it doesn't work well with above-47bit hint address.

Normally, the kernel doesn't create userspace mappings above 47-bit,
even if the machine allows this (such as with 5-level paging on x86-64).
Not all user space is ready to handle wide addresses. It's known that
at least some JIT compilers use higher bits in pointers to encode their
information.

Userspace can ask for allocation from full address space by specifying
hint address (with or without MAP_FIXED) above 47-bits. If the
application doesn't need a particular address, but wants to allocate
from whole address space it can specify -1 as a hint address.

Unfortunately, this trick breaks THP alignment in shmem/tmp:
shmem_get_unmapped_area() would not try to allocate PMD-aligned area if
*any* hint address specified.

This can be fixed by requesting the aligned area if the we failed to
allocated at user-specified hint address. The request with inflated
length will also take the user-specified hint address. This way we will
not lose an allocation request from the full address space.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Fixes: b569bab78d8d ("x86/mm: Prepare to expose larger address space to userspace")
---
 mm/shmem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 165fa6332993..dc539482ce67 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2107,9 +2107,10 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	/*
 	 * Our priority is to support MAP_SHARED mapped hugely;
 	 * and support MAP_PRIVATE mapped hugely too, until it is COWed.
-	 * But if caller specified an address hint, respect that as before.
+	 * But if caller specified an address hint and we allocated area there
+	 * successfully, respect that as before.
 	 */
-	if (uaddr)
+	if (uaddr == addr)
 		return addr;
 
 	if (shmem_huge != SHMEM_HUGE_FORCE) {
@@ -2143,7 +2144,7 @@ unsigned long shmem_get_unmapped_area(struct file *file,
 	if (inflated_len < len)
 		return addr;
 
-	inflated_addr = get_area(NULL, 0, inflated_len, 0, flags);
+	inflated_addr = get_area(uaddr, 0, inflated_len, 0, flags);
 	if (IS_ERR_VALUE(inflated_addr))
 		return addr;
 	if (inflated_addr & ~PAGE_MASK)
-- 
2.24.1

