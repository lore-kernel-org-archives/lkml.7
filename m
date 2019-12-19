Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30A2C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C071A2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 09:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="ZFpxsYLE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLSI77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:59:59 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34158 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfLSI77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 03:59:59 -0500
Received: by mail-io1-f68.google.com with SMTP id z193so4969674iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 00:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XhwcmI2wyfpsDhpGYM6tJ8TzKL8XHFXbjOnu1vJ//fU=;
        b=ZFpxsYLEdNHLWO1qXcwglF2c1sIqcsPaMcMqWna2m2gb8lVRd2R41lf+oahElV4lgd
         wmmU1ORgPQhvICUDw7qzZvfZjRwXpHNnwzixdBvnrHg0yIHvuF2JCFiPExZyoLx6fpFD
         Gvvzp3NwqxX9+M79JnMYkbCLI84tKHnMmLmic7ET86e9+mLDm3diShEEg8B1LObCW5Di
         AX+lBzctxpEMXkxR6iUJVJh5DLgtNcLs46fLGGMizcglrFSr6ZD0XoDmXiYZgVuwiYE8
         Y117UqX9G3EF5/HdaUWc1r+21GYWDZ3MgPXdQzMx3+d67UbxqiAAj+JsYNcUtP9duKe5
         nSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XhwcmI2wyfpsDhpGYM6tJ8TzKL8XHFXbjOnu1vJ//fU=;
        b=eop7cAeVYNnpP4D/4tkk38kr196LQF9NZVR0M2UrL8qtLiEZpJixzA1ICnCWq/qOx5
         IajyX9A5kaA2Mdd6nSi6EaYSmS9CRXGo8KA5rOW+ZNsOUOPTKvGsVrpl1rwSGHTtbLky
         yd+l7Hc4MmXSjcYpvAJgYm/KWWFygiyJpb3aZ9D6AkZUpviBfn5hLJA7yZ0jByWwuWs2
         bW0iD017PIdHc7P2W1oQMcs8hwhglyLD/RB4VTllAfNuahc49H3M5AmYeCbWG+xFL+qA
         O6aN6+e7WFbk4JHGVy/ICY2mZSJ7stb0HUljlnbhy9hR1qKONNT20YaZWApkNnEHVzes
         qtlQ==
X-Gm-Message-State: APjAAAUyQS1T9cGLswWkN5W5EBjrUQQnOFx69eDDURBIy3C4oXOdS5gu
        XRcxhHHR22xhu7m1BtERrJeIYgAjt/zLQp7eL/VEMg==
X-Google-Smtp-Source: APXvYqzPk4FlZdj7PEvti7vCUA4390Bw+OwFoETkThRyu8LG2KoaNO7bp9bbPYePbZmR/WPm2F7SiL45vQUpahKKX+M=
X-Received: by 2002:a5d:9dd9:: with SMTP id 25mr5066557ioo.287.1576745998374;
 Thu, 19 Dec 2019 00:59:58 -0800 (PST)
MIME-Version: 1.0
References: <20191213162453.15691-1-brgl@bgdev.pl> <20191213162453.15691-2-brgl@bgdev.pl>
 <51eb10e9-245e-7b3e-51ff-578e06e0759b@ti.com>
In-Reply-To: <51eb10e9-245e-7b3e-51ff-578e06e0759b@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Dec 2019 09:59:47 +0100
Message-ID: <CAMRc=MdBxko3PGK8MksiOYbm081oQf6gYxBp8xOwtyTJ5ruM5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] clocksource: davinci: work around a clocksource
 problem on dm365 SoC
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        David Lechner <david@lechnology.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 18 gru 2019 o 10:28 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> Hi Bart,
>
> On 13/12/19 9:54 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The DM365 platform has a strange quirk (only present when using ancient
> > u-boot - mainline u-boot v2013.01 and later works fine) where if we
> > enable the second half of the timer in periodic mode before we do its
> > initialization - the time won't start flowing and we can't boot.
> >
> > When using more recent u-boot, we can enable the timer, then reinitiali=
ze
> > it and all works fine.
> >
> > I've been unable to figure out why that is, but a workaround for this
> > is straightforward - just cache the enable bits for tim34.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Timer Global Control Register (TGCR) has bits to reset both halves of
> timer. Does placing both halves in reset, waiting a bit (say 10ms) and
> then taking them out of reset help solve the this problem?
>

No, it doesn't change anything. On u-boot present on my dm365-evm,
tim34 is not in reset when we get to linux, while tim12 is in reset,
but putting tim34 in reset in linux doesn't seem to change anything.

> Also, there are LPSCs controlling the timers. As an experiment, can you
> see if using LPSC_STATE_SWRSTDISABLE instead of LPSC_STATE_DISABLE in
> davinci_lpsc_clk_disable() and then doing a clk_disable() + clk_enable()
> on timer can get the timer out of this bad state.

I tried several combinations of this e.g. normal prepare_enable ->
disable -> enable, disable -> enable, disable -> delay -> enable etc.
and neither worked.

>
> We need some way for Linux to start on a clean state after bootloader is
> done. And trying to reset the timer before use seems to be a better way
> to accomplish it.
>
> I assume the original code was just lucky in not hitting this case?
>

I guess so. It used to re-read the registers instead of assuming
certain values. When I did it too, there was no problem, it's only
when we dropped re-reading that this must have appeared.

Bart
