Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01785C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C61542146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTLnsP7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbfI0OGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:06:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40549 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfI0OGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:06:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id l3so2889601wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZyHHXgc6Q6QHdwP79gBuKFm4KM2rxomgIQZLm0ILgc=;
        b=BTLnsP7dW8o4gwHZC4JoyArRZUQGEtx1FGV9PwHc3LuTfw1k2sbcRFk2KSXi23XVZr
         +RiZ+LdgyQO6DM+uiEwR+lBCfCDatjQgvjElYjbAj4qeCpq0rrn/zeehaEQ1tAf/Epav
         vrML0LRv82+mPY4f2XP+aaZf3y9jRCZqBb5UxxUUvnDwUyErgbC1X1wpmece42AXyKyk
         UM2v7Bc7NFkGS1qO0qdl4VhR67DrJ8vg9hKUj44sRToNMRmKF1QZZUV3GKF6dmhCToAw
         MahDlccmDua4sa2+UP+2ybRgTqmxN/OEftpRRhIJHEuueJyOnISJpstcrRNmSuRqy3ci
         VY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZyHHXgc6Q6QHdwP79gBuKFm4KM2rxomgIQZLm0ILgc=;
        b=Sq5hOI2EH4qqAT79y3+0ebQulwGFquzKmy+mvncL71A1oBWGVlHwLrXhq9216W9XEl
         B6u1H84wItKbiwod6MYjfrtB6cy4YRHawbTUNYqvkv6vn+LN4/ea4JYypR4/mCBdwi+H
         2txXyHqsduXeKMq/H1MurD/D1+0iQ+Es8XN/FhTmq2UeNbruPivNvAT4wxJtpSaNshgm
         NiX8+jIZeSSr8Q57Rw3X6mgVnOCYqEIolVOWPmRZbLoszlq3ZaEIYIn/WGFY/waHefZd
         invfSIcqodZDg1F7dvzGphsXN4f/1N5K3DuJpDntSoKXIyKyHtfKFd5D1kysDX4+UHFr
         N4dA==
X-Gm-Message-State: APjAAAWrdP4eCj1Cnkfu1pS9xny+CQ71WW44nnyQ+mm1x6peskGnoWbL
        34ZPMaE55ABax6Ctc2rURftoinJ5ob45jv1YafA=
X-Google-Smtp-Source: APXvYqxJDP+iWcLEunOVY11ZWBahFwsMraAVwibBnMf2OV10K3FY/tT4n0B0a3116No7g1Rg36LAk8AdRxg+iTTh3yI=
X-Received: by 2002:adf:e9c5:: with SMTP id l5mr3146924wrn.40.1569593205209;
 Fri, 27 Sep 2019 07:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190926225122.31455-1-lyude@redhat.com> <20190926225122.31455-4-lyude@redhat.com>
In-Reply-To: <20190926225122.31455-4-lyude@redhat.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 27 Sep 2019 10:06:33 -0400
Message-ID: <CADnq5_NUkJxcdc4PFW6MNiDaVD7WR+_JtztOxFqWkkXaR2Br=A@mail.gmail.com>
Subject: Re: [PATCH 3/6] drm/amdgpu/dm/mst: Use ->atomic_best_encoder
To:     Lyude Paul <lyude@redhat.com>
Cc:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        Thomas Lim <Thomas.Lim@amd.com>, Leo Li <sunpeng.li@amd.com>,
        David Francis <David.Francis@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 6:52 PM Lyude Paul <lyude@redhat.com> wrote:
>
> We are supposed to be atomic after all. We'll need this in a moment for
> the next commit.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index a398ddd1f306..d9113ce0be09 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -243,17 +243,17 @@ static int dm_dp_mst_get_modes(struct drm_connector *connector)
>         return ret;
>  }
>
> -static struct drm_encoder *dm_mst_best_encoder(struct drm_connector *connector)
> +static struct drm_encoder *
> +dm_mst_atomic_best_encoder(struct drm_connector *connector,
> +                          struct drm_connector_state *connector_state)
>  {
> -       struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
> -
> -       return &amdgpu_dm_connector->mst_encoder->base;
> +       return &to_amdgpu_dm_connector(connector)->mst_encoder->base;
>  }
>
>  static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
>         .get_modes = dm_dp_mst_get_modes,
>         .mode_valid = amdgpu_dm_connector_mode_valid,
> -       .best_encoder = dm_mst_best_encoder,
> +       .atomic_best_encoder = dm_mst_atomic_best_encoder,
>  };
>
>  static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
> --
> 2.21.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
