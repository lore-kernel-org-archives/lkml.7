Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867D2C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62097207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 17:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y143tXX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407993AbfIXRsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 13:48:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56922 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407478AbfIXRsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 13:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O0nfraiEUV4+QwMHxI+w0Nqu6sGkpxkc5IfF1hY76dw=; b=Y143tXX9kDfyXXoQ1ev6DHsff
        v66sqrTzaimx4sYNL42VqpTPYVELDY9PC3OIJccapnXjzE2EA3Ye9vx5A1fk0lip0vP9VTh9/V1Z9
        RiX97vLtrfObCCGA65q35ZdjGiFzU8rSdRxvGKDJleXJgK96RycEITOlNgFePt+EjgIz+ZkfREFFl
        s7or14br+DOWQt3F2qHMNWyI4srGBY7pJVGJcmpVp+O+rYuEP0WNTu29JcVdOLTbiRv8UOL88H4x1
        nQSVEvCjhu8opzz9vWZsF59/DJrk7uoduthG3Aar32FWrOEaiUEv/40agGW2CYS+kCKmo4kumewtx
        nNGCKAEfQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCov3-0002iQ-PN; Tue, 24 Sep 2019 17:48:09 +0000
Date:   Tue, 24 Sep 2019 10:48:09 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: drop mmap_sem before calling balance_dirty_pages()
 in write fault
Message-ID: <20190924174809.GH1855@bombadil.infradead.org>
References: <20190924171518.26682-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924171518.26682-1-hannes@cmpxchg.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 01:15:18PM -0400, Johannes Weiner wrote:
> +static int fault_dirty_shared_page(struct vm_fault *vmf)

vm_fault_t, shirley?

> @@ -2239,16 +2241,36 @@ static void fault_dirty_shared_page(struct vm_area_struct *vma,
>  	mapping = page_rmapping(page);
>  	unlock_page(page);
>  
> +	if (!page_mkwrite)
> +		file_update_time(vma->vm_file);
> +
> +	/*
> +	 * Throttle page dirtying rate down to writeback speed.
> +	 *
> +	 * mapping may be NULL here because some device drivers do not
> +	 * set page.mapping but still dirty their pages
> +	 *
> +	 * Drop the mmap_sem before waiting on IO, if we can. The file
> +	 * is pinning the mapping, as per above.
> +	 */
>  	if ((dirtied || page_mkwrite) && mapping) {
> -		/*
> -		 * Some device drivers do not set page.mapping
> -		 * but still dirty their pages
> -		 */
> +		struct file *fpin = NULL;
> +
> +		if ((vmf->flags &
> +		     (FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_RETRY_NOWAIT)) ==
> +		    FAULT_FLAG_ALLOW_RETRY) {
> +			fpin = get_file(vma->vm_file);
> +			up_read(&vma->vm_mm->mmap_sem);
> +			ret = VM_FAULT_RETRY;
> +		}
> +
>  		balance_dirty_pages_ratelimited(mapping);
> +
> +		if (fpin)
> +			fput(fpin);
>  	}
>  
> -	if (!page_mkwrite)
> -		file_update_time(vma->vm_file);
> +	return ret;
>  }

I'm not a fan of moving file_update_time() to _before_ the
balance_dirty_pages call.  Also, this is now the third place that needs
maybe_unlock_mmap_for_io, see
https://lore.kernel.org/linux-mm/20190917120852.x6x3aypwvh573kfa@box/

How about:

+	struct file *fpin = NULL;

 	if ((dirtied || page_mkwrite) && mapping) {
		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		balance_dirty_pages_ratelimited(mapping);
	}
+
+	if (fpin) {
+		file_update_time(fpin);
+		fput(fpin);
+		return VM_FAULT_RETRY;
+	}

 	if (!page_mkwrite)
 		file_update_time(vma->vm_file);
+	return 0;
 }

>  /*
> @@ -2491,6 +2513,7 @@ static vm_fault_t wp_page_shared(struct vm_fault *vmf)
>  	__releases(vmf->ptl)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	int ret = VM_FAULT_WRITE;

vm_fault_t again.

> @@ -3576,7 +3599,6 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>  static vm_fault_t do_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> -	struct mm_struct *vm_mm = vma->vm_mm;
>  	vm_fault_t ret;
>  
>  	/*
> @@ -3617,7 +3639,12 @@ static vm_fault_t do_fault(struct vm_fault *vmf)
>  
>  	/* preallocated pagetable is unused: free it */
>  	if (vmf->prealloc_pte) {
> -		pte_free(vm_mm, vmf->prealloc_pte);
> +		/*
> +		 * XXX: Accessing vma->vm_mm now is not safe. The page
> +		 * fault handler may have dropped the mmap_sem a long
> +		 * time ago. Only s390 derefs that parameter.
> +		 */
> +		pte_free(vma->vm_mm, vmf->prealloc_pte);

I'm confused.  This code looks like it was safe before (as it was caching
vma->vm_mm in a local variable), and now you've made it unsafe ... ?
