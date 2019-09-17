Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBE4C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390DF206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ja14gtvZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfIQOKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 10:10:21 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46761 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfIQOKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 10:10:21 -0400
Received: by mail-ot1-f65.google.com with SMTP id f21so1007otl.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 07:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8UALXrAF8WnpelFZ4otiIrYrkhsux0g2WXlYWe7ggk4=;
        b=Ja14gtvZdjyDosPDl0vXmCPksiwz1GkRkxKFdo1NirVHi8UWI0mDgDRvkDLsenfFYL
         +pnMVu50T4c8WNurYKwB/9e+Bjmhkmy8YbJZrQLVWEbW+yyBtil/BiqQpNxEuwu0YZ1+
         ERQEnpbQxfMDEIGiOUPOerXZHqBx5Y/ZuInS2+FcpajqfH5LLO9ILuhhL26gHyEwtowX
         9EurAe6mGc1fEFmYM0rV7lF3PYqIlf9MhweitSIiLGaKGA8lMhA9oaKPRNVAkf7ldEXC
         wLvpsy+//OHx26RcuDMtfLDnDfoIJM+7F6hh4Oz5uhQhUo+xWi5zkMF0AXWL8ks7ojem
         Arwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8UALXrAF8WnpelFZ4otiIrYrkhsux0g2WXlYWe7ggk4=;
        b=T7wLCWhpbp+vWuzrh1cfvXppKQpUrLbbgIKkLJWssalYrFoeAfx3KInZ/O04/qmT2v
         HXR8qpcBSDSS8iD1EzOIOmiwyNPYfYyiIUigrfKmeX/dfEHcTsoIMQ4va0IDnikivUBS
         UhBwAIQWNHLgRqWfDQbFeQFK5Bga0b69L8CSd6zlBlPinuvFyyWXxG41nptScZKHh8sA
         WD8I2GS82E8d5EifLBmJGJY1MmGDMwOR59CMBerUTCpchxJ1BXBsN6KaS27iC1DE7DnB
         UZzT3yVR2RYkTYLV6XvTocyp7SHRuVf7r0RV8DSyd58EnZPjQn8iWa29Rg8J0j7G0WP/
         JNhg==
X-Gm-Message-State: APjAAAXsawm81QExf1LXttYdqVXrXHA5foy+m+p0ufg+gVrmMswoA0Zw
        bRUPg40rLYomn3P7g2p8fSrB1TJRhle+xwJXGzU=
X-Google-Smtp-Source: APXvYqyds89hV8IjAloUM/+5NGhwLVhpl1GVga/SeSIVPZz/XiqQ1nIlWXDsPIydRM6CO03+PXzKbTapTxLc+pTjTls=
X-Received: by 2002:a05:6830:1e05:: with SMTP id s5mr2068860otr.173.1568729418876;
 Tue, 17 Sep 2019 07:10:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190915170809.10702-1-lpf.vector@gmail.com> <20190915170809.10702-6-lpf.vector@gmail.com>
 <alpine.DEB.2.21.1909151425490.211705@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.1909151425490.211705@chino.kir.corp.google.com>
From:   Pengfei Li <lpf.vector@gmail.com>
Date:   Tue, 17 Sep 2019 22:10:07 +0800
Message-ID: <CAD7_sbEVsPEJUGpvd=M13=gW316=T71cXbE9jGJG61TZRD7ZtQ@mail.gmail.com>
Subject: Re: [RESEND v4 5/7] mm, slab_common: Make kmalloc_caches[] start at
 size KMALLOC_MIN_SIZE
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christopher Lameter <cl@linux.com>, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 5:38 AM David Rientjes <rientjes@google.com> wrote:
>
> On Mon, 16 Sep 2019, Pengfei Li wrote:
>
> > Currently, kmalloc_cache[] is not sorted by size, kmalloc_cache[0]
> > is kmalloc-96, kmalloc_cache[1] is kmalloc-192 (when ARCH_DMA_MINALIGN
> > is not defined).
> >
> > As suggested by Vlastimil Babka,
> >
> > "Since you're doing these cleanups, have you considered reordering
> > kmalloc_info, size_index, kmalloc_index() etc so that sizes 96 and 192
> > are ordered naturally between 64, 128 and 256? That should remove
> > various special casing such as in create_kmalloc_caches(). I can't
> > guarantee it will be possible without breaking e.g. constant folding
> > optimizations etc., but seems to me it should be feasible. (There are
> > definitely more places to change than those I listed.)"
> >
> > So this patch reordered kmalloc_info[], kmalloc_caches[], and modified
> > kmalloc_index() and kmalloc_slab() accordingly.
> >
> > As a result, there is no subtle judgment about size in
> > create_kmalloc_caches(). And initialize kmalloc_cache[] from 0 instead
> > of KMALLOC_SHIFT_LOW.
> >
> > I used ./scripts/bloat-o-meter to measure the impact of this patch on
> > performance. The results show that it brings some benefits.
> >
> > Considering the size change of kmalloc_info[], the size of the code is
> > actually about 641 bytes less.
> >
>
> bloat-o-meter is reporting a net benefit of -241 bytes for this, so not
> sure about relevancy of the difference for only kmalloc_info.
>

