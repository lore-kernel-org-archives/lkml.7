Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF13C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7861204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 07:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="S/SdAfsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfK0H3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 02:29:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34430 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfK0H3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 02:29:23 -0500
Received: by mail-ot1-f68.google.com with SMTP id w11so18339310ote.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 23:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u8oUQFRZy3gf3+1yf0zkKS6+wd9DrvcbQ832mANUPWo=;
        b=S/SdAfsNtNo4n8om7tQ8ej8pWPma3kUq5jV16c0NRtI0d+7+cBogG4aHNIEOFRIssG
         DqNvD128D3m2Dw4hHw/EN5U0fY7Y+9+GVaZ2wbUCqpTFItYtg4m1gXzE3FX9kTacD0KE
         EzIgZ6gTcM/+yjIjDFAg0X7QxSA48QIcYpxEor2LIp5K7ip6lECTtMlDnVT8s6nRoVp+
         VxhuDmKkPxn3I7TnYd6R+VAn8Byx2sKZrpIKL570sT3n5WZFSaQVFQHvgbcQq0cs1w9V
         +idjzBgwlDMcXNa06M1IXARDreMzmjRFdZ6blxE8OrCksjV71MpuuONorciuI3YLPWrM
         CG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u8oUQFRZy3gf3+1yf0zkKS6+wd9DrvcbQ832mANUPWo=;
        b=TY5ZC2LakHcQJolJHvI6VidIh2c++WBe44H0NEDbRvK08fc0HMwk4DYTlpoGZC8OJa
         cJoTmBgMgtOPQudFRfW5+i/hskdfkVXoKs6/GC0mh4RiKUXQyFx3qtdL8WLpy6iZ+94G
         pN3cf2IgJw0fVB5ACFTfVqwL2sh+aPW+OGzvC8w6edRT6nBMeuqBq9gudonlnsDNEtwn
         8VpOGj20h6UcZpB0cx345hKdZvhJCIzj1S07tpUmb3wTxvSg9HpUPt93n2kkGy+iKqAa
         Zj5mf0CVGQDcw3K7MxcTRcs3EkDIjR7Cz7X3dwmetDuInjD9ofyWzCs4IvISgfGvx5DI
         TTEQ==
X-Gm-Message-State: APjAAAXvwgbwNY0S2kApaBylFVbfWXS9wW3NkLAEL7Pfvlejm+1nZQzR
        ZlGTH++SpE7gis160v+WOXLJVFK9QWY2JbzCJiAXBg==
X-Google-Smtp-Source: APXvYqwUJpU+ywaP4+HdQDqIrP53KyP5oXj3UgopnsUkAWzWQFz8KbbiHHCui0ide4gn0Mof0rjjgxah85RHCbxbzM8=
X-Received: by 2002:a9d:65cd:: with SMTP id z13mr2544801oth.85.1574839762873;
 Tue, 26 Nov 2019 23:29:22 -0800 (PST)
MIME-Version: 1.0
References: <20191126193027.11970-1-jcmvbkbc@gmail.com>
In-Reply-To: <20191126193027.11970-1-jcmvbkbc@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 27 Nov 2019 08:29:12 +0100
Message-ID: <CAMpxmJV6qCGWKadeDyJLqCDtZ3zFBQAZ0yZuWkYiy3ZqWUFGiA@mail.gmail.com>
Subject: Re: [PATCH] drivers/gpio/gpio-xtensa: fix driver build
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>,
        "Stable # 4 . 20+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 26 lis 2019 o 20:30 Max Filippov <jcmvbkbc@gmail.com> napisa=C5=82(a):
>
> Commit cad6fade6e78 ("xtensa: clean up WSR*/RSR*/get_sr/set_sr") removed
> {RSR,WSR}_CPENABLE from xtensa code, but did not fix up all users,
> breaking gpio-xtensa driver build.
> Update gpio-xtensa to use new xtensa_{get,set}_sr API.
>
> Cc: stable@vger.kernel.org # v5.0+
> Fixes: cad6fade6e78 ("xtensa: clean up WSR*/RSR*/get_sr/set_sr")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  drivers/gpio/gpio-xtensa.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpio-xtensa.c b/drivers/gpio/gpio-xtensa.c
> index 43d3fa5f511a..0fb2211f9573 100644
> --- a/drivers/gpio/gpio-xtensa.c
> +++ b/drivers/gpio/gpio-xtensa.c
> @@ -44,15 +44,14 @@ static inline unsigned long enable_cp(unsigned long *=
cpenable)
>         unsigned long flags;
>
>         local_irq_save(flags);
> -       RSR_CPENABLE(*cpenable);
> -       WSR_CPENABLE(*cpenable | BIT(XCHAL_CP_ID_XTIOP));
> -
> +       *cpenable =3D xtensa_get_sr(cpenable);
> +       xtensa_set_sr(*cpenable | BIT(XCHAL_CP_ID_XTIOP), cpenable);
>         return flags;
>  }
>
>  static inline void disable_cp(unsigned long flags, unsigned long cpenabl=
e)
>  {
> -       WSR_CPENABLE(cpenable);
> +       xtensa_set_sr(cpenable, cpenable);
>         local_irq_restore(flags);
>  }
>
> --
> 2.20.1
>

Patch applied, thanks!

Bart
