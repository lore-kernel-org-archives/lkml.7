Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BCDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEBF2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbfCYJZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:25:49 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38200 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbfCYJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:25:48 -0400
Received: by mail-ua1-f67.google.com with SMTP id d4so2735755uap.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyXgsi7Hmr4fSWEM1/z6vwIkuMzubjld/R4CuByIhuo=;
        b=C72Srl15sQKD2sAfjw8LlZyhhFH5SwvNbCyhPAOTALnFcZdSaCWA6C906sKRwvdakp
         5C5zCawLqN8LoSORQJQyeS9xldiBvBMCSx6XsqsaEMWejbdDJqWNLfPMTZKvL9M/9gWR
         sghzuUq8X6txHCzgNJfKbnjen/BYA37ZkOffof4RlnMSqbEwZhy5xvTLzAfgZbd9rRHs
         jHoRmxV5Pa3c/rUOoT+EcG4+7SsKY4SKWH1Xny+5sy1Ln/ksFbOF9NdH9ueFGyngY522
         kG+QhpW43mDe5XqSbg94Aql5yjueg0pTt2ZM69fcMvPYqDAlP8pyjg4xCvm0vTQYGG7+
         6S7A==
X-Gm-Message-State: APjAAAUyR7Zh8Bsi+JncIQ6POunNm38toByZ4629lXOxtA6Ay7QsGMW9
        Dmd3mBemFsidHckznmrnN5gmY7p0OqJtxjmJX6s=
X-Google-Smtp-Source: APXvYqwSswZxYDvJ7jKlJvXdykHaAYG5nqWq2RuDufDuUtO4DhUL0Xt5Ej2am2q5BX+wvZ6Z5HQRqmjkba2Fpys7THI=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr8914472uao.86.1553505947478;
 Mon, 25 Mar 2019 02:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1543625590.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1903051706060.145@nippy.intranet> <CAMuHMdW60DhofaVqdts-TmJbgpwVD7NOY4Hp9bbXD5K6-gp5GA@mail.gmail.com>
 <alpine.LNX.2.21.1903052027020.147@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1903052027020.147@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 25 Mar 2019 10:25:36 +0100
Message-ID: <CAMuHMdUX7cvM4NSJpEPN=kDg49EzeC3CvdDJsz0NQTnMkPdOrw@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] m68k: Drop arch_gettimeoffset and adopt
 clocksource API
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen N Chivers <schivers@csc.com.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kars de Jong <jongk@linux-m68k.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Tue, Mar 5, 2019 at 10:55 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Tue, 5 Mar 2019, Geert Uytterhoeven wrote:
> > On Tue, Mar 5, 2019 at 7:13 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> > > On Sat, 1 Dec 2018, Finn Thain wrote:
> > > > This series removes "select ARCH_USES_GETTIMEOFFSET" from arch/m68k
> > > > and converts users of arch_gettimeoffset to the clocksource API.
> > > > Various bugs are fixed along the way.
> > >
> > > Are there any plans to merge this series, Geert?
> >
> > Has this been tested on all/most platforms? Or do you think is it safe to
> > apply regardless?
> >
>
> The amiga, atari and mac patches have been tested.
>
> The apollo, q40, sun3 and sun3x patches are safe though untested, AFAIK. I
> confirmed that, in qemu at least, the default jiffies clocksource will
> work, and the patch is trivial.
>
> That leaves bvme6000, hp300, mvme147 and mvme16x. Those have not been
> tested. Here are some options for those platforms:
>
> 1) Apply the patches untested (gaining new clocksources and some API
> modernization for m68k, while fixing old bugs and potentially introducing
> new bugs).

Thank you, applied and queued for v5.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
