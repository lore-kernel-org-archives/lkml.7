Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E27C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCEA02199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hP5neMly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfGVI1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:27:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44253 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfGVI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:27:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id k18so36702686ljc.11;
        Mon, 22 Jul 2019 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nj8hr54aC91iZO9zPn8MMR4EigRoMAm4mTd0A3+k1NE=;
        b=hP5neMlyz+5e+2U8xDlE89eOLeTQWHaifGHF/QjpvKArO1BhhnEsqT7HfLg9KGm/qq
         qIlacbQp7CcFspokSaYv541f0QtAhFynrZGozw8oMU/qBIcvkfJVZrU4S+SJm6VYc0aX
         f8zJTvmroLD6bt+a1ZpBpbYye4JVoJ7yalM9I7ypuMDnyA0XSGC82n76FuLSIvytLjje
         nEI58UEqbDznzAcxz+0ma6vKfsFuhxI6cFn73UmXAaHE2NTYJviyzBaph9Edaq4c2CGw
         6nNbCothbaDr1NUvgUJhDFKig8UrVfqLN8Ab8baYlI+iCE/Dmi4LfZaMwjBw+8Z92hwC
         7Sjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nj8hr54aC91iZO9zPn8MMR4EigRoMAm4mTd0A3+k1NE=;
        b=oTCvTemefJDynsfVCLVRsbIb/IdjFGafp2WGBxF1SOIm1aIbXPDomsSfSIoXlOx5Pf
         +o8nshC02K9av8wqAON4UnIu1Om248GTbV+3s0iOaYTqbfRFiY/0JXibT/aH2jNPHoyh
         XCOeGpepS1WF/PVX2WKP3xDG4bg1TR8suBMxQyGyseHpOi2bVVm8vMpGUWBFFiIXwvus
         B0ue8xE94G0EVB7HHTOxSSw7jytzywlMnNs4KfPosPXnHi4iPea2NUhZky3eR0deD3By
         0m3byT3SM+u9YnRVDmCN8xaSI0yGm56d9ilwxWDcxhpHEe0crPt9wETAESpWQqF0dHWW
         xcTQ==
X-Gm-Message-State: APjAAAWZeRHoGVyWxI92+RirlCGluXRkzSWKpfz8x/wYed3CxSO2XK9D
        VTXEVRynHJb/jskzMEvlVt7Lgt8OErhL103KLGA=
X-Google-Smtp-Source: APXvYqwyDiZeM7CIZXMroBkoG2dnBbbNmuL1qR3F0kaVqk9dbQIfb9/GjjWTnFV6oLhY9burQ68yiDemISxthkZmRUM=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr24641129ljk.152.1563784023026;
 Mon, 22 Jul 2019 01:27:03 -0700 (PDT)
MIME-Version: 1.0
References: <1562782586-3994-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1562782586-3994-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 22 Jul 2019 13:56:51 +0530
Message-ID: <CAFqt6zaNcNdxcT2WLOvL0LTX_R9ShRNx6UW6s4k+wc=Zj2MaSg@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: nvidia: Remove dead code
To:     adaplas@gmail.com, b.zolnierkie@samsung.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 11:41 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> This is dead code since 3.15. If there is no plan to use it
> further, this can be removed forever.

Any comment on this patch ?

>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> ---
>  drivers/video/fbdev/nvidia/nv_setup.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
>
> diff --git a/drivers/video/fbdev/nvidia/nv_setup.c b/drivers/video/fbdev/nvidia/nv_setup.c
> index b17acd2..2fa6866 100644
> --- a/drivers/video/fbdev/nvidia/nv_setup.c
> +++ b/drivers/video/fbdev/nvidia/nv_setup.c
> @@ -119,34 +119,10 @@ u8 NVReadMiscOut(struct nvidia_par *par)
>  {
>         return (VGA_RD08(par->PVIO, VGA_MIS_R));
>  }
> -#if 0
> -void NVEnablePalette(struct nvidia_par *par)
> -{
> -       volatile u8 tmp;
> -
> -       tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
> -       VGA_WR08(par->PCIO, VGA_ATT_IW, 0x00);
> -       par->paletteEnabled = 1;
> -}
> -void NVDisablePalette(struct nvidia_par *par)
> -{
> -       volatile u8 tmp;
> -
> -       tmp = VGA_RD08(par->PCIO, par->IOBase + 0x0a);
> -       VGA_WR08(par->PCIO, VGA_ATT_IW, 0x20);
> -       par->paletteEnabled = 0;
> -}
> -#endif  /*  0  */
>  void NVWriteDacMask(struct nvidia_par *par, u8 value)
>  {
>         VGA_WR08(par->PDIO, VGA_PEL_MSK, value);
>  }
> -#if 0
> -u8 NVReadDacMask(struct nvidia_par *par)
> -{
> -       return (VGA_RD08(par->PDIO, VGA_PEL_MSK));
> -}
> -#endif  /*  0  */
>  void NVWriteDacReadAddr(struct nvidia_par *par, u8 value)
>  {
>         VGA_WR08(par->PDIO, VGA_PEL_IR, value);
> --
> 1.9.1
>
