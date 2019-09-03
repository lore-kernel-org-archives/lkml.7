Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CCC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF37220674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 15:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="aWiI9WRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbfICPI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:08:57 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42825 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbfICPI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 11:08:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id p3so9295985pgb.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 08:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=iV/j2+7ceSELqxPlCshRDxNfNslsjKkYw2OY9C0rDVo=;
        b=aWiI9WRgXbQeAID7GFyo3Q1ah/rNyTJ03sPm3IAil3CvNKVw/i6dbU+tnIx3g2XmjM
         c71n4AzjH4k5pt9CmABReGzF95E/+6RUuGYTsFuVhfeLtdZhz2Gv3MsUzoGRtOBxW2Sy
         0tBM1bRi6Y266azH+Hj7mMRqad9635cRAVTwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iV/j2+7ceSELqxPlCshRDxNfNslsjKkYw2OY9C0rDVo=;
        b=HxdEHuI6dpmwmJEzfGnTdLszkfipJKBsD8X3nWJihi3qMS4lX9YUg/avvoHSnYTWEj
         NA23w36hTEGAUJ2+Uy5+5W8lUpY/CbNBho59BbthBJx6aCV5ReilNc/+1A11eNaiAeIg
         UhaNYZb78lbhQa2dvRGRwWXR9bIfHRQ61Cu0DJsCzowp7nJpzLbCW3TfzW1MqpfPmdU9
         43hXBI3pFOo4urDHj2B457lMTRYXPoHTKetS+oVhHqog4SZgqEnDUfcfICwtsotjeL3Y
         lFandbN6rI3aSom7REnAGPYFZgesTqCmFGOEGjs7TVkD1DhcKMzrt3GktLmtzh/9n9ZG
         mKkg==
X-Gm-Message-State: APjAAAWodlXZZsQ9HNdJzVzkn5RpY2HAgCNJuiiIneCxWukJ6MDeT6M5
        UEvbMd1mXJMEYYJ4z+wu5emAJg==
X-Google-Smtp-Source: APXvYqxEkC0LeN+73qxepxpsVcqtgvFuYscUomXFoJBS7idF/AbxKh3/qr2qbPxdzwGKyr+HzUyREw==
X-Received: by 2002:a17:90a:9486:: with SMTP id s6mr585156pjo.0.1567523335724;
        Tue, 03 Sep 2019 08:08:55 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id m9sm26858738pgr.24.2019.09.03.08.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 08:08:54 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Nick Hu <nickhu@andestech.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     =?utf-8?Q?Alan_Quey-Liang_Kao=28=E9=AB=98=E9=AD=81=E8=89=AF=29?= 
        <alankao@andestech.com>,
        "paul.walmsley\@sifive.com" <paul.walmsley@sifive.com>,
        "palmer\@sifive.com" <palmer@sifive.com>,
        "aou\@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "green.hu\@gmail.com" <green.hu@gmail.com>,
        "deanbo422\@gmail.com" <deanbo422@gmail.com>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "linux-riscv\@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aryabinin\@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "glider\@google.com" <glider@google.com>,
        "dvyukov\@google.com" <dvyukov@google.com>,
        "Anup.Patel\@wdc.com" <Anup.Patel@wdc.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "alexios.zavras\@intel.com" <alexios.zavras@intel.com>,
        "atish.patra\@wdc.com" <atish.patra@wdc.com>,
        =?utf-8?B?6Zui6IG3Wm9uZyBab25nLVhpYW4gTGko5p2O5a6X5oayKQ==?= 
        <zong@andestech.com>,
        "kasan-dev\@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 2/2] riscv: Add KASAN support
In-Reply-To: <20190814074417.GA21929@andestech.com>
References: <cover.1565161957.git.nickhu@andestech.com> <88358ef8f7cfcb7fd01b6b989eccaddbe00a1e57.1565161957.git.nickhu@andestech.com> <20190812151050.GJ26897@infradead.org> <20190814074417.GA21929@andestech.com>
Date:   Wed, 04 Sep 2019 01:08:51 +1000
Message-ID: <87k1apto1o.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Hu <nickhu@andestech.com> writes:

> Hi Christoph,
>
> Thanks for your reply. I will answer one by one.
>
> Hi Alexander,
>
> Would you help me for the question about SOFTIRQENTRY_TEXT?
>
> On Mon, Aug 12, 2019 at 11:10:50PM +0800, Christoph Hellwig wrote:
>> > 2. KASAN can't debug the modules since the modules are allocated in VMALLOC
>> > area. We mapped the shadow memory, which corresponding to VMALLOC area,
>> > to the kasan_early_shadow_page because we don't have enough physical space
>> > for all the shadow memory corresponding to VMALLOC area.
>> 
>> How do other architectures solve this problem?
>> 
> Other archs like arm64 and x86 allocate modules in their module region.

I've run in to a similar difficulty in ppc64. My approach has been to
add a generic feature to allow kasan to handle vmalloc areas:

https://lore.kernel.org/linux-mm/20190903145536.3390-1-dja@axtens.net/

I link this with ppc64 in this series:

https://lore.kernel.org/linuxppc-dev/20190806233827.16454-1-dja@axtens.net/

