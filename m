Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B539C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DB921F26
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfGVILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:11:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:37446 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726339AbfGVILT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:11:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D86DDAF8E;
        Mon, 22 Jul 2019 08:11:17 +0000 (UTC)
Date:   Mon, 22 Jul 2019 10:11:15 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
Message-ID: <20190722081115.GH19068@suse.de>
References: <20190719184652.11391-1-joro@8bytes.org>
 <20190719184652.11391-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719184652.11391-4-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srewed up the subject :(, it needs to be

	"mm/vmalloc: Sync unmappings in __purge_vmap_area_lazy()"

of course.

On Fri, Jul 19, 2019 at 08:46:52PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> On x86-32 with PTI enabled, parts of the kernel page-tables
> are not shared between processes. This can cause mappings in
> the vmalloc/ioremap area to persist in some page-tables
> after the region is unmapped and released.
> 
> When the region is re-used the processes with the old
> mappings do not fault in the new mappings but still access
> the old ones.
> 
> This causes undefined behavior, in reality often data
> corruption, kernel oopses and panics and even spontaneous
> reboots.
> 
> Fix this problem by activly syncing unmaps in the
> vmalloc/ioremap area to all page-tables in the system before
> the regions can be re-used.
> 
> References: https://bugzilla.suse.com/show_bug.cgi?id=1118689
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Fixes: 5d72b4fba40ef ('x86, mm: support huge I/O mapping capability I/F')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  mm/vmalloc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 4fa8d84599b0..e0fc963acc41 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1258,6 +1258,12 @@ static bool __purge_vmap_area_lazy(unsigned long start, unsigned long end)
>  	if (unlikely(valist == NULL))
>  		return false;
>  
> +	/*
> +	 * First make sure the mappings are removed from all page-tables
> +	 * before they are freed.
> +	 */
> +	vmalloc_sync_all();
> +
>  	/*
>  	 * TODO: to calculate a flush range without looping.
>  	 * The list can be up to lazy_max_pages() elements.
> @@ -3038,6 +3044,9 @@ EXPORT_SYMBOL(remap_vmalloc_range);
>  /*
>   * Implement a stub for vmalloc_sync_all() if the architecture chose not to
>   * have one.
> + *
> + * The purpose of this function is to make sure the vmalloc area
> + * mappings are identical in all page-tables in the system.
>   */
>  void __weak vmalloc_sync_all(void)
>  {
> -- 
> 2.17.1
