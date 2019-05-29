Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAC6C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F082075C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 04:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hYOi8BkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfE2ETi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 00:19:38 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:44564 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfE2ETi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 00:19:38 -0400
Received: by mail-qt1-f173.google.com with SMTP id m2so937403qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 21:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FnqQyLt42DZ9noxJLCU2V14s5enRSAf3rpEHwRX9Kzo=;
        b=hYOi8BkFEY0SXxqQqLEZF9NnP9Pbvi1wS7yC9BK9JmRFXUan60kY7zFDXyLITqTDUS
         7ll6TdMYTzb7zrvvduAaFLWu3eONcUAliDarfOiByT5Tx+eF5Mcj8TPYuztHIg075hAh
         AaICUAmx02EeefvpAqjSqQcUnil3D9/4DGJhU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FnqQyLt42DZ9noxJLCU2V14s5enRSAf3rpEHwRX9Kzo=;
        b=mgQCRMGxltS+1+uzn7RB8zGcEX2dvAXzwhvkuea8JwjcNCKGPOa4Q7Kl2YW+JNEcPM
         lgJ1rjdHvcXLx9qWsiO0msT4Iyj4inoKy0UE7jzT4z76VOgQpzwsFW5+26auBJqk5wrE
         Byd7oaGLgxwFpnXDLTPCLa5TNwlx+HSRclIE7o+agrWfAT6jqWZmJmNUx2afp1Cqn802
         xBos3o9qw08J60hz2pOJ7XZe0i40yYIW6q5Bfkh4gUl9lA0kYtWs9DkgIVZDbe4uK/AF
         blbsk6fU/rtFgksCeGMbBfuXSLRVHEdzETv9hPZxrySmw1snLKXJR7eZWqSjHclCsICw
         YApA==
X-Gm-Message-State: APjAAAWU00AZbf8Mjlfh6wJn9AJl+sDgHxL2WAbwi9+m8qK/OedZGPcr
        rORMeM6YZIRk0qCpYTQCKrsV7hb3jTUuXhU60hbHCw==
X-Google-Smtp-Source: APXvYqxQjVrzoCeL6L4KHpLXuAIIoAai4JlsMWOYefX4hqGGu7mkiavfm3JE86Sp3YUok2L/Ps2IUpK+ghjSMUbbU7I=
X-Received: by 2002:a0c:b66f:: with SMTP id q47mr23601745qvf.102.1559103577129;
 Tue, 28 May 2019 21:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190519092537.69053-1-jitao.shi@mediatek.com> <20190519092537.69053-2-jitao.shi@mediatek.com>
In-Reply-To: <20190519092537.69053-2-jitao.shi@mediatek.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 29 May 2019 12:19:11 +0800
Message-ID: <CAJMQK-jST7mtoo-1C-8hU+O4x+_gOF0CuwToPwc=HJe86HDRHA@mail.gmail.com>
Subject: Re: [v3 1/7] drm/mediatek: move mipi_dsi_host_register to probe
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com,
        dri-devel@lists.freedesktop.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        CK Hu <ck.hu@mediatek.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Inki Dae <inki.dae@samsung.com>,
        linux-mediatek@lists.infradead.org, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        srv_heupstream@mediatek.com, lkml <linux-kernel@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2019 at 9:25 AM Jitao Shi <jitao.shi@mediatek.com> wrote:

> @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>                 return ret;
>         }
>
> -       ret = mipi_dsi_host_register(&dsi->host);
> -       if (ret < 0) {
> -               dev_err(dev, "failed to register DSI host: %d\n", ret);
> -               goto err_ddp_comp_unregister;
> -       }
> -
>         ret = mtk_dsi_create_conn_enc(drm, dsi);
>         if (ret) {
>                 DRM_ERROR("Encoder create failed with %d\n", ret);
> @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>         return 0;
>
>  err_unregister:
> -       mipi_dsi_host_unregister(&dsi->host);
> -err_ddp_comp_unregister:
>         mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>         return ret;
>  }
> @@ -1097,31 +1089,37 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>
>         dsi->host.ops = &mtk_dsi_ops;
>         dsi->host.dev = dev;
> +       dsi->dev = dev;
> +       ret = mipi_dsi_host_register(&dsi->host);
> +       if (ret < 0) {
> +               dev_err(dev, "failed to register DSI host: %d\n", ret);
> +               return ret;
> +       }
>
Since mipi_dsi_host_register() is moved from .bind to .probe,
mipi_dsi_host_unregister() should also be moved from .unbind to
.remove?

Thanks
