Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B3F2080A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="l8XwoOhr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393202AbfFMQ7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:59:52 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41553 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729799AbfFMAHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 20:07:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id g7so9878537oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 17:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tkriq+76AVHAvWoxrGme0DZvQ0r/bAVgHuOCgkIGtnY=;
        b=l8XwoOhrF8eV64+8QPkXsyAB77xTxH5+1FeNQoAuo2IunkQvtG1vuCWbxf61GiESpY
         fQIRFrAiJkW+IrDOfUaKnJbZt9tIC32l6Xy4ybZd5y3ZF5SAN9+oleOeFWzdpXuE5tAV
         RC4eULNdvWPH93o14WsX9bo0OmW/YIpmbKuQu5yM5Yf06EOJ8i9vnZaZodDO+7FagV71
         Vn5z9fSnD8ksqLo4LFbc1Dao5jxA7SYmjVUULSHTYmYSmk2sRZLdxHWS6v14AiSxFZzW
         tg1S2yelMDIEm5tB1fuWa71m73rK7k/ukBJ9OjAtcguxhkgnJ/jKbGZv9vMCqeRRtAHT
         0UtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tkriq+76AVHAvWoxrGme0DZvQ0r/bAVgHuOCgkIGtnY=;
        b=sx2OeFHf1ZmgdpXxvqILAwHTgmJVW5xdXSUlFmbCXeYQxkH31CjkjD+SldH3sBcUbj
         6NMr2+7EEXY7lHNrTzzccFfuFWVG31xHom/cVWPEK3bfNoSImV+t/onDqBu8ROMfd6hU
         2c3CWq8jz17AAKGf3Qn+yuA/M1kXRCwX4hJSdq38+WjWI57uPhjjdu0I5U/mfRryJqAG
         ShuVNnLvbYSQCRhOtIz+qvvtRSittFzod6QICdGUHcEI98AoKHhleaxKvbm/X2VZbobw
         kyGeVc2MpgQaOB+mZVmcKERKElDxQ2mIhLY5hRYRBQlLh86qVf9Y4n6pMf1GURHUkvbw
         dLsQ==
X-Gm-Message-State: APjAAAUETOc+CibhMVaj/3mqurbd/3YwjA7rQdSx0x+Xiq+PXRJz9Btr
        2q1xOzLNBzgKLIo0nHm650Ezhmt/EJZV0Oyr7yyvYA==
X-Google-Smtp-Source: APXvYqw2VZtovLNG6JskbLITjxABP/AQIL/VRraLlLfxmhWXh1G3n3MX02RIzNA0cPbyuLQPJ9zagbpHOtrvb+hDjn0=
X-Received: by 2002:aca:ec82:: with SMTP id k124mr1180994oih.73.1560384429638;
 Wed, 12 Jun 2019 17:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <1560366952-10660-1-git-send-email-cai@lca.pw> <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
 <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com> <1560376072.5154.6.camel@lca.pw>
In-Reply-To: <1560376072.5154.6.camel@lca.pw>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Jun 2019 17:06:57 -0700
Message-ID: <CAPcyv4hevCNgajrw7STXH4N5_heEOBz_-SzxcSB83DKDNacP9Q@mail.gmail.com>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from pfn_to_online_page()
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 2:47 PM Qian Cai <cai@lca.pw> wrote:
>
> On Wed, 2019-06-12 at 12:38 -0700, Dan Williams wrote:
> > On Wed, Jun 12, 2019 at 12:37 PM Dan Williams <dan.j.williams@intel.com>
> > wrote:
> > >
> > > On Wed, Jun 12, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
> > > >
> > > > The linux-next commit "mm/sparsemem: Add helpers track active portions
> > > > of a section at boot" [1] causes a crash below when the first kmemleak
> > > > scan kthread kicks in. This is because kmemleak_scan() calls
> > > > pfn_to_online_page(() which calls pfn_valid_within() instead of
> > > > pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=n.
> > > >
> > > > The commit [1] did add an additional check of pfn_section_valid() in
> > > > pfn_valid(), but forgot to add it in the above code path.
> > > >
> > > > page:ffffea0002748000 is uninitialized and poisoned
> > > > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > > > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > > > page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> > > > ------------[ cut here ]------------
> > > > kernel BUG at include/linux/mm.h:1084!
> > > > invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> > > > CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ #6
> > > > Hardware name: Lenovo ThinkSystem SR530 -[7X07RCZ000]-/-[7X07RCZ000]-,
> > > > BIOS -[TEE113T-1.00]- 07/07/2017
> > > > RIP: 0010:kmemleak_scan+0x6df/0xad0
> > > > Call Trace:
> > > >  kmemleak_scan_thread+0x9f/0xc7
> > > >  kthread+0x1d2/0x1f0
> > > >  ret_from_fork+0x35/0x4
> > > >
> > > > [1] https://patchwork.kernel.org/patch/10977957/
> > > >
> > > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > > ---
> > > >  include/linux/memory_hotplug.h | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/include/linux/memory_hotplug.h
> > > > b/include/linux/memory_hotplug.h
> > > > index 0b8a5e5ef2da..f02be86077e3 100644
> > > > --- a/include/linux/memory_hotplug.h
> > > > +++ b/include/linux/memory_hotplug.h
> > > > @@ -28,6 +28,7 @@
> > > >         unsigned long ___nr = pfn_to_section_nr(___pfn);           \
> > > >                                                                    \
> > > >         if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> > > > +           pfn_section_valid(__nr_to_section(___nr), pfn) &&      \
> > > >             pfn_valid_within(___pfn))                              \
> > > >                 ___page = pfn_to_page(___pfn);                     \
> > > >         ___page;                                                   \
> > >
> > > Looks ok to me:
> > >
> > > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > >
> > > ...but why is pfn_to_online_page() a multi-line macro instead of a
> > > static inline like all the helper routines it invokes?
> >
> > I do need to send out a refreshed version of the sub-section patchset,
> > so I'll fold this in and give you a Reported-by credit.
>
> BTW, not sure if your new version will fix those two problem below due to the
> same commit.
>
> https://patchwork.kernel.org/patch/10977957/
>
> 1) offline is busted [1]. It looks like test_pages_in_a_zone() missed the same
> pfn_section_valid() check.

All online memory is to be onlined as a complete section, so I think
the issue is more related to vmemmap_populated() not establishing the
mem_map for all pages in a section.

I take back my suggestions about pfn_valid_within() that operation
should always be scoped to a section when validating online memory.

>
> 2) powerpc booting is generating endless warnings [2]. In vmemmap_populated() at
> arch/powerpc/mm/init_64.c, I tried to change PAGES_PER_SECTION to
> PAGES_PER_SUBSECTION, but it alone seems not enough.

On PowerPC PAGES_PER_SECTION == PAGES_PER_SUBSECTION because the
PowerPC section size was already small. Instead I think the issue is
that PowerPC is partially populating sections, but still expecting
pfn_valid() to succeed. I.e. prior to the subsection patches
pfn_valid() would still work for those holes, but now that it is more
precise it is failing.
