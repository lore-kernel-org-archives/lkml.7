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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03773C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB64B2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 15:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sb577GZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfHAPA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 11:00:58 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46515 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfHAPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 11:00:58 -0400
Received: by mail-pl1-f196.google.com with SMTP id c2so32311854plz.13;
        Thu, 01 Aug 2019 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yOMIEOoJyU6PdmjsTxm7QjEJSeUYKSTKpb4tS2Mem4c=;
        b=Sb577GZwApsFb/zlrgWCzg0pTJqWahM59fxPtzybeJ58RPsL6p/WBRZBD0Z/dPAsH3
         NVpTF3QtKIVT/YoLyK109iP3uzjRKS0WAuLWzFPp52V46RpiQtfYNiKfCb+t0wMWlxZr
         5d8ydOMogInnafOtLivwqixh/93o/sfNAw13rrbKx4d7YBL7PJD2kZl1BskWuaAwIhvo
         U3zC1Pvn5ECODn5vTtZnEdOw2rKo6XA0m3j/S+apPT5qey/VJJL8j0r5ikP3ZVuxXv2T
         U1bFXNOeGsnmfIgKbysepi8RuwV94zefKG9QY4arNg7dIxdHLTB3Hztq13VyEPxcQH8K
         iYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yOMIEOoJyU6PdmjsTxm7QjEJSeUYKSTKpb4tS2Mem4c=;
        b=cLXJr4s0ndhvSlHl5E/ncP1IQrhghRjDOqUAOYGH5hYr1acUR6jPsH7VFj8rlvQIQO
         ux/RCj4pKHgOd3U80Za+zZ9Cw8bp4N89ozvCIGcEDEV5MHAM8m8d9c8nmHas5WgINbkD
         te6bYrd1B49jYz9wn1QTd9ZjDX495jFmumswyhzlrlML9NfRcCkP/ak55ONWUXuKEbba
         8f80qtzpABobZFR81BQdf9bmGugfsBMQirn4pawafN+QbihkAp5f1zzu5cCH1yuTBbD7
         2PZkvArSJ/VbEWG1RNevhiM0jZvexbbw/LSH3eFZ1JKzSX/Th4vOzgofvAwxyq624jlo
         VT+Q==
X-Gm-Message-State: APjAAAUQXj4wPcin6akijzUeHhlarxpMqXaYAUXvDM84ZmLR2tynXNE1
        n6xevC2lWd9YQ4p255APNAkabwfm0eyx2EgwmDY=
X-Google-Smtp-Source: APXvYqzg7dTk7kOMrKu4lVJsfNEts2wh9P4AOHQjeA6AATg4YD1bJ1qPrFu2zad1lQqK09QQRuIz7RSnQl94BMFGpjU=
X-Received: by 2002:a17:902:694a:: with SMTP id k10mr125267948plt.255.1564671657662;
 Thu, 01 Aug 2019 08:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <1564081563-28322-1-git-send-email-info@metux.net>
In-Reply-To: <1564081563-28322-1-git-send-email-info@metux.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Aug 2019 18:00:46 +0300
Message-ID: <CAHp75Vem8QZVGx6x0p3JgxA6kH3pG+1_zU=cgiDUDSC5p2ODDQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86/pcengines-apuv2: use KEY_RESTART for
 front button
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

On Thu, Jul 25, 2019 at 10:06 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> From: Enrico Weigelt <info@metux.net>
>
> The keycode KEY_RESTART is more appropriate for the front button,
> as most people use it for things like restart or factory reset.
>

Applied, thanks!

> Signed-off-by: Enrico Weigelt <info@metux.net>
> Fixes: f8eb0235f65989fc5521c40c78d1261e7f25cdbe ("x86: pcengines apuv2 gpio/leds/keys platform driver")

Please, use allowed minimum (12 nowadays) characters of hash.

> ---
>  drivers/platform/x86/pcengines-apuv2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
> index b0d3110..4138007c 100644
> --- a/drivers/platform/x86/pcengines-apuv2.c
> +++ b/drivers/platform/x86/pcengines-apuv2.c
> @@ -93,7 +93,7 @@
>
>  static struct gpio_keys_button apu2_keys_buttons[] = {
>         {
> -               .code                   = KEY_SETUP,
> +               .code                   = KEY_RESTART,
>                 .active_low             = 1,
>                 .desc                   = "front button",
>                 .type                   = EV_KEY,
> --
> 1.9.1
>


-- 
With Best Regards,
Andy Shevchenko
