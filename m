Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CEEC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E56272070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 09:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfG2JFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 05:05:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33726 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbfG2JFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 05:05:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so61030954wru.0;
        Mon, 29 Jul 2019 02:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qxGXy8FtO6vZfwLC9EabJrzvuG/ZhokgOoU0Ki4Dhbw=;
        b=jDc4wGfMkBV7POTrZPf6hRcIPHyA7llZULoVLQ31Q6ZHqzBEgwKjDFFDLyTaxKMnik
         Bqo3nTdgPdbCnPJonIrLmo6JswTmmtPdpPSQ99rys4/zCosjaH/LdEOr1a0BPhA5yLS7
         4H+SVPuieUkzpflESR16ZAVGLfk74r3QckmTp7UBqpfcCoCnYZ3Muk/THo+TT4xPvfS5
         vFfcjf6AeVJnJE8Y0qnxmY4iHOHgZ03geQnfNKBmJ3kME2EDPfKfV43aa+qfcwZQJ5rJ
         /riV80osvB47VCHoGjS95d8aapqli9K8u7Fy41vKHdybTYHiptP2LmGfUNXlp3Owk0G3
         qAFA==
X-Gm-Message-State: APjAAAWKwpeNfQ4c3qJqv9WRq81Ke+2poT4A1W47PrW/fFJwb6JdLpuL
        h7LCdXqnjCDIoiDpUryTVp+D7WhViZE/ce9b33g=
X-Google-Smtp-Source: APXvYqz6uojkUazaZHHYCxUOpwqlKfsC3vg/+iiUOP1b3dFA5D9/TZrHUuJeGqZvqozJ1+Et2HptvgBmlSS7h66vIBY=
X-Received: by 2002:adf:cd81:: with SMTP id q1mr117369836wrj.16.1564391138795;
 Mon, 29 Jul 2019 02:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190725180825.31508-1-max@enpas.org>
In-Reply-To: <20190725180825.31508-1-max@enpas.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 11:05:27 +0200
Message-ID: <CAMuHMdURm-9nazOBTL8uRH8WMt7gi=QUYy0qr9kaxzczCr+ujg@mail.gmail.com>
Subject: Re: [PATCH v3] ata/pata_buddha: Probe via modalias instead of initcall
To:     Max Staudt <max@enpas.org>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Max,

On Thu, Jul 25, 2019 at 8:08 PM Max Staudt <max@enpas.org> wrote:
> Up until now, the pata_buddha driver would only check for cards on
> initcall time. Now, the kernel will call its probe function as soon
> as a compatible card is detected.
>
> v3: Clean up devm_*, implement device removal.
>
> v2: Rename 'zdev' to 'z' to make the patch easy to analyse with
>     git diff --ignore-space-change
>
> Tested-by: Max Staudt <max@enpas.org>
> Signed-off-by: Max Staudt <max@enpas.org>

Sorry, I only noticed v3 after I replied to v2.
My comments are still valid, though.

> --- a/drivers/ata/pata_buddha.c
> +++ b/drivers/ata/pata_buddha.c

> +static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, },
> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, },
> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },

drivers/net/ethernet/8390/zorro8390.c also matches against
ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, while only
a single zorro_driver can bind to it.  Hence you can no longer use both
IDE and Ethernet on X-Surf :-(
Before, this worked, as the IDE driver just walked the list of devices.

I think the proper solution is to create MFD devices for Zorro boards
with multiple functions, and bind against the individual MFD cells.
That would also get rid of the nr_ports loop in the IDE driver, as each
instance would have its own cell.

I played with this a long time ago, but never finished it.
It worked fine for my Ariadne Ethernet card.
Last state at
https://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git/log/?h=zorro-mfd

Oh, seems I wrote up most of this before in
https://lore.kernel.org/lkml/CAMuHMdVe1KgQWYZ_BfBkSo3zr0c+TenLMEw3T=BLEQNoZ6ex7A@mail.gmail.com/

> +       { 0 }
> +};

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
