Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776E0C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 04:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F6E2084B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 04:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUkPcE54"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfJGE00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 00:26:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45107 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbfJGE00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 00:26:26 -0400
Received: by mail-io1-f66.google.com with SMTP id c25so25565702iot.12;
        Sun, 06 Oct 2019 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9cn7hWNDSYfp5yXqFFW958D3/KZM4oLb6q2uNhX0rvU=;
        b=SUkPcE54QuOqWOsnTUJ9OupBTtoc/62vjs+pcRhRlW91ahBSnrBEF2wJljxoPdk46O
         GQNGPESN0Ff1RrPM/aD2eDoqVXb+yyUkqzRTseS2sSq2nQQwQqXYcdkqHqgpVj9DePe8
         tM9olm3uxcRFSegXNDygnKTMAuMofJXZ3P2N1WakZ6wdpqOh3yfXAI14bWRts8LxVczv
         XF8H7QDA1WLazodSRkecb3uBVrzIfNoErB7x0n+nImaKizevHEHlyp7pcZAZcbrqPrl2
         Jqe1KFZLSRNlUOZ2kuG5LaDeSZ4tMyZAc8YmsHCc2YMoeJY0aERGwrVx0T75kbkLfzFI
         +vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9cn7hWNDSYfp5yXqFFW958D3/KZM4oLb6q2uNhX0rvU=;
        b=OqoofVKhenVt9fHFEWWjwvjH0zytajUPXipp+Uqu/e6rl6CY0Dv6AgFZoCCThWEvev
         Nmcb1tbksbQsG2VRWmYIPnlQRJhz/TC9Kx1dkRxD4R4YVB9v9yAwjmNBWjOC4wJzFA7P
         WNuIZj4Z+Av9Cl04aC8EqHd15KFS5nrFXDYKZ16PzUUBpKDwHdpPoABnprvjA1UtKH0O
         /7jO6jY/C2VzpaRrVzC4JmdO0gpWeMLOFVFULzqJXdiWCAYOJ/E+5RxbRahK+WiHhbEM
         kJN6lWll1rEIR/8/+1hZXZ4cgf2HT2syZ3mTYyL6JYjgQlKIs60Vi3jZonprEpaVuWAk
         Qw1w==
X-Gm-Message-State: APjAAAXdHfqjXKc1sMsTyxktqAI+ogFUYreA7ISYMWPSQemciTJHAuO9
        wf70lJ6bioMYyhYckyXVgQBy5Aj13AsA16Mzguo=
X-Google-Smtp-Source: APXvYqwNpG0DnS9E7tcNclPV8jO9ELB64ac4Ds2ETF8/Q67RH1TZJg0YKP6QP0J6Ls8/KN4ciXE8HHJrZwThDIB7Zh8=
X-Received: by 2002:a92:a80c:: with SMTP id o12mr25789967ilh.190.1570422383586;
 Sun, 06 Oct 2019 21:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191004190938.15353-1-navid.emamdoost@gmail.com> <540321eb-7699-1d51-59d5-dde5ffcb8fc4@web.de>
In-Reply-To: <540321eb-7699-1d51-59d5-dde5ffcb8fc4@web.de>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Sun, 6 Oct 2019 23:26:12 -0500
Message-ID: <CAEkB2ETtVwtmkpup65D3wqyLn=84ZHt0QRo0dJK5GsV=-L=qVw@mail.gmail.com>
Subject: Re: drm/imx: Checking a kmemdup() call in imx_pd_bind()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabio Estevam <festevam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

I agree with you, kmemdup may fail so a null check seems necessary there.

On Sun, Oct 6, 2019 at 4:33 AM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> I have taken another look also at the implementation of the function =E2=
=80=9Cimx_pd_bind=E2=80=9D.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/gpu/drm/imx/parallel-display.c?id=3D43b815c6a8e7dbccb5b8bd9c4b099c24=
bc22d135#n197
> https://elixir.bootlin.com/linux/v5.4-rc1/source/drivers/gpu/drm/imx/para=
llel-display.c#L197
>
> Now I find an unchecked call of the function =E2=80=9Ckmemdup=E2=80=9D su=
spicious.
> Will this detail trigger further software development considerations?
>
> Regards,
> Markus



--=20
Navid.
