Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9867C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C30A207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 17:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMNIwPei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfLJROx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 12:14:53 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:38481 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbfLJROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 12:14:53 -0500
Received: by mail-vk1-f195.google.com with SMTP id e5so1769977vkn.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 09:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=awtlruUsEk2kRl+JtKPViU1iCb8JGLYj7o5vhOb4Zxw=;
        b=VMNIwPei4Z4YUYDLsEl9KqXQl63xLpJ5ELTx1+OiHRL/BHtXjdyURCnVdAmZ8wTQ7Q
         u11ipBhMigkHOXVNieXgNe49Ibc2KTCR7V99VxqqzUCv5GC0rKugzNIBvNAwKSGuHLhS
         XErp43zQqVFEdqmpOv0tHzNqrHo0fagjwdnT8YM6tWO0kCR7IF8ODElssQgByxfNSXjF
         jcIh8vaf+GXHU8tT1HaASbImmrA5/ROZwaYfgTONZuNVlfLj88hGE6WM9kisbv1e4le7
         f+tPEo2+QnReocINW3Y+lw73Az1Fpckq1/Mv4vdRUy89xo2M8E3TF3TWjCDylAz0bcKf
         0/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=awtlruUsEk2kRl+JtKPViU1iCb8JGLYj7o5vhOb4Zxw=;
        b=oGIVNlouWlgC68Jsv4Tn/u4gsRvka6AB900orINH3FddteX5zW4mSkW7ymUR+L+r5J
         e3031CmrAhY2MEEcYT6ZvIGC3z96s7y9JQQUIjvNmJAVG8+Evb5UjeRm+u3GwWug/FxJ
         AbQAC9kLm4XLA6Jxn4bC4484bOuNOgBKrpy9j3A6GWEjQo4yeI39q4odjH1FnwSAiADY
         72M1hjat0z3Z/o+9sNLeC29oH36MQ7EOkVjNdnEFEtbzQbUOp6Gyrl2QfQjMJemCCUA+
         fp1DnjgTw/rKslDZyZqbL2x+BMP5ZNWgdEq7nxDNV+g0qmj4l+xXGdsHDw7CbTfdcFC1
         wrqA==
X-Gm-Message-State: APjAAAUHVaZFNG84tXMNBTDqtFePGoO5zbR2mEKO9ptZXdiND29BxbOk
        +hsx0qiN4uGMFjNX0cuxZeSCUqH0zyHRi0kz+Y0=
X-Google-Smtp-Source: APXvYqzumzI2gkBVqenl2uRLitu2zhun0WYxgzHzRMCOFggIX7PtF3YAQ9TIWKbG5HWivRcUPURj0WX5sXazZKIzeQk=
X-Received: by 2002:a1f:cec2:: with SMTP id e185mr5218012vkg.22.1575998091409;
 Tue, 10 Dec 2019 09:14:51 -0800 (PST)
MIME-Version: 1.0
References: <1575966995-13757-1-git-send-email-kevin3.tang@gmail.com> <1575966995-13757-5-git-send-email-kevin3.tang@gmail.com>
In-Reply-To: <1575966995-13757-5-git-send-email-kevin3.tang@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 10 Dec 2019 17:13:37 +0000
Message-ID: <CACvgo50Hgbb8ywX2RgFqkitxwBG64EhP9g1TSxgLkQf-6L6soA@mail.gmail.com>
Subject: Re: [PATCH RFC 4/8] drm/sprd: add Unisoc's drm display controller driver
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        orsonzhai@gmail.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        zhang.lyra@gmail.com, baolin.wang@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Tue, 10 Dec 2019 at 08:41, Kevin Tang <kevin3.tang@gmail.com> wrote:
>
> From: Kevin Tang <kevin.tang@unisoc.com>
>
> Adds DPU(Display Processor Unit) support for the Unisoc's display subsystem.
> It's support multi planes, scaler, rotation, PQ(Picture Quality) and more.
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linaro.org>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  drivers/gpu/drm/sprd/Makefile       |    6 +-
>  drivers/gpu/drm/sprd/disp_lib.c     |  290 +++++++
>  drivers/gpu/drm/sprd/disp_lib.h     |   40 +
>  drivers/gpu/drm/sprd/dpu/Makefile   |    8 +
>  drivers/gpu/drm/sprd/dpu/dpu_r2p0.c | 1464 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dpu.c     | 1152 +++++++++++++++++++++++++++
>  drivers/gpu/drm/sprd/sprd_dpu.h     |  217 ++++++
>  7 files changed, 3176 insertions(+), 1 deletion(-)

As we can see from the diff stat this patch is huge. So it would be fairly hard
to provide meaningful review as-is.

One can combine my earlier suggestion (to keep modeset/atomic out of 2/8), with
the following split:
 - 4/8 add basic atomic modeset support - one format, one rotation 0, no extra
 attributes
 - 5/8 add extra formats
 - 6/8 add extra rotation support
 - ... add custom attributes

<snip>

> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/disp_lib.c

> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/disp_lib.h

Let's keep this code out, for now. If we really need it we could revive/add it
at a later stage.

<snip>

> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/dpu/dpu_r2p0.c
> @@ -0,0 +1,1464 @@


> +struct gamma_entry {
> +       u16 r;
> +       u16 g;
> +       u16 b;
> +};
> +
Seem to be unused. Please drop this and double-check for other unused structs


