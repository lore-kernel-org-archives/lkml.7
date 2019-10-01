Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B35C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38FE221855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389520AbfJAP2a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:28:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbfJAP2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:28:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 677061000;
        Tue,  1 Oct 2019 08:28:29 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C6A2E3F71A;
        Tue,  1 Oct 2019 08:28:28 -0700 (PDT)
Date:   Tue, 1 Oct 2019 16:28:27 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Will Deacon <will@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH] Partially revert "compiler: enable
 CONFIG_OPTIMIZE_INLINING forcibly"
Message-ID: <20191001152826.GM42880@e119886-lin.cambridge.arm.com>
References: <20190930114540.27498-1-will@kernel.org>
 <CAK7LNARWkQ-z02RYv3XQ69KkWdmEVaZge07qiYC8_kyMrFzCTg@mail.gmail.com>
 <20191001104253.fci7s3sn5ov3h56d@willie-the-truck>
 <20191001114129.GL42880@e119886-lin.cambridge.arm.com>
 <20191001143626.GI25745@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001143626.GI25745@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 03:36:26PM +0100, Russell King - ARM Linux admin wrote:
> On Tue, Oct 01, 2019 at 12:41:30PM +0100, Andrew Murray wrote:
> > On Tue, Oct 01, 2019 at 11:42:54AM +0100, Will Deacon wrote:
> > > On Tue, Oct 01, 2019 at 06:40:26PM +0900, Masahiro Yamada wrote:
> > > > On Mon, Sep 30, 2019 at 8:45 PM Will Deacon <will@kernel.org> wrote:
> > > > > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > > > > index 93d97f9b0157..c37c72adaeff 100644
> > > > > --- a/lib/Kconfig.debug
> > > > > +++ b/lib/Kconfig.debug
> > > > > @@ -312,6 +312,7 @@ config HEADERS_CHECK
> > > > >
> > > > >  config OPTIMIZE_INLINING
> > > > >         def_bool y
> > > > > +       depends on !(ARM || ARM64) # https://gcc.gnu.org/bugzilla/show_bug.cgi?id=91111
> > > > 
> > > > 
> > > > This is a too big hammer.
> > > 
> > > It matches the previous default behaviour!
> > > 
> > > > For ARM, it is not a compiler bug, so I am trying to fix the kernel code.
> > > > 
> > > > For ARM64, even if it is a compiler bug, you can add __always_inline
> > > > to the functions in question.
> > > > (arch_atomic64_dec_if_positive in this case).
> > > > 
> > > > You do not need to force __always_inline globally.
> > > 
> > > So you'd prefer I do something like the diff below? I mean, it's a start,
> > > but I do worry that we're hanging arch/arm/ out to dry.
> > 
> > If I've understood one part of this issue correctly - and using the
> > c2p_unsupported build failure as an example [1], there are instances in
> > the kernel where it is assumed that the compiler will optimise out a call
> > to an undefined function, and also assumed that the compiler will know
> > at compile time that the function will never get called. It's common to
> > satisfy this assumption when the calling function is inlined.
> > 
> > But I suspect there may be other cases similar to c2p_unsupported which
> > are still lurking.
> > 
> > For example the following functions are called but non-existent, and thus
> > may be an area worth investigating:
> > 
> > __buggy_use_of_MTHCA_PUT, __put_dbe_unknown, __cmpxchg_wrong_size,
> > __bad_percpu_size, __put_user_bad, __get_user_unknown,
> > __bad_unaligned_access_size, __bad_xchg
> > 
> > But more generally, as this is a common pattern - isn't there a benefit
> > here for changing all of these to BUILD_BUG? (So they can be found easily).
> 
> Precisely, what is your suggestion?
> 
> If you think that replacing the call to __get_user_bad with BUILD_BUG(),
> BUILD_BUG() becomes a no-op when __OPTIMIZE__ is not defined (see the
> definition of __compiletime_assert() in linux/compiler.h); this means
> such places will be reachable, which leads to uninitialised variables.

I hadn't noticed the use of __OPTIMIZE__ - indeed if __compiletime_assert
is no-op'd and you reach it then you won't have a build error - but you
may get uninitialised values instead.

Presumably the purpose of __OPTIMIZE__ in this case is to prevent getting
an undefined function error for the __compiletime_assert line, even though
it doesn't get called (when using a compiler that doesn't optimize out the
call to the unused function).

