Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59FAC3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71E921855
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 16:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhnqbmSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfHRQ7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 12:59:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47025 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbfHRQ7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 12:59:53 -0400
Received: by mail-lf1-f67.google.com with SMTP id n19so7235519lfe.13;
        Sun, 18 Aug 2019 09:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1XLrmrHnxtun5E7MsD/TIJ4RWoKU+eFXlhCg4SB19I=;
        b=rhnqbmSuOY+3ZUyzlxvqIAPQ1XFULeoa/WbnYJFklorm8v700suEGO7RolfnDsPu0j
         0sVcYqTlNxP6GIcJigTatwt/g2ces8dcLQZJoZyO4grYu9m4TdhvYOIpZ4kd7KMtW0OR
         JRrgrKRO61SLRaACmkHAfRujvGQOpqeio/GD+vRfSdVsqqr0FZDEWmhXrP6WUzeBWj17
         wi/JKS2nekHQTnjdpktZ//KtAKa2QVmU0gvkwAle+NZSOoq/7+4/B6llPitWvk24UmTx
         YIGjzdzYj3s5xu5+2FB/tLFTfBlRNXS7qifdvOV2G7jNt602TzRGwvIETkne1JYutvwF
         yoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1XLrmrHnxtun5E7MsD/TIJ4RWoKU+eFXlhCg4SB19I=;
        b=U72Zqg4/J+yhb+XdDtVuX6EG3LfhI3YX5dVPU9KDmk72v2Il/C1A2Gu4zGPONKSK4x
         GGkrNBq6H4Eh2LnpVpHZGbNzyyb/qyIEitzPmLzs/ay/8aKSxAvNhP5mcjyGQbDGQLfb
         U8Tr0hNHVc8+yfWE4A42uNTmA8NOw7okWPjH/9TxcVB0Z71QfW51qDrH505R5I39Aak4
         FTnapV6cnsvbB6c+Fyt1+ESVZI5XhOGDIifsakmqzaCxItHkxlpPJPAR43MpYBgYFGMl
         MvhBxLb8ECTqh2XeSXLFoNXNbvOA3oHoyV/eIEc50hcV7HVBql0cRhzOEPTCIwfFpDsi
         7QBA==
X-Gm-Message-State: APjAAAXNPqAG2ToeDJvale1gdyWVh+UQHnouSWI8q0cDni9ZaSWPLMNw
        nLyshX1K+uapxjC3Sw8YpconykHFAyUeU7AfUHk=
X-Google-Smtp-Source: APXvYqwokMINd0UH74GIpnd7io2ObKo5H7IBPFeCJ0QR+2t7jvX04nrJBuQQCcAlAVBzKURgEstM9cKCJfuNVAKHFNo=
X-Received: by 2002:ac2:484e:: with SMTP id 14mr9995204lfy.50.1566147590405;
 Sun, 18 Aug 2019 09:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <1564515200-5020-1-git-send-email-jrdr.linux@gmail.com>
 <CAFqt6zb5ySDbkHVpPkOKHTrF8jFuNh=dXtnwPKO6TuEHBCkYgg@mail.gmail.com> <CAFqt6zYsA_0YpZcZ8+LrMEjeWDJ5mwUDJNvqOW1H4ewgKbp+aQ@mail.gmail.com>
In-Reply-To: <CAFqt6zYsA_0YpZcZ8+LrMEjeWDJ5mwUDJNvqOW1H4ewgKbp+aQ@mail.gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sun, 18 Aug 2019 22:29:38 +0530
Message-ID: <CAFqt6zYrX-5d8yYVwesYBPWQZK4iXPPv=2w7dqBtHvF9c1WJHA@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev:via: Remove dead code
To:     FlorianSchandinat@gmx.de, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 5:37 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> On Wed, Aug 7, 2019 at 2:11 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Wed, Jul 31, 2019 at 12:59 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> > >
> > > This is dead code since 3.15. If there is no plan to use
> > > it further, this can be removed forever.
> > >
> >
> > Any comment on this patch ?
>
> Any comment on this patch ?

If no comment can we get this in queue for 5.4 ?

>
> >
> > > Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> > > ---
> > >  drivers/video/fbdev/via/via-core.c | 43 --------------------------------------
> > >  1 file changed, 43 deletions(-)
> > >
> > > diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
> > > index e2b2062..ffa2ca2 100644
> > > --- a/drivers/video/fbdev/via/via-core.c
> > > +++ b/drivers/video/fbdev/via/via-core.c
> > > @@ -221,49 +221,6 @@ void viafb_release_dma(void)
> > >  }
> > >  EXPORT_SYMBOL_GPL(viafb_release_dma);
> > >
> > > -
> > > -#if 0
> > > -/*
> > > - * Copy a single buffer from FB memory, synchronously.  This code works
> > > - * but is not currently used.
> > > - */
> > > -void viafb_dma_copy_out(unsigned int offset, dma_addr_t paddr, int len)
> > > -{
> > > -       unsigned long flags;
> > > -       int csr;
> > > -
> > > -       mutex_lock(&viafb_dma_lock);
> > > -       init_completion(&viafb_dma_completion);
> > > -       /*
> > > -        * Program the controller.
> > > -        */
> > > -       spin_lock_irqsave(&global_dev.reg_lock, flags);
> > > -       viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_DONE);
> > > -       /* Enable ints; must happen after CSR0 write! */
> > > -       viafb_mmio_write(VDMA_MR0, VDMA_MR_TDIE);
> > > -       viafb_mmio_write(VDMA_MARL0, (int) (paddr & 0xfffffff0));
> > > -       viafb_mmio_write(VDMA_MARH0, (int) ((paddr >> 28) & 0xfff));
> > > -       /* Data sheet suggests DAR0 should be <<4, but it lies */
> > > -       viafb_mmio_write(VDMA_DAR0, offset);
> > > -       viafb_mmio_write(VDMA_DQWCR0, len >> 4);
> > > -       viafb_mmio_write(VDMA_TMR0, 0);
> > > -       viafb_mmio_write(VDMA_DPRL0, 0);
> > > -       viafb_mmio_write(VDMA_DPRH0, 0);
> > > -       viafb_mmio_write(VDMA_PMR0, 0);
> > > -       csr = viafb_mmio_read(VDMA_CSR0);
> > > -       viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_START);
> > > -       spin_unlock_irqrestore(&global_dev.reg_lock, flags);
> > > -       /*
> > > -        * Now we just wait until the interrupt handler says
> > > -        * we're done.
> > > -        */
> > > -       wait_for_completion_interruptible(&viafb_dma_completion);
> > > -       viafb_mmio_write(VDMA_MR0, 0); /* Reset int enable */
> > > -       mutex_unlock(&viafb_dma_lock);
> > > -}
> > > -EXPORT_SYMBOL_GPL(viafb_dma_copy_out);
> > > -#endif
> > > -
> > >  /*
> > >   * Do a scatter/gather DMA copy from FB memory.  You must have done
> > >   * a successful call to viafb_request_dma() first.
> > > --
> > > 1.9.1
> > >