Thanks for your comments.

The size of kmalloc_info has been increased from 432 to 832 (it was
renamed to all_kmalloc_info ). So when the change in kmalloc_info size
is not included, it actually reduces 641 bytes.

> This, to me, looks like increased complexity for the statically allocated
> arrays vs the runtime complexity when initializing the caches themselves.

For runtime kmalloc requests, the implementation of kmalloc_slab() is
no different than before.
For constant kmalloc requests, the smaller size of .text means better
(the compiler does constant optimization).
Therefore, I don't think this patch adds complexity.

> Not sure that this is an improvement given that you still need to do
> things like
>
> +#if KMALLOC_SIZE_96_EXIST == 1
> +       if (size > 64 && size <= 96) return (7 - KMALLOC_IDX_ADJ_0);
> +#endif
> +
> +#if KMALLOC_SIZE_192_EXIST == 1
> +       if (size > 128 && size <= 192) return (8 - KMALLOC_IDX_ADJ_1);
> +#endif

kmalloc_index() is difficult to handle for me.

At first, I made the judgment in the order of size in kmalloc_index(),

----
/* Order 96, 192 */
static __always_inline unsigned int kmalloc_index(size_t size)
{
...
if (size <=                8) return ( 3 - KMALLOC_IDX_ADJ_0);
if (size <=               16) return ( 4 - KMALLOC_IDX_ADJ_0);
if (size <=               32) return ( 5 - KMALLOC_IDX_ADJ_0);
if (size <=               64) return ( 6 - KMALLOC_IDX_ADJ_0);
#if KMALLOC_SIZE_96_EXIST == 1
if (size <=               96) return ( 7 - KMALLOC_IDX_ADJ_0);
#endif
if (size <=              128) return ( 7 - KMALLOC_IDX_ADJ_1);
#if KMALLOC_SIZE_192_EXIST == 1
if (size <=              192) return ( 8 - KMALLOC_IDX_ADJ_1);
#endif
if (size <=              256) return ( 8 - KMALLOC_IDX_ADJ_2);
...
}

but bloat-o-meter shows that I did a bad job.
----
$ ./scripts/bloat-o-meter vmlinux-base vmlinux-patch_1-5-order_96_192
add/remove: 3/7 grow/shrink: 129/167 up/down: 3691/-2530 (1161)
Function                                     old     new   delta
all_kmalloc_info                               -     832    +832
jhash                                        744    1119    +375
__regmap_init                               3252    3411    +159
drm_mode_atomic_ioctl                       2373    2479    +106
apply_wqattrs_prepare                        449     531     +82
process_preds                               1772    1851     +79
amd_uncore_cpu_up_prepare                    251     327     +76
property_entries_dup.part                    789     861     +72
pnp_register_port_resource                    98     167     +69
pnp_register_mem_resource                     98     167     +69
pnp_register_irq_resource                    146     206     +60
pnp_register_dma_resource                     61     121     +60
pcpu_get_vm_areas                           3086    3139     +53
sr_probe                                    1360    1409     +49
fl_create                                    675     724     +49
ext4_expand_extra_isize_ea                  2218    2265     +47
fib6_info_alloc                               60     105     +45
init_worker_pool                             247     291     +44
ctnetlink_alloc_filter.part                    -      43     +43
alloc_workqueue                             1229    1270     +41
...
Total: Before=14789209, After=14790370, chg +0.01%

It increased by 1161 bytes.

I tried to modify it many times until the special judgment of 96, 192
was placed at the beginning of the function, and the bloat-o-meter
showed a reduction of 241 bytes.

$ ./scripts/bloat-o-meter vmlinux-base vmlinux-patch_1-5
add/remove: 1/2 grow/shrink: 6/64 up/down: 872/-1113 (-241)
Total: Before=14789209, After=14788968, chg -0.00%

Therefore, the implementation of kmalloc_index() in the patch is
intentional.

In addition, the above data was generated from my laptop. But with the
same code and kernel configuration, it shows different test results on
my PC (probably due to different versions of GCC).

$ ./scripts/bloat-o-meter vmlinux-base vmlinux-patch_1-5
add/remove: 1/2 grow/shrink: 6/70 up/down: 856/-1062 (-206)

$ ./scripts/bloat-o-meter vmlinux-base vmlinux-patch_1-5-order_96_192
add/remove: 1/2 grow/shrink: 12/71 up/down: 989/-1165 (-176)

Sorting 96 and 192 by size in a timely manner makes the result worse,
but at least the sum is still negative.
