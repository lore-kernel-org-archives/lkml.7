Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE178FA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A0D20650
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 12:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kPp2Lbyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392905AbfJPMLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 08:11:06 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36225 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392877AbfJPMLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 08:11:06 -0400
Received: by mail-lf1-f68.google.com with SMTP id u16so4691128lfq.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAcMglJ0sMZP7+r5P2KE/QX2T7ue0jf4q4Bd1DSk2+o=;
        b=kPp2LbyytXuiszE7XqY4dsXBc5wTYwqSTDkG2glMbJy8Pzs+bcaA9exT6sjDt6XIxI
         zbDgBJPyZkMVp/13P/6/lt/Am7sHZmwIQXCDGs9gNOmVqkTKc0ASGOUrz1Tkxf1vOdUG
         3+hgdaFZVjnoJgKTORduGR9Px142SvukOwkjnhZ4d/pZsRSWfTcFrMzxMkiLgF3hLe3K
         Csr2B0hlXr5Td3UaKF3awDZKfKY9cC+CvK4bTh/rFyvf7V3iRGlJ4QDYS8RZ6m3014HP
         um/NzdbRHbtwz3zKwxhUh1JOv7s0RkC9B3V8DxhSywbPSF9Nz4ktSeYRwZ9gBWRlA9fA
         ee0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAcMglJ0sMZP7+r5P2KE/QX2T7ue0jf4q4Bd1DSk2+o=;
        b=TBt4puxCVNbyiCuD2QJdZbO12C0LGPwy5UbX1VocjXO4vgUC7TL5a8cKsfYj4B1FVA
         WeditN6TA93HuFfjaLLbUlH9vCVpvydBys4Ot38Ejh4l9+75hCAprdSeo7VceyiHIPv6
         SBFpDbzJ4mRCA6ytPosKdS4yWsfcsHrGzZx/mSGq4EUvvPzIn6TmF5Bnd+EQpPvOwrU8
         nNh2gMX8qxnfHrx0tz6yKZvkFtmYQZmLUIO7JInHN7h2K5o0cpavuUkdQ0f4YrXMO91t
         WXo8H8FMCIpPF5ZcEY5Tm01ztsqvpXJlR/mo2Z/IqUcucZmL1OjtQC3nAHnarMJbLiFv
         LNJw==
X-Gm-Message-State: APjAAAUxcUBCLn3+iQFbLtmldHY2vw/nTO/0XKPWDN42XVE5gOvFPNYd
        Sfb3gldBv4L/TmDw1SC8tUF5okqMt11ahZWujqWUZg==
X-Google-Smtp-Source: APXvYqyC/8s5wFJQZ84rZaLlU3QiDyhyWI8h+dFx0LNQamFK0NlRVzDmYzTFmoBGE7Ny04pOfYsYDfSM9SKQDobKlpU=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr2022223lfl.61.1571227863019;
 Wed, 16 Oct 2019 05:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20191011005643.41007-1-hui.song_1@nxp.com>
In-Reply-To: <20191011005643.41007-1-hui.song_1@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 16 Oct 2019 14:10:51 +0200
Message-ID: <CACRpkdaU82GHxRbWqF-CxHdsJJ02YHtdA0kWvZz-8eCWXNxHAA@mail.gmail.com>
Subject: Re: [PATCH v8] gpio/mpc8xxx: change irq handler from chained to normal
To:     Hui Song <hui.song_1@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 3:07 AM Hui Song <hui.song_1@nxp.com> wrote:

> More than one gpio controllers can share one interrupt, change the
> driver to request shared irq.
>
> While this will work, it will mess up userspace accounting of the number
> of interrupts per second in tools such as vmstat.  The reason is that
> for every GPIO interrupt, /proc/interrupts records the count against GIC
> interrupt 68 or 69, as well as the GPIO itself.  So, for every GPIO
> interrupt, the total number of interrupts that the system has seen
> increments by two.
>
> Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@nxp.com>
> Signed-off-by: Alex Marginean <alexandru.marginean@nxp.com>
> Signed-off-by: Song Hui <hui.song_1@nxp.com>
> ---
> Changes in v8:
>         - merge two lines as one line to fit 80 characters.

Patch applied.

Yours,
Linus Walleij
