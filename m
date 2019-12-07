Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0CEC43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A439A2245C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 00:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575679136;
	bh=pXgE5bJzghH5mG4jiwsiWhC/T97HlG8oVxO+qHwaLtg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=quUTEMYp/npCfauGxzyogAnogOKIdp8RvtZqWoss+D7xELWqMBxsrabmcWjAtdgdd
	 FzuQuuXNwanfbh0gl2dhPUNvHWoF9VPzAouokImhnO+MiFbPwlEOB9kyI7n/If0ro6
	 hkgbPPF1dHi67ZDa7dW+DsF2Zth4UlFmAg/Q+vP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfLGAiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:38:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfLGAiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 19:38:55 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 555CC217F4;
        Sat,  7 Dec 2019 00:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575679134;
        bh=pXgE5bJzghH5mG4jiwsiWhC/T97HlG8oVxO+qHwaLtg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gOYIIK+Pufb0FTzfOJJIZVX9AevjAXpf2Gwym20jWFIoUoXfk+qI9BEPAkynHMXzD
         lhztH0y2SyYKYFuCX5aS8W70c+aHV3gy47mr2w45LgvIimNT+wDD/PIDRh+rZssSn3
         49Wn9C8bzZnwSdoV/p11WeyWl+iMWBjoA6FfKt1A=
Date:   Fri, 6 Dec 2019 16:38:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     kasan-dev@googlegroups.com, linux-mm@kvack.org,
        aryabinin@virtuozzo.com, glider@google.com,
        linux-kernel@vger.kernel.org, dvyukov@google.com,
        daniel@iogearbox.net, cai@lca.pw
Subject: Re: [PATCH 1/3] mm: add apply_to_existing_pages helper
Message-Id: <20191206163853.cdeb5dc80a8622fb6323a8d2@linux-foundation.org>
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

> apply_to_page_range takes an address range, and if any parts of it
> are not covered by the existing page table hierarchy, it allocates
> memory to fill them in.
> 
> In some use cases, this is not what we want - we want to be able to
> operate exclusively on PTEs that are already in the tables.
> 
> Add apply_to_existing_pages for this. Adjust the walker functions
> for apply_to_page_range to take 'create', which switches them between
> the old and new modes.

Wouldn't apply_to_existing_page_range() be a better name?

--- a/include/linux/mm.h~mm-add-apply_to_existing_pages-helper-fix-fix
+++ a/include/linux/mm.h
@@ -2621,9 +2621,9 @@ static inline int vm_fault_to_errno(vm_f
 typedef int (*pte_fn_t)(pte_t *pte, unsigned long addr, void *data);
 extern int apply_to_page_range(struct mm_struct *mm, unsigned long address,
 			       unsigned long size, pte_fn_t fn, void *data);
-extern int apply_to_existing_pages(struct mm_struct *mm, unsigned long address,
-				   unsigned long size, pte_fn_t fn,
-				   void *data);
+extern int apply_to_existing_page_range(struct mm_struct *mm,
+				   unsigned long address, unsigned long size,
+				   pte_fn_t fn, void *data);
 
 #ifdef CONFIG_PAGE_POISONING
 extern bool page_poisoning_enabled(void);
--- a/mm/memory.c~mm-add-apply_to_existing_pages-helper-fix-fix
+++ a/mm/memory.c
@@ -2184,12 +2184,12 @@ EXPORT_SYMBOL_GPL(apply_to_page_range);
  * Unlike apply_to_page_range, this does _not_ fill in page tables
  * where they are absent.
  */
-int apply_to_existing_pages(struct mm_struct *mm, unsigned long addr,
-			    unsigned long size, pte_fn_t fn, void *data)
+int apply_to_existing_page_range(struct mm_struct *mm, unsigned long addr,
+				 unsigned long size, pte_fn_t fn, void *data)
 {
 	return __apply_to_page_range(mm, addr, size, fn, data, false);
 }
-EXPORT_SYMBOL_GPL(apply_to_existing_pages);
+EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
 
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
_

