Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10DFC49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F3D2190F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F3UmVNyk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbfKEKE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:04:59 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42456 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387742AbfKEKE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:04:59 -0500
Received: by mail-lj1-f196.google.com with SMTP id n5so10082443ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Syu30Am6BErl09auW6zTpaceggouTxknVxJ/Bz3Nu6s=;
        b=F3UmVNykzWHUTwNdwBuIbGn2Gmfwp0lPCaec0SGFmqb3Uet67QafNd3kCYlw6Ko+iZ
         xv75pN0y9ypmC6pikz0liwOGhAiNts/UROWuHig/DbuhUeFBXD4yqjhPU382v6bC9Ru0
         /j8rerZpggbnjA3tv+Ouiy3Tj9W/7DfdMcsnk1B6kFVShopOgMjoLO9MthZ4KIHuWxuc
         BQP4u2JN974kAVhnIVbXsl02XqxL6+gMbv3UJRx1mRF+XO8D2Fmke5YyV809sOBHqgmv
         rvgASQ5uItepUr0wXaAijVdeu8uYwD5Cz3CiEi/f3Yi1VzBKw690MH7685YqlBJAUyAK
         /oMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Syu30Am6BErl09auW6zTpaceggouTxknVxJ/Bz3Nu6s=;
        b=Y8wWDWVutGAHXqB+/uoRlgNtxmrbMK6yaq4/iIaBlX79huGJAw7zPAG9fpuziFy56i
         /ZJ3EpKwTCfex8yF6qibzlSb0EDSthVS0FO425PIWJde7MhDP9eABW1WhGJneoDWXjC5
         s0RzvEbV1f+hD7CmC6RO0M5NXiJ5hQIjYe6SDmdwUG60NaOT10tZ2lTs1neRGZb4PDQ0
         o4k5oOJZYmMdZ21OOU6LrqO3u5rDtcruPsVe05Gu7Vtl5HQe4Dtyw7ZaA2X/tb5MTZ1x
         HIYoJlaQlDX3jqjXemC3A1YXoSv+GVCoNNuMYGAm4CJ86Q7uloIodDM2A+9T4BA4vQ7X
         eZ8A==
X-Gm-Message-State: APjAAAWic7YXyMaOg0rsKVz8F2dnurFczTab1P4+NOOXFtPnVWccz4H4
        YrWKrTY72FPmSARKffEDiPjjfybrFARqQJeN/cX2hw==
X-Google-Smtp-Source: APXvYqzNQn4xnOeOTV9UejT9zf0JppB8XIps/M7O6A+dhmKjufcoOTliNdNUw1qqwcAYUPtRHSb50EJJlG+Vv1iRlcY=
X-Received: by 2002:a2e:9a55:: with SMTP id k21mr8950214ljj.251.1572948295656;
 Tue, 05 Nov 2019 02:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-38-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-38-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Nov 2019 11:04:44 +0100
Message-ID: <CACRpkdajkSh6Bbvpfycm83j1GuCm+pTfw9fQS53JEfG2i07MKg@mail.gmail.com>
Subject: Re: [PATCH 38/46] video: backlight: tosa: use gpio lookup table
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:43 PM Arnd Bergmann <arnd@arndb.de> wrote:

> The driver should not require a machine specific header. Change
> it to pass the gpio line through a lookup table, and move the
> timing generator definitions into the drivers itself.
>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> ---
> I'm not overly confident that I got the correct device names
> for the lookup table, it would be good if someone could
> double-check.

You're anyway doing more than required for the people who
may or may not be using this platform. Brokenness can surely
be fixed later, it's not like we are taking down the entire Amazon
cloud or something.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
