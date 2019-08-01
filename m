Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4EBC19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DAC2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0jFp1Oq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731405AbfHAPB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:01:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33621 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfHAPB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:01:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id n190so2919968pgn.0;
        Thu, 01 Aug 2019 08:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ltf46IwQlfq1FBahfTxmlTfSaIAN4qkQArqQHX7t5zs=;
        b=A0jFp1OqpbASNBgS/jaAK+wEp6H+pvrecdn6c4F5TtqRW7BibGhS35S9BRhSmpK/tj
         PqXwIzhKQ/RBiFalPxtnhjXBSRrYFnD6DF6IK74QruSOw2fYAbygqpRrwOlO5I/3kJ7Z
         NHgfW9DLMBOb3KIi3BsLbHRPgXTaUHmVHb9XTlZg7/J3EOHxURaY3kZzo1k8eHjvpGp7
         2AmjauA52aVaLav4bFG6UfP5SxQ09lKBmxj/DexLZegvN7RvXINtHHEy7UEmd2eLAVwd
         a81zY9Spm2fc1+ThdoiH7dYSTF/OvpsKbo1NSOWffRrXv61slYUvKJkAZ0BCIhQL/z1x
         kSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ltf46IwQlfq1FBahfTxmlTfSaIAN4qkQArqQHX7t5zs=;
        b=Q+Nh/YFGezX8qQ7iRRtsRvpSSsYU97dDyxOj8kVahp0bv910ZZnckTLQ1YXwmZUBGC
         a/Ux6z27v8D5Ll3vU/1r33aSD+ZGzUgFZ2ytgdlWJmaMaH2THWC9F+L3HAC6VmC70jfx
         wxyefQfXg0C0oFTaa5BtGNTeyiCUp5Jfcdi4uPr40cHQ2ndZfLlP7u0Ri4MAbKOmGgEv
         Q50fY3YsZ5NdrcIBKAamiRphRTFfkBAMhNaZF6mVn13Pl8ba4v+QNN14VY38mBItvjB/
         Z/MG2NevC/oX6XkDQQRKQog3gqCX5UAt6pdSMAzM76z/1upSodBGuRp1WJ40d8gtPKJX
         F57A==
X-Gm-Message-State: APjAAAVT5p/3Ao7M91GEY5BVGP1R7HSqRQuh1kZ8hR4ezjqPIL6jgUQY
        flBHXqkFjNX6k+moKvAvD3XuAsQaTKk9qXtssX1DVbWN
X-Google-Smtp-Source: APXvYqwRwo5j7YujGPQRoh2MSb9oSMZLSP5aEEvaQYAS0r5Y3YP8FUZQRVwicehru5JNC9oj9ShHz63BLkqH9SRgXzY=
X-Received: by 2002:a17:90a:35e6:: with SMTP id r93mr9225297pjb.20.1564671685391;
 Thu, 01 Aug 2019 08:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <1564411166-23693-1-git-send-email-info@metux.net>
In-Reply-To: <1564411166-23693-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Aug 2019 18:01:13 +0300
Message-ID: <CAHp75Ver+VL1RHB9oD0voSsLNYTtJovS=haz9MjFu+kUdS3A5A@mail.gmail.com>
Subject: Re: [PATCH] platform: x86: pcengines-apu2: wire up simswitch gpio as led
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 5:39 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> From: Enrico Weigelt <info@metux.net>
>
> The APU3+ boards have two SIM sockets, while only one of them
> can be routed to the mpcie slots at a time. Selection is done
> via simswap gpio.
>
> We currently don't have a fitting subsystem for those cases yet,
> so just wire it up to a LED for the time being. While this isn't
> really semantically correct, it's a good compromise.
>

Applied, thanks!

> Signed-off-by: Enrico Weigelt <info@metux.net>
> ---
>  drivers/platform/x86/pcengines-apuv2.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> index b0d3110..adecd6a 100644
> --- a/drivers/platform/x86/pcengines-apuv2.c
> +++ b/drivers/platform/x86/pcengines-apuv2.c
> @@ -69,7 +69,8 @@
>  static const struct gpio_led apu2_leds[] = {
>         { .name = "apu:green:1" },
>         { .name = "apu:green:2" },
> -       { .name = "apu:green:3" }
> +       { .name = "apu:green:3" },
> +       { .name = "apu:simswap" },
>  };
>
>  static const struct gpio_led_platform_data apu2_leds_pdata = {
> @@ -86,6 +87,8 @@
>                                 NULL, 1, GPIO_ACTIVE_LOW),
>                 GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3,
>                                 NULL, 2, GPIO_ACTIVE_LOW),
> +               GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_REG_SIMSWAP,
> +                               NULL, 3, GPIO_ACTIVE_LOW),
>         }
>  };
>
> --
> 1.9.1
>


-- 
With Best Regards,
Andy Shevchenko
