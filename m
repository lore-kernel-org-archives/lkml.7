Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5830BC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E19207FA
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 10:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569752098;
	bh=iA59w1NaMEWbdMwVd9RqjRIthDIUAHLMrP7xRK9GzCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=03sx44MIls/v/trzA5IqS/SLIqjqsa+flCibvu0nceFEBsKjwjX2hMk6x+GKruJFq
	 fzNO2nOZ01k59ApS0iR2ExV3NxCHWq/kr/5zQDxoRWgtg+MoWS6bOcFy3Zc7/3A4+d
	 fgBP5sELP+whskTkjRrI3tmoiprBH6fg8M43wXoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfI2KM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 06:12:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfI2KM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 06:12:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91A76207FA;
        Sun, 29 Sep 2019 10:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569751977;
        bh=iA59w1NaMEWbdMwVd9RqjRIthDIUAHLMrP7xRK9GzCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsimsHhgmGlkho9Zjk2InZF3otI2sYSWm269oaYYRMVvh3u8CR0xguJunZyBa0UxB
         3FDThahbn9TSTlk93/fEXsvg5XkBgKbbrKkyd/dSytBUu+/o7a4kEhQuuI/jL3Vztg
         6VPLj7yBmwHhmYUr0BBy+/qBPnRldE5+7QGDRu8U=
Date:   Sun, 29 Sep 2019 12:12:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jun.zhang@intel.com
Cc:     labbott@redhat.com, sumit.semwal@linaro.org, arve@android.com,
        tkjos@android.com, maco@android.com, joel@joelfernandes.org,
        christian@brauner.io, devel@driverdev.osuosl.org,
        Jie A <jie.a.bai@intel.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        he@osuosl.org, Bai@osuosl.org, bo <bo.he@intel.com>
Subject: Re: [PATCH] ion_system_heap: support X86 archtecture
Message-ID: <20190929101254.GA1907778@kroah.com>
References: <20190929072841.14848-1-jun.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190929072841.14848-1-jun.zhang@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 03:28:41PM +0800, jun.zhang@intel.com wrote:
> From: zhang jun <jun.zhang@intel.com>
> 
> we see tons of warning like:
> [   45.846872] x86/PAT: NDK MediaCodec_:3753 map pfn RAM range req
> write-combining for [mem 0x1e7a80000-0x1e7a87fff], got write-back
> [   45.848827] x86/PAT: .vorbis.decoder:4088 map pfn RAM range req
> write-combining for [mem 0x1e7a58000-0x1e7a58fff], got write-back
> [   45.848875] x86/PAT: NDK MediaCodec_:3753 map pfn RAM range req
> write-combining for [mem 0x1e7a48000-0x1e7a4ffff], got write-back
> [   45.849403] x86/PAT: .vorbis.decoder:4088 map pfn RAM range
> req write-combining for [mem 0x1e7a70000-0x1e7a70fff], got write-back
> 
> check the kernel Documentation/x86/pat.txt, it says:
> A. Exporting pages to users with remap_pfn_range, io_remap_pfn_range,
> vm_insert_pfn
> Drivers wanting to export some pages to userspace do it by using
> mmap interface and a combination of
> 1) pgprot_noncached()
> 2) io_remap_pfn_range() or remap_pfn_range() or vm_insert_pfn()
> With PAT support, a new API pgprot_writecombine is being added.
> So, drivers can continue to use the above sequence, with either
> pgprot_noncached() or pgprot_writecombine() in step 1, followed by step 2.
> 
> In addition, step 2 internally tracks the region as UC or WC in
> memtype list in order to ensure no conflicting mapping.
> 
> Note that this set of APIs only works with IO (non RAM) regions.
> If driver ants to export a RAM region, it has to do set_memory_uc() or
> set_memory_wc() as step 0 above and also track the usage of those pages
> and use set_memory_wb() before the page is freed to free pool.
> 
> the fix follow the pat document, do set_memory_wc() as step 0 and
> use the set_memory_wb() before the page is freed.
> 
> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: zhang jun <jun.zhang@intel.com>
> Signed-off-by: Bai, Jie A <jie.a.bai@intel.com>
> ---
>  drivers/staging/android/ion/ion_system_heap.c | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/staging/android/ion/ion_system_heap.c
> index b83a1d16bd89..d298b8194820 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -13,6 +13,7 @@
>  #include <linux/scatterlist.h>
>  #include <linux/slab.h>
>  #include <linux/vmalloc.h>
> +#include <asm/set_memory.h>
>  
>  #include "ion.h"
>  
> @@ -134,6 +135,13 @@ static int ion_system_heap_allocate(struct ion_heap *heap,
>  	sg = table->sgl;
>  	list_for_each_entry_safe(page, tmp_page, &pages, lru) {
>  		sg_set_page(sg, page, page_size(page), 0);
> +
> +#ifdef CONFIG_X86
> +	if (!(buffer->flags & ION_FLAG_CACHED))
> +		set_memory_wc((unsigned long)page_address(sg_page(sg)),
> +			      PAGE_ALIGN(sg->length) >> PAGE_SHIFT);
> +#endif

There is no way to do this without these #ifdefs?  That feels odd, why
can't you just always test for this?

thanks,

greg k-h
