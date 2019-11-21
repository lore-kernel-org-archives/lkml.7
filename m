Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6BFC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCDC206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 18:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wkp25PFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfKUSb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 13:31:29 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45224 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUSb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 13:31:29 -0500
Received: by mail-oi1-f195.google.com with SMTP id 14so4067976oir.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 10:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zes9nx3wWOfwgkI+Dul1p5z28VLkMHp34WWYw/4B4xM=;
        b=Wkp25PFcZ403A1Ab9dtH00UDW+ztY9yfO5ob/GgE/2yV3cRKXm7YMtYFtLdE+Dsva3
         9Rp7LdEU0QVZIsPXy980hXnC4LQ9KYwFcnhhwyD0vo4Ok6W3S6MZRT5jISG4FvLREXtz
         AWAp8TsSWkWK8zlCxWzKcEZ/j6zwmvwRFNOG78fD68Z8CxTbK06XUuEF+1q0XUT1Ovhs
         C0xgW4AGzSMcuLFkJ64mQbF2vtg/0a2TRJhlwNHdWkkfTCAr3cgi3cBxR9GKcC1Gkppu
         YTEvvuuBpO9jyZpYHtYh0xn7CGIvTzBvTNIjpSvir4A692IKFEazzfbK47bCNvU0KlKx
         qS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zes9nx3wWOfwgkI+Dul1p5z28VLkMHp34WWYw/4B4xM=;
        b=ip9C865k/878yljdalDJ6T2kJo9FpADAkkeNt0cz98cQK3bWM4tyk3ZH5vViEPK8LG
         zJt2P5GUr9K1R0rmoUy9tSDzEJTvP6sNWtGVKJpZkQmpVZX/+en8vj2mrLfNV8TIOyGQ
         EwUoMmmdI8eg1iCgwKVA1YXWhhLWmbvfUuoa5Pp2zbX/s9aSZ26vueHFrDJtj7dfD8jm
         xeHGjtqcntBTI/NTgq3+deRNJVwj8armrZBk2hx9ZhpXzX5+4prhrUtrroGRYF/ZlUhf
         qoKY9KrYBl1vlj3RJXHNdVg8is6gV2DvTKcmTfDlsuhwVSbHDT0nI+pDGeGbg83WUqDC
         06sw==
X-Gm-Message-State: APjAAAUbeUpWr7iIXVqNOqOB8OLLNLLSGRQLtSChwl9xMBACqxaIAcym
        XE8EL3XpKPDCicW6bpocBSn26GMsLp1nq9jSIPw=
X-Google-Smtp-Source: APXvYqyen3cn+EY2RAzHvEa5NUjEhWs2OO/9/OSlmmI0VmHx00JqrZodxXdJRT5Kl/NB0JdTu71ixm3Ce1mmHgz5IXQ=
X-Received: by 2002:aca:c50f:: with SMTP id v15mr9263185oif.5.1574361088233;
 Thu, 21 Nov 2019 10:31:28 -0800 (PST)
MIME-Version: 1.0
References: <20191004190938.15353-1-navid.emamdoost@gmail.com>
In-Reply-To: <20191004190938.15353-1-navid.emamdoost@gmail.com>
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Thu, 21 Nov 2019 12:31:17 -0600
Message-ID: <CAEkB2EQGCcwBO4iZBiHthUAJUeprw2Q09932GATd6XVyXqukzw@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: fix memory leak in imx_pd_bind
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 4, 2019 at 2:09 PM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> In imx_pd_bind, the duplicated memory for imxpd->edid via kmemdup should
> be released in drm_of_find_panel_or_bridge or imx_pd_register fail.
>
> Fixes: ebc944613567 ("drm: convert drivers to use drm_of_find_panel_or_bridge")
> Fixes: 19022aaae677 ("staging: drm/imx: Add parallel display support")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---

Would you please review this patch?

Thanks,

>  drivers/gpu/drm/imx/parallel-display.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/imx/parallel-display.c b/drivers/gpu/drm/imx/parallel-display.c
> index e7ce17503ae1..9522d2cb0ad5 100644
> --- a/drivers/gpu/drm/imx/parallel-display.c
> +++ b/drivers/gpu/drm/imx/parallel-display.c
> @@ -227,14 +227,18 @@ static int imx_pd_bind(struct device *dev, struct device *master, void *data)
>
>         /* port@1 is the output port */
>         ret = drm_of_find_panel_or_bridge(np, 1, 0, &imxpd->panel, &imxpd->bridge);
> -       if (ret && ret != -ENODEV)
> +       if (ret && ret != -ENODEV) {
> +               kfree(imxpd->edid);
>                 return ret;
> +       }
>
>         imxpd->dev = dev;
>
>         ret = imx_pd_register(drm, imxpd);
> -       if (ret)
> +       if (ret) {
> +               kfree(imxpd->edid);
>                 return ret;
> +       }
>
>         dev_set_drvdata(dev, imxpd);
>
> --
> 2.17.1
>


-- 
Navid.
