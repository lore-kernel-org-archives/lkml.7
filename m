Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C1C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C480214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="prencWNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfLKL0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:26:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39285 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727469AbfLKL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:26:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so23597685wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 03:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AXTqM53euYhJDX4R+qhI2h5dF93uoBPLPxhADwzStNg=;
        b=prencWNALFk8vubbf2cYL0WZTuAMMC+KXeVtDHyFqN9T5OlfXSoh6sLZo8yDoaXqNZ
         mV9vHouVCvcLe+/ZkY4pcf5eKh17/KYeMxha/GktmjTlnJ8GYa8ef23wsdznsYmgvJBG
         umXDJOLaQd+e9AZhStaVCmeh+7eeuOY/psJRlTrasb8zL9wJjzg4uErg6duuBDQ62m9b
         XGZ2dGPrer6mwuPu2iaFySv1J4Qfx6xb8XN3zrYPufnihcLQr5a0jz2Ooe9Q6bXjWlsu
         Q+1vX4TE1l1PkAoy/XvuNiGjJT2wWPE20Sqg/556R+s1t051Mx40urpFHg7C47RkCVnC
         B4Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXTqM53euYhJDX4R+qhI2h5dF93uoBPLPxhADwzStNg=;
        b=E5n4C7/1QQwq246OnLY0QgNQu/wj5RGzmIrNjTMQfIYrEimUSQYCjOqkM7cdVegOLl
         c0vrnEDky6QhgiZ16uP8DkDnbFqwN0qjZFmLjMGvNK1BZwLXerxLmVOHeBz6ja1Nijbd
         hjfPnuir6xvNoNO8Et8cQCkH4VPQCSlgPXpak+QuyeYVgaTJePXSr3Myo/LbEZVupTxN
         9ZAx8rvfplTreJBBc3exbwlowdwKfcZSlBqMuq86LETODxGzYw3TITleSnnvbcUELvDj
         sN+cEm0mt+E0Jktmv5M3vlOmYBQqiR6BvwwZfy9TDEBuTQMzg+E+Vm0UlixjnjXVyOJv
         gQ/Q==
X-Gm-Message-State: APjAAAXVWCk6VAdPW/K179RKbKcSKFg50Fasnt4tcx+SnsWBEgqNbXu/
        AJi00/G/fjHRm4Q91iLgJvFK7glmM4ApOhCT0TC3BA==
X-Google-Smtp-Source: APXvYqy9lCF01YcgEoakbGjQlZfWivLtBTQnZ+zyfahZ2E64gukPanZuEMFnU6xJJK4dHQKa4sWwobDSdvF5F9v4JyU=
X-Received: by 2002:a5d:46c1:: with SMTP id g1mr3181360wrs.200.1576063579504;
 Wed, 11 Dec 2019 03:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20191206165542.31469-1-ardb@kernel.org> <20191206165542.31469-7-ardb@kernel.org>
 <20191209191242.GA3075464@rani.riverdale.lan> <CAKv+Gu8QWcSwRajsO5voTQJxDHy613ugCd_R6=SStf9ABrmtfQ@mail.gmail.com>
 <20191210200546.GA55356@rani.riverdale.lan>
In-Reply-To: <20191210200546.GA55356@rani.riverdale.lan>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 11 Dec 2019 11:26:17 +0000
Message-ID: <CAKv+Gu_VUAEw0auwhOyEAHn4BjDBPc9P4a+WBwJuRb_cBVi0NQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] efi/earlycon: Remap entire framebuffer after page initialization
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2019 at 21:05, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Mon, Dec 09, 2019 at 07:24:13PM +0000, Ard Biesheuvel wrote:
> > On Mon, 9 Dec 2019 at 20:12, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > On Fri, Dec 06, 2019 at 04:55:42PM +0000, Ard Biesheuvel wrote:
> > > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > >
> > > > When commit 69c1f396f25b
> > > >
> > > >   "efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation"
> > > >
> > > > moved the x86 specific EFI earlyprintk implementation to a shared location,
> > > > it also tweaked the behaviour. In particular, it dropped a trick with full
> > > > framebuffer remapping after page initialization, leading to two regressions:
> > > > 1) very slow scrolling after page initialization,
> > > > 2) kernel hang when the 'keep_bootcon' command line argument is passed.
> > > >
> > > > Putting the tweak back fixes #2 and mitigates #1, i.e., it limits the slow
> > > > behavior to the early boot stages, presumably due to eliminating heavy
> > > > map()/unmap() operations per each pixel line on the screen.
> > > >
> > >
> > > Could the efi earlycon have an interaction with PCI resource allocation,
> > > similar to what commit dcf8f5ce3165 ("drivers/fbdev/efifb: Allow BAR to
> > > be moved instead of claiming it") fixed for efifb?
> >
> > Yes. If the BAR gets moved, things will break. This is mostly an issue
> > for the keep_bootcon case, but that is documented as being a debug
> > feature specifically for addressing console initialization related
> > issues. Earlycon itself is also a debug feature, so if you hit the BAR
> > reallocation issue, you're simply out of luck. Note that this happens
> > rarely in practice, only on non-x86 systems where the firmware and the
> > kernel have very different policies regarding BAR allocation, and on
> > DT based systems, you can force the OS to honour the existing
> > allocation by using linux,pci-probe-only
>
> Thanks. Another q -- I tried out the earlycon=efifb, and it seems like
> it gets disabled (without keep_bootcon) as soon as dummycon takes over,
> which is well before the real console.
>
> DUMMY_CONSOLE is defined as
>         depends on VGA_CONSOLE!=y || SGI_NEWPORT_CONSOLE!=y
>         default y
>
> so it seems like it will pretty much always be enabled, as it doesn't
> seem likely that VGA_CONSOLE=y and SGI_NEWPORT_CONSOLE=y would ever be
> true simultaneously.
>
> Am I missing something or is this the way it's supposed to work? So
> keep_bootcon seems almost necessary with the EFI boot console? Would a
> patch to not disable boot console when dummycon is initialized, but wait
> for a real console, be useful?
>

Well spotted!

I have traced this down to [0] which combined various arch specific
definitions into one, and obviously chose the wrong boolean operator
for combining the conditions.

Patches welcome.


[0] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/drivers/video/console/Kconfig?id=31d2a7d36d6989c714b792ec00358ada24c039e7
