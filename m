Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AFBC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 00:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F83C21851
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 00:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUaaGZmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388931AbfGYAOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 20:14:09 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:35033 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388323AbfGYAOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 20:14:09 -0400
Received: by mail-ua1-f66.google.com with SMTP id j21so19175932uap.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 17:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=52yHeUkF4ZoRUNCDavzmri0iOxuTjNdnglq5NXLL3nU=;
        b=BUaaGZmNKhwq2CrAuC7Bb39IMc86nujEB7qq7ZOWMVBQLklmlxcJ6jvSy/fMASVAVv
         sXBIKMrnscLqC6C3EiLytJhiUDdFDo7zXlsq0N0yeQMYmEQzU7J9n2h27IhznlyLdXwb
         SOpTezPrnmFuTb+mUg0XEfG6ic7g/pOtzv+U2u/dQ+X+7qxsHQugU9NaVsUjofh/B18h
         YjmsqWZFzI7esxZs0YuDBVRHAdeXWZu0//zw4botCzla5XegQTtbp+VCKzLqkD7RDQt7
         qZWyNHRRYJzeXWRbH0FFumTWQWCBs6Zh7dz6m7M/Qz7+frOJyU7s9+osQPUX0/YY9CqN
         y90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=52yHeUkF4ZoRUNCDavzmri0iOxuTjNdnglq5NXLL3nU=;
        b=OJjStkxVlQQ9OOIKweJSRSYfNxyGiup6aFGvOy1eqPSDaeyvhgYhFcoLrmWl/4NydZ
         Wf3dCKYbTZQokgFnJSNgDSyjN3ZcNGl9X/P41Err3RdA4C7HYUqE4UHO1HpTUG6uiITR
         d6c5d6pTqWUefztS+Fm4dsDhtzdKTpTvi+vBCjlB1fWUZOJHbLWYcnUyylUZLlDYgDBE
         W6VOmABOw9pIh43W3CFeIUPmaGw3swBcL5NruWZta7EpsBZqrQM65j3W5oA+J59RIWde
         g4MWPeXSIN3Ug/9vOuxaepfcdJcy1WvH+ZtbADpLYOyvUu2r/00Bf20R5v/vTOsMQmMd
         /lGg==
X-Gm-Message-State: APjAAAUbV2qWeSuEQJWlNoHZIWVW5x8Rk2Jv2kzmLtUP+1HKsEllZa89
        VPpk6QgUvVLSbn5yOZyLftUQ78d5rFTrG4eT4dNag+jkGA==
X-Google-Smtp-Source: APXvYqy2OJk4ovKdOyzhEqz/h/rwaR4Vkqc/8TRWsHU3N+Jb7nXNeL8PHRZLkClsMi9o+adNPNO3BfVItg3l0Kn/rjo=
X-Received: by 2002:ab0:7491:: with SMTP id n17mr2934050uap.102.1564013647817;
 Wed, 24 Jul 2019 17:14:07 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbrS3dGrTrMMkGRkk=hRL38rrGiYTZ4REX9rJ0T+wcGoQ@mail.gmail.com>
 <alpine.DEB.2.21.1907241257240.1791@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1907241257240.1791@nanos.tec.linutronix.de>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 25 Jul 2019 01:13:56 +0100
