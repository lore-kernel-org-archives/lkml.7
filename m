Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E268C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552DB20870
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="li5wluUZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfK0W2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:28:51 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36262 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbfK0W2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:28:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id j7so21579421oib.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 14:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeXZ4luqCFNOPNM7E+9i6XZwG6Bi3IeNYp/i0vjoN04=;
        b=li5wluUZUo67xUOUjkpEHsTybwfeR0mZ8+iHAG7b0JlFSUrdCdOhEYUH3EeWmEwYov
         UNZ+SoidmuEwIfkCvtnTAfktOKGxHJu6bNIjPsFHg/OPD5rymcqC+6iimYnawpLMI0EB
         hKvZXNbaTgMRX4KyhMg0i02RWhjuX/GgAdFLuSB5a6RT3kXjImhXXWhdBWr9djo953Y4
         tCwnAlGhSdbnbLdwZ7V0aG7XrShPVoFCtxqtndzOPMABP14hK4hbQkDziDtAhIrdPLcZ
         +uLgx04uFM5YzR3c4C0wEhXhGXigfx+ruLxivWVq53+eHHMVgKUjSYZHE+BXGy6WtXR8
         XROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeXZ4luqCFNOPNM7E+9i6XZwG6Bi3IeNYp/i0vjoN04=;
        b=EV20GCLhiFd+lmWqu5lf3FLuh9S9eQkwn26806PFP61Cm4W+7AJbwZLSkEHWv4dc3U
         8FhPAIadTpWRYHi8g+yS01YTf4hiGfVod4LtXB0YZZZfJiFirJ/v9R3y01R33kG6+wUz
         3Yf+BhPAq8BBpvijGzvRbdPwB8cbVoDlVk56iMXdhV8Pe1A/nHZRRJPCYQJCyRVC0NNJ
         C0Lm81O2SiCUw9hgS0K8XrbLqIS7/UPgocNhI34vEoTJi9O3DzS482cGWrGVdbtOSeyf
         drzEAuhPw/JL4CEG8FcNYE7EeMw0felGJxHY1VcZ8trxjSoxECXkM9PbBkx5nrQhb4so
         3ntg==
X-Gm-Message-State: APjAAAWRXD93KcnsBV08kIiVmla4RPsJkZlnsbfRH+l+bKxcZ/QqMdy4
        /OgBcJM3YzvZwP/jUWOT3dAQrvtzlfsHBw0QsBGbzQ==
X-Google-Smtp-Source: APXvYqyQP4RAxV2mUJJ+XJJ2Rf9/9eFYVgtXHs6Npz3WK7Xm9giK0qIq0VGPNm4luJs0itKnN96rmtXRxQY5Kl0F6rs=
X-Received: by 2002:aca:ccd1:: with SMTP id c200mr6180503oig.157.1574893728992;
 Wed, 27 Nov 2019 14:28:48 -0800 (PST)
MIME-Version: 1.0
References: <20191120170208.211997-1-jannh@google.com> <20191120170208.211997-2-jannh@google.com>
 <20191120202516.GD32572@linux.intel.com>
In-Reply-To: <20191120202516.GD32572@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 27 Nov 2019 23:28:22 +0100
Message-ID: <CAG48ez0D2Neddh5WTX-agdpS=Xyf3XWXFB=DebxxV9nAVY43Gg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] x86/traps: Print non-canonical address on #GP
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 9:25 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
> On Wed, Nov 20, 2019 at 06:02:06PM +0100, Jann Horn wrote:
> > @@ -509,11 +511,50 @@ dotraplinkage void do_bounds(struct pt_regs *regs, long error_code)
> >       do_trap(X86_TRAP_BR, SIGSEGV, "bounds", regs, error_code, 0, NULL);
> >  }
> >
> > +/*
> > + * On 64-bit, if an uncaught #GP occurs while dereferencing a non-canonical
> > + * address, return that address.
>
> Stale comment now that it's decoding canonical addresses too.

Right, reworded.

> > + */
> > +static bool get_kernel_gp_address(struct pt_regs *regs, unsigned long *addr,
> > +                                        bool *non_canonical)
>
> Alignment of non_canonical is funky.

Fixed the indentation.

