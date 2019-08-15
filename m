Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CF5C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63012083B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 23:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfHOXNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 19:13:20 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46213 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730386AbfHOXNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 19:13:20 -0400
Received: by mail-oi1-f193.google.com with SMTP id t24so3454870oij.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OiMfOR7Lnqn7tP3k80pw2nBJ03dVcn8MhawyWGtoGR0=;
        b=CQD9D12ZbV6mA9LndEr8ssWl4D6bogQmM3Xmm0xr4lLM5DTLYF18eseP9aka0akOVg
         0Kaly4Iuy306TFWyULMN+EVb2tg3asoTJAF4s4E91qOnn34jjWf5LjplcCT8pKIkjRXs
         DhCHfisJfY4mozTivbZskJDIDPCSUuSchkzLmzEj14oShhqMw8KIW9PdezQxe6tBqOK7
         p/iQaSKAuwB/JA8XxK5uagtQHOKJ3I7SdBFuaIsjhGyJJHog8fPcBYcOfVzRbv2PXiwY
         MOtQY7ccegoUBeqX/VurOElZBwWHVpX0ViJUK1opN1s2II4A9jzx8xk4fY2mFuZKEJA9
         lWkA==
X-Gm-Message-State: APjAAAXcH/9Wrs1KDHSsjGU3BjQG1B3WIvbvGqq4Q+BzkWt9Vv3yCexX
        JrqvS0MveeyfYa0+S5oFmc2HKecvabs=
X-Google-Smtp-Source: APXvYqwQorl3SI35+lDKA21yd3BeQq+hYroPBREzzYo7a522EgWgJPubmM8KslVHjF2B7R1Y8i/tMg==
X-Received: by 2002:a05:6808:3d5:: with SMTP id o21mr2863712oie.108.1565910799376;
        Thu, 15 Aug 2019 16:13:19 -0700 (PDT)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com. [209.85.167.176])
        by smtp.gmail.com with ESMTPSA id n13sm1616803otf.51.2019.08.15.16.13.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 16:13:19 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id t24so3454848oij.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 16:13:18 -0700 (PDT)
X-Received: by 2002:aca:1a0e:: with SMTP id a14mr3052062oia.51.1565910798823;
 Thu, 15 Aug 2019 16:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <1562165800-30721-1-git-send-email-ioana.ciornei@nxp.com> <1562165800-30721-2-git-send-email-ioana.ciornei@nxp.com>
In-Reply-To: <1562165800-30721-2-git-send-email-ioana.ciornei@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Thu, 15 Aug 2019 18:13:07 -0500
X-Gmail-Original-Message-ID: <CADRPPNQDRhocXmpA08rEBqpFBrm1ub9z3+r74GNcMs6bqUL8OA@mail.gmail.com>
Message-ID: <CADRPPNQDRhocXmpA08rEBqpFBrm1ub9z3+r74GNcMs6bqUL8OA@mail.gmail.com>
Subject: Re: [PATCH 1/3] bus: fsl-mc: remove explicit device_link_del
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
> Starting with commit 72175d4ea4c4 ("driver core: Make driver core own
> stateful device links") stateful device links are owned by the driver
> core and should not be explicitly removed on device unbind. Delete all
> device_link_del appearances from the fsl-mc bus.
>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Hi Laurentiu,

What do you think of this patches?  I can take it through fsl/soc if
you can ACK it.

Regards,
Leo

> ---
>  drivers/bus/fsl-mc/fsl-mc-allocator.c | 1 -
>  drivers/bus/fsl-mc/mc-io.c            | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> index 8ad77246f322..cc7bb900f524 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -330,7 +330,6 @@ void fsl_mc_object_free(struct fsl_mc_device *mc_adev)
>
>         fsl_mc_resource_free(resource);
>
> -       device_link_del(mc_adev->consumer_link);
>         mc_adev->consumer_link = NULL;
>  }
>  EXPORT_SYMBOL_GPL(fsl_mc_object_free);
> diff --git a/drivers/bus/fsl-mc/mc-io.c b/drivers/bus/fsl-mc/mc-io.c
> index 3ae574a58cce..d9629fc13a15 100644
> --- a/drivers/bus/fsl-mc/mc-io.c
> +++ b/drivers/bus/fsl-mc/mc-io.c
> @@ -255,7 +255,6 @@ void fsl_mc_portal_free(struct fsl_mc_io *mc_io)
>         fsl_destroy_mc_io(mc_io);
>         fsl_mc_resource_free(resource);
>
> -       device_link_del(dpmcp_dev->consumer_link);
>         dpmcp_dev->consumer_link = NULL;
>  }
>  EXPORT_SYMBOL_GPL(fsl_mc_portal_free);
> --
> 1.9.1
>
