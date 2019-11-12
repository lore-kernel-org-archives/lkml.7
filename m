Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F3CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46CF214E0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ujxa9jop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfKLPvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:51:41 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34313 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKLPvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:51:41 -0500
Received: by mail-qt1-f194.google.com with SMTP id i17so8697853qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 07:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JRkRZ7G9FEZbsuWYChLlwVfTl2uGOJSYFakfp3EaVJw=;
        b=ujxa9jop550A/2di5rDoAoni3YLc8CaCGYZHLGIB6xDMKJ3j78Nn+UztcwrzgAdH1g
         zi37QlndiYuKmfPRgUX6pt/MHTgljgzl22nvRyThTcIm5zgMLSYbr44bmpgZw4ctebSU
         NC7zqIMewvyvxtzhrNUtQ+EwdW+FkQaeAfAjuCGQhOpSNv6r5an73gn0Y9Twzo5QNizC
         3F2ng5hbwmgJCD+p7dkxRVC21a0oelu6eXg0rLeaCHYW9K/Tv+NcKDaCkf0et8cG+Xzp
         PUI7WPhXsbD6V2wzCkT9JXEWp1LEmS7mUvMPb9XpoRdw8yNfPri8dAINPu2wNro9LpQ5
         pNxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JRkRZ7G9FEZbsuWYChLlwVfTl2uGOJSYFakfp3EaVJw=;
        b=Ml13+zuMOreQZE4zbHULaQVgTEoipOw7IQA4itO/QsiEUrjTVOdmQOQh/vwzJqtkby
         slVP2irbRXy8ztfoX7Zk3Lv162nScJ0Xnn8lFfifyI7pxe5jU6Z3SEXOD4+ewUUPsplS
         gKq8TDVdb0Q9xmftnwXsBx3MMMQ0WHUyR4zvV/5hMSPbb58GBT8o+Ej5O9juM9Rx5bNG
         vAtjRhBKrFGalyBjUWwt4lzwPhZ6gxsEae0v0EzMX2dGFoOU2qfwj4TtIcqUu479dDGw
         T6HUT6ddf1d+6L1Zvy6Dk2/7sjxNiefN/bcuT5S75A/9e+2Uj46BzcB3eP5ZleLylx3L
         5MKQ==
X-Gm-Message-State: APjAAAUrre/E6Y8rolo+daQ491z5AamLTYJp6Y9tn85lyxYb1O6TsXdY
        pwRL4VXVLPKdHb8doaSFyZj/qhsLp0c1thOEI7Q=
X-Google-Smtp-Source: APXvYqw+pxUFTSyPILdszSIQZPHKTYgSQB4MBTgxCQZbMJ+mVpWZFt1CtOHmmuuGCJHpgxn3ylDrB73u58dQBgYPRec=
X-Received: by 2002:ac8:1494:: with SMTP id l20mr12163363qtj.356.1573573898357;
 Tue, 12 Nov 2019 07:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20191104173737.142558-1-robdclark@gmail.com> <20191104173737.142558-2-robdclark@gmail.com>
In-Reply-To: <20191104173737.142558-2-robdclark@gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Tue, 12 Nov 2019 16:51:27 +0100
Message-ID: <CAFqH_52nFGmG-sMb03ByGSJGckT1D_TKWuy1DpkJt2usxHWHpA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] drm/atomic: clear new_state pointers at hw_done
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        Sean Paul <seanpaul@chromium.org>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Missatge de Rob Clark <robdclark@gmail.com> del dia dl., 4 de nov.
2019 a les 18:42:
>
> From: Rob Clark <robdclark@chromium.org>
>
> The new state should not be accessed after this point.  Clear the
> pointers to make that explicit.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

While looking to another issue I applied this patch on top of 5.4-rc7
and my display stopped working. The system gets stuck with the
messages below

...
[   17.558689] rockchip-vop ff8f0000.vop: Adding to iommu group 1
[   17.566014] rk3399-gru-sound sound: ASoC: failed to init link DP: -517
[   17.567618] rockchip-vop ff900000.vop: Adding to iommu group 2
[   17.580671] rk3399-gru-sound sound: ASoC: failed to init link DP: -517
[   17.585996] rockchip-drm display-subsystem: bound ff8f0000.vop (ops
vop_component_ops [rockchipdrm])
[   17.589294] rk3399-gru-sound sound: ASoC: failed to init link DP: -517
[   17.599899] rockchip-drm display-subsystem: bound ff900000.vop (ops
vop_component_ops [rockchipdrm])
[   17.615846] rockchip-dp ff970000.edp: no DP phy configured
[   17.622495] rockchip-drm display-subsystem: bound ff970000.edp (ops
rockchip_dp_component_ops [rockchipdrm])
[   17.633688] rockchip-drm display-subsystem: bound fec00000.dp (ops
cdn_dp_component_ops [rockchipdrm])
[   17.644141] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   17.651548] [drm] No driver support for vblank timestamp query.

Not really useful information at this point, but I am wondering if
could be that the rockchip driver is doing something wrong more than
this patch is wrong?

Thanks,
 Enric

> ---
>  drivers/gpu/drm/drm_atomic_helper.c | 30 +++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 648494c813e5..aec9759d9df2 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -2246,12 +2246,42 @@ EXPORT_SYMBOL(drm_atomic_helper_fake_vblank);
>   */
>  void drm_atomic_helper_commit_hw_done(struct drm_atomic_state *old_state)
>  {
> +       struct drm_connector *connector;
> +       struct drm_connector_state *old_conn_state, *new_conn_state;
>         struct drm_crtc *crtc;
>         struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> +       struct drm_plane *plane;
> +       struct drm_plane_state *old_plane_state, *new_plane_state;
>         struct drm_crtc_commit *commit;
> +       struct drm_private_obj *obj;
> +       struct drm_private_state *old_obj_state, *new_obj_state;
>         int i;
>
> +       /*
> +        * After this point, drivers should not access the permanent modeset
> +        * state, so we also clear the new_state pointers to make this
> +        * restriction explicit.
> +        *
> +        * For the CRTC state, we do this in the same loop where we signal
> +        * hw_done, since we still need to new_crtc_state to fish out the
> +        * commit.
> +        */
> +
> +       for_each_oldnew_connector_in_state(old_state, connector, old_conn_state, new_conn_state, i) {
> +               old_state->connectors[i].new_state = NULL;
> +       }
> +
> +       for_each_oldnew_plane_in_state(old_state, plane, old_plane_state, new_plane_state, i) {
> +               old_state->planes[i].new_state = NULL;
> +       }
> +
> +       for_each_oldnew_private_obj_in_state(old_state, obj, old_obj_state, new_obj_state, i) {
> +               old_state->private_objs[i].new_state = NULL;
> +       }
> +
>         for_each_oldnew_crtc_in_state(old_state, crtc, old_crtc_state, new_crtc_state, i) {
> +               old_state->crtcs[i].new_state = NULL;
> +
>                 commit = new_crtc_state->commit;
>                 if (!commit)
>                         continue;
> --
> 2.23.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
