Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B15C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4010F2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GZJEHsCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbfCNLWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:22:02 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:40722 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCNLWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:22:02 -0400
Received: by mail-it1-f193.google.com with SMTP id l139so4187236ita.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g89uGnwMKHAlF/Ze8V49mohWd9YCk6jNzWrTuvMUCxw=;
        b=GZJEHsCztaGZ1sKJfc72hWaswqU82lcnjixO5gDVFb5j9YktrUVmeaetNbhRP2IW3S
         a/UyFN3SaA4pfQjK5y3b21XG6SlgxK41uuHlFsJIjakOV0pjN72CSoRLWOtNPtSB2jvh
         S0iDuUtVWuTasV4fRomkqcOVxexZeHoN6HJW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g89uGnwMKHAlF/Ze8V49mohWd9YCk6jNzWrTuvMUCxw=;
        b=K0BG5BqX8/dC2ediEXME4/+suA87vjqLRhD/8X7B9gUbdrlriC9zH1syboJR4jshSH
         wJESkc5pvzPi2RnfEup/p9aWmNJDxbd1/XNwr6uGrsgZNH4GDVfEiGWfKKB4W4EmPrv1
         18JHQw7F3+xGow42h0DUqz8wCuPtlq8tSHKWUxVf8uSjr8HKTtw1dUlxiqiodXXgo+3P
         Bn8KzFsdpHNZvlmcmRYKx/nG/nrbzpuS4gUC3bCR+pts5xEoqe61NauOSbJcmYvu5Q2r
         NZeXWs7v+1HrGZ6hZilx+CUurgpFv5j8b5+gTj7fbKeStYE8KRagHZulIV/D2vHllTHw
         2MZQ==
X-Gm-Message-State: APjAAAWXRy9jBx0ZEbRg5niRGaJdnPYFaBoFg7k9PQUWdonY4cIf18Oa
        XsvONuO3Qj6X+bPNxwL+sBr0y+SnQ26vHK1u7eR+Uw==
X-Google-Smtp-Source: APXvYqxU5zSflSXa88/Ae79ndGydOO10EP/so+/3Q03Z2lHCs0N3bcZt2sXofYrrroEfZbjALw35ws1TSpf20rpWhK4=
X-Received: by 2002:a02:4802:: with SMTP id p2mr13952658jaa.8.1552562521632;
 Thu, 14 Mar 2019 04:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190313235211.28995-1-eric@anholt.net>
In-Reply-To: <20190313235211.28995-1-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Thu, 14 Mar 2019 11:21:50 +0000
Message-ID: <CAApk1dWqPtCem_BHYVKY47TR8GtvDivY_kg0fv+w+gBZZPnNqA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/v3d: Add a note about OOM vs FRDONE, which may be
 racing on v3.3.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2019 at 23:52, Eric Anholt <eric@anholt.net> wrote:
>
> We deref v3d->bin_job in the work handler, but v3d->bin_job doesn't
> actually hold a ref on the job.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_irq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_irq.c b/drivers/gpu/drm/v3d/v3d_irq.c
> index b4d6ae81186d..a09442ec7297 100644
> --- a/drivers/gpu/drm/v3d/v3d_irq.c
> +++ b/drivers/gpu/drm/v3d/v3d_irq.c
> @@ -87,7 +87,8 @@ v3d_irq(int irq, void *arg)
>         if (intsts & V3D_INT_OUTOMEM) {
>                 /* Note that the OOM status is edge signaled, so the
>                  * interrupt won't happen again until the we actually
> -                * add more memory.
> +                * add more memory.  Also, as of V3D 4.1, FRDONE won't
> +                * be reported until any OOM state has been cleared.
Strictly speaking it's FLDONE for bins.


>                  */
>                 schedule_work(&v3d->overflow_mem_work);
>                 status = IRQ_HANDLED;
> --
> 2.20.1
>
