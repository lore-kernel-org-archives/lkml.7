Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08D9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776252071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 16:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TjeOtaUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfKTQ4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:56:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39527 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbfKTQ4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 11:56:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id n26so110609edw.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7V6/i5BVfmb8deXGWmiOtNjPW4f2p7Dy5MQaRkpSzUc=;
        b=TjeOtaUMCAT3O+Fh0iRpN2TPEMUa33cOgei/T5x7g4OcpGJjUChpY0wRPE4R+QelB4
         TXtct2CbP4vYv8FOWHlpaHbCdBrrMED6Nk28EP46ZScz/N5Ay//XFrcQRiJaPkljzXg+
         e3kA7BOvZ8OPnp7geUY0zaL8NKH2OuuiEyCfMKcKZS5CE3fHcVQC8iNXamE7Q5Naj/ac
         FCFKrNRaHNySinKjv7YFBCM/B2dfQnMnpC5hLjfJ4IS/B/QdN/S6RH5c3GOUkCXp6qIW
         hZlyOZ+oFLtWWB2L2Whf58JV9e7MjtN0+JTXbc1lllAbd4fsQTBLyjXgjwKTadk4Jl90
         +oUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7V6/i5BVfmb8deXGWmiOtNjPW4f2p7Dy5MQaRkpSzUc=;
        b=F239Vz6XYj15S9O8yz66/G7at4csD7YXIzd6Hu/x8QmUimm4EbglE3gMk/IvMhUKZQ
         TFn4oloh/I3rJXCSODavV7ZxkEjymkkonPumF7Dheuybp5reMIsfMYaH9mnVI3Vahdh2
         P6H0i8VePOYrVXiuBEUN+RdwspnJC3RqBdbNucFJzwnxVUmeQGMawmTRfGnq0jjW5l5Q
         M7BGgqRC19Cipa7mqKpODGKZNFpVd/YiwLQL+27hTfSmyMiA11oGIGZeLYRLWVzgck8a
         qoYIhixUD75p+ysTlzlbtzz7c/TYneXPF4NXdUwaB4+A0Kq3fTXNE9k7deCAarCdUBzr
         1uQw==
X-Gm-Message-State: APjAAAVuLFn7PiDwKgqnhUe3mP2LXHl+MNf+VsemAnjqMd0pFlCPYSgw
        g5DkBI5u7fK83HKeV0jTIz8QQbpZFt4r6x8z25mpKA==
X-Google-Smtp-Source: APXvYqxFrcCtr+7FIBwRlOPWEu+UdTdnLUqzdqJ9mb4cutVRSNOGzSFpg4atZwXpcsdrHuvvgGtNeJ57et0ppWZLJLM=
X-Received: by 2002:a17:906:52d3:: with SMTP id w19mr6666497ejn.268.1574268961165;
 Wed, 20 Nov 2019 08:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20191119221006.1021520-1-pasha.tatashin@soleen.com> <20191120164307.GA19681@lakrids.cambridge.arm.com>
In-Reply-To: <20191120164307.GA19681@lakrids.cambridge.arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Nov 2019 11:55:50 -0500
Message-ID: <CA+CK2bAkb7zg6ne=PzA7UrQF49J2Sa7rmyWM3Bqugfe00-36ng@mail.gmail.com>
Subject: Re: [PATCH] arm64: kernel: memory corruptions due non-disabled PAN
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        steve.capper@arm.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        allison@lohutok.net, info@metux.net, alexios.zavras@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 11:43 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Pavel,
>
> On Tue, Nov 19, 2019 at 05:10:06PM -0500, Pavel Tatashin wrote:
> > Userland access functions (__arch_clear_user, __arch_copy_from_user,
> > __arch_copy_in_user, __arch_copy_to_user), enable and disable PAN
> > for the duration of copy. However, when copy fails for some reason,
> > i.e. access violation the code is transferred to fixedup section,
> > where we do not disable PAN.
>
> Thanks for reporting this. This is a very nasty bug.

Indeed, it was biting us randomly, and it took me awhile to understand
the root cause.

>
> > The bug is a security violation as the access to userland is still
> > open when it should be disabled, but it also causes memory corruptions
> > when software emulated PAN is used: CONFIG_ARM64_SW_TTBR0_PAN=y.
>
> I see that with CONFIG_ARM64_SW_TTBR0_PAN=y, this means that we may
> leave the stale TTBR0 value installed across a context-switch (and have
> reproduced that locally), but I'm having some difficulty reproducing the
> corruption that you see.

I will send the full test shortly. Note, I was never able to reproduce
it in QEMU, only on real hardware. Also, for some unknown reason after
kexec I could not reproduce it only during first boot, so it is
somewhat fragile, but I am sure it can be reproduced in other cases as
well, it is just my reproducer is not tunes for that.

>
> > I was able to reproduce memory corruption problem on Broadcom's SoC
> > ARMv8-A like this:
> >
> > Enable software perf-events with PERF_SAMPLE_CALLCHAIN so userland's
> > stack is accessed and copied.
>
> IIUC this tickles the issue by performing a faulting uaccess in IRQ
> context. On the path to returnign from the exception, it directly calls
> into the scheduler as part of el1_preempt, erroneously passing the TTBR0
> value to the next task. Note that a preemption would remove the stale
> TTBR0 value as part of kernel entry.

Correct.

>
> It looks like if we're in this state, and return from an exception taken
> from EL1 with SW PAN enabled, we'll also leave the stale TTBR0 value
> installed. If PAN was disabled (e.g. in the middle of a uaccess region),
> then we'll restore the correct TTBR0.
>
> > The test program performed the following on every CPU and forking many
> > processes:
> >
> >       unsigned long *map = mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
> >                                 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> >       map[0] = getpid();
> >       sched_yield();
> >       if (map[0] != getpid()) {
> >               fprintf(stderr, "Corruption detected!");
> >       }
> >       munmap(map, PAGE_SIZE);
>
> Can you provide the whole test, please? And precisely how you're
> launching it?

I will shortly.

>
> I've tried turning the above into a main() function, and spawning a
> number of instances in parallel while perf is running, but I haven't
> been able to reproduce the issue locally, and I'm concerned that I'm
> missing something.
>
> > From time to time I was getting map[0] to contain pid for a different
> > process.
>
> How often is "from time to time"? How many processes are you running,
> across how many CPUs?

Less than a second on 8 CPU SoC it takes for a process to get access
to address space of another process.

>
> >
> > Fixes: 338d4f49d6f7114 ("arm64: kernel: Add support for Privileged...")
> >
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> > ---
> >  arch/arm64/lib/clear_user.S     | 1 +
> >  arch/arm64/lib/copy_from_user.S | 1 +
> >  arch/arm64/lib/copy_in_user.S   | 1 +
> >  arch/arm64/lib/copy_to_user.S   | 1 +
> >  4 files changed, 4 insertions(+)
>
> FWIW, the diff below looks correct to me, but we might want to fold this
> into the C wrappers, so that this is consistent with the other uaccess
> cases (and done in one place in the code).

I agree, and I actually have a patch for that, but I wanted my fix to
be included into 5.4 if possible. This is why I sent it out. I will
send out a C wrapper patch soon, but that one won't need to be
backported to stable.

Pasha
