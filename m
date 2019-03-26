Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E767C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA1820857
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553592208;
	bh=fwS/ALGOPr8KIfTdUgfnTX2UIm3vXxbQvxT6KrdmdHQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0hPJxq6CRUHFfENkw91S6L4j6dZWbsAoS8NVYJ76a6h4lppLcrTjWWdvyJxi6+Pow
	 daurj+m4Vhk43vcm2751IsLje/hQZkf7WD4VVt6Se+O3NMWJuVwOcLua91hzjiGKUE
	 cGOVwyJqQyPPyZSWnZHSS8v4HqdrooZ4T9YJIf18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfCZJX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:23:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40828 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725497AbfCZJX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:23:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 294C4ACEB;
        Tue, 26 Mar 2019 09:23:25 +0000 (UTC)
Date:   Tue, 26 Mar 2019 10:23:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rppt@linux.ibm.com, osalvador@suse.de,
        willy@infradead.org, william.kucharski@oracle.com
Subject: Re: [PATCH v2 1/4] mm/sparse: Clean up the obsolete code comment
Message-ID: <20190326092324.GJ28406@dhcp22.suse.cz>
References: <20190326090227.3059-1-bhe@redhat.com>
 <20190326090227.3059-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326090227.3059-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-03-19 17:02:24, Baoquan He wrote:
> The code comment above sparse_add_one_section() is obsolete and
> incorrect, clean it up and write new one.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>

Please note that you need /** to start a kernel doc. Other than that.

Acked-by: Michal Hocko <mhocko@suse.com>
> ---
> v1-v2:
>   Add comments to explain what the returned value means for
>   each error code.
> 
>  mm/sparse.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 69904aa6165b..b2111f996aa6 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -685,9 +685,18 @@ static void free_map_bootmem(struct page *memmap)
>  #endif /* CONFIG_SPARSEMEM_VMEMMAP */
>  
>  /*
> - * returns the number of sections whose mem_maps were properly
> - * set.  If this is <=0, then that means that the passed-in
> - * map was not consumed and must be freed.
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
