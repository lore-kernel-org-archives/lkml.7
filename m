Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DBCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8C66218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 15:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EbD0K39v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfCOPlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 11:41:07 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46534 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfCOPlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 11:41:07 -0400
Received: by mail-vs1-f68.google.com with SMTP id w26so3165271vsk.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fS41VYqya/WVUGZLNniCmC5a4GGeDfvLmnwezaJ7ig=;
        b=EbD0K39vwqz3bVhBwsrYt6dbj88kc7EN+goE7Gu4cGD7r0th4fq6jKz1Ey2FrXYj/p
         nOQVuD/riRIOSggdZH3rlKnxJ9k6X5dn85itRyRf49BZ3l6pMkmSF67txxrQfwy2jAS4
         a1b11WqlVLU1uaZ4Tta4OKD5z+DiEkr+OWKNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fS41VYqya/WVUGZLNniCmC5a4GGeDfvLmnwezaJ7ig=;
        b=fX/r7qyaGAFtzcFqmhw2v5TfrJP1/VX3Lco8OlzFnB97dPb8RjecpyUQnaCMb4pNSt
         sZhtO9ShaBPH24/y3UaBEnKI2dBBRZ/nwbkes6s715A9ZeFmds30gTatXt+3RcS0+o7r
         4+e9w80cfwprBRtF7tYimPoI2zRPNm/Y/Rjc0wiWM+IO1zFpbVLMemMqBVK+Ng97QzYZ
         Vlk9bR63wUb7bWn/+eRR0a/PvSgOGvUMazikA1Fu28xbVdP9kpDRTcbn5KClsCKw3391
         mitSZ5xx52NRunuTkiXaX9Kpt4H9zWbdNinvBXr6FTPPbHmU3XDvWYZ3TWOAReIfpLwx
         v6LA==
X-Gm-Message-State: APjAAAUURbQjWd/eKgU6DBW5PcIBimz7pEtgCpMLRqV9CPVYN+IxmrG9
        TW/X17+8Z2sQX1Cf10+vAkmF07mA3Gs=
X-Google-Smtp-Source: APXvYqzS6CD/UKFtigjMlVGwHQvYcYlPlfMcLr+6UOXPiB0g/R2JhBi0hVdfAqjDjAeUhlHj64dpIg==
X-Received: by 2002:a67:1407:: with SMTP id 7mr2416317vsu.125.1552664466276;
        Fri, 15 Mar 2019 08:41:06 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id s38sm2562391uad.17.2019.03.15.08.41.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 08:41:04 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id x1so3244815uaj.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 08:41:04 -0700 (PDT)
X-Received: by 2002:ab0:2a95:: with SMTP id h21mr6833uar.121.1552664464154;
 Fri, 15 Mar 2019 08:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190314234159.191745-1-dianders@chromium.org>
 <CAK7LNATa+TnXb+a6on-sx2mjNoAiORe-WeZ8UusETHdSrXowuw@mail.gmail.com> <CAK7LNAT=04WAMEfN7u5N_oO2RwT9bYALMN3SZ3WFQo-=3vEjsQ@mail.gmail.com>
In-Reply-To: <CAK7LNAT=04WAMEfN7u5N_oO2RwT9bYALMN3SZ3WFQo-=3vEjsQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 Mar 2019 08:40:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XqH7knZwK+a+bsACwc-j2NgH914mLTc_POR_GAipVf7w@mail.gmail.com>
Message-ID: <CAD=FV=XqH7knZwK+a+bsACwc-j2NgH914mLTc_POR_GAipVf7w@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Make NOSTDINC_FLAGS a simply expanded variable
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Mar 15, 2019 at 8:37 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Mar 16, 2019 at 12:27 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Fri, Mar 15, 2019 at 8:42 AM Douglas Anderson <dianders@chromium.org> wrote:
> > >
> > > During a simple no-op (nothing changed) build I saw 39 invocations of
> > > the C compiler with the argument "-print-file-name=include".  We don't
> > > need to call the C compiler 39 times for this--one time will suffice.
> > >
> > > Let's change NOSTDINC_FLAGS to a simply expanded variable to avoid
> > > this since there doesn't appear to be any reason it should be
> > > recursively expanded.
> > >
> > > On my build this shaved ~400 ms off my "no-op" build.
> > >
> > > Note that the recursive expansion seems to date back to the (really
> > > old) commit e8f5bdb02ce0 ("[PATCH] Makefile include path ordering").
> > > It's a little unclear to me if the point of that patch was to switch
> > > the variable to be recursively expanded (which it did) or to avoid
> > > directly assigning to NOSTDINC_FLAGS (AKA to switch to +=) because
> > > someone else (out of tree?) was setting it.  I presume later since if
> > > the only goal was to switch to recursive expansion the patch would
> > > have just removed the ":".
> > >
> > > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Applied to linux-kbuild.
> > Thanks.
>
>
> BTW, I noticed no one else
> appends NOSTDINC_FLAGS.
>
>
> So, does it make more sense to do as follows?
>
>
> NOSTDINC_FLAGS := -nostdinc -isystem $(shell $(CC) -print-file-name=include)

It might.  ...but go back to look at commit e8f5bdb02ce0 ("[PATCH]
Makefile include path ordering").  Why did they do a += there since
even then nobody was setting it.  Try:

$ git grep NOSTDINC_FLAGS e8f5bdb02ce0~


Do you understand what was going on in that commit?

-Doug
