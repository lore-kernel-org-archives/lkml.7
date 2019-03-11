Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFEBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 00:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8335820652
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 00:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfCKACZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 20:02:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58634 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfCKACZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 20:02:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C7C37C04959C;
        Mon, 11 Mar 2019 00:02:24 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CA261001E69;
        Mon, 11 Mar 2019 00:02:21 +0000 (UTC)
Date:   Mon, 11 Mar 2019 08:02:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Omar Sandoval <osandov@fb.com>, Jiri Bohac <jbohac@suse.cz>,
        Dave Young <dyoung@redhat.com>
Subject: Re: [PATCH v5] x86/gart/kcore: Exclude GART aperture from kcore
Message-ID: <20190311000218.GD21116@MiWiFi-R3L-srv>
References: <20190308030508.13548-1-kasong@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190308030508.13548-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 11 Mar 2019 00:02:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/19 at 11:05am, Kairui Song wrote:
> On machines where the GART aperture is mapped over physical RAM,
> /proc/kcore contains the GART aperture range and reading it may lead
> to kernel panic.
> 
> Vmcore used to have the same issue, until we fixed it in
> commit 2a3e83c6f96c ("x86/gart: Exclude GART aperture from vmcore")',
> leveraging existing hook infrastructure in vmcore to let /proc/vmcore
> return zeroes when attempting to read the aperture region, and so it
> won't read from the actual memory.
> 
> We apply the same workaround for kcore. First implement the same hook
> infrastructure for kcore, then reuse the hook functions introduced in
> previous vmcore fix. Just with some minor adjustment, rename some
> functions for more general usage, and simplify the hook infrastructure
> a bit as there is no module usage yet.
> 
> Suggested-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Kairui Song <kasong@redhat.com>
> 
> ---
> 

Looks good to me, thanks for the effort.

Acked-by: Baoquan He <bhe@redhat.com>

Thanks
Baoquan


