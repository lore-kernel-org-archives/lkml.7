Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D6C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A25C204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 15:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTZrZjLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbfEVPCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 11:02:48 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44369 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729517AbfEVPCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 11:02:45 -0400
Received: by mail-io1-f66.google.com with SMTP id f22so2081615iol.11;
        Wed, 22 May 2019 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDrBocZqF5A9uvIRjwm8TlVuWA42reD9PHLLFCTbFI8=;
        b=KTZrZjLxDXab0dPMxFWXRl0eNy5ybOtX4eJo2UN5GMYS9KUvUQzE+BJ2oOkdLIs3Zj
         Jp2RILHcGS16ekSnEUBvKzm2hFcfnHE5Jr7612tdepE6cVhQ0m68o8JTg25/p2aYQOO3
         p9O7BC1ztcFxnGtwkZEwfAymH20dUnw0+/jFdte++fufR7JCWA21iKVnfocFpy8AbGzb
         eCPr1cAtcv2kqlo6rOh+ztAYbJcfnkL40ep1dNVnLYbmCic+1UqqhP8s+EvnZBvbAdHl
         RjLZyllNq3Utg6BZ11E+o5dyeu0yMlVy4v5JwWmfsm/Y+MuDgJV8yr3kBvfqx6dlWS2r
         wTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDrBocZqF5A9uvIRjwm8TlVuWA42reD9PHLLFCTbFI8=;
        b=gwzNcI4UghOVZnd+8z/xYlEiNPUzVVc7TITTn+eTO9/vC2fWXMlhMqt5cvDkoQQafh
         7FqGkNuFS4lUqZrLSqnvw9Bev0eLTGJA/QWullivfuFC4XbRKQ6Npli25RdRIl8gRpAF
         3NhEILf5bXJXgR0fhNP8486WFvQuJELuS63kT8z7D1JNk3S5AMy6UsAowpH/tp0z1KyC
         GTWvyfH4kaiSzhrI6SZBtBI3boZ4HN96anK9UZrHiKTPVoq0AolhCvas0j5raEW5TSFw
         f1ZKJyMEEThJFRIKfPcjgY0pwC/vJ3rt2LUjV/6pnXmr5a9u56jUYTuc+8BqKuoILWKm
         g3vA==
X-Gm-Message-State: APjAAAWC30H602ggBUAXIsZ459surKefIwSKpZlzol1x4LaO5mTGa+hI
        O2Qmc9l57oNxXD8ZzCDcRySdjfzYVaTI4Y6psvzFtkrWsbQ=
X-Google-Smtp-Source: APXvYqzLGNbsta34sjAK5yPAwpIwFYJUcC4AaRk6875xUEBJ05MhRdbGMYpQSWHnZpUcyA82CQZxP98IIXCSFC3pQV8=
X-Received: by 2002:a6b:b7ce:: with SMTP id h197mr26284954iof.169.1558537364407;
 Wed, 22 May 2019 08:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190522120736.5521-1-alexandre.belloni@bootlin.com>
In-Reply-To: <20190522120736.5521-1-alexandre.belloni@bootlin.com>
From:   Sylvain Lemieux <slemieux.tyco@gmail.com>
Date:   Wed, 22 May 2019 11:02:32 -0400
Message-ID: <CA+rxa6oabqMLAUyXVX-tvrAkpNDXVQ7KqiEqSf73J1HXwY-e5A@mail.gmail.com>
Subject: Re: [PATCH v2] usb: gadget: udc: lpc32xx: allocate descriptor with GFP_ATOMIC
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Vladimir Zapolskiy <vz@mleia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, James Grant <jamesg@zaltys.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>

On Wed, May 22, 2019 at 8:07 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Gadget drivers may queue request in interrupt context. This would lead to
> a descriptor allocation in that context. In that case we would hit
> BUG_ON(in_interrupt()) in __get_vm_area_node.
>
> Also remove the unnecessary cast.
>
> Tested-by: James Grant <jamesg@zaltys.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>
> Changes in v2:
>  - remove unnecessary cast as pointed by Joe Perches
>  - Collected tested-by
>
>  drivers/usb/gadget/udc/lpc32xx_udc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
> index d8f1c60793ed..2719194ebf42 100644
> --- a/drivers/usb/gadget/udc/lpc32xx_udc.c
> +++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
> @@ -937,8 +937,7 @@ static struct lpc32xx_usbd_dd_gad *udc_dd_alloc(struct lpc32xx_udc *udc)
>         dma_addr_t                      dma;
>         struct lpc32xx_usbd_dd_gad      *dd;
>
> -       dd = (struct lpc32xx_usbd_dd_gad *) dma_pool_alloc(
> -                       udc->dd_cache, (GFP_KERNEL | GFP_DMA), &dma);
> +       dd = dma_pool_alloc(udc->dd_cache, GFP_ATOMIC | GFP_DMA, &dma);
>         if (dd)
>                 dd->this_dma = dma;
>
> --
> 2.21.0
>
