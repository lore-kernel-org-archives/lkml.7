Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E066AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23E9208E4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O0F773vP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCHQrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:47:23 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43190 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfCHQrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:47:22 -0500
Received: by mail-io1-f65.google.com with SMTP id y6so17225790ioq.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThuiAdI4Oa28GV2aGlXvwfiYRXBF8HgkLqsbgGYZ700=;
        b=O0F773vPfteHzEYuWTX7HQEZ4FGjnHPKonT0T+oqO1oJTOIu3Idoz5YeCuN9jKMBLU
         IBiqaatZX9N321QlTBP1+1iHuHHMm71sgRWnw8/eEbs1Iet6StcNv06qK21Vs0/4pN5x
         929qAFUfPA459FfMsdkB8zHLUSKdTFQqPsVr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThuiAdI4Oa28GV2aGlXvwfiYRXBF8HgkLqsbgGYZ700=;
        b=hlgpno4LjYdfe1KQ7bRnkBKypVaDpuCz/mN4hRBpcgebXCHsUP3VhalKPwB/QH5n2m
         VXJ4kExCVVUWPiqKkAezjk/waXtwjC3qbf4ztgpBZYGUwWSSNX5Bg9mKuQpn8TICvAnE
         E+7mzQAiMBKPK/rHZlkZ2pQ5Bes1sy/DXYyUEbm9LigAcYggBz2ae/q/4pDYogg4sht6
         kXjDUFxoQ69+7TaOTOvpw/8tHcgztmrQ3F92BuFiv9OVrY8TmTSD8PEs4k0ALrqy9Zol
         ry8IwsaRS7TsRm/5Fm0u03LSydBXSR3A+98JztISqr53kcHb07ztyCQBESQyW5kfOhqM
         9Mgw==
X-Gm-Message-State: APjAAAUqU0+dkLvgc0hythKC7JaBl6K15sv2fNNPM4oOz/hmvKn+AYDo
        sjLvl3IBuTFjrxEtYvP0v0xbaz3vQBWYzQlD9ejW2w==
X-Google-Smtp-Source: APXvYqyK7EW80PJwQ2BHC+TGEdwWI/OPg2xivcp9Sfrg0cF9jWxBFmiGSwroto0oQUPFDrPrRYoQIIxJS6Rgk2fYrqQ=
X-Received: by 2002:a5d:818d:: with SMTP id u13mr9823560ion.20.1552063642081;
 Fri, 08 Mar 2019 08:47:22 -0800 (PST)
MIME-Version: 1.0
References: <20190220233658.986-1-eric@anholt.net> <20190220233658.986-3-eric@anholt.net>
In-Reply-To: <20190220233658.986-3-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Fri, 8 Mar 2019 16:47:11 +0000
Message-ID: <CAApk1dVxEvinAE+7Vw2_Rb1hyJMXnbxKDGyJmwgTN=a=7seJSg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] drm/v3d: Make sure the GPU is on when measuring clocks.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Thomas Spurden <thomas.spurden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 at 23:37, Eric Anholt <eric@anholt.net> wrote:
>
> You'll get garbage measurements if the registers always read back
> 0xdeadbeef
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>

> ---
>  drivers/gpu/drm/v3d/v3d_debugfs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
> index eb2b2d2f8553..a24af2d2f574 100644
> --- a/drivers/gpu/drm/v3d/v3d_debugfs.c
> +++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
> @@ -187,6 +187,11 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
>         uint32_t cycles;
>         int core = 0;
>         int measure_ms = 1000;
> +       int ret;
> +
> +       ret = pm_runtime_get_sync(v3d->dev);
> +       if (ret < 0)
> +               return ret;
>
>         if (v3d->ver >= 40) {
>                 V3D_CORE_WRITE(core, V3D_V4_PCTR_0_SRC_0_3,
> @@ -210,6 +215,9 @@ static int v3d_measure_clock(struct seq_file *m, void *unused)
>                    cycles / (measure_ms * 1000),
>                    (cycles / (measure_ms * 100)) % 10);
>
> +       pm_runtime_mark_last_busy(v3d->dev);
> +       pm_runtime_put_autosuspend(v3d->dev);
> +
>         return 0;
>  }
>
> --
> 2.20.1
>
