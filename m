Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDEAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9482146F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="p5OFWqj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbfC0OK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:10:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39707 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfC0OKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:10:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id t124so208860wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjAPIoM35iEoblHbjRgWliMF0RRAsRtMAenOonc8eiQ=;
        b=p5OFWqj22LSYm0Sw0eE1RwJ9BJM8I1K3UwB0SPs/oHVP9BzKsb9c6C7B8s9VtySQYz
         03IuoqqHsN/3q9GtXvpxoEtZ+OT9L9oSGOZ2Q6IvV9dpq6kgWR1dTSy2Jd881YZ9AeYv
         LEDPvK8LD02xgZIs/pJuo0X/jUCt2/zCdKfPTqcDAKSNH0jBI3aLDqc3eFh2taDpwQqg
         kZAAaboHn2lGIheg32OcZxISjIaviIcmKujzZ5jqOwQNt9lVtSWPaWwCnhr+iqyIRUz3
         hWcgwsG74Kx504ps2nvWQ7tpsHHzL7+0eXXOaxd4fm9ESTVI8YsFMQI9kCbR7L8Zj/N5
         b4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjAPIoM35iEoblHbjRgWliMF0RRAsRtMAenOonc8eiQ=;
        b=B9cymj6gRXnv16rS2Re1SP37welqvgRs/3JBRUSroOT5TkVLDhrAHtqo4SWn4pHYMQ
         lC5zbqUqUluTOWMmdAzqEZfLwLod76B9mUPTbhLMAUK4HUQ6oCBOnm72znaGorNWlR6F
         hE4GL0YxJQCZ8lZrUcYl7H9j2PC9VkQx9uMLIBpE+JunqmijBfB/z9rDNKBhMneGkM52
         VeWXz0tglC91V/xyO56DYBM8Z8mn01l5vWVtQWBPuMxlr3IqbZRPGg6wVFdEevey0pLF
         JwCLHA9MCHu6x/PXkKSL73OmcAfa/lHBzlRksCyMtCH8R+jq8e5uWiKDAA2k3TN6LxtK
         PDvw==
X-Gm-Message-State: APjAAAXllMhCGebDIr08H34ftc/2HqBh/ttHd+v5TdnqGoOG6aWMt+yt
        LCCvhitpXvy5FNgAdLJeByqcXFyUjA2rKt3+jF1cKA==
X-Google-Smtp-Source: APXvYqxru1ptwwJRUXtFsi7Ft9XaelKUJmVaUTdDKdeqN98Ll0cYbs2VvM9Ku5PZwXL7YNnapUzo2XdjGg9TXuBK4z4=
X-Received: by 2002:a1c:e185:: with SMTP id y127mr13388880wmg.76.1553695850667;
 Wed, 27 Mar 2019 07:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190327100201.32220-1-anup.patel@wdc.com> <7edf91f1-1df5-5513-d372-d84edd12edf3@garyguo.net>
 <CAAhSdy1+rc9ge02uqNvse5Z6XmDxsRH0G=5GnMsh+6m1LMLFYg@mail.gmail.com> <49628dc9-c56d-6b60-9520-e4eb0e3b3424@garyguo.net>
In-Reply-To: <49628dc9-c56d-6b60-9520-e4eb0e3b3424@garyguo.net>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 27 Mar 2019 19:40:39 +0530
Message-ID: <CAAhSdy1gUYZWZsaN7JESgKHv_GyMKq56_Fmg0dPspUaiBbSCtg@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Implement ASID allocator
To:     Gary Guo <gary@garyguo.net>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 7:08 PM Gary Guo <gary@garyguo.net> wrote:
>
> On 27/03/2019 11:42, Anup Patel wrote:
> > On Wed, Mar 27, 2019 at 4:57 PM Gary Guo <gary@garyguo.net> wrote:
> >>
> >> Hi Anup,
> >>
> >> This won't work in an actual hardware with ASID support. There're more
> >
> > Can you elaborate why >
> >
> > This implementation is based on Linux ARM64 ASID allocator which is
> > tested for large number of CPUs on real HW.
> >
> >> interactions with TLB flushes that need to be considered. You won't see
> >
> > Yap, already considered. Please point me to unhandled case.
> >
> When memory mapping is changed, you need to flush it from all cores that
> previously have that process executed, etc. Our patches both take
> inspiration from ARM's code, but the major difference between my code is
> handling of cache invalidations, see my code's cache_mask, etc. This is
> actually the most error-prone part, and I spent more time trying to find
> an optimal solution for this than porting the ASID allocator. The major
> difference is that ARM has a much more expressive sets of TLB flush
> instructions compared to RISC-V.

We should not require explicit cache maintenance anywhere in RISC-V
because caches are transparent to SW in RISC-V. The HW can use
"sfence.vma" hints for cache maintenance.

Further, (just like ARM world) the page table walks are cache coherent in
RISC-V so we should not require any cache flushes along with TLB flushes.

Now if you seeing inconsistent cache contents then it might due to some
bug in your HW. I am just guessing here.

Regarding changing memory mapping, I am sure generic Linux kernel will
issue appropriate flush_tlb_xyz() calls.

>  >
> >> this on both QEMU and SiFive board, as QEMU does not have ASID, so it
> >> pretends that ASID is supported by just flushing its TLB everytime you
> >
> > Nope, it does not. It detects whether ASID is supported or not. If supported
> > it will also figure-out number of ASID bits supported by HW.
> >
> Except that you can detect that QEMU supports ASID, but actually it does
> not. However QEMU is still correct because it always flush TLB when you
> set SATP/SPTBR. You won't be able to find out bugs in your code by just
> testing on QEMU.

I am not advocating that testing on QEMU is sufficient. Its just functionally
correct and works on HW without ASID support.

>
> > SiFive board does not have ASID bits so this implementation successfully
> > detects that number of ASID bits are 0 and fallbacks to original way of
> > local TLB flushes. >
> >> change sptbr. I suspect the performance gain you see is just due to
> >> saved TLB flush as TLB flush is super expensive in QEMU (all translation
> >> block jumps need to be cleared).
> >
> > Yes, performance gain is due to saved TLB flushes.
> >
> > On HW which supports ASID bits, we will see more performance
> > improvements. >
> A hardware TLB flush is cheaper than QEMU' TLB flush. As no hardware
> supports ASID at the moment the performance gain is minimal.
> >>
> >> I have my version here https://github.com/nbdd0121/linux/tree/asid. I
> >> haven't done code cleanups yet, but this version has correctness of its
> >> ASID code tested on our TLB simulator tool (which unfortunately I can't
> >> share right now as it involves with unpublished works).
> >
> > Except few minor differences. You version of ASID allocator is same as
> > mine. In fact there are lot of similar code framgements in your version
> > compared to Linux ARM64 as well. I am sure this patch will work for you.
> > >>
> >> In fact my submit my previous patch series exactly as the basis of this
> >> patch.
> >
> > This patch is based your patch series so I suggest you take this patch
> > and try it on your simulator.
> >
> I've tested, and it does not boot.

Thanks for the info. Now help me make this patch better.

Regards,
Anup
