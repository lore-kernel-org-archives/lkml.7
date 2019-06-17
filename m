Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFE1C31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2B820820
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 09:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbfFQJ2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 05:28:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:43372 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfFQJ2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 05:28:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CCC6AE67;
        Mon, 17 Jun 2019 09:28:13 +0000 (UTC)
Subject: Re: [RFC PATCH 10/16] xen/balloon: support ballooning in xenhost_t
To:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     pbonzini@redhat.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, sstabellini@kernel.org,
        joao.m.martins@oracle.com
References: <20190509172540.12398-1-ankur.a.arora@oracle.com>
 <20190509172540.12398-11-ankur.a.arora@oracle.com>
From:   Juergen Gross <jgross@suse.com>
Message-ID: <c67f2fd9-c837-bc13-492f-f3bed7f01f05@suse.com>
Date:   Mon, 17 Jun 2019 11:28:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509172540.12398-11-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.19 19:25, Ankur Arora wrote:
> Xen ballooning uses hollow struct pages (with the underlying GFNs being
> populated/unpopulated via hypercalls) which are used by the grant logic
> to map grants from other domains.
> 
> This patch allows the default xenhost to provide an alternate ballooning
> allocation mechanism. This is expected to be useful for local xenhosts
> (type xenhost_r0) because unlike Xen, where there is an external
> hypervisor which can change the memory underneath a GFN, that is not
> possible when the hypervisor is running in the same address space
> as the entity doing the ballooning.
> 
> Co-developed-by: Ankur Arora <ankur.a.arora@oracle.com>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   arch/x86/xen/enlighten_hvm.c       |  7 +++++++
>   arch/x86/xen/enlighten_pv.c        |  8 ++++++++
>   drivers/xen/balloon.c              | 19 ++++++++++++++++---
>   drivers/xen/grant-table.c          |  4 ++--
>   drivers/xen/privcmd.c              |  4 ++--
>   drivers/xen/xen-selfballoon.c      |  2 ++
>   drivers/xen/xenbus/xenbus_client.c |  6 +++---
>   drivers/xen/xlate_mmu.c            |  4 ++--
>   include/xen/balloon.h              |  4 ++--
>   include/xen/xenhost.h              | 19 +++++++++++++++++++
>   10 files changed, 63 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index 5ef4d6ad920d..08becf574743 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -63,6 +63,7 @@
>   #include <asm/tlb.h>
>   
>   #include <xen/interface/xen.h>
> +#include <xen/xenhost.h>
>   #include <asm/xen/hypervisor.h>
>   #include <asm/xen/hypercall.h>
>   
> @@ -583,12 +584,21 @@ static int add_ballooned_pages(int nr_pages)
>    * @pages: pages returned
>    * @return 0 on success, error otherwise
>    */
> -int alloc_xenballooned_pages(int nr_pages, struct page **pages)
> +int alloc_xenballooned_pages(xenhost_t *xh, int nr_pages, struct page **pages)
>   {
>   	int pgno = 0;
>   	struct page *page;
>   	int ret;
>   
> +	/*
> +	 * xenmem transactions for remote xenhost are disallowed.
> +	 */
> +	if (xh->type == xenhost_r2)
> +		return -EINVAL;

Why don't you set a dummy function returning -EINVAL into the xenhost_r2
structure instead?

> +
> +	if (xh->ops->alloc_ballooned_pages)
> +		return xh->ops->alloc_ballooned_pages(xh, nr_pages, pages);
> +

Please make alloc_xenballooned_pages() an inline wrapper and use the
current implmentaion as the default. This avoids another if ().

>   	mutex_lock(&balloon_mutex);
>   
>   	balloon_stats.target_unpopulated += nr_pages;
> @@ -620,7 +630,7 @@ int alloc_xenballooned_pages(int nr_pages, struct page **pages)
>   	return 0;
>    out_undo:
>   	mutex_unlock(&balloon_mutex);
> -	free_xenballooned_pages(pgno, pages);
> +	free_xenballooned_pages(xh, pgno, pages);
>   	return ret;
>   }
>   EXPORT_SYMBOL(alloc_xenballooned_pages);
> @@ -630,10 +640,13 @@ EXPORT_SYMBOL(alloc_xenballooned_pages);
>    * @nr_pages: Number of pages
>    * @pages: pages to return
>    */
> -void free_xenballooned_pages(int nr_pages, struct page **pages)
> +void free_xenballooned_pages(xenhost_t *xh, int nr_pages, struct page **pages)
>   {
>   	int i;
>   
> +	if (xh->ops->free_ballooned_pages)
> +		return xh->ops->free_ballooned_pages(xh, nr_pages, pages);
> +

Same again: please use an inline wrapper.


Juergen
