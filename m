Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24170CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFB71204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQqhJBlg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbfKDPp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 10:45:58 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36485 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDPp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:45:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id a6so9209435lfo.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwOQqfkML6mZVQQJ0E1pEMWKtqr2r31eZ85PaIGMmgU=;
        b=IQqhJBlgWadnxdyu6cfIUzn+zx293WrU0J+vvVeex9J89EKwEta3C+qpkGchecJNst
         94ZcUnB59g0NBqIFhuspeGj+nDwA5WvzUg44Idu5OAztaNmUdRQR2UAAwYBCHjgOjYxZ
         3jip6PFRtj1srZaUJ0ller1NjpZwW6IXAyS8f4/TKPJo4R0+MzH7pVU6m5AefC0T853K
         BWYv7Qo+U2WWHKmjH+VFGTtcLgtu42ZVpYOkG5bhQkMx82LEjUVeElNVi02LiLcTSqIu
         +JFf18NG48PeCeIH3j0oao+twWgoUcO+mQzVHiGK28OzkMxw/Aihuyx8xgOlItbFJggv
         aHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwOQqfkML6mZVQQJ0E1pEMWKtqr2r31eZ85PaIGMmgU=;
        b=Ng41l7QJhYMcyjF5RLc2CZnb7d2xlr3tDbn2ZuP+BrkT7OEdmSy+3G13PJTCfhRInr
         OQWAjBrMeRygVE8PMqaAma1oMnqx4VBvOhN3DQXCz36sE4hDxULG1planXsX9BoIAzzT
         sijUqV7d/0+taIH89JjHJhQOPDFgSDSL7XDBYmDC+LEriwe2AtNmlOSb/wqU3OyGLvvO
         TFsSjjlDd7WVBsFXxFOrdVud3NZxjJ/k60aQ9z1l5EoJYGjG9AJrucRpL+nniFml8juv
         i9CFX09fvRmxwHx3qgOu2V8rNQvEHC2K0Gn0wfq1raC/GtcttU5qpmxmpakYnpJXn+q6
         1UQQ==
X-Gm-Message-State: APjAAAWhOZ1swwvpwrktIXZVZbw4utEEV9mIYECMOkM8fx6RzLZ+oNGF
        DMKoWMO3FLqrmshEDwRdzda7zNP6nc76cXrGIULDRA==
X-Google-Smtp-Source: APXvYqwttKRdVsyVJcuL188wpW/OsgZ62RtyOb5/f6UDc4Kan+iShKlu2eMEBGHO+HNXoRn8M2t5FVfJxN4hDx/+sU0=
X-Received: by 2002:a19:651b:: with SMTP id z27mr17005776lfb.117.1572882354242;
 Mon, 04 Nov 2019 07:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20191018154052.1276506-1-arnd@arndb.de> <20191018154201.1276638-15-arnd@arndb.de>
In-Reply-To: <20191018154201.1276638-15-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 4 Nov 2019 16:45:41 +0100
Message-ID: <CACRpkdbb9xy7EFGZ1f3DumM46UDZ3wzQ8Ubc9rz4MGNo84E6Jw@mail.gmail.com>
Subject: Re: [PATCH 15/46] ARM: pxa: maybe fix gpio lookup tables
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 5:42 PM Arnd Bergmann <arnd@arndb.de> wrote:

> From inspection I found a couple of GPIO lookups that are
> listed with device "gpio-pxa", but actually have a number
> from a different gpio controller.
>
> Try to rectify that here, with a guess of what the actual
> device name is.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

OOps my mistakes:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I suppose this tells us a bit about how much these platforms
are getting tested in real life though :/

Yours,
Linus Walleij
