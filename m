Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E859FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78252085A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 14:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YnagnjO5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfENOmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 10:42:54 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39492 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfENOmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 10:42:54 -0400
Received: by mail-vk1-f195.google.com with SMTP id s80so4331714vke.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HxDUMgya6C+pewtw7CuJTqXH1C16ghWjNPJmFKzBodw=;
        b=YnagnjO5b68039SYmxN/WdB6Ql0sRD42h+ael4hmT//KXQ86nw8uXrPU+1d9zAISK0
         B/ZPTyFXNf5dghs1EWBTX81mNIRNG38fXxm6eUqFxpimvYxcKZ/s8SzEqss7mf3T9NG9
         c6Mwmn07wSQZkXlpK4KSKMGmtVb7c83RJWuXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HxDUMgya6C+pewtw7CuJTqXH1C16ghWjNPJmFKzBodw=;
        b=kpdrgQ9AmWGGOs+CAmVPFgFshY7ih2xGhEofuUDd9jsRu4JP6losq2INl+JQrap8ZT
         UGR8CNHxxs2Tkq3xHfd+bFTM757/A8dXu0XlSQlbaoWhZ8yC3M2XgWBYs+gYMXnQX7Cb
         JN++mgwVo4mI4iyH2aHhDo1DxtMKOaj/m1hZQuVIimV/NH+KVv3J1V0mL4JxZOV2c2jR
         pVIX8/erCd0sApCydUzk6RyYEkkQVHPe8RRPXIL261sC/jQK93iEnhx5uGEy2QKVhI8p
         dWdsIOHjBWInuSE9Ikx+l1RgwxIWcmkp5tkN8kCG2NMMjo1j2apucBxQVVvR2XJNuj/6
         wOOg==
X-Gm-Message-State: APjAAAVN2pFHZD3fNjHXiYnckdudywd4xzZXBDiGtX6KRDKoQvTi3ygJ
        d5zDhqzbIryxHbhR/laiUPZewtY8lT8=
X-Google-Smtp-Source: APXvYqybLZHG+r1zNH+mkKerxKqVa3IqaAHw0upr2teNG0BEfzbNQPStFodc3jNmArlT0FTT480YTw==
X-Received: by 2002:a1f:a611:: with SMTP id p17mr4189929vke.50.1557844972879;
        Tue, 14 May 2019 07:42:52 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id v124sm5412608vke.42.2019.05.14.07.42.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 07:42:51 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id l20so1934905vsp.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 07:42:51 -0700 (PDT)
X-Received: by 2002:a67:79ca:: with SMTP id u193mr16139657vsc.20.1557844970925;
 Tue, 14 May 2019 07:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190510223437.84368-1-dianders@chromium.org> <20190510223437.84368-2-dianders@chromium.org>
 <20190512073301.GC21483@sirena.org.uk> <CAD=FV=UBic4qywgYQFGEXx_frD9ZoRJX7XGgDbQCvb2CbkBa9w@mail.gmail.com>
 <20190514093038.GB8665@sirena.org.uk>
In-Reply-To: <20190514093038.GB8665@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 May 2019 07:42:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
Message-ID: <CAD=FV=UXhQg2CuNsTCkSe1BuEvkGMj6qeUB2iF=Qfj=Z0fLiWw@mail.gmail.com>
Subject: Re: [PATCH 1/4] spi: For controllers that need realtime always use
 the pump thread
To:     Mark Brown <broonie@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 14, 2019 at 2:30 AM Mark Brown <broonie@kernel.org> wrote:

> On Mon, May 13, 2019 at 01:24:57PM -0700, Doug Anderson wrote:
> > On Sun, May 12, 2019 at 10:05 AM Mark Brown <broonie@kernel.org> wrote:
>
> > In my case performance is 2nd place to a transfer not getting
> > interrupted once started (so we don't break the 8ms rule of the EC).
>
> That's great but other users do care very much about performance and are
> also interested in both priority control and avoiding context thrashing.
>
> > My solution in v2 of my series is to take out the forcing in the case
> > that the controller wanted "rt" priority and then to add "force" to
> > the parameter name.  If someone wants rt priority for the thread but
> > doesn't want to force all transfers to the thread we can later add a
> > different parameter for that?
>
> I think that's going to be the common case for this.  Forcing context
> thrashing is really not something anyone else is asking for.

OK, that's fair.  Even if nobody else is asking for it, the solution
I've coded up for v2 still allows cros_ec to use the SPI core's thread
in a pretty clean way and saves a bunch of code in cros_ec.  It
shouldn't penalize any other SPI users.

...but I guess you're saying that you don't want to guarantee that the
SPI core will happen to have this thread sitting around in the future
so you'd rather add the extra complexity to cros_ec so the core can
evolve more freely?

-Doug
