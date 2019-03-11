Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B16C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FCC21872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552318780;
	bh=PIh2RqSE6xm2uW/oO7DHOcc52neJDPZgog/RRatZEY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BOlFQ62MZfhJR4Wjunt9vMXbKEm77gX2hjLl38QMuBIH3hWBylW7QmMUIbisBDaJB
	 mSsiFo0x0G1ISz/zsFps9ZG8hiGnJYd3APAKB46h3R/qDfpyE8x1dz4Mifz2qfeYe8
	 Zt2oNrr30thEcd8Fq1IlCqAr+HM3wWzoyf+cOha8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfCKPjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:39:39 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39616 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKPjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:39:39 -0400
Received: by mail-lj1-f193.google.com with SMTP id g80so4489416ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bDkuJtxD0NMnHUhhT8vuTYdKs1FgcVsbN9MTv7cPTMI=;
        b=H7reVy24SQkeZI/Q/3zebUzrBrGMH3l3xrh4IT2/gL19IlPsi7/9Q5Tu2zxLL52tZX
         HFHdsWfOz7VAGHcJrUWR0Y00hmjAVuOaB1+4xaRsuSFEpg0ws9zfIcqHax3fJ9Ej+W51
         6Yz9dv/n/9U8qtf25k0T8auwfnxJlgiD0T9U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bDkuJtxD0NMnHUhhT8vuTYdKs1FgcVsbN9MTv7cPTMI=;
        b=kQlyqF4J/kXpAbezJs3/dpPt/nVQxuXcw2YbbjIQJXE/FwoUmlxXYZun6dIMdMrkfy
         5QPpuKFW70qc5g4ylTNr8pYH0p/D4jKKR9Z4BL5T7Wn8ZpFi/5Cw8KDtRSTY4e5aOwHZ
         HlabkxV4uRERHwH9cipFdExykz4aGAug7UBVFynP8lkv/O4jiKXvZgDAvZADPlyo5o19
         sAecIUyyEeNmgx136vhrFKKqWCF3gDM/jtgmEu9cMNvk/RFk7clOg84AYm/593gVhZi2
         wBDNq4PCjWjyq3auZAOJ/NxwCnIjMQSo91ABdtsIk0dx2DwVDrqF/Ey550jwcUNMLtDC
         AQ6A==
X-Gm-Message-State: APjAAAUi36ZttOwn/v5y4c5Y4wBs3Qr7XxdEljIRnvWExBsYhV1aHEdl
        vMyZC+T0kQDnr6V0COexfkGQSZ9/u0Q=
X-Google-Smtp-Source: APXvYqwjUViO42MR6X2dumuND4VP8oKHNYGu0OSK85MryEM3olkg8RHXu++o4zEpuuSBdSqJoFjsGA==
X-Received: by 2002:a2e:2f04:: with SMTP id v4mr17092202ljv.129.1552318775769;
        Mon, 11 Mar 2019 08:39:35 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q9sm1148578lfk.40.2019.03.11.08.39.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 08:39:34 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id u68so3794126lff.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 08:39:34 -0700 (PDT)
X-Received: by 2002:ac2:4424:: with SMTP id w4mr4240665lfl.148.1552318773874;
 Mon, 11 Mar 2019 08:39:33 -0700 (PDT)
MIME-Version: 1.0
References: <155221755096.13878.3370977359110476046.tglx@nanos.tec.linutronix.de>
 <155221755097.13878.5173016541431155948.tglx@nanos.tec.linutronix.de>
 <CAHk-=wjNes0wn0KUMMY6dOK_sN69z2TiGpDZ2cyzYF07s64bXQ@mail.gmail.com> <alpine.DEB.2.21.1903111516190.1691@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1903111516190.1691@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Mar 2019 08:39:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUyG3+Zwb74LSOPGtTBvK9N6DG4f=Y5Yv9Xzcy-qY0Qw@mail.gmail.com>
Message-ID: <CAHk-=whUyG3+Zwb74LSOPGtTBvK9N6DG4f=Y5Yv9Xzcy-qY0Qw@mail.gmail.com>
Subject: Re: [GIT pull] x86/asm for 5.1
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 7:22 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> > So it basically "pins" the bits on CPU's before they are ready, so the
> > secondary CPU's maghically get the bits set _independently_ of running
> > the actual setup code to set them. That may *work*, but it sure looks
> > iffy.
>
> Which I looked at and it's a non issue. The SMAP/SMEP settings are globally
> the same

No, Thomas, they really aren't globally the same, and it causes
problems in that patch, and particularly in the actual "security" part
of it.

>  and the non-boot CPUs set the bits very early in the boot process.

They are set early in the boot process, but they are set separately
for each CPU, and not at the same time.

And that's important. It's important because when the *first* CPU sets
the "you now need to pin and check the SMAP bit", the _other_ CPU"s
have not set it yet.

Why is that a real and big deal?

It's a real and big deal because when the *other* CPU's get around to
booting and do _their_ thing, they don't have their per-cpu bits set
yet, so _as_ they are setting up, they will be doing that

        cr4_set_bits(X86_CR4_SMEP/SMAP/UMIP);

dance trying to set one bit at a time, and as they do that, they don't
yet have the pinned bits set.

So what does that result in?

It results in that insanity in the patch where it *first* does the

        val |= cr4_pin;

which is entirely insane for three important reasons:

 (a) doing that is what causes 99% of the pain with "oh, the compiler
will now have seen that 'val' already has the bits set, so the
compiler might optimize out the test afterwards, so we need to play
extra games".

 (b) doing that first is pointless from a ROP use angle, since an
attacker would use the address to after the operation, so now it's
confusing anybody who reads the code into maybe thinking that that
initial "or" has some security meaning

 (c) BUT it's actually *bad* for security, because doing that early
'or' means that you lose the warning about possible _real_ mistakes
where somebody hadn't set the bit or screwed up, because you're now
hiding it by setting the bits early,

See? It's a real downside. It causes the code to look odd, and
pointless, and in the process it actually causes *less* verification
coverage and attack warning because it will not warn about somebody
who ended up getting to that "set cr4" part with bits clear by other
tricks (for example, by corrupting the argument, or by just getting
the ROP address from the pvops table for 'set_cr4()').

So it literally makes the patch uglier and *weaker*.

Side note: my suggested version was not as strong as it should have
been either. The actual inline asm should still have the "+r" part to
make sure it actually tests the register value (AFTER the write!) that
it used, and that there's no reload or similar that the compiler did
that causes it to test another value than the one it actually wrote to
%cr3.

So the inline asm should probably be

        asm volatile("mov %0,%%cr4":"+r" (val):"memory");

to make it better to actually test 'val' after the write.

Anyway, I repeat: when a patch is trying to fix a really esoteric
security issue, and the *only* reason for a patch is for that actual
attack, then the fix in question should really be held to some much
higher standards than this patch was held to.

When the comments are actively garbage and don't match the code, when
the code doesn't actually do a good job of testing against the attack
despite _trying_ to and actively DOES NOT WARN if somebody got to
there by picking up the pointer to the function, then patch is simply
not a great patch.

Don't make excuses for a bad patch.

                Linus
