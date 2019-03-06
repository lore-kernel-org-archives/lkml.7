Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF64C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C652620675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfCFPHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:07:47 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39232 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728387AbfCFPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:07:42 -0500
Received: by mail-vs1-f66.google.com with SMTP id w14so2402668vso.6;
        Wed, 06 Mar 2019 07:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eqCR/x6MXiCoDlxqOwLKwWPD8DPLAZaFGR5oIkCNoPc=;
        b=P0ByNC5CvGRNosR2/cdNO8QwA51Hg1UQ0xwO63oEhJVbs8TZAENtE+qPEo6aAsgdSs
         IgxWGF2Z9pu0ABXGxec0H9JtL2lnkkxIuzZfWdUfBaVL4pRhmgAK6sLLEIwb2klq0pez
         WrcjU46LVQDiHmgpxsh91e5GDnplXLKNA5oYVeu+Smaz9DoKE33VKL321VcoxEUDoCJc
         1gtqMjJf+3kVjFpu5556JazHwc19afygRbtiLQwps/VNELRg+V7mZ3a0yuI5Kqr5MBcF
         VUdmk4hP+1zaP+66gR0USYnunULM9HKHgp6FZY/4Y7kpddtFkdXBMk3aXj6ctVIwnbvK
         x7oA==
X-Gm-Message-State: APjAAAWtiQExSSdpAaUIrk38NDZRrJ6ShylqB5Lpoyw230Lkq168oMVn
        vd1i3PrG9hEyYGWEyq4qbrCMEpE93jGKtFpgiNQ=
X-Google-Smtp-Source: APXvYqzNsUwZf3d0wd71Sb0obxg3M+dOU6vD/A3M+igaDX27MM/c+/JqvdFA/0n/GumrYpgVSuuWMmq/fqij2GoHyrA=
X-Received: by 2002:a67:fc9a:: with SMTP id x26mr4144877vsp.166.1551884861275;
 Wed, 06 Mar 2019 07:07:41 -0800 (PST)
MIME-Version: 1.0
References: <CAG48ez1RVd5mQ_Pb6eygQESaZhpQz765OAZYSoPE0kPqfZEXQg@mail.gmail.com>
 <20190305091904.GB8256@zn.tnic> <20190305122218.GD13380@bombadil.infradead.org>
 <20190305134347.4be2449c@alans-desktop> <20190305145717.GD8256@zn.tnic>
 <CAHk-=wi2E4kugAW7BQwNSVwYHOr=B_9EgzBRMpQ2+1dxAqydDg@mail.gmail.com>
 <20190305173134.GE8256@zn.tnic> <CAHk-=wg0bY=RFhD4NW9x++fC0bME=_-9xM3kexGGM3gefHQTyQ@mail.gmail.com>
 <20190305181138.GG8256@zn.tnic> <20190305181808.GH8256@zn.tnic>
In-Reply-To: <20190305181808.GH8256@zn.tnic>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Mar 2019 16:07:29 +0100
Message-ID: <CAMuHMdW+m0Q+j3rsQdMXnrEPm+XB5Y2AQrxW5sD1mZAKgmEqoA@mail.gmail.com>
Subject: Re: [PATCH] x86: Deprecate a.out support
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Tue, Mar 5, 2019 at 8:04 PM Borislav Petkov <bp@alien8.de> wrote:
> On Tue, Mar 05, 2019 at 07:11:38PM +0100, Borislav Petkov wrote:
> > I guess you could Cc arch maintainers with the a.out-core.h removal
> > patch to see if anyone screams.
>
> And they're like two for which we need confirmation:
>
> $ git ls-files | grep a.out-core.h
> arch/alpha/include/asm/a.out-core.h
> arch/m68k/include/asm/a.out-core.h
> arch/um/include/asm/a.out-core.h
> arch/x86/include/asm/a.out-core.h
>
> um and x86 are clear.
>
> Adding alpha and m68k MLs to Cc.

Thanks!

The oldest binaries I still have lying around (an ext2 ramdisk image,
still used from time to time) are ELF, from just after the a.out to ELF
transition on m68k.

I think it's safe to assume no one still runs a.out binaries on m68k.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
