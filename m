Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BCFC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C93208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bm6JFeaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbfHLMHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:07:49 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38578 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfHLMHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:07:42 -0400
Received: by mail-lf1-f66.google.com with SMTP id h28so73976444lfj.5;
        Mon, 12 Aug 2019 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qOdEFC2M11gWaSPmcjDghbM0bbwUm04RK0v5uO2apg=;
        b=bm6JFeaJrLhrdxvwrgL87KoQHBHCewBcUoT2U/byVHVE3ObbAAy6bppBP1Nqiz4YWx
         PVT3ypwO0OkqNOcD5zyOeig2OqXTGd5gPHpwB+zawhlvxf5Or9WyAvnfeyPUOUtk7bGM
         3FtpbcGVEaSca+wwR7PRR0ZR7n1a82+rJl2EAVaPQaJRxJs9AffhXzO9UQGoWge/o9jh
         DhnJH2brcwMuBHEZObqjDOtHMb4ilsbmt6DkRoJYS25kZd9Fbc3JGSveoVNZ0750p8mm
         T0lShpIinpgE8k0zgEE9/+Bn7xgnnFf5qoKooFWRigATHI93FlUhCn9fp8Zkik4Q/+n6
         GgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qOdEFC2M11gWaSPmcjDghbM0bbwUm04RK0v5uO2apg=;
        b=CQiWhA+thKLQ+L9c29gGP5Hcf3388jlTIZ8hWruFG6WFrDmbEU+tosF/wnBxdyCdke
         NffvkzMlL/ZK/KyrJi+0/eB/prF7DU7xEELrJEcrUy2nEB37nMJdcOJIcIdH55zHDG3a
         qRiBtLApGhm31dK3fuuPEXBFhyU3mf/8mYVfkkmzqlKJxuvHut9IO1eid/Rr/fIL+M06
         3qgBuxP1OV53ik4A3a4ONsFW3Rs3lLdnSyjupYecnBQLxRh0I+FypBW/zudINpf7ASdL
         eydaWOwftuVTOhJ8pN7YdnewEe3o0ClouNR/KnDDXrgzWtM3AGACQfqLOuegeAjgO4Ww
         pmwQ==
X-Gm-Message-State: APjAAAXvdUi755WIY4k/MZHoeLHpwaRDxUwuvYJYON5hWi/9A+VumS6n
        0QKn7F+GBvfX4YIlaAQ8CPxE6NyEkYF8uf/mFOnTWA==
X-Google-Smtp-Source: APXvYqz3B/76maiN8iU2SHYGuDc8LbEmLoZtKd5InqL2eR3IO1G+3shPVco9MXX/jUMEsG+IcnjuF7rHRLMod6Vfdq4=
X-Received: by 2002:ac2:484e:: with SMTP id 14mr19367643lfy.50.1565611659997;
 Mon, 12 Aug 2019 05:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <1564515200-5020-1-git-send-email-jrdr.linux@gmail.com> <CAFqt6zb5ySDbkHVpPkOKHTrF8jFuNh=dXtnwPKO6TuEHBCkYgg@mail.gmail.com>
In-Reply-To: <CAFqt6zb5ySDbkHVpPkOKHTrF8jFuNh=dXtnwPKO6TuEHBCkYgg@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 12 Aug 2019 17:37:28 +0530
Message-ID: <CAFqt6zYsA_0YpZcZ8+LrMEjeWDJ5mwUDJNvqOW1H4ewgKbp+aQ@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev:via: Remove dead code
To:     FlorianSchandinat@gmx.de, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 7, 2019 at 2:11 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Wed, Jul 31, 2019 at 12:59 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > This is dead code since 3.15. If there is no plan to use
> > it further, this can be removed forever.
> >
>
> Any comment on this patch ?

Any comment on this patch ?

>
> > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > ---
> >  drivers/video/fbdev/via/via-core.c | 43 --------------------------------------
> >  1 file changed, 43 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
> > index e2b2062..ffa2ca2 100644
> > --- a/drivers/video/fbdev/via/via-core.c
> > +++ b/drivers/video/fbdev/via/via-core.c
> > @@ -221,49 +221,6 @@ void viafb_release_dma(void)
> >  }
> >  EXPORT_SYMBOL_GPL(viafb_release_dma);
> >
> > -
> > -#if 0
> > -/*
> > - * Copy a single buffer from FB memory, synchronously.  This code works
> > - * but is not currently used.
> > - */
> > -void viafb_dma_copy_out(unsigned int offset, dma_addr_t paddr, int len)
> > -{
> > -       unsigned long flags;
> > -       int csr;
> > -
> > -       mutex_lock(&viafb_dma_lock);
> > -       init_completion(&viafb_dma_completion);
> > -       /*
> > -        * Program the controller.
> > -        */
> > -       spin_lock_irqsave(&global_dev.reg_lock, flags);
> > -       viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_DONE);
> > -       /* Enable ints; must happen after CSR0 write! */
> > -       viafb_mmio_write(VDMA_MR0, VDMA_MR_TDIE);
> > -       viafb_mmio_write(VDMA_MARL0, (int) (paddr & 0xfffffff0));
> > -       viafb_mmio_write(VDMA_MARH0, (int) ((paddr >> 28) & 0xfff));
> > -       /* Data sheet suggests DAR0 should be <<4, but it lies */
> > -       viafb_mmio_write(VDMA_DAR0, offset);
> > -       viafb_mmio_write(VDMA_DQWCR0, len >> 4);
> > -       viafb_mmio_write(VDMA_TMR0, 0);
> > -       viafb_mmio_write(VDMA_DPRL0, 0);
> > -       viafb_mmio_write(VDMA_DPRH0, 0);
> > -       viafb_mmio_write(VDMA_PMR0, 0);
> > -       csr = viafb_mmio_read(VDMA_CSR0);
> > -       viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_START);
> > -       spin_unlock_irqrestore(&global_dev.reg_lock, flags);
> > -       /*
> > -        * Now we just wait until the interrupt handler says
> > -        * we're done.
> > -        */
> > -       wait_for_completion_interruptible(&viafb_dma_completion);
> > -       viafb_mmio_write(VDMA_MR0, 0); /* Reset int enable */
> > -       mutex_unlock(&viafb_dma_lock);
> > -}
> > -EXPORT_SYMBOL_GPL(viafb_dma_copy_out);
> > -#endif
> > -
> >  /*
> >   * Do a scatter/gather DMA copy from FB memory.  You must have done
> >   * a successful call to viafb_request_dma() first.
> > --
> > 1.9.1
> >
