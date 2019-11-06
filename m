Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAF0C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 857E5217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GanIKZ9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbfKFHVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:21:42 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34404 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfKFHVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:21:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id n13so6454249pff.1;
        Tue, 05 Nov 2019 23:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RjcWseZDp53ZsKtc5YLxUsse+m3KARrZ1Ou63MXjdxQ=;
        b=GanIKZ9MrdVtBmKUbTdfFXkeiCjXtfZJ2sAWIt7dqViG995heeXhR12lcDHp4Emy0w
         m6Zn2lJmHsEdLZ8jT60LNbMuTcgOSxGjszVigD/1RPxx/aKJC0Q2Y5wwCC2aRAe6zQK/
         NWv4SdxPlHL9MJgDY6XJWg+QBHq2KT927l211txYZ2pUckdmTThNiMdxT0VZpcVqWdja
         GTvzYKvKETktYTQnpsar89tAHTNhZNbtC7qz1nJL9ywYaySOjKkaG3uSzLCbhzYhKMSw
         lDpxBi2gf+sz+fyGrh8tsa8F63bfv62cKMzEQReLKwnHx2b2IjvayiN0k4uuCyUZYoyO
         M2qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjcWseZDp53ZsKtc5YLxUsse+m3KARrZ1Ou63MXjdxQ=;
        b=MnXdrAj2ZuPYm4wVVE66i/hluSW8FCs0zULZ5Dh9gQmoqWKr5tkh2U8tL3pSkseJ0V
         vq3MASyrEsNEZx1WaddDcjhaclGoxdM8A8VKDTBESuQfwP8dRukcaEo1xS0W2PmCE0PI
         MfFQX29sWV/wd6dqoRj8Q0Q0jcHdEEyUDog4gxKrWQV85rvGkyRUFJ4TL31kQ3vpdP5B
         C3GyAkj6gDoipiVThANX6oTKDpp1sXW/7YLwZ9Tl63olntO9cXsxfeTtp4BeJWhYiyPD
         CwUy9btCm82RoKcDpdPgR6fvSnIPxZsEnDZb/usZAk5MiAwDHbuuRCskJICMmx3AZ42l
         YiKg==
X-Gm-Message-State: APjAAAVvt//L+b7JXZQTehss6v1uzBHn49oArWLH3buSOoRuFtBJsB8b
        zM3JEetDK4xrqwbLAvpywm1f86U5cpI1uQPqejU=
X-Google-Smtp-Source: APXvYqwiBxDuq0Qr009Xx2Cx16r9gU2XC0rGWaLGYHUJDm1uLLJ/41h46s+FlxHihfoFLZfWrPOmuWKgHGe8w48SPyI=
X-Received: by 2002:a17:90b:958:: with SMTP id dw24mr1895113pjb.30.1573024901387;
 Tue, 05 Nov 2019 23:21:41 -0800 (PST)
MIME-Version: 1.0
References: <20191104213417.18036-1-leonmaxx@gmail.com>
In-Reply-To: <20191104213417.18036-1-leonmaxx@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Nov 2019 09:21:30 +0200
Message-ID: <CAHp75VfS_AC+QmCY5M1VXd6QJLFQ=YtTdY4yDrJMPPMY_JxYLg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] asus_wmi: Support of ASUS TUF laptops on Ryzen CPUs
To:     Leonid Maksymchuk <leonmaxx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Chris Chiu <chiu@endlessm.com>,
        Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>,
        Kristian Klausen <kristian@klausen.dk>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Corentin Chary <corentin.chary@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 11:34 PM Leonid Maksymchuk <leonmaxx@gmail.com> wrote:
>
> Hi,
>
> this patch series adds support of ASUS TUF laptops on Ryzen CPUs to existing
> asus_wmi platform driver and also fixes minor bug.
>
> v2: fixed indentation.

Usual versioning
RFC [RFC v2, ...]
v1
v2, ...

Okay, next one will be v3 to avoid overlapping.

I'll take first patch later, but I also will give more comments to patch 2.
Please, give me time to review it properly.

>
> Leonid Maksymchuk (3):
>   asus_wmi: Fix return value of fan_boost_mode_store
>   asus_wmi: Add support for fan boost mode on FX505DY/FX705DY
>   asus_wmi: Set default fan boost mode to normal
>
>  drivers/platform/x86/asus-wmi.c            | 57 ++++++++++++++++++++++--------
>  include/linux/platform_data/x86/asus-wmi.h |  1 +
>  2 files changed, 43 insertions(+), 15 deletions(-)
>
> --
> 1.8.3.1
>


-- 
With Best Regards,
Andy Shevchenko
