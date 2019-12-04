Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B46C2D0BE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA00206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 22:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3XXWpQ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbfLDWU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 17:20:26 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43181 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbfLDWU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 17:20:26 -0500
Received: by mail-pf1-f194.google.com with SMTP id h14so524486pfe.10;
        Wed, 04 Dec 2019 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6etV9LslkIFbiE7TnRDB+5AgZ527uoDUjQE1aC+Ye4=;
        b=e3XXWpQ3njbF3qiUE9FN1Xpx23rTDxO74C0MGCZAJ5AOLLe1g4AAwL4Raa7W8qiIIU
         iEX7UndxDdLgEo8fTIguQebuSYbrFUwvS7y54UdoAUO8x4463uREoITjkuZ6HXwBnzB4
         WQPeuuTkdCwU+PetWfgQJVeNnUIoUP4NiKBYfk22mL0G6beurwvITJXhApmJaNIZuz32
         mQPNDNneXd6Cf+pt+JH2UtvTvK4fifs6gbB7PLjGB6f7OVZQiFtz8Agu6IpfoZ4RxgVk
         k7UhOIrxEePvo+pgHh7MajKScP9DmS3+9YcABG/wBrMfLKNqDIkZAhEJsWdq7RfmoSLZ
         BYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6etV9LslkIFbiE7TnRDB+5AgZ527uoDUjQE1aC+Ye4=;
        b=N5DU4D/OcBTro1BWD7rqwNbY9r8PT8QWx44pgShZ95r07N5LkAwkuqFU5UimycxG2+
         gO1lZPW+pEMhu6DAu7v2L54/GG5aqBasafbz4ZI4y5eWODMSM2AQw+t0rwkckaC1YUFv
         EWlGhA6g+aWLwU8rxkc19B6ZH1beKq+uCWP16qols1Z5TVjY/M/bkC/aNrA7OcSJJgeS
         kr95oaWIajb7esUINteH+knCoP8LNWm0Gkaj60RBSdNcRYtslcPqwcewE5Lal5GYxv4g
         SnELjwGMHabyAr6J+GGUInemd5Z39nCI4pMJRoBrZ9yd1MX/nRE7KBvuv6B0wifQ6ibY
         oJRw==
X-Gm-Message-State: APjAAAWRxYVz54TYpPSvxSpSq2Ja36+/he38nWh/Lca/CXHTq6qxw7PX
        tpi7CjjR0Lm92Ejp/MJCaJMW1rezNLIr2oQFmeJCs5M+w/s=
X-Google-Smtp-Source: APXvYqwlzoNGSUvrLmcPr7iZtmahKdK6BB+FR9vhs2qcaK2NoNk6y+5mUTuXynV8wvFXGjj647vw2KvMpvinZ+/X/T8=
X-Received: by 2002:a63:e14a:: with SMTP id h10mr5816637pgk.74.1575498025476;
 Wed, 04 Dec 2019 14:20:25 -0800 (PST)
MIME-Version: 1.0
References: <20191204155912.17590-1-brgl@bgdev.pl> <20191204155912.17590-5-brgl@bgdev.pl>
In-Reply-To: <20191204155912.17590-5-brgl@bgdev.pl>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Dec 2019 00:20:13 +0200
Message-ID: <CAHp75VeomEj1oD=O+=FV-9L2cyJUuhKOzDDb3nFyuVmmu6LHoA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] gpiolib: use gpiochip_get_desc() in linehandle_create()
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 4, 2019 at 7:18 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Unduplicate the ngpio check by simply calling gpiochip_get_desc() and
> checking its return value.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Fun fact, I have for longer than a month a similar series, though not
baked well, and never had time to send it up.
Thanks you did this!

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpio/gpiolib.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index b3ffb079e323..6ef55cc1188b 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -678,14 +678,13 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>         /* Request each GPIO */
>         for (i = 0; i < handlereq.lines; i++) {
>                 u32 offset = handlereq.lineoffsets[i];
> -               struct gpio_desc *desc;
> +               struct gpio_desc *desc = gpiochip_get_desc(gdev->chip, offset);
>
> -               if (offset >= gdev->ngpio) {
> -                       ret = -EINVAL;
> +               if (IS_ERR(desc)) {
> +                       ret = PTR_ERR(desc);
>                         goto out_free_descs;
>                 }
>
> -               desc = &gdev->descs[offset];
>                 ret = gpiod_request(desc, lh->label);
>                 if (ret)
>                         goto out_free_descs;
> --
> 2.23.0
>


-- 
With Best Regards,
Andy Shevchenko