> +static struct scale_cfg scale_copy;
> +static struct cm_cfg cm_copy;
> +static struct slp_cfg slp_copy;
> +static struct gamma_lut gamma_copy;
> +static struct hsv_lut hsv_copy;
> +static struct epf_cfg epf_copy;
> +static u32 enhance_en;
> +
> +static DECLARE_WAIT_QUEUE_HEAD(wait_queue);
> +static bool panel_ready = true;
> +static bool need_scale;
> +static bool mode_changed;
> +static bool evt_update;
> +static bool evt_stop;
> +static u32 prev_y2r_coef;
> +
We should really avoid static variables. Some of the above look like enhancer
state. One could create a struct keeping it alongside the rest of the display
pipeline, right?


<snip>

> +static void dpu_enhance_backup(u32 id, void *param)
> +{
As the enhance code is fairly large, lets keep the portions to a separate patch.


<snip>

> +static struct dpu_core_ops dpu_r2p0_ops = {
Nit: as a general rule ops should be const.


> +static int __init dpu_core_register(void)
> +{
> +       return dpu_core_ops_register(&entry);
> +}
> +
> +subsys_initcall(dpu_core_register);
I think that subsys_initcall, __init and MODULE area applicable only
when we have multiple
modules. Not 100% sure though ;-)


> diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
> new file mode 100644
> index 0000000..43142b3
> --- /dev/null
> +++ b/drivers/gpu/drm/sprd/sprd_dpu.c

> +struct sprd_plane {
> +       struct drm_plane plane;
> +       struct drm_property *alpha_property;
> +       struct drm_property *blend_mode_property;
Core DRM already has alpha and blend_mode properties. Please reuse the code


> +       struct drm_property *fbc_hsize_r_property;
> +       struct drm_property *fbc_hsize_y_property;
> +       struct drm_property *fbc_hsize_uv_property;
> +       struct drm_property *y2r_coef_property;
> +       struct drm_property *pallete_en_property;
> +       struct drm_property *pallete_color_property;
Let's have these properties introduced with separate follow-up patches.
Please mention, in the commit message, why they are specific to the driver.


<snip>

> +static int sprd_dpu_init(struct sprd_dpu *dpu)
> +{
> +       struct dpu_context *ctx = &dpu->ctx;
> +
> +       down(&ctx->refresh_lock);
> +
> +       if (dpu->ctx.is_inited) {
> +               up(&ctx->refresh_lock);
> +               return 0;
> +       }
> +
> +       if (dpu->glb && dpu->glb->power)
> +               dpu->glb->power(ctx, true);
> +       if (dpu->glb && dpu->glb->enable)
> +               dpu->glb->enable(ctx);
> +
> +       if (ctx->is_stopped && dpu->glb && dpu->glb->reset)
> +               dpu->glb->reset(ctx);
> +
> +       if (dpu->clk && dpu->clk->init)
> +               dpu->clk->init(ctx);
> +       if (dpu->clk && dpu->clk->enable)
> +               dpu->clk->enable(ctx);
> +
> +       if (dpu->core && dpu->core->init)
> +               dpu->core->init(ctx);
> +       if (dpu->core && dpu->core->ifconfig)
> +               dpu->core->ifconfig(ctx);
> +
Hmm I can see the core, clk and glb (ops) being added to the respective lists.
Yet the code which adds those to the dpu isn't so obvious. Where is it?


> +       ctx->is_inited = true;
> +
Nit: is_inited -> initialized



<snip>

> +struct dpu_core_ops {
> +       int (*parse_dt)(struct dpu_context *ctx,
> +                       struct device_node *np);
> +       u32 (*version)(struct dpu_context *ctx);
> +       int (*init)(struct dpu_context *ctx);
> +       void (*uninit)(struct dpu_context *ctx);
> +       void (*run)(struct dpu_context *ctx);
> +       void (*stop)(struct dpu_context *ctx);
> +       void (*disable_vsync)(struct dpu_context *ctx);
> +       void (*enable_vsync)(struct dpu_context *ctx);
> +       u32 (*isr)(struct dpu_context *ctx);
> +       void (*ifconfig)(struct dpu_context *ctx);
> +       void (*write_back)(struct dpu_context *ctx, u8 count, bool debug);
> +       void (*flip)(struct dpu_context *ctx,
> +                    struct sprd_dpu_layer layers[], u8 count);
> +       int (*capability)(struct dpu_context *ctx,
> +                       struct dpu_capability *cap);
> +       void (*bg_color)(struct dpu_context *ctx, u32 color);
> +       void (*enhance_set)(struct dpu_context *ctx, u32 id, void *param);
> +       void (*enhance_get)(struct dpu_context *ctx, u32 id, void *param);
> +       int (*modeset)(struct dpu_context *ctx,
> +                       struct drm_mode_modeinfo *mode);
> +       bool (*check_raw_int)(struct dpu_context *ctx, u32 mask);
> +};
> +
> +struct dpu_clk_ops {
> +       int (*parse_dt)(struct dpu_context *ctx,
> +                       struct device_node *np);
> +       int (*init)(struct dpu_context *ctx);
> +       int (*uinit)(struct dpu_context *ctx);
> +       int (*enable)(struct dpu_context *ctx);
> +       int (*disable)(struct dpu_context *ctx);
> +       int (*update)(struct dpu_context *ctx, int clk_id, int val);
> +};
> +
> +struct dpu_glb_ops {
> +       int (*parse_dt)(struct dpu_context *ctx,
> +                       struct device_node *np);
> +       void (*enable)(struct dpu_context *ctx);
> +       void (*disable)(struct dpu_context *ctx);
> +       void (*reset)(struct dpu_context *ctx);
> +       void (*power)(struct dpu_context *ctx, int enable);
> +};
> +
Some of the above seem unused - parse_dt for example. Please drop the dead code.


HTH
Emil
