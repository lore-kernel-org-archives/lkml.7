Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFD7C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B682146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfI0Mpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:45:55 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38105 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfI0Mpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:45:54 -0400
Received: by mail-ot1-f66.google.com with SMTP id e11so2107061otl.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XdHj9CUIRn1bgsM+6mBPRINoGvRqefaGdJ7HyQ7uQQk=;
        b=rfavjP3FyCp8sIuks9Q0WcRue6lFb+bbuOh2JBIAzbjWjlUJT885DhSGHGMolkBVuD
         3U+XNv2gcbCVg85+xbT+Oy4sSgBHicufVANEkkmnZhJBk/eA0rmqnMPrbqErLEyj0SrL
         kyRpYiCf6/DH4UQzXj3jfJGuxu0IO1tXGH8MLRTjXwSqbcSOEbkYW1GBliXDgt4snDUH
         qxbwNfZD84+cgLqmDl2mGTBLjYnVLYAClAT5XplbikTcuK+uO8b4Es071Ur/kquDLayu
         bHy09j4CI4oFSlkBK1i1Q4uK5NksNzkkqqnaPt7DZHXhO7i893n8zZPI/FcZBEjevifS
         jf6g==
X-Gm-Message-State: APjAAAVkV1maQGkqwFXVdn3kthtIPEowNJKFqtz734Uue0rTb+s88/Rk
        m+bFdZSQSwagyBo+hR6ADXkBj/SheWhtyRXYkKnJ1w==
X-Google-Smtp-Source: APXvYqy0dJZnS+qplEq9PCcAwzPw+E6vfBlSy21Ptq26bwCZIEjG55UbvKQ17wbb/EDVxG5DUaMQRsmC5mJ1HWh6RzE=
X-Received: by 2002:a9d:17e6:: with SMTP id j93mr3103258otj.297.1569588353689;
 Fri, 27 Sep 2019 05:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <1503819148-11676-1-git-send-email-himanshujha199640@gmail.com>
In-Reply-To: <1503819148-11676-1-git-send-email-himanshujha199640@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 27 Sep 2019 14:45:42 +0200
Message-ID: <CAMuHMdWWnAVsVci9ZAKX_hhwYCHgaMNdOt=+k3P_xCQ7jWG-iw@mail.gmail.com>
Subject: Re: [PATCH] nubus: remove cast to void pointer
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     Finn Thain <fthain@telegraphics.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Himanshu,

On Sun, Aug 27, 2017 at 9:33 AM Himanshu Jha
<himanshujha199640@gmail.com> wrote:
> Casting void pointers to other pointer types in unnecessary.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Thanks for your patch!

> --- a/drivers/nubus/nubus.c
> +++ b/drivers/nubus/nubus.c
> @@ -167,7 +167,7 @@ static unsigned char *nubus_dirptr(const struct nubus_dirent *nd)
>  void nubus_get_rsrc_mem(void *dest, const struct nubus_dirent *dirent,
>                         int len)
>  {
> -       unsigned char *t = (unsigned char *)dest;
> +       unsigned char *t = dest;
>         unsigned char *p = nubus_dirptr(dirent);
>
>         while (len) {
> @@ -180,7 +180,7 @@ EXPORT_SYMBOL(nubus_get_rsrc_mem);
>  void nubus_get_rsrc_str(void *dest, const struct nubus_dirent *dirent,
>                         int len)
>  {
> -       unsigned char *t = (unsigned char *)dest;
> +       unsigned char *t = dest;
>         unsigned char *p = nubus_dirptr(dirent);
>
>         while (len) {

The second chunk is no longer valid, but the first one still is.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue the first chunk for v5.5.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
