Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22507C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE63A20868
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 16:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dTSEO7ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfCHQpd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 11:45:33 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40253 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbfCHQpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 11:45:33 -0500
Received: by mail-io1-f68.google.com with SMTP id p17so17219649iol.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2019 08:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FpyiCTfsggCqek9bFJmTjYVnLMonKJfxoS148viDPkc=;
        b=dTSEO7ubFodfXQcjxDij4qzMzOvQXClgx6qNieoHlbCiN8JI6NKdkpbusBgFw9pE2N
         qLJsP6aOv1BNzqSX8rNNe9Pb9X8KE+WeFBZ9L6vK0ftvt5YdQ9uS7ZEUiGD/+PcALEWE
         IoLg+AfV72dp+2Pb32GQTsrw3xNNf0bZ3JoTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FpyiCTfsggCqek9bFJmTjYVnLMonKJfxoS148viDPkc=;
        b=FLpOJeKnOwcLwF0hsZBnEn1Uq1EAZWdP/DUiN0CCVFUS6L5pHFVnEwB1xump+5kT++
         AY3yrGNq1fhyLO8PpjEVSWa3NPNB8jZ9cvj5wjr3DEBgS/xZHm1i34DLXNwDzAh4mPZb
         U4UAAu1os9vDwxmCV2Y1ZkE/yVrtqS50dFZgTw7G1+2JfiZbtZrfRZZ7A4mRUZ9vExEK
         xVGXBSNYduHyJ7zdrZMrg2xCFdCbTNwLs6mMihvqz1Y14kGAnhFJ6XKy5FNyELTSnyfe
         FiS/5Ax+jmL/oFfwdnSyPk+agypB+HjXBIYFxh3k7eojXroHHvqZXwttATVlqMRPB99X
         ZggA==
X-Gm-Message-State: APjAAAU8Wtn01BhixcbBOVH1rymsv/sBVNL1m5/D8LE/N8rgNRRalCoo
        GNggrRgtg1BLzvGBZ1fXGHipPjdEtsoJJtNoYNWpOg==
X-Google-Smtp-Source: APXvYqxPrqoqHOSGdaUHtWhk/nCBHp+hfGinPKxdznSubx0WwkVI3PVW72bzh80tzisFnjHLsZ9bBOLHA2x0Rvpv6FQ=
X-Received: by 2002:a5d:818d:: with SMTP id u13mr9819037ion.20.1552063531925;
 Fri, 08 Mar 2019 08:45:31 -0800 (PST)
MIME-Version: 1.0
References: <20190220233658.986-1-eric@anholt.net> <20190220233658.986-2-eric@anholt.net>
In-Reply-To: <20190220233658.986-2-eric@anholt.net>
From:   Dave Emett <david.emett@broadcom.com>
Date:   Fri, 8 Mar 2019 16:45:20 +0000
Message-ID: <CAApk1dWSLJSMYis=kCdLmb09VjwBnZM3hzcRk_Gu5Yg3i2i6qA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm/v3d: Don't try to set OVRTMUOUT on V3D 4.x.
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
> The old field is gone and the register now has a different field,
> QRMAXCNT for how many TMU requests get serviced before thread switch.
> We were accidentally reducing it from its default of 0x3 (4 requests)
> to 0x0 (1).
>
> v2: Skip setting the reg at all on 4.x, instead of trying to update
>     only the old field.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Reviewed-by: Dave Emett <david.emett@broadcom.com>


> ---
>  drivers/gpu/drm/v3d/v3d_gem.c  | 3 ++-
>  drivers/gpu/drm/v3d/v3d_regs.h | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
> index 109be31e47ea..449d01ea54a0 100644
> --- a/drivers/gpu/drm/v3d/v3d_gem.c
> +++ b/drivers/gpu/drm/v3d/v3d_gem.c
> @@ -25,7 +25,8 @@ v3d_init_core(struct v3d_dev *v3d, int core)
>          * type.  If you want the default behavior, you can still put
>          * "2" in the indirect texture state's output_type field.
>          */
> -       V3D_CORE_WRITE(core, V3D_CTL_MISCCFG, V3D_MISCCFG_OVRTMUOUT);
> +       if (v3d->ver < 40)
> +               V3D_CORE_WRITE(core, V3D_CTL_MISCCFG, V3D_MISCCFG_OVRTMUOUT);
>
>         /* Whenever we flush the L2T cache, we always want to flush
>          * the whole thing.
> diff --git a/drivers/gpu/drm/v3d/v3d_regs.h b/drivers/gpu/drm/v3d/v3d_regs.h
> index 6ccdee9d47bd..8e88af237610 100644
> --- a/drivers/gpu/drm/v3d/v3d_regs.h
> +++ b/drivers/gpu/drm/v3d/v3d_regs.h
> @@ -216,6 +216,8 @@
>  # define V3D_IDENT2_BCG_INT                            BIT(28)
>
>  #define V3D_CTL_MISCCFG                                0x00018
> +# define V3D_CTL_MISCCFG_QRMAXCNT_MASK                 V3D_MASK(3, 1)
> +# define V3D_CTL_MISCCFG_QRMAXCNT_SHIFT                1
>  # define V3D_MISCCFG_OVRTMUOUT                         BIT(0)
>
>  #define V3D_CTL_L2CACTL                                0x00020
> --
> 2.20.1
>
