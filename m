Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B6DC31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78212147A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 18:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="m72H1JuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbfFMSmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 14:42:45 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40343 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfFMSmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:42:45 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so23760479qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 11:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UwMPFqdlIlsuUyh94qFqJWo8bgG4XPcsMw90Y+SBHo=;
        b=m72H1JuYwEklluNoL7iFcJ4fK1/znCJxc2nKWcKAZD0cUcJ6w9pIZgCffzJ9cU93YM
         VCdRP2gFU1N2XR9uFOQkXHLB/PZ3krW1EOCCFiSuDk94lHqoHohx77cO7FmY+hrpFGo2
         BHC1V3Nyxtac9u5elipQWjaIjqaHLfQ7x52w5aiwosXXnKoqsTwUMS9O+Qia7XjZpsaB
         o/fCsLJWTpUy37qCxOYkh4QmoHp/96ndIDT0ctOJ1NiwddfDvqABd3LcMjx/uernE6bf
         6K1i2Jruo7WdkFiCZrib1zSEPTMYJsWMtr1bFYRvwmc9vBnWzuExETMLgY/a8obuksR9
         Pjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UwMPFqdlIlsuUyh94qFqJWo8bgG4XPcsMw90Y+SBHo=;
        b=dM41bY/6eggxPBuKNN60WYWfYC1qk92UhbwMmlTA+gKh9h4s6IlfPfDfftWMDwMVBY
         tJBT4gxL09WTVuf/OLOKpEEPG5Xz8JOdeg8b3pyDNV070lAZPy0aZWgyHRWAezNw+gHa
         Hw6lorCmzGFYtV6LwAQULDvFZLXmJhJOT3FIjFJ9kZGKdsfT7pmw9I4Rjsxvuj2OdaDW
         Wd0zEWvd+O1h/I9XJqvxy087m0NxoHjNQVE+1069YVdBsNteK4sVlTeGTcvwycRIlHuJ
         cVEUF5i9Y1rat6UlG4SApnaSyQuFE0cobZgKeLvu3zWMXJ648DHwKtMi5JZVEfIZIxhq
         PpFg==
X-Gm-Message-State: APjAAAVAJS6HSma7W4YhHBbv4OCarXaRqXZZVx114T4A7dxbWxegbZed
        r6T6YDn6e1Kzfg/L5B6cBoxgBYpTwW0=
X-Google-Smtp-Source: APXvYqweJ7xdOI8P5EqLfWoSxv+GlPbkxVwck5o16U0lpPxXdVRwemiqvvWAQUljR4EYDejY7u9CjQ==
X-Received: by 2002:a0c:d4f4:: with SMTP id y49mr4840624qvh.238.1560451363801;
        Thu, 13 Jun 2019 11:42:43 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u2sm230776qtj.97.2019.06.13.11.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 11:42:43 -0700 (PDT)
Message-ID: <1560451362.5154.14.camel@lca.pw>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from
 pfn_to_online_page()
From:   Qian Cai <cai@lca.pw>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Jun 2019 14:42:42 -0400
In-Reply-To: <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
         <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 12:37 -0700, Dan Williams wrote:
> On Wed, Jun 12, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
> > 
> > The linux-next commit "mm/sparsemem: Add helpers track active portions
> > of a section at boot" [1] causes a crash below when the first kmemleak
> > scan kthread kicks in. This is because kmemleak_scan() calls
> > pfn_to_online_page(() which calls pfn_valid_within() instead of
> > pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=n.
> > 
> > The commit [1] did add an additional check of pfn_section_valid() in
> > pfn_valid(), but forgot to add it in the above code path.
> > 
> > page:ffffea0002748000 is uninitialized and poisoned
> > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> > ------------[ cut here ]------------
> > kernel BUG at include/linux/mm.h:1084!
> > invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> > CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ #6
> > Hardware name: Lenovo ThinkSystem SR530 -[7X07RCZ000]-/-[7X07RCZ000]-,
> > BIOS -[TEE113T-1.00]- 07/07/2017
> > RIP: 0010:kmemleak_scan+0x6df/0xad0
> > Call Trace:
> >  kmemleak_scan_thread+0x9f/0xc7
> >  kthread+0x1d2/0x1f0
> >  ret_from_fork+0x35/0x4
> > 
> > [1] https://patchwork.kernel.org/patch/10977957/
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> >  include/linux/memory_hotplug.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> > index 0b8a5e5ef2da..f02be86077e3 100644
> > --- a/include/linux/memory_hotplug.h
> > +++ b/include/linux/memory_hotplug.h
> > @@ -28,6 +28,7 @@
> >         unsigned long ___nr = pfn_to_section_nr(___pfn);           \
> >                                                                    \
> >         if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> > +           pfn_section_valid(__nr_to_section(___nr), pfn) &&      \
> >             pfn_valid_within(___pfn))                              \
> >                 ___page = pfn_to_page(___pfn);                     \
> >         ___page;                                                   \
> 
> Looks ok to me:
> 
> Acked-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...but why is pfn_to_online_page() a multi-line macro instead of a
> static inline like all the helper routines it invokes?

Sigh, probably because it is a mess over there.

memory_hotplug.h and mmzone.h are included each other. Converted it directly to
a static inline triggers compilation errors because mmzone.h was included
somewhere else and found pfn_to_online_page() needs things like
pfn_valid_within() and online_section_nr() etc which are only defined later in
mmzone.h.

Move pfn_to_online_page() into mmzone.h triggers errors below.

In file included from ./arch/x86/include/asm/page.h:76,
                 from ./arch/x86/include/asm/thread_info.h:12,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/slab.h:15,
                 from ./include/linux/crypto.h:19,
                 from arch/x86/kernel/asm-offsets.c:9:
./include/linux/memory_hotplug.h: In function ‘pfn_to_online_page’:
./include/asm-generic/memory_model.h:54:29: error: ‘vmemmap’ undeclared (first
use in this function); did you mean ‘mem_map’?
 #define __pfn_to_page(pfn) (vmemmap + (pfn))
                             ^~~~~~~
./include/asm-generic/memory_model.h:82:21: note: in expansion of macro
‘__pfn_to_page’
 #define pfn_to_page __pfn_to_page
                     ^~~~~~~~~~~~~
./include/linux/memory_hotplug.h:30:10: note: in expansion of macro
‘pfn_to_page’
   return pfn_to_page(pfn);
          ^~~~~~~~~~~
./include/asm-generic/memory_model.h:54:29: note: each undeclared identifier is
reported only once for each function it appears in
 #define __pfn_to_page(pfn) (vmemmap + (pfn))
                             ^~~~~~~
./include/asm-generic/memory_model.h:82:21: note: in expansion of macro
‘__pfn_to_page’
 #define pfn_to_page __pfn_to_page
                     ^~~~~~~~~~~~~
./include/linux/memory_hotplug.h:30:10: note: in expansion of macro
‘pfn_to_page’
   return pfn_to_page(pfn);
          ^~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:112: arch/x86/kernel/asm-offsets.s] Error 1
