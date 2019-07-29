Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15331C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8FFC206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfG2IxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:53:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38228 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbfG2IxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:53:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so60881839wrr.5;
        Mon, 29 Jul 2019 01:53:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gYEJAxjcgTtQm2cZf+kuqC8244eoV04/bbKoaP0JwWQ=;
        b=hrKT5Ot/r7j4G30s4V9YYNaBuGxXYNQQ3g6LL2i+YOjZNg6pgpPgi+9aNJDDy2f3Kn
         fT8IRvocwDjv3zPiKap+N7DlLmzIBuJWJ7u5MBTUWFM3e1sOxTJ+ptxjr0lVOIYkITAH
         KuUNUJ76ibu/Em0nF6t0vIMXguAfa+TPBVxhi7Xoupam9ZR7AJO9tOA09709Egzzg5It
         g0/JiHXUBoQpltlevOxAzYe9SEa1c7l47w1DtxPEXON/uW9yqyhPU5UHrZ2dN4pL8KlQ
         trMiQJh3fd1hiJdWnJJ+UD75dQdHd9yIWN69PadGqhr2BlLZOlsNEJV3wox8Kd8O0l7U
         JCmQ==
X-Gm-Message-State: APjAAAV93uT9FLai778aVqN8CI7B9UYsa+g9ZAozfypX823xVcvZL7y+
        8PZDpIEijVfNAaC2uBUaxdsxnAQ8nbV2zZ99hTZUYM53
X-Google-Smtp-Source: APXvYqx8nJujn6ne9ZWaFEFrYjHAXB637TBnOpb2N0+qfCp412FAB/ohFygoSLEF6ctIy65qF9cINXkMdMZ2RNME/WE=
X-Received: by 2002:a5d:630c:: with SMTP id i12mr31091883wru.312.1564390398844;
 Mon, 29 Jul 2019 01:53:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190725102211.8526-1-max@enpas.org>
In-Reply-To: <20190725102211.8526-1-max@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 10:53:07 +0200
Message-ID: <CAMuHMdXFW2mEg8jChA=JFt-u9NMGp9m+1FnoGe=+Pxme3O2ESg@mail.gmail.com>
Subject: Re: [PATCH v2] ata/pata_buddha: Probe via modalias instead of initcall
To:     Max Staudt <max@enpas.org>
Cc:     linux-ide@vger.kernel.org,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Thu, Jul 25, 2019 at 3:25 PM Max Staudt <max@enpas.org> wrote:
> Up until now, the pata_buddha driver would only check for cards on
> initcall time. Now, the kernel will call its probe function as soon
> as a compatible card is detected.
>
> Device removal remains unimplemented. A WARN_ONCE() serves as a
> reminder.
>
> v2: Rename 'zdev' to 'z' to make the patch easy to analyse with
>     git diff --ignore-space-change
>
> Tested-by: Max Staudt <max@enpas.org>
> Signed-off-by: Max Staudt <max@enpas.org>

Thanks for your patch!

> --- a/drivers/ata/pata_buddha.c
> +++ b/drivers/ata/pata_buddha.c

> @@ -145,111 +146,162 @@ static struct ata_port_operations pata_xsurf_ops = {
>         .set_mode       = pata_buddha_set_mode,
>  };
>
> -static int __init pata_buddha_init_one(void)
> +static int pata_buddha_probe(struct zorro_dev *z,
> +                            const struct zorro_device_id *ent)
>  {

[...]

> +       switch (z->id) {
> +       case ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA:
> +       default:
> +               type = BOARD_BUDDHA;
> +               break;
> +       case ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL:
> +               type = BOARD_CATWEASEL;
> +               nr_ports++;
> +               break;
> +       case ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF:
> +               type = BOARD_XSURF;
> +               break;
> +       }

Please obtain the type from ent->driver_data instead of using a switch()
statement...

> -module_init(pata_buddha_init_one);
> +static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, },
> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, },
> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },

... after storing it in zorro_device_id.driver_data here.

> +       { 0 }
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
