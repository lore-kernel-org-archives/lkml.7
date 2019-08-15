Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11172C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5A92086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbfHOXRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:17:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36585 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbfHOXRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:17:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id k18so8054584otr.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FHzn0YAhkzkDUdc/IdDANTSNQr5IznYphFQTCaPi3SI=;
        b=gHwzBh6YljIbZ39cEeo616RlX4XgbkRV18HamXeTK0Eq6lXnAT46eMotywJzs94Pkq
         PjOrKdTnyFYnJEzi/uVx1QYLRZdIhRCaT/nrZ5Y5G1dYGMkB3PGWA8rFjN9okE4eF57E
         KJFs8Ayv2VvIVeuxuQU4WcLqmLyvxnctw/6/S8zi7JUjCsB8wXFqzHAxY7HsdAG+aOEe
         JFbSTbK3WChxwi0jlTACvPU+NYQIxg50tykhrVLkRZfF5hx83RPrQr2ENaP6ToNI+hRp
         2ISd09mRNFBQgJtXhQj3p6hLzM/lzmnxboP11oCtz/RQkYZCCvZkt/IUOt/fEA9rZsLu
         AQeA==
X-Gm-Message-State: APjAAAVkjyyB3S7ABWUN20ZH6ayuji/rBjIVNXL8xGA1eTXz74sEx7aQ
        eczzGaClihmZ01SIotEwLifv3xMfc/c=
X-Google-Smtp-Source: APXvYqw/wpzNjGrcUGn79CG372lHazAh96pxWzP1ufE9YP8r8/zegYBjQVxA77nSYgtMtZAv7DMFdg==
X-Received: by 2002:a05:6830:13d9:: with SMTP id e25mr547439otq.197.1565911059162;
        Thu, 15 Aug 2019 16:17:39 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id n109sm1567594ota.36.2019.08.15.16.17.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 16:17:38 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id y8so3482453oih.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:17:38 -0700 (PDT)
X-Received: by 2002:aca:1a0e:: with SMTP id a14mr3062547oia.51.1565911058646;
 Thu, 15 Aug 2019 16:17:38 -0700 (PDT)
MIME-Version: 1.0
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com> <1562165800-30721-3-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1562165800-30721-3-git-send-email-ioana.ciornei@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 15 Aug 2019 18:17:27 -0500
X-Gmail-Original-Message-ID: <CADRPPNSx5HUx3BJv-cxn=C7341wnC=yympQF7VM9jCroeUa7qA@mail.gmail.com>
Message-ID: <CADRPPNSx5HUx3BJv-cxn=C7341wnC=yympQF7VM9jCroeUa7qA@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: fsl: dpio: remove explicit device_link_remove
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <Roy.Pledge@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 9:58 AM Ioana Ciornei <ioana.ciornei@nxp.com> wrote:
>
> Starting with commit 72175d4ea4c4 ("driver core: Make driver core
> own stateful device links") stateful device links are owned by the
> driver core and should not be explicitly removed on device unbind.
> Delete all device_link_remove appearances from the dpio driver.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Applied for next.  Thanks.

> ---
>  drivers/soc/fsl/dpio/dpio-service.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
> index b9539ef2c3cd..518a8e081b49 100644
> --- a/drivers/soc/fsl/dpio/dpio-service.c
> +++ b/drivers/soc/fsl/dpio/dpio-service.c
> @@ -305,8 +305,6 @@ void dpaa2_io_service_deregister(struct dpaa2_io *service,
>         list_del(&ctx->node);
>         spin_unlock_irqrestore(&d->lock_notifications, irqflags);
>
> -       if (dev)
> -               device_link_remove(dev, d->dev);
>  }
>  EXPORT_SYMBOL_GPL(dpaa2_io_service_deregister);
>
> --
> 1.9.1
>
