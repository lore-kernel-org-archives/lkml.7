Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238B3C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED34B206CD
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWbri8oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfINTmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:42:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35267 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfINTmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:42:45 -0400
Received: by mail-lj1-f193.google.com with SMTP id q22so25544496ljj.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 12:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qEuJqEba5wd0EP42PfWTuZEN2nNByfuuSJHMeH7V5js=;
        b=aWbri8oFWimFKwzNLl8dD8A6uR8s9aQvkud0KLHl+/Mp6+B2kuy58ZTBrhHHdUKjH+
         tovVX+rYex0P9grYA2a2NmrGbZR1eWcimwHjPO1xq9VOhMfhiLrOSOUQPwKi0xG6pEtE
         JHkbbcJ0tXIna0YENdEvm+7q19wmgvTL99xjxxzAcWy9GA3LDorOp5Ac84lNJGCb8q6v
         Hse+RYCFyYDUvmo5CR+Vy2EIrfvqu2mAyzL7WqXHigJFjEZDA4oQGIoSoV1kMftxGiN1
         //HkC2b8mhyHwmrk/ufRQU165MsmG9sgL9y5gMjZgS+x1doMBIjMuKGVB0cbnAUrs7SB
         gL5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qEuJqEba5wd0EP42PfWTuZEN2nNByfuuSJHMeH7V5js=;
        b=jfSq9MAfghqX4oR/BHSUU2jE6nm+wDEisylAjv+JvY9EmJguZEhNVUvf9gqG6McfcX
         HUOj+OXWSE3PXZUUY+gNB+f+exv0uAEMNygcNpj5RGVuD/Mb/DhcaBAGpqi6mHAD7ZQd
         FspeOu6l+rwIdO0d8QW+PdsgSnJp3t6wsy2vurfQFVb1/C8Lh6BwyCeLB+QF/axQEm9/
         S2i2M19hlfxPkfa3LDMF1Mv3w3cRfjtquIguY3E7xTYAkzZa2dm/Jz6XV1+rLDFznqzx
         1XDHvjvz6XBjid1m4wGDF7MpKKPJ5zPFom01pxZt83JQMBvKJJkRnsJMzhYDzg5R0WHy
         cR0g==
X-Gm-Message-State: APjAAAWw3uR8ZTr3L2xOMz4V1/zr2ikxyneZGwo0ArVDsxWl4kxPBw81
        aIXaHe78uqfOy1XC6EHo+2S2Iu2pSWbstIbGB3Y=
X-Google-Smtp-Source: APXvYqynUVQ3mZD5qF/lIExEGnZb6E8RMFLC7y4Jg8vqFfQuMna5mylWQmzi2IwdYnXfInoF5GDMRhpiYjnxPw8Ug3M=
X-Received: by 2002:a2e:5d98:: with SMTP id v24mr34390435lje.56.1568490163906;
 Sat, 14 Sep 2019 12:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <529ec882-734f-17ae-e4cb-3aeb563ad1d5@bluespec.com> <mhng-c06cc89b-42d9-4f95-b090-2db96628d5fb@palmer-si-x1e>
In-Reply-To: <mhng-c06cc89b-42d9-4f95-b090-2db96628d5fb@palmer-si-x1e>
From:   Charles Papon <charles.papon.90@gmail.com>
Date:   Sat, 14 Sep 2019 21:42:32 +0200
Message-ID: <CAMabmMJ=QcH-529O6ORWbFwOrAnMKeWTvQ=WGYgnOoihqj9uFA@mail.gmail.com>
Subject: Re: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Darius Rad <darius@bluespec.com>, jason@lakedaemon.net,
        maz@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had issues with that plic driver. The current implementation wasn't
usable with driver using level sensitive interrupt together with the
IRQF_ONESHOT flag.

Those null were producing crashes in the chained_irq_enter function.
Filling them with dummy function fixed the issue.

On Sat, Sep 14, 2019 at 9:00 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 12 Sep 2019 14:40:34 PDT (-0700), Darius Rad wrote:
> > As per the existing comment, irq_mask and irq_unmask do not need
> > to do anything for the PLIC.  However, the functions must exist
> > (the pointers cannot be NULL) as they are not optional, based on
> > the documentation (Documentation/core-api/genericirq.rst) as well
> > as existing usage (e.g., include/linux/irqchip/chained_irq.h).
> >
> > Signed-off-by: Darius Rad <darius@bluespec.com>
> > ---
> >  drivers/irqchip/irq-sifive-plic.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> > index cf755964f2f8..52d5169f924f 100644
> > --- a/drivers/irqchip/irq-sifive-plic.c
> > +++ b/drivers/irqchip/irq-sifive-plic.c
> > @@ -111,6 +111,13 @@ static void plic_irq_disable(struct irq_data *d)
> >       plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
> >  }
> >
> > +/*
> > + * There is no need to mask/unmask PLIC interrupts.  They are "masked"
> > + * by reading claim and "unmasked" when writing it back.
> > + */
> > +static void plic_irq_mask(struct irq_data *d) { }
> > +static void plic_irq_unmask(struct irq_data *d) { }
> > +
> >  #ifdef CONFIG_SMP
> >  static int plic_set_affinity(struct irq_data *d,
> >                            const struct cpumask *mask_val, bool force)
> > @@ -138,12 +145,10 @@ static int plic_set_affinity(struct irq_data *d,
> >
> >  static struct irq_chip plic_chip = {
> >       .name           = "SiFive PLIC",
> > -     /*
> > -      * There is no need to mask/unmask PLIC interrupts.  They are "masked"
> > -      * by reading claim and "unmasked" when writing it back.
> > -      */
> >       .irq_enable     = plic_irq_enable,
> >       .irq_disable    = plic_irq_disable,
> > +     .irq_mask       = plic_irq_mask,
> > +     .irq_unmask     = plic_irq_unmask,
> >  #ifdef CONFIG_SMP
> >       .irq_set_affinity = plic_set_affinity,
> >  #endif
>
> I can't find any other drivers in irqchip with empty irq_mask/irq_unmask.  I'm
> not well versed in irqchip stuff, so I'll leave it up to the irqchip
> maintainers to comment on if this is the right way to do this.  Either way, I'm
> assuming it'll go in through some the irqchip tree so
>
> Acked-by: Palmer Dabbelt <palmer@sifive.com>
>
> just to make sure I don't get in the way if it is the right way to do it :).
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
