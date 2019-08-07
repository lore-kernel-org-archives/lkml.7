Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E09C19759
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5271F229F3
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 08:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQ0RgEnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbfHGIlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 04:41:42 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41649 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbfHGIll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 04:41:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id d24so84670887ljg.8;
        Wed, 07 Aug 2019 01:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eYs/hQ3Y9LNfDGfBwcEVi7jKWGv89xUHBEJ8ouLAv+k=;
        b=kQ0RgEnpAFC5CMzVJfhYi9nPHrh0w5+cXUjSBBYDhgTZ8497vE2tCTzV/bQ4HlC8LS
         vHu8ar8KSPjGI3fz819BSYQjXu9sLeuNcK1JCyLfeNOEEl5gUo3uq4l9Spc3SZ0qNLWX
         RRKcRRPsHVI8ZrWf6KgQ49/PH6BslLzpM8MEUWsM7IyrAMHmXOcwIJ+k4Vp8x1A6q4db
         wjnA9URJbuaAhiO93dKv6xhmv2gI73DPxoJG2a11fDNkS8YzmV+6ihxCHs1s6F/RUKy6
         pPtVh3AyTgL5MzM9xqRJv6KlPtsQdJQmPOEmoJjPro5Zf1h9wziybDyGzc/1y49nqCZG
         Ay6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eYs/hQ3Y9LNfDGfBwcEVi7jKWGv89xUHBEJ8ouLAv+k=;
        b=JUWb+01G7sWTqwAW33YTLEr89KTa7UFKaJz1RAxdqRP20t1YdiG1zoN2/n+F2V5GuF
         zvJOGFg7SeKQgT6pS6eJG0QcqFiHQrLvG065oecAVaERoqEiMCUUX/3yOw2wusdZebe8
         X1BUgnHV4dRvdf0hEch7I1ClgjkcqqGrYUzQ7YPUS0xiYGNd/ZNALVW/btwa1JkQhqtN
         g6hBdukKwYHVbt+nYsnOrMESlfd77c9imr+C3AqufDNkIXxFMUVSkyyUq46muaKQpz4V
         fuaFtR7xgKVVxIwNLtl6jVISpz9hhxmw8PxVxEfmA76gJ5tgk4SvzYpzYEUc95Wi7ANV
         1/vA==
X-Gm-Message-State: APjAAAVXnKP/WN/8kVdJb07JozyTSrHHfoLhZogt9aNr6zkY8CWljFx1
        Mj0q23khzyhMBcErQ78T7PICKVL8KbTBK+gqBSQ=
X-Google-Smtp-Source: APXvYqyVOVGtiZzZb0C8zEOAb896AFsHxLnvz2H4GMAhBW2sjDWWEslMf/XyRcI9iSzv92vqZUIs05pv6SdtEdUML4I=
X-Received: by 2002:a2e:93cc:: with SMTP id p12mr4278994ljh.11.1565167299490;
 Wed, 07 Aug 2019 01:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <1564515200-5020-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1564515200-5020-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 7 Aug 2019 14:11:27 +0530
Message-ID: <CAFqt6zb5ySDbkHVpPkOKHTrF8jFuNh=dXtnwPKO6TuEHBCkYgg@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev:via: Remove dead code
To:     FlorianSchandinat@gmx.de, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 12:59 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> This is dead code since 3.15. If there is no plan to use
> it further, this can be removed forever.
>

Any comment on this patch ?

> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/video/fbdev/via/via-core.c | 43 --------------------------------------
>  1 file changed, 43 deletions(-)
>
> diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
> index e2b2062..ffa2ca2 100644
> --- a/drivers/video/fbdev/via/via-core.c
> +++ b/drivers/video/fbdev/via/via-core.c
> @@ -221,49 +221,6 @@ void viafb_release_dma(void)
>  }
>  EXPORT_SYMBOL_GPL(viafb_release_dma);
>
> -
> -#if 0
> -/*
> - * Copy a single buffer from FB memory, synchronously.  This code works
> - * but is not currently used.
> - */
> -void viafb_dma_copy_out(unsigned int offset, dma_addr_t paddr, int len)
> -{
> -       unsigned long flags;
> -       int csr;
> -
> -       mutex_lock(&viafb_dma_lock);
> -       init_completion(&viafb_dma_completion);
> -       /*
> -        * Program the controller.
> -        */
> -       spin_lock_irqsave(&global_dev.reg_lock, flags);
> -       viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_DONE);
> -       /* Enable ints; must happen after CSR0 write! */
> -       viafb_mmio_write(VDMA_MR0, VDMA_MR_TDIE);
> -       viafb_mmio_write(VDMA_MARL0, (int) (paddr & 0xfffffff0));
> -       viafb_mmio_write(VDMA_MARH0, (int) ((paddr >> 28) & 0xfff));
> -       /* Data sheet suggests DAR0 should be <<4, but it lies */
> -       viafb_mmio_write(VDMA_DAR0, offset);
> -       viafb_mmio_write(VDMA_DQWCR0, len >> 4);
> -       viafb_mmio_write(VDMA_TMR0, 0);
> -       viafb_mmio_write(VDMA_DPRL0, 0);
> -       viafb_mmio_write(VDMA_DPRH0, 0);
> -       viafb_mmio_write(VDMA_PMR0, 0);
> -       csr = viafb_mmio_read(VDMA_CSR0);
> -       viafb_mmio_write(VDMA_CSR0, VDMA_C_ENABLE|VDMA_C_START);
> -       spin_unlock_irqrestore(&global_dev.reg_lock, flags);
> -       /*
> -        * Now we just wait until the interrupt handler says
> -        * we're done.
> -        */
> -       wait_for_completion_interruptible(&viafb_dma_completion);
> -       viafb_mmio_write(VDMA_MR0, 0); /* Reset int enable */
> -       mutex_unlock(&viafb_dma_lock);
> -}
> -EXPORT_SYMBOL_GPL(viafb_dma_copy_out);
> -#endif
> -
>  /*
>   * Do a scatter/gather DMA copy from FB memory.  You must have done
>   * a successful call to viafb_request_dma() first.
> --
> 1.9.1
>