Why is the call to __get_user_bad not guarded in this way for when
__OPTIMIZE__ isn't set, i.e. why doesn't it suffer from the issue
that the following fixes?

c03567a8e8d5 ("include/linux/compiler.h: don't perform compiletime_assert with -O0")


> 
> > Or to avoid this class of issues, change them to BUG or unreachable - but
> > lose the benefit of compile time detection?
> 
> I think you ought to read the GCC manual wrt __builtin_unreachable().
> "If control flow reaches the point of the `__builtin_unreachable',
>  the program is undefined.  It is useful in situations where the
>  compiler cannot deduce the unreachability of the code."

Thanks, I've now read it. My suggestion arose from looking at existing
uses in the kernel - e.g. drivers/spi/spi-rockchip.c,
drivers/pinctrl/pinctrl-ingenic.c, etc. I guess these types of uses
should use BUG or similar instead right?

> 
> I have seen cases where the instructions following an unreachable
> code section have been the literal pool for the function - which,
> if reached, would be quite confusing to debug.  If you're lucky, you
> might get an undefined instruction exception.  If not, you could
> continue and start executing another part of the function, leading
> to possibly no crash at all - but unexpected results (which may end
> up leaking sensitive data.)
> 
> For example, in our BUG() implementation on 32-bit ARM, we use
> unreachable() after the asm() statement creating the bug table
> entry and inserting the undefined instruction into the text.
> Here's the resulting disassembly:
> 
>      278:       ebfffffe        bl      0 <page_mapped>
>                         278: R_ARM_CALL page_mapped
>      27c:       e3500000        cmp     r0, #0
>      280:       1a00006c        bne     438 <invalidate_inode_pages2_range+0x3ac>
> ...
>      2d4:       ebfffffe        bl      0 <_raw_spin_lock_irqsave>
>                         2d4: R_ARM_CALL _raw_spin_lock_irqsave
>      2d8:       e5943008        ldr     r3, [r4, #8]
>      2dc:       e3130001        tst     r3, #1
>      2e0:       e1a02000        mov     r2, r0
>      2e4:       1a000054        bne     43c <invalidate_inode_pages2_range+0x3b0>
> ...
>      438:       e7f001f2        .word   0xe7f001f2
>      43c:       e2433001        sub     r3, r3, #1
>      440:       eaffffa9        b       2ec <invalidate_inode_pages2_range+0x260>
> 
> Now, consider what unreachable() actually gets you here - it tells
> the compiler that we do not expect to reach this point (that being
> the point between 438 and 43c.)  If we were to reach that point, we
> would continue executing the code at 43c.
> 
> In this case, it would be like...
> 
> 	if (BUG_ON(page_mapped(page)))
> 	    goto random-location-in-xa_lock_irqsave()-inside-invalidate_complete_page2();
> 
> So no.  unreachable() is not an option.

Thanks for the example.

> 
> We really do want these places to be compile-time detected - relying
> on triggering them at runtime is just not good enough IMHO (think
> about how much testing the kernel would require to discover one of
> these suckers buried in the depths of the code.)
> 
> Here's the question to ask: do we want to reliably detect issues
> that we know are bad, which can lead to:
> - unreliable kernel operation,
> - user exploitable crashes,
> or do we want to hide them for the sake of allowing -O0 compilation?
> 
> Given that the kernel as a general rule has very poor run-time test
> coverage at the moment, I don't think this is the time to consider
> giving up the protection that we have against this badness.
> 
> We've had several instances where these checks have triggered in the
> user access code, and people have noticed when doing build tests.
> They probably don't have the ability to do run-time testing on every
> arch.
> 
> So, the existing facility of detecting these at build time is, IMHO,
> an absolute must.
> 
> It would be different if the kernel community as a whole had the
> ability to run-test every code path through the kernel source on
> every arch, but I don't see that's a remotely realistic prospect.

I completely agree.

> 
> If we want -O0 to work, but still want to preserve the ability to
> detect these adequately, I think the easiest solution to that would
> be to provide these dummy functions only when building with -O0,
> making them all BUG().

Though please note that this issue isn't limited to -O0, it relates to
building without CONFIG_OPTIMIZE_INLINING - resulting in functions
marked as inline not always being inlined.

I'm interested to determine if there is a benefit for all the functions
I mentioned (there are more) to have the same name which may be something
other than BUILD_BUG.

Thanks,

Andrew Murray

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
