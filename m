Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3091BC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0888320705
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3nD0GB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgAHJMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:12:48 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34735 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgAHJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:12:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id z22so2570002ljg.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSRXBmbI4K9SJWTndImb6/QuzMsMIzFzBHbV5ZWEJ8g=;
        b=V3nD0GB4Xcs+Bk2fajfsc/L0TAJmnRzgImnFRpf94E3COREr1g6UzDhtf2aMxtdYlh
         28sdhiGJ3TKb33HK76E+bwxi0vgF5GpQ0gOyCazOnmYTswARFDkErWkncOl9BSrLHteu
         1C7TmLu2JpvR8xAeIzMijnuDoTUSOprW11/ufFflVrRC087MeX5VNhldArAm64qZMZul
         TmpwLdoRwiL4VEkpdjKc+lWbljyQio+67ZhQmC2zt/DKS5flWg0R+fXBChu1pFn6culH
         l65wG2yqKdwc+2RPlD62iqkUuI79TLzsn6pvusXN0gOVePsjzazHrzFV0G+KZJ9PIcNb
         N1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSRXBmbI4K9SJWTndImb6/QuzMsMIzFzBHbV5ZWEJ8g=;
        b=hNic6PYusPZDyMWXDdEQGt2ao8t7cuAYJSR7s8/7j6qS+hGTzIsASYwOeEiA9v0zZt
         XTNotTJW6SieQyFDnir3BV/uk3oPSCMVIESE1RbToFkdR57jc99tDx37Gsr8kfxJay/L
         OQk1LctJfgdVGMVeCKsWRWDFqkNWH+I1+Cl8Xxjc2YfQZFh0FvjyHNHGkUsSLuzGM5No
         FRi9M8nkhAylT6QRN3pzZLE0mNzs6u/qOK+W/9OspRoWLaiyD9UWQV7Jktfmmp+LVwzd
         webzSeyLJHn1gqARmLcDzD8z0RlAkFVMG8ELF5wn7mGuqT6pns5sZqGKkLGcrcKWMoo8
         6ZuQ==
X-Gm-Message-State: APjAAAVLfp+niLz63+mVAYkBFX41CiyrY9fWVKhf7dQoDrkN5Kld1BuE
        GK+2wW1qSKnkpnz4tIOVvflrC8uR8c7AGCHfrNU=
X-Google-Smtp-Source: APXvYqxpyQq/UHQabiIuF0OTy3EUrOivAw+JIegqNL6S3XfcYZPfmTToE1h8OTmr2MLDXAAjlUZxueDRFDuVv2RTBzM=
X-Received: by 2002:a05:651c:1214:: with SMTP id i20mr2287435lja.107.1578474766167;
 Wed, 08 Jan 2020 01:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20191227114811.14907-1-chenzhou10@huawei.com>
In-Reply-To: <20191227114811.14907-1-chenzhou10@huawei.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Wed, 8 Jan 2020 10:12:35 +0100
Message-ID: <CAMeQTsY2+9Z1ShVrp1AbQo4+VbVymHrv2meg7353=YDoWbFeLw@mail.gmail.com>
Subject: Re: [PATCH next] drm/gma500: remove set but not used variables 'hist_reg'
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 12:52 PM Chen Zhou <chenzhou10@huawei.com> wrote:
>
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/gma500/psb_irq.c: In function psb_irq_turn_off_dpst:
> drivers/gpu/drm/gma500/psb_irq.c:473:6:
>         warning: variable hist_reg set but not used [-Wunused-but-set-variable]
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>

Applied to drm-misc-next

Thanks
Patrik

> ---
>  drivers/gpu/drm/gma500/psb_irq.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/gma500/psb_irq.c b/drivers/gpu/drm/gma500/psb_irq.c
> index 40a37e4..91f9001 100644
> --- a/drivers/gpu/drm/gma500/psb_irq.c
> +++ b/drivers/gpu/drm/gma500/psb_irq.c
> @@ -470,12 +470,11 @@ void psb_irq_turn_off_dpst(struct drm_device *dev)
>  {
>         struct drm_psb_private *dev_priv =
>             (struct drm_psb_private *) dev->dev_private;
> -       u32 hist_reg;
>         u32 pwm_reg;
>
>         if (gma_power_begin(dev, false)) {
>                 PSB_WVDC32(0x00000000, HISTOGRAM_INT_CONTROL);
> -               hist_reg = PSB_RVDC32(HISTOGRAM_INT_CONTROL);
> +               PSB_RVDC32(HISTOGRAM_INT_CONTROL);
>
>                 psb_disable_pipestat(dev_priv, 0, PIPE_DPST_EVENT_ENABLE);
>
> --
> 2.7.4
>