> Update from V4:
> - Remove the unregistering funtion and move functions never used after
>   init to .init
> 
> Update from V3:
> - Reuse the approach in V2, as Jiri noticed V3 approach may fail
>   some use case. It introduce overlapped region in kcore, and can't
>   garenteen the read request will fall into the region we wanted.
> - Improve some function naming suggested by Baoquan in V2.
> - Simplify the hook registering and checking, we are not exporting the
>   hook register function for now, no need to make it that complex.
> 
> Update from V2:
> Instead of repeating the same hook infrastructure for kcore, introduce
> a new kcore area type to avoid reading from, and let kcore always bypass
> this kind of area.
> 
> Update from V1:
> Fix a complie error when CONFIG_PROC_KCORE is not set
> 
>  arch/x86/kernel/aperture_64.c | 20 +++++++++++++-------
>  fs/proc/kcore.c               | 27 +++++++++++++++++++++++++++
>  include/linux/kcore.h         |  2 ++
>  3 files changed, 42 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/aperture_64.c b/arch/x86/kernel/aperture_64.c
> index 58176b56354e..294ed4392a0e 100644
> --- a/arch/x86/kernel/aperture_64.c
> +++ b/arch/x86/kernel/aperture_64.c
> @@ -14,6 +14,7 @@
>  #define pr_fmt(fmt) "AGP: " fmt
>  
>  #include <linux/kernel.h>
> +#include <linux/kcore.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/memblock.h>
> @@ -57,7 +58,7 @@ int fallback_aper_force __initdata;
>  
>  int fix_aperture __initdata = 1;
>  
> -#ifdef CONFIG_PROC_VMCORE
> +#if defined(CONFIG_PROC_VMCORE) || defined(CONFIG_PROC_KCORE)
>  /*
>   * If the first kernel maps the aperture over e820 RAM, the kdump kernel will
>   * use the same range because it will remain configured in the northbridge.
> @@ -66,20 +67,25 @@ int fix_aperture __initdata = 1;
>   */
>  static unsigned long aperture_pfn_start, aperture_page_count;
>  
> -static int gart_oldmem_pfn_is_ram(unsigned long pfn)
> +static int gart_mem_pfn_is_ram(unsigned long pfn)
>  {
>  	return likely((pfn < aperture_pfn_start) ||
>  		      (pfn >= aperture_pfn_start + aperture_page_count));
>  }
>  
> -static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
> +static void __init exclude_from_core(u64 aper_base, u32 aper_order)
>  {
>  	aperture_pfn_start = aper_base >> PAGE_SHIFT;
>  	aperture_page_count = (32 * 1024 * 1024) << aper_order >> PAGE_SHIFT;
> -	WARN_ON(register_oldmem_pfn_is_ram(&gart_oldmem_pfn_is_ram));
> +#ifdef CONFIG_PROC_VMCORE
> +	WARN_ON(register_oldmem_pfn_is_ram(&gart_mem_pfn_is_ram));
> +#endif
> +#ifdef CONFIG_PROC_KCORE
> +	WARN_ON(register_mem_pfn_is_ram(&gart_mem_pfn_is_ram));
> +#endif
>  }
>  #else
> -static void exclude_from_vmcore(u64 aper_base, u32 aper_order)
> +static void exclude_from_core(u64 aper_base, u32 aper_order)
>  {
>  }
>  #endif
> @@ -474,7 +480,7 @@ int __init gart_iommu_hole_init(void)
>  			 * may have allocated the range over its e820 RAM
>  			 * and fixed up the northbridge
>  			 */
> -			exclude_from_vmcore(last_aper_base, last_aper_order);
> +			exclude_from_core(last_aper_base, last_aper_order);
>  
>  			return 1;
>  		}
> @@ -520,7 +526,7 @@ int __init gart_iommu_hole_init(void)
>  	 * overlap with the first kernel's memory. We can't access the
>  	 * range through vmcore even though it should be part of the dump.
>  	 */
> -	exclude_from_vmcore(aper_alloc, aper_order);
> +	exclude_from_core(aper_alloc, aper_order);
>  
>  	/* Fix up the north bridges */
>  	for (i = 0; i < amd_nb_bus_dev_ranges[i].dev_limit; i++) {
> diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
> index bbcc185062bb..d29d869abec1 100644
> --- a/fs/proc/kcore.c
> +++ b/fs/proc/kcore.c
> @@ -54,6 +54,28 @@ static LIST_HEAD(kclist_head);
>  static DECLARE_RWSEM(kclist_lock);
>  static int kcore_need_update = 1;
>  
> +/*
> + * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
> + * Same as oldmem_pfn_is_ram in vmcore
> + */
> +static int (*mem_pfn_is_ram)(unsigned long pfn);
> +
> +int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn))
> +{
> +	if (mem_pfn_is_ram)
> +		return -EBUSY;
> +	mem_pfn_is_ram = fn;
> +	return 0;
> +}
> +
> +static int pfn_is_ram(unsigned long pfn)
> +{
> +	if (mem_pfn_is_ram)
> +		return mem_pfn_is_ram(pfn);
> +	else
> +		return 1;
> +}
> +
>  /* This doesn't grab kclist_lock, so it should only be used at init time. */
>  void __init kclist_add(struct kcore_list *new, void *addr, size_t size,
>  		       int type)
> @@ -465,6 +487,11 @@ read_kcore(struct file *file, char __user *buffer, size_t buflen, loff_t *fpos)
>  				goto out;
>  			}
>  			m = NULL;	/* skip the list anchor */
> +		} else if (!pfn_is_ram(__pa(start) >> PAGE_SHIFT)) {
> +			if (clear_user(buffer, tsz)) {
> +				ret = -EFAULT;
> +				goto out;
> +			}
>  		} else if (m->type == KCORE_VMALLOC) {
>  			vread(buf, (char *)start, tsz);
>  			/* we have to zero-fill user buffer even if no read */
> diff --git a/include/linux/kcore.h b/include/linux/kcore.h
> index 8c3f8c14eeaa..c843f4a9c512 100644
> --- a/include/linux/kcore.h
> +++ b/include/linux/kcore.h
> @@ -44,6 +44,8 @@ void kclist_add_remap(struct kcore_list *m, void *addr, void *vaddr, size_t sz)
>  	m->vaddr = (unsigned long)vaddr;
>  	kclist_add(m, addr, sz, KCORE_REMAP);
>  }
> +
> +extern int __init register_mem_pfn_is_ram(int (*fn)(unsigned long pfn));
>  #else
>  static inline
>  void kclist_add(struct kcore_list *new, void *addr, size_t size, int type)
> -- 
> 2.20.1
> 
