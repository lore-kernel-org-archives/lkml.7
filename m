Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B83C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305502082C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfCEHuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:50:55 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:44862 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727042AbfCEHuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:50:55 -0500
Received: by mail-ua1-f65.google.com with SMTP id r21so6896788uan.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 23:50:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJQy2eZmxa2kZTjrpayF6beH9mz6o6lejKOYF66JVEM=;
        b=ZEBFUvhxwe6UqruplYyejIlY2fg0YMhencGCVfwVqnVFlg8xWrP8KJaNy00VVNObTq
         6PWmNx+3YHIn7291fiIRcIVDuGnZxiZM7KRMVGh63DoyfPcwpir45CfdXgz9UK29HT5i
         SqvqSPxjaOSkcbCWchq6vpWUKtrYDxXoOUMWviG7QKZQ+a+aJmZqMb4Y4+wW7HlCZMlR
         mAngMR3CDjxMYjubVgVor/cRTYHyg8rd76HjzFbKwhG+50Pcwk4zgQ3W4LkF5C906a2f
         0JfL/NtPWWahZAP8frODrmetQqHeGzsNAhzq6nyFdhne21SVgy2bE0xoVIS30fCQYtBb
         Js1g==
X-Gm-Message-State: APjAAAVg6iZToVG6qjbLTsQkHJ0fQRrCshJ1PqAIdJxg7EVo+gIP7BLc
        6IYzxfaZHrj/Bb7Y4Fs6ZkLtiBK0ezTmf7nc2Ks=
X-Google-Smtp-Source: APXvYqyh2va6B2XakHivRwk9rKnCts/W9zwI154TdDOqtxv5U5F4TJ/aHNN8G1xlkkr4G4fHgxBXmDZuR6zXbD1ky8Y=
X-Received: by 2002:a9f:30dc:: with SMTP id k28mr532005uab.75.1551772254083;
 Mon, 04 Mar 2019 23:50:54 -0800 (PST)
MIME-Version: 1.0
References: <cover.1543625590.git.fthain@telegraphics.com.au> <alpine.LNX.2.21.1903051706060.145@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1903051706060.145@nippy.intranet>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 5 Mar 2019 08:50:42 +0100
Message-ID: <CAMuHMdW60DhofaVqdts-TmJbgpwVD7NOY4Hp9bbXD5K6-gp5GA@mail.gmail.com>
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

On Tue, Mar 5, 2019 at 7:13 AM Finn Thain <fthain@telegraphics.com.au> wrote:
> On Sat, 1 Dec 2018, Finn Thain wrote:
> > This series removes "select ARCH_USES_GETTIMEOFFSET" from arch/m68k
> > and converts users of arch_gettimeoffset to the clocksource API.
> > Various bugs are fixed along the way.
>
> Are there any plans to merge this series, Geert?

Has this been tested on all/most platforms? Or do you think is it safe to
apply regardless?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
