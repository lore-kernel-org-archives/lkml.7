Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95368C48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6956E20659
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561658269;
	bh=AuFJz8ka4bbd9U8/rrPBsrwzzsfKjM33G6LhSwHHcbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uKyM126BLS0kyYkszdHwqy9YdUXoFq4Q4VFQAVDbLjo2wpajaRF56WU4PeNSXJX4O
	 pgd3nEkOvKM5fX1hKyulZ7rWyYAZgGJefSk0KsA/DX06hkmS4s9ZGXhMOF6yoCusW4
	 qzfWZFevdkQlEi47xaIm0O+haCfwg9DbWM0mC3dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfF0R5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbfF0R5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:57:47 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E74E2177B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561658267;
        bh=AuFJz8ka4bbd9U8/rrPBsrwzzsfKjM33G6LhSwHHcbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pwSTMjXHGt/r9fLzwmASxdxE/MmLeOQQgtEWbcj4Fz3PTiBFMaiK7bmkIU1SJoaOl
         w9R8eI2/KXAX3pKdJp8fhRJfvTpdd3SGtoI+mq/ZuFWFQPWzJnHZeJBgsrIg+oVgL8
         3BLPjvrqsqk/1SFDO5kG5qLtztrvaPW/n3nt+1XY=
Received: by mail-qk1-f174.google.com with SMTP id x18so2472969qkn.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 10:57:47 -0700 (PDT)
X-Gm-Message-State: APjAAAULx417sIUYHdFHqHwSqkMv/mK2k4B4e0KLajeMMKPDa3MXY6px
        P6/dV8NGJFNDWFWUIlnUGT9nKJ89POUAB8Fqyg==
X-Google-Smtp-Source: APXvYqxhQp2BTbtvCFGln6FbDKha/1kQyYa7alsmb9UvgsSNplaI6MWMixSvDaZWUZprwBsf2EDRykU9lv19KYFgGos=
X-Received: by 2002:ae9:ebd1:: with SMTP id b200mr4759890qkg.152.1561658266279;
 Thu, 27 Jun 2019 10:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190627155318.38053-1-steven.price@arm.com> <20190627155318.38053-2-steven.price@arm.com>
In-Reply-To: <20190627155318.38053-2-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Jun 2019 11:57:34 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ5ebyrvapvOSvg1ejgkbqEZyYh2AWAbO0UE=DssKtW1Q@mail.gmail.com>
Message-ID: <CAL_JsqJ5ebyrvapvOSvg1ejgkbqEZyYh2AWAbO0UE=DssKtW1Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] drm/gem: Rename drm_gem_dumb_map_offset() to drm_gem_map_offset()
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Airlie <airlied@linux.ie>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 9:53 AM Steven Price <steven.price@arm.com> wrote:
>
> drm_gem_dumb_map_offset() is a useful helper for non-dumb clients, so
> rename it to remove the _dumb and add a comment that it can be used by
> shmem clients.
>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>  drivers/gpu/drm/drm_dumb_buffers.c      | 4 ++--
>  drivers/gpu/drm/drm_gem.c               | 9 ++++++---
>  drivers/gpu/drm/exynos/exynos_drm_gem.c | 3 +--
>  include/drm/drm_gem.h                   | 4 ++--
>  4 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
> index d18a740fe0f1..b55cfc9e8772 100644
> --- a/drivers/gpu/drm/drm_dumb_buffers.c
> +++ b/drivers/gpu/drm/drm_dumb_buffers.c
> @@ -48,7 +48,7 @@
>   * To support dumb objects drivers must implement the &drm_driver.dumb_create
>   * operation. &drm_driver.dumb_destroy defaults to drm_gem_dumb_destroy() if
>   * not set and &drm_driver.dumb_map_offset defaults to
> - * drm_gem_dumb_map_offset(). See the callbacks for further details.
> + * drm_gem_map_offset(). See the callbacks for further details.
>   *
>   * Note that dumb objects may not be used for gpu acceleration, as has been
>   * attempted on some ARM embedded platforms. Such drivers really must have
> @@ -127,7 +127,7 @@ int drm_mode_mmap_dumb_ioctl(struct drm_device *dev,
>                                                     args->handle,
>                                                     &args->offset);
>         else
> -               return drm_gem_dumb_map_offset(file_priv, dev, args->handle,
> +               return drm_gem_map_offset(file_priv, dev, args->handle,
>                                                &args->offset);
>  }
>
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a8c4468f03d9..62842b7701bb 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -298,7 +298,7 @@ drm_gem_handle_delete(struct drm_file *filp, u32 handle)
>  EXPORT_SYMBOL(drm_gem_handle_delete);
>
>  /**
> - * drm_gem_dumb_map_offset - return the fake mmap offset for a gem object
> + * drm_gem_map_offset - return the fake mmap offset for a gem object
>   * @file: drm file-private structure containing the gem object
>   * @dev: corresponding drm_device
>   * @handle: gem object handle
> @@ -307,10 +307,13 @@ EXPORT_SYMBOL(drm_gem_handle_delete);
>   * This implements the &drm_driver.dumb_map_offset kms driver callback for
>   * drivers which use gem to manage their backing storage.
>   *
> + * It can also be used by drivers using the shmem backend as they have the
> + * same restriction that imported objects cannot be mapped.

Maybe better not to say 'shmem' explicitly or just mention it as an
example so when we have a 2nd case we don't have to update the
comment.

...drivers with GEM BO implementations which have the same...

I can fix up and apply. Some other acks would be nice first.

Rob
