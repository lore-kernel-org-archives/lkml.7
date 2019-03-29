Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2AA5C10F0A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBF12184D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553850861;
	bh=3ZoxF6KZYnnY7ElCX73OPASnPPN67xd3ApK2U8mBZlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tnhEAjbO8yBSjeIs4P21HzLBccZAwKj/RxeLe1rw6Rjq8753UHpRYmkFDWvzqfuNy
	 FmO649dPYQ2BBwnL5yzpQU+8QvI67LOyM371vf6pU4E6g1CWOWvJE8LJt2xUqq3fNP
	 1HD8fj+c2XERtzUquWNr1N85Ssr8evuIgybB0dJ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbfC2JOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:14:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:38986 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728770AbfC2JOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:14:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 01631AE60;
        Fri, 29 Mar 2019 09:14:19 +0000 (UTC)
Date:   Fri, 29 Mar 2019 10:14:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rafael@kernel.org, akpm@linux-foundation.org, osalvador@suse.de,
        rppt@linux.ibm.com, willy@infradead.org, fanc.fnst@cn.fujitsu.com
Subject: Re: [PATCH v3 1/2] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190329091418.GE28616@dhcp22.suse.cz>
References: <20190329082915.19763-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329082915.19763-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 29-03-19 16:29:14, Baoquan He wrote:
> The code comment above sparse_add_one_section() is obsolete and
> incorrect, clean it up and write new one.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
> v2->v3:
>   Normalize the code comment to use '/**' at 1st line of doc
>   above function.
> v1-v2:
>   Add comments to explain what the returned value means for
>   each error code.
>  mm/sparse.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 69904aa6165b..363f9d31b511 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -684,10 +684,19 @@ static void free_map_bootmem(struct page *memmap)
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
> -/*
> - * returns the number of sections whose mem_maps were properly
> - * set.  If this is <=0, then that means that the passed-in
> - * map was not consumed and must be freed.
> +/**
> + * sparse_add_one_section - add a memory section
> + * @nid: The node to add section on
> + * @start_pfn: start pfn of the memory range
> + * @altmap: device page map
> + *
> + * This is only intended for hotplug.
> + *
> + * Returns:
> + *   0 on success.
> + *   Other error code on failure:
> + *     - -EEXIST - section has been present.
> + *     - -ENOMEM - out of memory.
>   */
>  int __meminit sparse_add_one_section(int nid, unsigned long start_pfn,
>  				     struct vmem_altmap *altmap)
> -- 
> 2.17.2
> 

-- 
Michal Hocko
SUSE Labs