> > +{
> > +#ifdef CONFIG_X86_64
> > +     u8 insn_buf[MAX_INSN_SIZE];
> > +     struct insn insn;
> > +
> > +     if (probe_kernel_read(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
> > +             return false;
> > +
> > +     kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
> > +     insn_get_modrm(&insn);
> > +     insn_get_sib(&insn);
> > +     *addr = (unsigned long)insn_get_addr_ref(&insn, regs);
> > +
> > +     if (*addr == (unsigned long)-1L)
>
> Nit, wouldn't -1UL avoid the need to cast?

Ooh. I incorrectly assumed that a minus sign would be part of the
number literal and wouldn't be allowed for unsigned types, and didn't
realize that -1UL is just -(1UL)... thanks, will adjust.

> > +             return false;
> > +
> > +     /*
> > +      * Check that:
> > +      *  - the address is not in the kernel half or -1 (which means the
> > +      *    decoder failed to decode it)
> > +      *  - the last byte of the address is not in the user canonical half
> > +      */
>
> This -1 part of the comment should be moved above, or probably dropped
> entirely.

Yeah... I remember changing that as well as the comment above, I think
I lost the overview and accidentally went back to an earlier version
of the commit at some point... adjusted, thanks.

> > +     *non_canonical = *addr < ~__VIRTUAL_MASK &&
> > +                      *addr + insn.opnd_bytes - 1 > __VIRTUAL_MASK;
> > +
[...]
> > +             if (addr_resolved)
> > +                     snprintf(desc, sizeof(desc),
> > +                         GPFSTR " probably for %saddress 0x%lx",
> > +                         non_canonical ? "non-canonical " : "", gp_addr);
>
> I still think not explicitly calling out the straddle case will be
> confusing, e.g.
>
>   general protection fault probably for non-canonical address 0x7fffffffffff: 0000 [#1] SMP
>
> versus
>
>   general protection fault, non-canonical access 0x7fffffffffff - 0x800000000006: 0000 [#1] SMP
>
>
> And for the canonical case, "probably for address" may not be all that
> accurate, e.g. #GP(0) due to a instruction specific requirement is arguably
> just as likely to apply to the instruction itself as it is to its memory
> operand.

Okay, I'll bump up the level of hedging for canonical addresses to "maybe".

> Rather than pass around multiple booleans, what about adding an enum and
> handling everything in (a renamed) get_kernel_gp_address?  This works
> especially well if address decoding is done for 32-bit as well as 64-bit,
> which is probably worth doing since we're printing the address in 64-bit
> even if it's canonical.  The ifdeffery is really ugly if its 64-bit only...

The part about 32-bit makes sense to me; I've limited the
CONFIG_X86_64 ifdeffery to the computation of *non_canonical.

> enum kernel_gp_hint {
>         GP_NO_HINT,
>         GP_SEGMENT,
>         GP_NON_CANONICAL,
>         GP_STRADDLE_CANONICAL,
>         GP_RESOLVED_ADDR,
> };

I don't really like plumbing the error code down to the helper just so
that it can return an enum value to us based on that; but I guess the
rest of it does make the code a bit more pretty, will adjust.

> I get that adding a print just for the straddle case is probably overkill,
> but it seems silly to add all this and not make it as precise as possible.
>
>   general protection fault, non-canonical address 0xdead000000000000: 0000 [#1] SMP
>   general protection fault, non-canonical access 0x7fffffffffff - 0x800000000006: 0000 [#1] SMP
>   general protection fault, possibly for address 0xffffc9000021bd90: 0000 [#1] SMP
>   general protection fault, possibly for address 0xebcbde5c: 0000 [#1] SMP  // 32-bit kernel
>
>
> Side topic, opnd_bytes isn't correct for instructions with fixed 64-bit
> operands (Mq notation in the opcode map), which is probably an argument
> against the fancy straddle logic...

And there also is nothing in the instruction decoder that could ever
set opnd_bytes to 1, AFAICS. So while I think that the inaccuracies
there don't really matter for the coarse "is it noncanonical #GP?"
distinction right now - especially considering that userland isn't
allowed to allocate the last canonical virtual page on X86-64 -, it
definitely isn't accurate enough to explicitly print the access size
or end address.