Message-ID: <CALjTZvZtu8sSycu2soSXCEP1yZiVNFKkxs4JY_puFahwFuuRcQ@mail.gmail.com>
Subject: Re: [BUG] Linux 5.3-rc1: timer problem on x86-64 (Pentium D)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2019 at 12:02, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Rui,
>
> On Wed, 24 Jul 2019, Rui Salvaterra wrote:
> > I don't know if this has been reported before, but from a cursory
> > search it doesn't seem to be the case.
> > I have a x86-64 Pentium (4) D machine which always worked perfectly
> > with Linux 5.2 using the TSC as the clock source. With Linux 5.3-rc1 I
> > can't, for the life of me, boot it with anything other than
> > clocksource=3Djiffies, it completely hangs without even a backtrace.
>
> The obvious candidate for this is the following section:
>
> c8c4076723da ("x86/timer: Skip PIT initialization on modern chipsets")
> dde3626f815e ("x86/apic: Use non-atomic operations when possible")
> 748b170ca19a ("x86/apic: Make apic_bsp_setup() static")
> 2420a0b1798d ("x86/tsc: Set LAPIC timer period to crystal clock frequency=
")
> 52ae346bd26c ("x86/apic: Rename 'lapic_timer_frequency' to 'lapic_timer_p=
eriod'")
> 604dc9170f24 ("x86/tsc: Use CPUID.0x16 to calculate missing crystal frequ=
ency")

Hi again, everyone,

Looks like we have a winner. Actually, I did a full bisection between
5.2 and 5.3-rc1. Full log follows:

git bisect start
# good: [0ecfebd2b52404ae0c54a878c872bb93363ada36] Linux 5.2
git bisect good 0ecfebd2b52404ae0c54a878c872bb93363ada36
# bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1
git bisect bad 5f9e832c137075045d15cd6899ab0505cfb2ca4b
# bad: [e786741ff1b52769b044b7f4407f39cd13ee5d2d] Merge tag
'staging-5.3-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad e786741ff1b52769b044b7f4407f39cd13ee5d2d
# bad: [8f6ccf6159aed1f04c6d179f61f6fb2691261e84] Merge tag
'clone3-v5.3' of
git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
git bisect bad 8f6ccf6159aed1f04c6d179f61f6fb2691261e84
# bad: [ed63b9c873601ca113da5c7b1745e3946493e9f3] Merge tag
'media/v5.3-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect bad ed63b9c873601ca113da5c7b1745e3946493e9f3
# bad: [4d2fa8b44b891f0da5ceda3e5a1402ccf0ab6f26] Merge branch 'linus'
of git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6
git bisect bad 4d2fa8b44b891f0da5ceda3e5a1402ccf0ab6f26
# bad: [46f1ec23a46940846f86a91c46f7119d8a8b5de1] Merge branch
'core-rcu-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 46f1ec23a46940846f86a91c46f7119d8a8b5de1
# good: [2a1ccd31420a7b1acd6ca37b2bec2d723aa093e4] Merge branch
'irq-core-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good 2a1ccd31420a7b1acd6ca37b2bec2d723aa093e4
# good: [ab2486a9ee3243c8342549f58a13cdfa9abb497a] Merge branch
'x86-fpu-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect good ab2486a9ee3243c8342549f58a13cdfa9abb497a
# bad: [2f0f6503e37551eb8d8d5e4d27c78d28a30fed5a] Merge branch
'x86-timers-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
git bisect bad 2f0f6503e37551eb8d8d5e4d27c78d28a30fed5a
# good: [fd329f276ecaad7a371d6f91b9bbea031d0c3440] x86/mtrr: Skip
cache flushes on CPUs with cache self-snooping
git bisect good fd329f276ecaad7a371d6f91b9bbea031d0c3440
# bad: [e37f0881e9d9ec8b12f242cc2b78d93259aa7f0f] x86/hpet: Introduce
struct hpet_base and struct hpet_channel
git bisect bad e37f0881e9d9ec8b12f242cc2b78d93259aa7f0f
# good: [8c273f2c81f0756f65b24771196c0eff7ac90e7b] x86/hpet: Move
static and global variables to one place
git bisect good 8c273f2c81f0756f65b24771196c0eff7ac90e7b
# bad: [3535aa12f7f26fc755514b13aee8fac15741267e] x86/hpet:
Decapitalize and rename EVT_TO_HPET_DEV
git bisect bad 3535aa12f7f26fc755514b13aee8fac15741267e
# bad: [3222daf970f30133cc4c639cbecdc29c4ae91b2b] x86/hpet: Separate
counter check out of clocksource register code
git bisect bad 3222daf970f30133cc4c639cbecdc29c4ae91b2b
# good: [6bdec41a0cbcbda35c9044915fc8f45503a595a0] x86/hpet: Shuffle
code around for readability sake
git bisect good 6bdec41a0cbcbda35c9044915fc8f45503a595a0
# first bad commit: [3222daf970f30133cc4c639cbecdc29c4ae91b2b]
x86/hpet: Separate counter check out of clocksource register code

I haven't tried reverting this commit and recompiling (it's already
past 1:00 here, need to sleep), but I'll try it tomorrow, if required.
Note that on this machine (i945G) the HPET is disabled at boot and is
forcefully enabled by the kernel=E2=80=A6

[    0.147527] pci 0000:00:1f.0: Force enabled HPET at 0xfed00000

=E2=80=A6 and the commit message reads=E2=80=A6

"The init code checks whether the HPET counter works late in the init
function when the clocksource is registered. That should happen right
with the other sanity checks."

=E2=80=A6 maybe now the check is happening a bit too early=E2=80=A6?

Thanks,
Rui
