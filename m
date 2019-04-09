Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A36C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A8E20820
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 22:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554849681;
	bh=ms7rRLvMuGYmkqkJQHjbRBwbIXKh/nVEHZ69qixa6hA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FkuOOrfUqL60ofPDys7beTnWKli41EOtazxuq2yzz4nlFx4PsfG2EEAd0utg/+KGU
	 MkMB2/hMM8xt4ST/dAeagRRUVMQFAgUUY7UJ18V7qJR8Kx/9dnGqnFwOH3VKdY0nWY
	 qU1QTV1ZpUfz8FRz+nPKFHjmJST3Fnhr6dQWR3Mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfDIWlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 18:41:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39610 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfDIWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 18:41:18 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3AE610D5;
        Tue,  9 Apr 2019 22:41:16 +0000 (UTC)
Date:   Tue, 9 Apr 2019 15:41:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>, Qian Cai <cai@lca.pw>,
        Arun KS <arunks@codeaurora.org>,
        Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH v1 1/4] mm/memory_hotplug: Release memory resource after
 arch_remove_memory()
Message-Id: <20190409154115.0e94499072e93947a9c1e54e@linux-foundation.org>
In-Reply-To: <20190409100148.24703-2-david@redhat.com>
References: <20190409100148.24703-1-david@redhat.com>
        <20190409100148.24703-2-david@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Apr 2019 12:01:45 +0200 David Hildenbrand <david@redhat.com> wrote:

> __add_pages() doesn't add the memory resource, so __remove_pages()
> shouldn't remove it. Let's factor it out. Especially as it is a special
> case for memory used as system memory, added via add_memory() and
> friends.
> 
> We now remove the resource after removing the sections instead of doing
> it the other way around. I don't think this change is problematic.
> 
> add_memory()
> 	register memory resource
> 	arch_add_memory()
> 
> remove_memory
> 	arch_remove_memory()
> 	release memory resource
> 
> While at it, explain why we ignore errors and that it only happeny if
> we remove memory in a different granularity as we added it.

Seems sane.

> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1820,6 +1806,25 @@ void try_offline_node(int nid)
>  }
>  EXPORT_SYMBOL(try_offline_node);
>  
> +static void __release_memory_resource(u64 start, u64 size)
> +{
> +	int ret;
> +
> +	/*
> +	 * When removing memory in the same granularity as it was added,
> +	 * this function never fails. It might only fail if resources
> +	 * have to be adjusted or split. We'll ignore the error, as
> +	 * removing of memory cannot fail.
> +	 */
> +	ret = release_mem_region_adjustable(&iomem_resource, start, size);
> +	if (ret) {
> +		resource_size_t endres = start + size - 1;
> +
> +		pr_warn("Unable to release resource <%pa-%pa> (%d)\n",
> +			&start, &endres, ret);
> +	}
> +}

The types seem confused here.  Should `start' and `size' be
resource_size_t?  Or maybe phys_addr_t.

release_mem_region_adjustable() takes resource_size_t's.

Is %pa the way to print a resource_size_t?  I guess it happens to work
because resource_size_t happens to map onto phys_addr_t, which isn't
ideal.

Wanna have a headscratch over that?

>  /**
>   * remove_memory
>   * @nid: the node ID
> @@ -1854,6 +1859,7 @@ void __ref __remove_memory(int nid, u64 start, u64 size)
>  	memblock_remove(start, size);
>  
>  	arch_remove_memory(nid, start, size, NULL);
> +	__release_memory_resource(start, size);
>  
>  	try_offline_node(nid);

