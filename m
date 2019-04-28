Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D5C4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B07206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 14:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfD1O2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 10:28:02 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:48145 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726659AbfD1O2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 10:28:01 -0400
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 381E61C0005;
        Sun, 28 Apr 2019 14:27:53 +0000 (UTC)
Subject: Re: [PATCH v3 04/11] arm64, mm: Move generic mmap layout functions to
 mm
To:     Kees Cook <keescook@chromium.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-riscv@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>
References: <20190417052247.17809-1-alex@ghiti.fr>
 <20190417052247.17809-5-alex@ghiti.fr>
 <CAGXu5j+NV7nfQ044kvsqqSrWpuXH5J6aZEbvg7YpxyBFjdAHyw@mail.gmail.com>
 <fd2b02b3-5872-ccf6-9f52-53f692fba02d@ghiti.fr>
 <CAGXu5j+NkQ+nwRShuKeHMwuy6++3x0QMS9djE=wUzUUtAkVf3g@mail.gmail.com>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <cf4073ed-098f-779e-32e1-f3273622b115@ghiti.fr>
Date:   Sun, 28 Apr 2019 10:27:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+NkQ+nwRShuKeHMwuy6++3x0QMS9djE=wUzUUtAkVf3g@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: sv-FI
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/19 10:19 AM, Kees Cook wrote:
> On Thu, Apr 18, 2019 at 12:55 AM Alex Ghiti <alex@ghiti.fr> wrote:
>> Regarding the help text, I agree that it does not seem to be frequent to
>> place
>> comment above config like that, I'll let Christoph and you decide what's
>> best. And I'll
>> add the possibility for the arch to define its own STACK_RND_MASK.
> Yeah, I think it's very helpful to spell out the requirements for new
> architectures with these kinds of features in the help text (see
> SECCOMP_FILTER for example).
>
>>> I think CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT should select
>>> CONFIG_ARCH_HAS_ELF_RANDOMIZE. It would mean moving
>>
>> I don't think we should link those 2 features together: an architecture
>> may want
>> topdown mmap and don't care about randomization right ?
> Given that the mmap randomization and stack randomization are already
> coming along for the ride, it seems weird to make brk randomization an
> optional feature (especially since all the of the architectures you're
> converting include it). I'd also like these kinds of security features
> to be available by default. So, I think one patch to adjust the MIPS
> brk randomization entropy and then you can just include it in this
> move.
>
>> Actually, I had to add those ifdefs for mmap_rnd_compat_bits, not
>> is_compat_task.
> Oh! In that case, use CONFIG_HAVE_ARCH_MMAP_RND_BITS. :) Actually,
> what would be maybe cleaner would be to add mmap_rnd_bits_min/max
> consts set to 0 for the non-CONFIG_HAVE_ARCH_MMAP_RND_BITS case at the
> top of mm/mmap.c.
>
> I really like this clean-up! I think we can move x86 to it too without
> too much pain. :)
>
Hi,

Just a short note to indicate that while working on v4, I realized this 
series had a some issues:

- I broke the case ARCH_HAS_ELF_RANDOMIZE selected but not
   ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT (which can happen on arm 
without MMU for example)
- I use mmap_rnd_bits unconditionnally whereas it might not be defined 
(it works for all arches I moved though)

The only clean solution I found for the first problem is to propose a 
common implementation for arch_randomize_brk
and arch_mmap_rnd, which is another series on its own and another good 
cleanup since every architecture uses
the same functions (except ppc, but that can be workarounded easily).
Just like moving x86 deserves its own series since it adds up 8/9 commits.
I am on vacations for 2 weeks, so I won't have time to submit another 
patchset before, sorry about that.

Thanks,

Alex

