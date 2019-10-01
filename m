Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411F2ECDFB6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CF721783
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 05:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbfJAF2M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 01:28:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:7652 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727720AbfJAF2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 01:28:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Sep 2019 22:28:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,570,1559545200"; 
   d="scan'208";a="190478749"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2019 22:28:10 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 22:28:10 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Sep 2019 22:28:09 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.119]) with mapi id 14.03.0439.000;
 Tue, 1 Oct 2019 13:28:08 +0800
From:   "Zhang, Jun" <jun.zhang@intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "labbott@redhat.com" <labbott@redhat.com>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        "arve@android.com" <arve@android.com>,
        "tkjos@android.com" <tkjos@android.com>,
        "maco@android.com" <maco@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "christian@brauner.io" <christian@brauner.io>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "Bai, Jie A" <jie.a.bai@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "he@osuosl.org" <he@osuosl.org>, "Bai@osuosl.org" <Bai@osuosl.org>,
        "He, Bo" <bo.he@intel.com>
Subject: RE: [PATCH] ion_system_heap: support X86 archtecture
Thread-Topic: [PATCH] ion_system_heap: support X86 archtecture
Thread-Index: AQHVdppyYu/UDgwp3kCa1tCveaZ4I6dB6ZkAgANY4IA=
Date:   Tue, 1 Oct 2019 05:28:07 +0000
Message-ID: <88DC34334CA3444C85D647DBFA962C2735B662D8@SHSMSX104.ccr.corp.intel.com>
References: <20190929072841.14848-1-jun.zhang@intel.com>
 <20190929101254.GA1907778@kroah.com>
In-Reply-To: <20190929101254.GA1907778@kroah.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjViOGZjNzEtZDcxOS00YTFjLTk4NGUtYTUzYzBjOGNmMjUwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoic25ZeGlQekh3WlRQa1RtNTVxa0VvSEpzV2RmaU5SdG41eWxkbm4reU1Ta3c0aTJpQVEwTUdPODZqUCtsdTNiRiJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Greg

Sorry, I am newcomer, and I don't know why couldn't use #ifdefs?  I only refer some kernel code(V4.19) in drivers/hwtracing/intel_th/msu.c.
Could you tell me why? And I tell my workmate to avoid the same case.

If I define a config in Kconfig, and static inline function in .h file, then call it? Could you accept it?

If not, Could you give me a sample?

Thanks,
Jun

-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org> 
Sent: Sunday, September 29, 2019 6:13 PM
To: Zhang, Jun <jun.zhang@intel.com>
Cc: labbott@redhat.com; sumit.semwal@linaro.org; arve@android.com; tkjos@android.com; maco@android.com; joel@joelfernandes.org; christian@brauner.io; devel@driverdev.osuosl.org; Bai, Jie A <jie.a.bai@intel.com>; linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; linaro-mm-sig@lists.linaro.org; he@osuosl.org; Bai@osuosl.org; He, Bo <bo.he@intel.com>
Subject: Re: [PATCH] ion_system_heap: support X86 archtecture

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
> vm_insert_pfn Drivers wanting to export some pages to userspace do it 
> by using mmap interface and a combination of
> 1) pgprot_noncached()
> 2) io_remap_pfn_range() or remap_pfn_range() or vm_insert_pfn() With 
> PAT support, a new API pgprot_writecombine is being added.
> So, drivers can continue to use the above sequence, with either
> pgprot_noncached() or pgprot_writecombine() in step 1, followed by step 2.
> 
> In addition, step 2 internally tracks the region as UC or WC in 
> memtype list in order to ensure no conflicting mapping.
> 
> Note that this set of APIs only works with IO (non RAM) regions.
> If driver ants to export a RAM region, it has to do set_memory_uc() or
> set_memory_wc() as step 0 above and also track the usage of those 
> pages and use set_memory_wb() before the page is freed to free pool.
> 
> the fix follow the pat document, do set_memory_wc() as step 0 and use 
> the set_memory_wb() before the page is freed.
> 
> Signed-off-by: he, bo <bo.he@intel.com>
> Signed-off-by: zhang jun <jun.zhang@intel.com>
> Signed-off-by: Bai, Jie A <jie.a.bai@intel.com>
> ---
>  drivers/staging/android/ion/ion_system_heap.c | 28 
> ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ion/ion_system_heap.c 
> b/drivers/staging/android/ion/ion_system_heap.c
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
> +			      PAGE_ALIGN(sg->length) >> PAGE_SHIFT); #endif

There is no way to do this without these #ifdefs?  That feels odd, why can't you just always test for this?

thanks,

greg k-h
