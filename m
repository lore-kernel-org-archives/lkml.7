Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C44DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A61F21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfD3L7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:59:55 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:40068 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfD3L7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:59:51 -0400
Received: by mail-vk1-f196.google.com with SMTP id l17so3026917vke.7;
        Tue, 30 Apr 2019 04:59:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68G41fzqy/t8KAzyAUuR7DOWW+Zvyi6v+m6lvfvvc+0=;
        b=Avz5LXAVgTu/W4Tll+6H17nun9by9PM3UnmeIs9qcFKhS4s2ENyc25V1ItsYeOOrJf
         M2bwTH3BV766g+AjXsWbhx/rskvnirHtZoE+dFF6dXKSDWIcMW3OXLqjZ/XBhSFcjAX6
         biiuuo++/4LMeJy4/WylFfkULHklOhGNEvMXdWtdU0eh10euO41V55fMAViI0RFnshqT
         tZ7P3+8BwRW/hWDnkXWep3fjFuAnudlqBR81h0verHToztgS4AizEQg/kt5OPU7as8Tp
         NGtSrVcfBEMIuHzNuZrTOBSYjKdCsgC8EvXLuHfskI2RaDXfv7DQx741XVhglNidi7ll
         CdwA==
X-Gm-Message-State: APjAAAXV/iJX+OyPjEgOf5JhVgofaDq6lvaliXtkSmj1JfcN6cp8vnL9
        Qn0UC2f06acLpBhJu4QtQD2CsvdUHnpsXXyQ/z0=
X-Google-Smtp-Source: APXvYqygIlklTnbIk6rM0U9zkVtPflbEuf3kSFG/GNNQnmU5aiEFoRpZdVM+Sii2SE3lHQP9DwnZPtD6ccV2tu1UN/s=
X-Received: by 2002:a1f:17cd:: with SMTP id 196mr660349vkx.83.1556625590532;
 Tue, 30 Apr 2019 04:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190429152006.22593-1-geert+renesas@glider.be>
 <20190429152006.22593-3-geert+renesas@glider.be> <3ecf87e2-4e70-9159-a364-d41f1b744f7b@cogentembedded.com>
In-Reply-To: <3ecf87e2-4e70-9159-a364-d41f1b744f7b@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 30 Apr 2019 13:59:39 +0200
Message-ID: <CAMuHMdV3DNqDmTVHzmenS_jecnijx8bAjTV_7RRtTPEzg+uJ+Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] irqchip/renesas-irqc: Remove devm_kzalloc()/ioremap_nocache()
 error printing
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On Tue, Apr 30, 2019 at 10:12 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 29.04.2019 18:20, Geert Uytterhoeven wrote:
> > There is no need to print a message if devm_kzalloc() or
>
>     Just kzalloc() in this case.

Thanks, silly copy-and-paste error.

> > --- a/drivers/irqchip/irq-renesas-irqc.c
> > +++ b/drivers/irqchip/irq-renesas-irqc.c
> > @@ -173,7 +172,6 @@ static int irqc_probe(struct platform_device *pdev)
> >       /* ioremap IOMEM and setup read/write callbacks */
> >       p->iomem = ioremap_nocache(io->start, resource_size(io));
> >       if (!p->iomem) {
> > -             dev_err(&pdev->dev, "failed to remap IOMEM\n");
> >               ret = -ENXIO;
>
>     -ENOMEM?

I'd say yes, except that this error code is removed in patch [5/5], so I don't
think it's worth changing it in this patch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
