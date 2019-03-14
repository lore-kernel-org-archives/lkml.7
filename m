Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D430CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA49920811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552587317;
	bh=2TEllSkb1218zmvcrJAECjhP3zujdeio/V5FOokbDWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=diMkPusgtB078SOetYLu0gSpFf9BqO8A8/RpO5rPfFdHE3q0I+W6GHVIrB3JibOEW
	 bbQz6n/ecV+bafWNxCjSU4Dd2afB0RQzQMBDUCeBdUWOWokNcQ2Vt+98SqJO9sdo/i
	 vbXSnbY+qkPh9CGPuYXqRJfGLolgXz3zscFyX/i8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfCNSPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbfCNSPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:15:16 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12EA421874
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 18:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552587315;
        bh=2TEllSkb1218zmvcrJAECjhP3zujdeio/V5FOokbDWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0U+QWaxN5tx5AqDVtRWw7JnLoiky/SQgioYpf/kNxAr4k484TdAiT+P1Sg7yLk66U
         ZFm2fewM+zxZZEEnxUy2Bi+VvOt0fvlnDMR/wdkQO/nTTLxo8rIj2U0ukIQGukyMrc
         pXTu5rjS/Irw6/mMmjhKLj3OPW/mLsJqasjaUpDA=
Received: by mail-qt1-f182.google.com with SMTP id d2so7139518qti.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 11:15:15 -0700 (PDT)
X-Gm-Message-State: APjAAAVovCI1qmp+zeDOxHpBmjgpApbHD5bR58+hx3T4A0fH1fg0QMj8
        hrIMzSRdOOyG/8wnbxluFMRFutGpAts/eK052g==
X-Google-Smtp-Source: APXvYqyFrQkDefChHc5Wbj+pInsf2TJWFRTUbZLhW9gZsIKChmj0Wz3Gy3Ekaj0BN6FHgggF9aUPVEJLY/6E/KHpnFE=
X-Received: by 2002:aed:21cb:: with SMTP id m11mr38981604qtc.257.1552587314259;
 Thu, 14 Mar 2019 11:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190313004344.24169-1-robh@kernel.org> <20190314163451.13431-1-eric@anholt.net>
In-Reply-To: <20190314163451.13431-1-eric@anholt.net>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Mar 2019 13:15:02 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLeyDahEpWkj=3ogEcbz84qFQTj=wBZDTDoyNjbRz3Ccg@mail.gmail.com>
Message-ID: <CAL_JsqLeyDahEpWkj=3ogEcbz84qFQTj=wBZDTDoyNjbRz3Ccg@mail.gmail.com>
Subject: Re: [PATCH] drm/v3d: Use the new shmem helpers to reduce driver boilerplate.
To:     Eric Anholt <eric@anholt.net>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 11:34 AM Eric Anholt <eric@anholt.net> wrote:
>
> The new shmem helpers from Noralf and Rob abstract out a bunch of our
> BO creation and mapping code.
>
> v2: Use the new sgt getter, and flag pages as dirty before freeing.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/v3d/Kconfig   |   1 +
>  drivers/gpu/drm/v3d/v3d_bo.c  | 317 ++++++++++------------------------
>  drivers/gpu/drm/v3d/v3d_drv.c |  27 +--
>  drivers/gpu/drm/v3d/v3d_drv.h |  14 +-
>  drivers/gpu/drm/v3d/v3d_gem.c |  12 +-
>  drivers/gpu/drm/v3d/v3d_irq.c |   8 +-
>  drivers/gpu/drm/v3d/v3d_mmu.c |  11 +-
>  7 files changed, 120 insertions(+), 270 deletions(-)

> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 945eaaaad016..b84d89c7b3fb 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -201,7 +201,8 @@ v3d_attach_object_fences(struct v3d_bo **bos, int bo_count,
>
>         for (i = 0; i < bo_count; i++) {
>                 /* XXX: Use shared fences for read-only objects. */
> -               reservation_object_add_excl_fence(bos[i]->base.resv, fence);
> +               reservation_object_add_excl_fence(bos[i]->base.base.resv,
> +                                                 fence);

All these 'bos[i]->base.base' occurrences are not the prettiest.
Changing your bos array to a struct drm_gem_object ** instead would
help. That's what I did for panfrost. Though I've not looked at were
you actually need the v3d_bo.

Either way,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
