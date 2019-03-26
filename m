Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC52C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B977320856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553592580;
	bh=j6zoOEW+A+lYDgy9qXFRRwfP9iM4mQcbQuGy0vzHiYY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0UAcl0AwXWXfztDxnPmKs59mKQa4KDvQA17td5ISef+VtmSGJ9hVLGjwzCunb+88B
	 M6DLnszzC9AD2XLDXO64WHOUy3PYYGKT9S8uEOY0t/hwrGDDlUHNgZxEhEaG35wc4L
	 U+cSMYgNCQyr7VVMuR0CKcV0YZgE5jxfDmZEv0zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfCZJ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:29:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729334AbfCZJ3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:29:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 63BC9AC8C;
        Tue, 26 Mar 2019 09:29:37 +0000 (UTC)
Date:   Tue, 26 Mar 2019 10:29:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 2/4] mm/sparse: Optimize sparse_add_one_section()
Message-ID: <20190326092936.GK28406@dhcp22.suse.cz>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-3-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326090227.3059-3-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 17:02:25, Baoquan He wrote:
> Reorder the allocation of usemap and memmap since usemap allocation
> is much simpler and easier. Otherwise hard work is done to make
> memmap ready, then have to rollback just because of usemap allocation
> failure.

Is this really worth it? I can see that !VMEMMAP is doing memmap size
allocation which would be 2MB aka costly allocation but we do not do
__GFP_RETRY_MAYFAIL so the allocator backs off early.

> And also check if section is present earlier. Then don't bother to
> allocate usemap and memmap if yes.

Moving the check up makes some sense.

> Signed-off-by: Baoquan He <bhe@redhat.com>

The patch is not incorrect but I am wondering whether it is really worth
it for the current code base. Is it fixing anything real or it is a mere
code shuffling to please an eye?

> ---
> v1->v2:
>   Do section existence checking earlier to further optimize code.
> 
>  mm/sparse.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index b2111f996aa6..f4f34d69131e 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -714,20 +714,18 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	ret = sparse_index_init(section_nr, nid);
>  	if (ret < 0 && ret != -EEXIST)
>  		return ret;
> -	ret = 0;
> -	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> -	if (!memmap)
> -		return -ENOMEM;
> -	usemap = __kmalloc_section_usemap();
> -	if (!usemap) {
> -		__kfree_section_memmap(memmap, altmap);
> -		return -ENOMEM;
> -	}
>  
>  	ms = __pfn_to_section(start_pfn);
> -	if (ms->section_mem_map & SECTION_MARKED_PRESENT) {
> -		ret = -EEXIST;
> -		goto out;
> +	if (ms->section_mem_map & SECTION_MARKED_PRESENT)
> +		return -EEXIST;
> +
> +	usemap = __kmalloc_section_usemap();
> +	if (!usemap)
> +		return -ENOMEM;
> +	memmap = kmalloc_section_memmap(section_nr, nid, altmap);
> +	if (!memmap) {
> +		kfree(usemap);
> +		return  -ENOMEM;
>  	}
>  
>  	/*
> @@ -739,12 +737,7 @@ int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  	section_mark_present(ms);
>  	sparse_init_one_section(ms, section_nr, memmap, usemap);
>  
> -out:
> -	if (ret < 0) {
> -		kfree(usemap);
> -		__kfree_section_memmap(memmap, altmap);
> -	}
> -	return ret;
> +	return 0;
>  }
>  
>  #ifdef CONFIG_MEMORY_HOTREMOVE
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs
