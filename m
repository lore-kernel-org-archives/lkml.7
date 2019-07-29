Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DBC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC6C2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 11:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbfG2L7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 07:59:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46602 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387637AbfG2L7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 07:59:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id z1so61509201wru.13;
        Mon, 29 Jul 2019 04:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BVl2KLYRX2yB17JNvSA0Y0othA+CXNCz/bd+X3xpONM=;
        b=OpCaknbrXm7ObkiZcLtnOQi1s2Fh1siUnRa6zn8qTItpPWJ7wtjJgp2RPcJ2oU+dbn
         C25yMFDOxbM0LIIwBIV7wxoaDjCuhEbgrisYgp/Sjp3GTE33XMyGHeZzS1DNeOSBxsRa
         xCYsl3fKw7Kmq5WDoncQXY4sswj/fPtKlGvsqHupj8szrycrdTzdK6QqscYX61BzozOX
         dyBCFlweuH6PHZO4FkP2RAKc7IB8zVM+x4C/lFR6d7eRw4eIgO0X1cXJ7qJSvmtSpvae
         eOaH2nQmCG6rmpyJRwUb2ayraU6X8Ht5nO/1v6Bx6PrikcDDWR4Z/iOQR/ylutHO5P2G
         A14w==
X-Gm-Message-State: APjAAAWV1CjjyVZIy7BHmYQ6TO74xGZKMK3jM4OjO1r2NLKIktNospfJ
        GxVfmAByeWKY5/1hgUvy06aW8SDd33KfdQph5pv/Kw==
X-Google-Smtp-Source: APXvYqyanqfn7CaWIZrT3E4bP6/81ouZsZd30WX/e+Yg8T3jSDGsz2eEroLIU5Y8dZlk89dDgguuS+2sM2JZGHTWq5A=
X-Received: by 2002:a5d:4b91:: with SMTP id b17mr446298wrt.57.1564401539861;
 Mon, 29 Jul 2019 04:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190725180825.31508-1-max@enpas.org> <CAMuHMdURm-9nazOBTL8uRH8WMt7gi=QUYy0qr9kaxzczCr+ujg@mail.gmail.com>
 <9cde6e79-52da-e0c0-f452-6afc2e5fa5ee@enpas.org> <CGME20190729113035epcas2p213400dfb13ca10b4f24cedf856cf2187@epcas2p2.samsung.com>
 <CAMuHMdUGsfzQg8xy2OqWfuo09MxwZ5OJz=t5CARJp+A1ZVtqaA@mail.gmail.com> <3fb686e0-1f60-b7c3-5b88-83f63e56a563@samsung.com>
In-Reply-To: <3fb686e0-1f60-b7c3-5b88-83f63e56a563@samsung.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 29 Jul 2019 13:58:48 +0200
Message-ID: <CAMuHMdXJc9RJx-Ntb9KCcJKoWPMDAsvqJMYLUOLvwEhVt8KBJg@mail.gmail.com>
Subject: Re: [PATCH v3] ata/pata_buddha: Probe via modalias instead of initcall
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Max Staudt <max@enpas.org>, Jens Axboe <axboe@kernel.dk>,
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

Hi Bartlomiej,

On Mon, Jul 29, 2019 at 1:52 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> On 7/29/19 1:30 PM, Geert Uytterhoeven wrote:
> > On Mon, Jul 29, 2019 at 1:10 PM Max Staudt <max@enpas.org> wrote:
> >> On 07/29/2019 11:05 AM, Geert Uytterhoeven wrote:
> >>>> --- a/drivers/ata/pata_buddha.c
> >>>> +++ b/drivers/ata/pata_buddha.c
> >>>
> >>>> +static const struct zorro_device_id pata_buddha_zorro_tbl[] = {
> >>>> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_BUDDHA, },
> >>>> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_CATWEASEL, },
> >>>> +       { ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, },
> >>>
> >>> drivers/net/ethernet/8390/zorro8390.c also matches against
> >>> ZORRO_PROD_INDIVIDUAL_COMPUTERS_X_SURF, while only
> >>> a single zorro_driver can bind to it.  Hence you can no longer use both
> >>> IDE and Ethernet on X-Surf :-(
> >>> Before, this worked, as the IDE driver just walked the list of devices.
> >>
> >> Okay, now this gets dirty.
> >>
> >> The reason why I've submitted this patch is to allow pata_buddha to be built into the kernel at all. Without this patch, its initcall would be called before the Zorro structures are initialised, hence not finding any boards.
> >
> > IC. I wasn't aware of the new pata_buddha.c driver not working at all
> > when builtin.
>
> Isn't the same true also for old buddha.c driver?
> (please see below)

> >> What shall I do? Maybe as a stop-gap measure, we could hard-code a
> >> module_init() again, just for X-Surf? It's been good enough until a
> >> few weeks ago, so what could go wrong ;)
> >
> > In the short run: keep on using drivers/ide/buddha.c?
>
> IDE subsystem is initialized even before libata so I cannot see how
> this would help?
>
> drivers/Makefile:
> ...
> obj-$(CONFIG_IDE)               += ide/
> obj-y                           += scsi/
> obj-y                           += nvme/
> obj-$(CONFIG_ATA)               += ata/
> ...
> obj-$(CONFIG_ZORRO)             += zorro/
> ...
>
> What am I missing?

Oops, that might be an incorrect assumption on my side...
(note to myself: never assume existing code is actually working as
expected ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
