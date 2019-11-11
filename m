Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F9EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D19520659
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 20:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH7tBeUV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfKKUgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 15:36:14 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33245 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbfKKUgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 15:36:12 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so728764wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 12:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Hs8WKz86XzUIoluSOZo0Sxzyo8CVkAKNCavkYaNLGw=;
        b=QH7tBeUVEVlA5jM/gxqSk27QzuUocFCCtBKHp/KhmIws/ve+jW1kwLgGQock2xhwDo
         pMPHUSBY5mQhQk1dGlDAwzsNulaz1U8qi4iOAbC0AdV/qxkS7BZKJMA1G6yLPNpEbbf9
         w+th7huiKfGVn9FmXt9B4THl2ZFnhaXr6a2uX/gZFmvyQIVT6ARZ/Qcel4NfYtlXqdbs
         6pRsyVqwM7PI7IRHzJPvCo5o2aTR+angYBjSXjDmIdn3ummriEKZoa6PKJ3TUn52jQ56
         1c332P4a5VI7jtGXiEOn3rKBPOrnrswHLDd6BQGZ2CIV2YFXFGRA0msz7Ji0hr7U5C5P
         6h7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Hs8WKz86XzUIoluSOZo0Sxzyo8CVkAKNCavkYaNLGw=;
        b=suhNoNqcbs88GZmYipoeHvqHhPHlsq8eAIlTvIeiZMIj56pwD+OMk+xfo9uCiGiNC4
         q+9rp5meUass68gWfvT8HBCJf4/5V2IEsfHshNhGOWwz2vYZXC7b3l5Z3u9H8E76Hxez
         D5qXuaya+kQteeGH9OetscuPHPGs+vkRQ3hkZ7rTgMr5m3Zr/2ogIQGgwfU/L5Uoj+Md
         sEGCa5MtrmBREnXbAbxyEK6Q0HVZfI5OjO1u+ksW+iwSPWgo4P4BkeEyv95eGOz7cAWm
         9HWcXb/zwIpt7QxZMjbOj4SfwaUpZhvgKvKhzOhoQJEBs1AcVfVO66DB65te3UUPPczH
         tV1g==
X-Gm-Message-State: APjAAAUKzA9lUSysu7bTD2XtQwWrIeNIMvd0fMtoR98raVvOD4+u06yf
        Al97Gqb7zWKoj5PWJ8ZxudEgZqaR/G+2l3Ts5ng=
X-Google-Smtp-Source: APXvYqwlG/2OIQhaPChGUJzXk1eNkMHqGbXaIe3aV9yzHDBxGh6AxWYo/M0y57THQ4STLSIuzBPpulqUP/0eKpB6Ic8=
X-Received: by 2002:a7b:c408:: with SMTP id k8mr754117wmi.67.1573504570718;
 Mon, 11 Nov 2019 12:36:10 -0800 (PST)
MIME-Version: 1.0
References: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
In-Reply-To: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 11 Nov 2019 15:35:58 -0500
Message-ID: <CADnq5_PL1y0O=w6DcZ4uq7B8tJxFx-KpTEr+m2-vVz+d64sVbQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Clean up code in radeon_pci_shutdown()
To:     Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
Cc:     Chunming Zhou <David1.Zhou@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 3:29 PM Kyle Mahlkuch
<kmahlkuc@linux.vnet.ibm.com> wrote:
>
> From: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
>
> This fixes the formatting on one comment and consolidates the
> pci_get_drvdata() into the radeon_suspend_kms().
>
> Signed-off-by: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
> index 4528f4d..357d29a 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -379,10 +379,6 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>  static void
>  radeon_pci_shutdown(struct pci_dev *pdev)
>  {
> -#ifdef CONFIG_PPC64
> -       struct drm_device *ddev = pci_get_drvdata(pdev);
> -#endif
> -
>         /* if we are running in a VM, make sure the device
>          * torn down properly on reboot/shutdown
>          */
> @@ -390,13 +386,14 @@ static int radeon_pci_probe(struct pci_dev *pdev,
>                 radeon_pci_remove(pdev);
>
>  #ifdef CONFIG_PPC64
> -       /* Some adapters need to be suspended before a
> +       /*
> +        * Some adapters need to be suspended before a
>          * shutdown occurs in order to prevent an error
>          * during kexec.
>          * Make this power specific becauase it breaks
>          * some non-power boards.
>          */
> -       radeon_suspend_kms(ddev, true, true, false);
> +       radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
>  #endif
>  }
>
> --
> 1.8.3.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
