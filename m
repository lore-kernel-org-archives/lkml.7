Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB2CECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBD5206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:59:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar-org.20150623.gappssmtp.com header.i=@fooishbar-org.20150623.gappssmtp.com header.b="Zk7zrYDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfJKL7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:59:18 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44615 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJKL7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:59:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id m13so9510254ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qZxcysWcGBjK40AA/XUOIdw3iHtZgIgHG9FtdNWtwBI=;
        b=Zk7zrYDiiAloCyPwmmtaBGLskO2Fx1VMfLtS0bvFGEfrMXwqWjgwR0fLfvMCm0mhNb
         CvaDy0a+1pSt6z/9qZkexB2994P9n/iUPRpzZL7ZHOUacbuyY2ZAbPSQJQcTp3Xkl99p
         Py83bspMfff+i7yzB2pP/ZM5cHgVwagS0RKJHIFBsklI6O44CO+pY/NF8aZBbb+WT7Ep
         e3UTNNptN5s+r5NWbU+5gAv2U4bxSS2MOHZbK4rmM2X+fRvYidMhfxKcE3+6y+zc5SrG
         kSFEpHjXj3MNmevmM1KqxBJSl7swdsnabGzHoo9gG3j6zN818LNg0U24WI49R/W+Jq6d
         m+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qZxcysWcGBjK40AA/XUOIdw3iHtZgIgHG9FtdNWtwBI=;
        b=d41bhDSwTBy8CxGtrktLI8TwuJyid+tudgD/x6ZKwTEgLYOtccpMsNL18e1cGQG3eH
         F/MoOY68cJdfsgFdwM/FfqE/y8Y8pHdJ4i2aOeTfvsESPPtrUcvTF7cEOBMPQgD6a7Uu
         JQYLsHAX054FXxnsn+1pzi/f+AT6RZfPV4k8e/zMzc4Uekp9IaFG9ue+gnIhNc3gM5RZ
         KeGIZtm/lr+SuC/DXLn+NbFqqpL24GHNO7NMQnK9vW9Vz3PhozKmBmmKbIoap97HCRH7
         tvisEk8jrrrjc//xOSW4UO1oOgv2nKCTWH2D4BcLbyIrAaWfrEfh/47+lgLRdG9lqO7w
         TC8Q==
X-Gm-Message-State: APjAAAXKzkvCoh8dxDIxi8T1QnmnVI02ShRq+YxANDAF7N6aJZmwYsF1
        VR9U1OJPD2ona9xZ9a2y7513VZZyWs+Q8uFQDsM0aA==
X-Google-Smtp-Source: APXvYqyu8ngFvs0Ijr0BcLjn77SktYZ8O5FQq+oWdsZebG5H9lIAvGxp6elULEAs295/M0RD9pF16TysYOraX+QU4KA=
X-Received: by 2002:a2e:957:: with SMTP id 84mr8958337ljj.245.1570795153555;
 Fri, 11 Oct 2019 04:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20191011111813.20851-1-andrzej.p@collabora.com> <20191011111813.20851-3-andrzej.p@collabora.com>
In-Reply-To: <20191011111813.20851-3-andrzej.p@collabora.com>
From:   Daniel Stone <daniel@fooishbar.org>
Date:   Fri, 11 Oct 2019 12:59:02 +0100
Message-ID: <CAPj87rNb=Sa2Hg8KZK5ioocdv0BMj9c3NHK2v4UZibMmw2DdGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/rockchip: Add support for afbc
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Brian Starkey <brian.starkey@arm.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrzej,

On Fri, 11 Oct 2019 at 12:18, Andrzej Pietrasiewicz
<andrzej.p@collabora.com> wrote:
> @@ -32,6 +35,46 @@ rockchip_fb_alloc(struct drm_device *dev, const struct drm_mode_fb_cmd2 *mode_cm
>         int ret;
>         int i;
>
> +       if (mode_cmd->modifier[0]) {
> +               const struct drm_format_info *info;
> +               int bpp;
> +
> +               if (mode_cmd->modifier[0] &

Use != here, not &~.

> +       case DRM_FORMAT_BGR888:
> +               return AFBC_FMT_U8U8U8;
> +       case DRM_FORMAT_RGB565:
> +       case DRM_FORMAT_BGR565:
> +               return AFBC_FMT_RGB565;
> +       default:
> +               DRM_ERROR("unsupported afbc format[%08x]\n", format);

This should not be reachable, because you shouldn't be able to create
a framebuffer with an unsupported format/modifier combination.

> +static bool rockchip_mod_supported(struct drm_plane *plane,
> +                                  u32 format, u64 modifier)
> +{
> +       const struct drm_format_info *info;
> +
> +       if (WARN_ON(modifier == DRM_FORMAT_MOD_INVALID))
> +               return false;
> +
> +       if (modifier == DRM_FORMAT_MOD_LINEAR)
> +               return true;
> +
> +       if (modifier & ~DRM_FORMAT_MOD_ARM_AFBC(

Again use != here.

> +                               AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 |
> +                               AFBC_FORMAT_MOD_SPARSE
> +                       )
> +       ) {
> +               DRM_DEBUG_KMS("Unsupported format modifer 0x%llx\n", modifier);
> +
> +               return false;
> +       }
> +
> +       info = drm_format_info(format);
> +       if (info->num_planes != 1) {
> +               DRM_DEBUG_KMS("AFBC buffers expect one plane\n");
> +               return false;
> +       }

This is where you should reject unsupported format + AFBC
combinations. Doing it here prevents it from ever being advertised to
userspace in the first place.

> @@ -808,6 +919,24 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
>
>         spin_lock(&vop->reg_lock);
>
> +       if (fb->modifier == DRM_FORMAT_MOD_ARM_AFBC(
> +               AFBC_FORMAT_MOD_BLOCK_SIZE_16x16 | AFBC_FORMAT_MOD_SPARSE)) {
> +               int afbc_format = vop_convert_afbc_format(fb->format->format);
> +
> +               VOP_AFBC_SET(vop, format, afbc_format | 1 << 4);

I assume the (1 << 4) programs the 16x16 block size. Can we support
other block sizes?

> +               VOP_AFBC_SET(vop, hreg_block_split, 0);

Does this mean we can also support AFBC_FORMAT_MOD_SPLIT?

> +               VOP_AFBC_SET(vop, win_sel, VOP_WIN_TO_INDEX(vop_win));
> +               VOP_AFBC_SET(vop, hdr_ptr, dma_addr);
> +               VOP_AFBC_SET(vop, pic_size, act_info);
> +
> +               /*
> +                * The window being udated becomes the AFBC window
> +                */
> +               vop->afbc_win = vop_win;
> +
> +               pr_info("AFBC on plane %s\n", plane->name);

Please do not use pr_info() here. Userspace should not be able to
trigger logging, apart from DRM_DEBUG.

> +static const uint64_t format_modifiers_win_full[] = {
> +       DRM_FORMAT_MOD_NONE,

*DRM_FORMAT_MOD_LINEAR

Cheers,
Daniel
