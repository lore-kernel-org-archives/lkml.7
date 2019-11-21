Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8EDC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60D9F206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZBgJAoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKUSJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:09:16 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:45275 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbfKUSJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:09:16 -0500
Received: by mail-io1-f68.google.com with SMTP id v17so4492674iol.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhDv8B/MH9k+2gQLkxu3wNqBY8ATU21NQy45rVB5e/0=;
        b=JZBgJAoHLsaELThn5k6UAy5s4Qo+A7dUCdsWtG0c42UhKK3t+dMn/5paQKhgqRE532
         uu5lgnDMfAtg5I1V+8oaBRUjskvJu4k+FHeV2d38VLXO22aaGK6tzwMLVcsJcrx5HJSS
         Imay1ryOzoA2d5/D7lv7a6qluP3VEAIvRK5t7Xb2R4f+9EUnzkpbcv9CEcoQ8aE6Zr+6
         RKfUJj8XpzVDUz5E1eANFZ4CnzI4DU9eAurhl5e84U/clJmkiDAOuLly9caEvcBcpozR
         4lgp2i+TSUJsD/fbwXufE++3B1lScdQr0tN/OGW/vSu5DAzRZeDYM/+pwm3TFfrYyw57
         nltg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhDv8B/MH9k+2gQLkxu3wNqBY8ATU21NQy45rVB5e/0=;
        b=Jm1DID2QBxL3ofA4xXXFgjlxqCHi1ZwyEEFWykA/OBED9d7/h+Rkz8wy66/YLqQ5Nf
         BtX0gvbylmZxnryy7gclNFwr8L/FeUVb2LRLko6ytd9J4NhJnidwh9mI2mQme7+5jw5B
         JBQvEhhmjdcy3wl3dBjSJjZwddJ9jRtdfMVZT3wiAnxrXcWfw+9ImRFy1riSCzUEMeF8
         kI7dabQYnXKTLt28Lo509ctmFcUnXZ/+zd7vyuSaOjrcr6P0zhjyq/FH60VL7RX9IpEB
         6AzDe71S6r9ypJnb76JOMXXWDSrA5+J3HM4VqBwROiDO50h6GemYisdRlHHqsySzzOE5
         ouPQ==
X-Gm-Message-State: APjAAAVlmb0jYulMwf4vcRbufpKTQWREn+N5E/I2X/1zza+osTUqrjgL
        xesKU3xTHR9YBYFv4StY/EziL6ap2qCznliikbw=
X-Google-Smtp-Source: APXvYqxlo2bv+bM+ry7TgMS2bHzA+FeG4N2aN4fgU0MpxQpJgbxeccusuTVlwBNNkJxfQTfEZoio57HSh9Teo0+EC80=
X-Received: by 2002:a02:ce51:: with SMTP id y17mr7688720jar.1.1574359754949;
 Thu, 21 Nov 2019 10:09:14 -0800 (PST)
MIME-Version: 1.0
References: <20191021211449.9104-1-navid.emamdoost@gmail.com>
In-Reply-To: <20191021211449.9104-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Thu, 21 Nov 2019 12:09:04 -0600
Message-ID: <CAEkB2ERA6Rx9fZiwXH+m8_OV8to0TuLJRVRiUKfKtSoeoT0uJw@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau: Fix memory leak in nouveau_bo_alloc
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 4:14 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In the implementation of nouveau_bo_alloc() if it fails to determine the
> target page size via pi, then the allocated memory for nvbo should be
> released.
>
> Fixes: 019cbd4a4feb ("drm/nouveau: Initialize GEM object before TTM object")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Would you please review this patch?


Thanks,
Navid.

> ---
>  drivers/gpu/drm/nouveau/nouveau_bo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
> index f8015e0318d7..18857cf44068 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_bo.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
> @@ -276,8 +276,10 @@ nouveau_bo_alloc(struct nouveau_cli *cli, u64 *size, int *align, u32 flags,
>                         break;
>         }
>
> -       if (WARN_ON(pi < 0))
> +       if (WARN_ON(pi < 0)) {
> +               kfree(nvbo);
>                 return ERR_PTR(-EINVAL);
> +       }
>
>         /* Disable compression if suitable settings couldn't be found. */
>         if (nvbo->comp && !vmm->page[pi].comp) {
> --
> 2.17.1
>


-- 
Navid.
