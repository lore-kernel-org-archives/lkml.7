Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9EFC2D0C1
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D472D24673
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575679030;
	bh=7dRPatdPCbbZGZLlBLBgkiWBhSl7GWUs4mboLXQ5xMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZTn5yEIsRkMsDBFKsXhMweaFKmTZ3b9l2deLmBJsakzCx0CJ+14TEmmLJatQ51PCu
	 bhhSjtUxuzHqdSzLB5JwDYeTHScozD8NpcwmTFFkB4V1VsiA3Uqxj/TYnZmH0+AreJ
	 b+3qCCN8FjWVJ/QWgOtRlSspW9WRMm9QVxOWpiOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLGAhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:37:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbfLGAhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:37:09 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E51C6217F4;
        Sat,  7 Dec 2019 00:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575679028;
        bh=7dRPatdPCbbZGZLlBLBgkiWBhSl7GWUs4mboLXQ5xMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hCUwOrYRci73JrGgxEGqlNTxcjWwwXrJ5/yLUIIMvZ/cEWvggOe1UEAAgGsHvmLpK
         bwC3thokiEet0eWhvrewRZtbwwc5L8wXM9wMoJ5laFloknZHPoM9/3wKsBsvbbq4V9
         9J9m0dkhLSnfpToe/MMZ4kqCHbdnlTOU8J8529X4=
Date:   Fri, 6 Dec 2019 16:37:07 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        daniel@iogearbox.net, cai@lca.pw
Subject: Re: [PATCH 1/3] mm: add apply_to_existing_pages helper
Message-Id: <20191206163707.17f627c502846bd636049ad4@linux-foundation.org>
In-Reply-To: <20191205140407.1874-1-dja@axtens.net>
References: <20191205140407.1874-1-dja@axtens.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Dec 2019 01:04:05 +1100 Daniel Axtens <dja@axtens.net> wrote:

> +/*
> + * Scan a region of virtual memory, calling a provided function on
> + * each leaf page table where it exists.
> + *
> + * Unlike apply_to_page_range, this does _not_ fill in page tables
> + * where they are absent.
> + */
> +int apply_to_existing_pages(struct mm_struct *mm, unsigned long addr,
> +			    unsigned long size, pte_fn_t fn, void *data)
> +{
> +	pgd_t *pgd;
> +	unsigned long next;
> +	unsigned long end = addr + size;
> +	int err = 0;
> +
> +	if (WARN_ON(addr >= end))
> +		return -EINVAL;
> +
> +	pgd = pgd_offset(mm, addr);
> +	do {
> +		next = pgd_addr_end(addr, end);
> +		if (pgd_none_or_clear_bad(pgd))
> +			continue;
> +		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, false);
> +		if (err)
> +			break;
> +	} while (pgd++, addr = next, addr != end);
> +
> +	return err;
> +}
> +EXPORT_SYMBOL_GPL(apply_to_existing_pages);

This is almost identical to apply_to_page_range() and cries out for
some deduplication.  This?

--- a/mm/memory.c~mm-add-apply_to_existing_pages-helper-fix
+++ a/mm/memory.c
@@ -2141,12 +2141,9 @@ static int apply_to_p4d_range(struct mm_
 	return err;
 }
 
-/*
- * Scan a region of virtual memory, filling in page tables as necessary
- * and calling a provided function on each leaf page table.
- */
-int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
-			unsigned long size, pte_fn_t fn, void *data)
+static int __apply_to_page_range(struct mm_struct *mm, unsigned long addr,
+				 unsigned long size, pte_fn_t fn,
+				 void *data, bool create)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -2159,13 +2156,25 @@ int apply_to_page_range(struct mm_struct
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, end);
-		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, true);
+		if (!create && pgd_none_or_clear_bad(pgd))
+			continue;
+		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, create);
 		if (err)
 			break;
 	} while (pgd++, addr = next, addr != end);
 
 	return err;
 }
+
+/*
+ * Scan a region of virtual memory, filling in page tables as necessary
+ * and calling a provided function on each leaf page table.
+ */
+int apply_to_page_range(struct mm_struct *mm, unsigned long addr,
+			unsigned long size, pte_fn_t fn, void *data)
+{
+	return __apply_to_page_range(mm, addr, size, fn, data, true);
+}
 EXPORT_SYMBOL_GPL(apply_to_page_range);
 
 /*
@@ -2178,25 +2187,7 @@ EXPORT_SYMBOL_GPL(apply_to_page_range);
 int apply_to_existing_pages(struct mm_struct *mm, unsigned long addr,
 			    unsigned long size, pte_fn_t fn, void *data)
 {
-	pgd_t *pgd;
-	unsigned long next;
-	unsigned long end = addr + size;
-	int err = 0;
-
-	if (WARN_ON(addr >= end))
-		return -EINVAL;
-
-	pgd = pgd_offset(mm, addr);
-	do {
-		next = pgd_addr_end(addr, end);
-		if (pgd_none_or_clear_bad(pgd))
-			continue;
-		err = apply_to_p4d_range(mm, pgd, addr, next, fn, data, false);
-		if (err)
-			break;
-	} while (pgd++, addr = next, addr != end);
-
-	return err;
+	return __apply_to_page_range(mm, addr, size, fn, data, false);
 }
 EXPORT_SYMBOL_GPL(apply_to_existing_pages);
 
_