However, see Christophe Leroy's comments: he thinks I should take a
different approach in a number of places, including just adding a
separate module area. I haven't had time to think through all of his
proposals yet; in particular I'd want to think through what the
implication of a separate module area is for KASLR.

Regards,
Daniel

>
>> > @@ -54,6 +54,8 @@ config RISCV
>> >  	select EDAC_SUPPORT
>> >  	select ARCH_HAS_GIGANTIC_PAGE
>> >  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>> > +	select GENERIC_STRNCPY_FROM_USER if KASAN
>> 
>> Is there any reason why we can't always enabled this?  Also just
>> enabling the generic efficient strncpy_from_user should probably be
>> a separate patch.
>> 
> You're right, always enable it would be better.
>
>> > +	select HAVE_ARCH_KASAN if MMU
>> 
>> Based on your cover letter this should be if MMU && 64BIT
>> 
>> >  #define __HAVE_ARCH_MEMCPY
>> >  extern asmlinkage void *memcpy(void *, const void *, size_t);
>> > +extern asmlinkage void *__memcpy(void *, const void *, size_t);
>> >  
>> >  #define __HAVE_ARCH_MEMMOVE
>> >  extern asmlinkage void *memmove(void *, const void *, size_t);
>> > +extern asmlinkage void *__memmove(void *, const void *, size_t);
>> > +
>> > +#define memcpy(dst, src, len) __memcpy(dst, src, len)
>> > +#define memmove(dst, src, len) __memmove(dst, src, len)
>> > +#define memset(s, c, n) __memset(s, c, n)
>> 
>> This looks weird and at least needs a very good comment.  Also
>> with this we effectively don't need the non-prefixed prototypes
>> anymore.  Also you probably want to split the renaming of the mem*
>> routines into a separate patch with a proper changelog.
>> 
> I made some mistakes on this porting, this would be better:
>
> #define __HAVE_ARCH_MEMSET
> extern asmlinkage void *memset(void *, int, size_t);
> extern asmlinkage void *__memset(void *, int, size_t);
>
> #define __HAVE_ARCH_MEMCPY
> extern asmlinkage void *memcpy(void *, const void *, size_t);
> extern asmlinkage void *__memcpy(void *, const void *, size_t);
>
> #define __HAVE_ARCH_MEMMOVE
> extern asmlinkage void *memmove(void *, const void *, size_t);
> extern asmlinkage void *__memmove(void *, const void *, size_t);
>
> #if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
>
> #define memcpy(dst, src, len) __memcpy(dst, src, len)
> #define memmove(dst, src, len) __memmove(dst, src, len)
> #define memset(s, c, n) __memset(s, c, n)
>
> #endif
>
>> >  #include <asm/tlbflush.h>
>> >  #include <asm/thread_info.h>
>> >  
>> > +#ifdef CONFIG_KASAN
>> > +#include <asm/kasan.h>
>> > +#endif
>> 
>> Any good reason to not just always include the header?
>>
> Nope, I would remove the '#ifdef CONFIG_KASAN', and do the logic in the header
> instead.
>
>> > +
>> >  #ifdef CONFIG_DUMMY_CONSOLE
>> >  struct screen_info screen_info = {
>> >  	.orig_video_lines	= 30,
>> > @@ -64,12 +68,17 @@ void __init setup_arch(char **cmdline_p)
>> >  
>> >  	setup_bootmem();
>> >  	paging_init();
>> > +
>> >  	unflatten_device_tree();
>> 
>> spurious whitespace change.
>> 
>> > diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>> > index 23cd1a9..9700980 100644
>> > --- a/arch/riscv/kernel/vmlinux.lds.S
>> > +++ b/arch/riscv/kernel/vmlinux.lds.S
>> > @@ -46,6 +46,7 @@ SECTIONS
>> >  		KPROBES_TEXT
>> >  		ENTRY_TEXT
>> >  		IRQENTRY_TEXT
>> > +		SOFTIRQENTRY_TEXT
>> 
>> Hmm.  What is the relation to kasan here?  Maybe we should add this
>> separately with a good changelog?
>> 
> There is a commit for it:
>
> Author: Alexander Potapenko <glider@google.com>
> Date:   Fri Mar 25 14:22:05 2016 -0700
>
>     arch, ftrace: for KASAN put hard/soft IRQ entries into separate sections
>
>     KASAN needs to know whether the allocation happens in an IRQ handler.
>     This lets us strip everything below the IRQ entry point to reduce the
>     number of unique stack traces needed to be stored.
>
>     Move the definition of __irq_entry to <linux/interrupt.h> so that the
>     users don't need to pull in <linux/ftrace.h>.  Also introduce the
>     __softirq_entry macro which is similar to __irq_entry, but puts the
>     corresponding functions to the .softirqentry.text section.
>
> After reading the patch I understand that soft/hard IRQ entries should be
> separated for KASAN to work, but why?
>
> Alexender, do you have any comments on this?
>
>> > +++ b/arch/riscv/mm/kasan_init.c
>> > @@ -0,0 +1,102 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> 
>> This probably also wants a copyright statement.
>> 
>> > +	// init for swapper_pg_dir
>> 
>> Please use /* */ style comments.
>
> -- 
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20190814074417.GA21929%40andestech.com.
