Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A252BC00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D39F206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 13:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728435AbfCENfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 08:35:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:48896 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727492AbfCENfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 08:35:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DA36ACA8;
        Tue,  5 Mar 2019 13:35:44 +0000 (UTC)
Subject: Re: [PATCH] [v2] xen: avoid link error on ARM
To:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Paul Durrant <paul.durrant@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20190305133057.3998926-1-arnd@arndb.de>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d194daf0-ba2a-9faa-2f0f-08bd7f8955f9@suse.com>
Date:   Tue, 5 Mar 2019 14:35:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190305133057.3998926-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2019 14:30, Arnd Bergmann wrote:
> Building the privcmd code as a loadable module on ARM, we get
> a link error due to the private cache management functions:
> 
> ERROR: "__sync_icache_dcache" [drivers/xen/xen-privcmd.ko] undefined!
> 
> Move the code into a new file that is always built in when Xen
> is enabled, as suggested by Juergen Gross. Additional code will
> be moved into this file later.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: rename mm.o to xen-builtin.o, make it unconditional
> ---
>  drivers/xen/Makefile      |  1 +
>  drivers/xen/privcmd.c     | 30 +---------------------------
>  drivers/xen/xen-builtin.c | 41 +++++++++++++++++++++++++++++++++++++++
>  include/xen/xen-ops.h     |  3 +++
>  4 files changed, 46 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/xen/xen-builtin.c
> 
> diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
> index ad3844d9f876..c3cbfcf30d38 100644
> --- a/drivers/xen/Makefile
> +++ b/drivers/xen/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_HOTPLUG_CPU)		+= cpu_hotplug.o
>  obj-y	+= grant-table.o features.o balloon.o manage.o preempt.o time.o
>  obj-y	+= mem-reservation.o
> +obj-y	+= xen-builtin.o
>  obj-y	+= events/
>  obj-y	+= xenbus/
>  
> diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
> index b24ddac1604b..290b6aca7e1d 100644
> --- a/drivers/xen/privcmd.c
> +++ b/drivers/xen/privcmd.c
> @@ -723,26 +723,6 @@ static long privcmd_ioctl_restrict(struct file *file, void __user *udata)
>  	return 0;
>  }
>  
> -struct remap_pfn {
> -	struct mm_struct *mm;
> -	struct page **pages;
> -	pgprot_t prot;
> -	unsigned long i;
> -};
> -
> -static int remap_pfn_fn(pte_t *ptep, pgtable_t token, unsigned long addr,
> -			void *data)
> -{
> -	struct remap_pfn *r = data;
> -	struct page *page = r->pages[r->i];
> -	pte_t pte = pte_mkspecial(pfn_pte(page_to_pfn(page), r->prot));
> -
> -	set_pte_at(r->mm, addr, ptep, pte);
> -	r->i++;
> -
> -	return 0;
> -}
> -
>  static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
>  {
>  	struct privcmd_data *data = file->private_data;
> @@ -809,15 +789,7 @@ static long privcmd_ioctl_mmap_resource(struct file *file, void __user *udata)
>  		goto out;
>  
>  	if (xen_feature(XENFEAT_auto_translated_physmap)) {
> -		struct remap_pfn r = {
> -			.mm = vma->vm_mm,
> -			.pages = vma->vm_private_data,
> -			.prot = vma->vm_page_prot,
> -		};
> -
> -		rc = apply_to_page_range(r.mm, kdata.addr,
> -					 kdata.num << PAGE_SHIFT,
> -					 remap_pfn_fn, &r);
> +		rc = xen_remap_vma_range(vma, kdata.addr, kdata.num << PAGE_SHIFT);
>  	} else {
>  		unsigned int domid =
>  			(xdata.flags & XENMEM_rsrc_acq_caller_owned) ?
> diff --git a/drivers/xen/xen-builtin.c b/drivers/xen/xen-builtin.c
> new file mode 100644
> index 000000000000..8ad0d4900588
> --- /dev/null
> +++ b/drivers/xen/xen-builtin.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Architecture independent helper functions for memory management
> + *
> + * Written by Paul Durrant <paul.durrant@citrix.com>
> + */
> +#include <linux/mm.h>
> +#include <linux/export.h>

Shouldn't you #include xen/xen-ops.h here as well?


Juergen
