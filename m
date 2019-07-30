Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77EEC0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B64206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 13:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqhwbWrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfG3Nxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 09:53:34 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35397 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfG3Nxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 09:53:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id l2so56710621wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sRNyE+EBeZmmKMzlKZ3g2C4UmwWiHUkr9GsksgRrCKY=;
        b=dqhwbWrzsvrYeI14epgt/jOL2hrc3T0PYfnThNVRdSef9Wqy+aFFLwBsF2POpbyJCl
         TGHiK4IcA6IDsACDNpkrXwZRSIkUSKoThlXKutz/DNnTe7bY2Dz+bZJRuh3DYpVOltnx
         HE3xqWmBwDEY7X2ePdqdmffMe/RiUVxGkEKVOsR/20sUgtev2Noj32H2dZ/pBGD4WEg0
         TFi+Mu23Vc3AXdM5HJcrHM/2tPS1yHsIAA3ZYRNi1kMnJk1AmKGn6HU5ivqoA+j2xsXU
         a5+m7kUruzKoU+X+0q/i6IyPMDarsIAIrgGiRXwb8Ci+1Vs7AcYXyIYv7hvDOyOmqMKD
         rWGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sRNyE+EBeZmmKMzlKZ3g2C4UmwWiHUkr9GsksgRrCKY=;
        b=FWwz17Fk1+TllNS+iRwl52ScBl3OzszgUCs4aknVmYNT1PS31Zc3Smzb32iMe63ocm
         FU8pwC+ryeaxqqlL49M/Q4zo8J5yQExjuebWGJyxTBsOIMeAn0QDcMYe54Wnm9aM0sB+
         d6TUAo6MUSa3LgyYKqFeGKApeEENwQQtU2SBwAeXkgZnWnQsx+0fq4Yb+T5I6SWXTt0u
         G5VhzQsvlM3IH71NR9P9VYeTaZUc2ViDV/fYPosuz8GSRT1MPcTSs1l1xFAi4FSw4VzM
         v+NE+NnQbMOPTLP7hLX7xIax92X3Z6ZYFsjv8Kr/Nx7CXnMckAduOaghKrbuiG5/r4OG
         8l6w==
X-Gm-Message-State: APjAAAXYugXgfQoYjds0jp7LT43d57IGpWn/rxFqhDsUsu9YHOPQwQeM
        J7oA4O7Rmt5njlHqyompKZ5xfU9SG814R0QsIQoJlg==
X-Google-Smtp-Source: APXvYqwIkFxdslyfwCaMMfBkmahunUdpZQpajxB0UUGK7ijeHMt9QGHPL6MKBjjC8kdU2pQLalAoa4PE7fm9PCL9Ets=
X-Received: by 2002:a1c:6a0e:: with SMTP id f14mr111667883wmc.154.1564494811692;
 Tue, 30 Jul 2019 06:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <201907281218.F6D2C2DD@keescook> <CAHk-=wj+1vDh2=eZExibYF9Lo0GsGxaAjxCSwpUFVURrN44cUQ@mail.gmail.com>
 <201907281507.B3F11DD54@keescook>
In-Reply-To: <201907281507.B3F11DD54@keescook>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 30 Jul 2019 15:53:19 +0200
Message-ID: <CAG_fn=Us9wREo+9PG-jPCTXsNv-rencgYHowtwXahuYBgdDs4A@mail.gmail.com>
Subject: Re: [GIT PULL] meminit fix for v5.3-rc2
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees, Linus,

On Mon, Jul 29, 2019 at 12:16 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Jul 28, 2019 at 12:43:15PM -0700, Linus Torvalds wrote:
> > On Sun, Jul 28, 2019 at 12:21 PM Kees Cook <keescook@chromium.org> wrot=
e:
> > >
> > > Please pull this meminit fix for v5.3-rc2.
> >
> > Side noe: I find "meminit" a confusing description for the structleak
> > thing. When I hear it, it sounds like some generic memory
> > initialization thing in the VM layer (which we obviously do also
> > have), not the stack variable initialization.
>
> I will find a better name. :) We dreamed up "meminit" as finding a name
> for the umbrella of both stack and heap auto-initialization. But I
> agree, it's confusing.
>
> > Also, have you guys talked to gcc people about just making it a real
> > feature, like I think it is for clang? In particular, I still suspect
> > that we could/should  just make zero-filling the *default* in the long
> > run, and say "our C standard is that local variables are initialized
> > to zero, exactly the same way static variables are".
I wonder how hard it should be to make a zero-filling GCC plugin?
I'm not a big fan of hacking GCC, but it shouldn't differ much from
the existing GCC plugins that initialize locals.

> Yes, this is on the list for discussion at Plumber's. Having gcc do
> auto-init is the first part. Convincing Clang that _zero_ init isn't
> a language-breaking change is the second part. :P That's been a whole
> other issue.
>
> > I know you posted some numbers somewhere (well, I'm pretty sure you
> > did) and the full stack initialization really was pretty cheap,
> > wasn't it?
>
> Yes, Clang's initialization (which is 0xAA not 0x00 in most cases) is
> cheap. There are rumors(?) of some pathological workloads, though. I
> haven't seen real numbers for that though.
>
> I'll try to find the Clang numbers (maybe Alexander has them?) but I
> remember it being the same as (or maybe better than) the gcc-plugin
> version, which I measured here:

I've some stale data collected on an x86 QEMU instance.
For 0x00 stack initialization:
 - hackbench, netperf and parallel Linux build were virtually free
(slowdown within stdev)
 - for af_inet_loopback the slowdown was ~4%
For 0xAA stack initialization:
 - netperf and parallel Linux build were free
 - for hackbench the slowdown was ~1.5%
 - for af_inet_loopback the slowdown was ~7%

Since then we've made some improvements to Clang (and more are coming,
e.g. cross-function DSE in https://reviews.llvm.org/D61879), so I
expect the performance numbers to be better now.
A big chunk of slowdown had been caused by DSE not working well with
inline assembly on x86, need to check what's the current status there.

Lately I've been mostly benchmarking Android system performance using
the hwuimacro benchmark suite (an end-to-end benchmark for various UI
features).
Most of the benchmarks are unaffected by stack initialization, however
there are cases in which the slowdown is up to 5% for no obvious
reason (the hottest functions don't have initialization code in them,
slowdown could be related to increased icache pressure).

The biggest problem is that there's no single slowdown number to report.
Benchmarks like netperf may show big slowdowns, but many systems don't
run under netperf-like load 24/7
For graphical apps it's critical that the user doesn't notice the UI
glitches introduced by the instrumentation, so benchmarks exploiting
the full graphical stack are a lot more interesting.
Those often have big variance though, and are very specific to the
particular system.

Alex

> https://git.kernel.org/linus/81a56f6dcd20
>
> --
> Kees Cook


--
Alexander Potapenko
Software Engineer

Google Germany GmbH
Erika-Mann-Stra=C3=9Fe, 33
80636 M=C3=BCnchen

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
