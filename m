Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2618C4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BC6E2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571213435;
	bh=qJAAgxZV9t+Ukd+VWUxpcDfqisWBPKPAQSJNO7sVLf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mLQZGnvydVR90Hos8upMCxDbPhLgs+j43lIoaGdnoGdIZNtSU/1QHCXnbP3S/4GM3
	 9ibbKzGWFrG/gF0gjPaSCRS6Y9V4bWh2WVrzZ9USz64JGKdhNShvaiCUKILlE3Mo+q
	 ZwmG6EmrTltgqnq5pUsOPQlj5ermFvT9FFrHC9pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404067AbfJPIKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:10:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:54124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403890AbfJPIKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:10:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 371DFB5EC;
        Wed, 16 Oct 2019 08:10:31 +0000 (UTC)
Date:   Wed, 16 Oct 2019 10:10:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, mm-commits@vger.kernel.org,
        pugaowei@gmail.com, vbabka@suse.cz, linux-mm@kvack.org
Subject: Re: +
 mm-mmapc-use-is_err_value-to-check-return-value-of-get_unmapped_area.patch
 added to -mm tree
Message-ID: <20191016081030.GM317@dhcp22.suse.cz>
References: <20191015204819.t_fZYLeEw%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015204819.t_fZYLeEw%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-10-19 13:48:19, Andrew Morton wrote:
> From: Gaowei Pu <pugaowei@gmail.com>
> Subject: mm/mmap.c: use IS_ERR_VALUE to check return value of get_unmapped_area
> 
> get_unmapped_area() returns an address or -errno on failure.  Historically
> we have checked for the failure by offset_in_page() which is correct but
> quite hard to read.  Newer code started using IS_ERR_VALUE which is much
> easier to read.  Convert remaining users of offset_in_page as well.
> 
> [mhocko@suse.com: rewrite changelog]
> Link: http://lkml.kernel.org/r/20191012102512.28051-1-pugaowei@gmail.com
> Signed-off-by: Gaowei Pu <pugaowei@gmail.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Acked-by: Michal Hocko <mhocko@suse.com>

There are few more to convert

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 94d38a39d72e..9c197a26c0f4 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1448,7 +1448,7 @@ static int xol_add_vma(struct mm_struct *mm, struct xol_area *area)
 		/* Try to map as high as possible, this is only a hint. */
 		area->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
 						PAGE_SIZE, 0, 0);
-		if (area->vaddr & ~PAGE_MASK) {
+		if (IS_ERR_VALUE(area->vaddr)) {
 			ret = area->vaddr;
 			goto fail;
 		}
diff --git a/mm/mremap.c b/mm/mremap.c
index 1fc8a29fbe3f..122938dcec15 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -558,7 +558,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	ret = get_unmapped_area(vma->vm_file, new_addr, new_len, vma->vm_pgoff +
 				((addr - vma->vm_start) >> PAGE_SHIFT),
 				map_flags);
-	if (offset_in_page(ret))
+	if (IS_ERR_VALUE(ret))
 		goto out1;
 
 	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, uf,
@@ -706,7 +706,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 					vma->vm_pgoff +
 					((addr - vma->vm_start) >> PAGE_SHIFT),
 					map_flags);
-		if (offset_in_page(new_addr)) {
+		if (IS_ERR_VALUE(new_addr)) {
 			ret = new_addr;
 			goto out;
 		}

and also few more to consider. e.g. move_vma return value checks. I
haven't checked other offset_in_page users.

> ---
> 
>  mm/mmap.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/mm/mmap.c~mm-mmapc-use-is_err_value-to-check-return-value-of-get_unmapped_area
> +++ a/mm/mmap.c
> @@ -1417,7 +1417,7 @@ unsigned long do_mmap(struct file *file,
>  	 * that it represents a valid section of the address space.
>  	 */
>  	addr = get_unmapped_area(file, addr, len, pgoff, flags);
> -	if (offset_in_page(addr))
> +	if (IS_ERR_VALUE(addr))
>  		return addr;
>  
>  	if (flags & MAP_FIXED_NOREPLACE) {
> @@ -2996,15 +2996,16 @@ static int do_brk_flags(unsigned long ad
>  	struct rb_node **rb_link, *rb_parent;
>  	pgoff_t pgoff = addr >> PAGE_SHIFT;
>  	int error;
> +	unsigned long mapped_addr;
>  
>  	/* Until we need other flags, refuse anything except VM_EXEC. */
>  	if ((flags & (~VM_EXEC)) != 0)
>  		return -EINVAL;
>  	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
>  
> -	error = get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
> -	if (offset_in_page(error))
> -		return error;
> +	mapped_addr = get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
> +	if (IS_ERR_VALUE(mapped_addr))
> +		return mapped_addr;
>  
>  	error = mlock_future_check(mm, mm->def_flags, len);
>  	if (error)
> _
> 
> Patches currently in -mm which might be from pugaowei@gmail.com are
> 
> mm-mmapc-use-is_err_value-to-check-return-value-of-get_unmapped_area.patch

-- 
Michal Hocko
SUSE Labs
