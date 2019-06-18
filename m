Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31F9C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23A120873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 21:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfFRVrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 17:47:35 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43559 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfFRVre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 17:47:34 -0400
Received: by mail-ua1-f65.google.com with SMTP id o2so7584166uae.10;
        Tue, 18 Jun 2019 14:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0RWfX7/brWCQJZlmTP4b1pf0cVwk5bUjTnCrdF8UAY=;
        b=cUXKUiQ935N3nlS6kFzB0TCzb78U/V078a6zAg8F82mDBMaMZoPg24ItFFb8STlRVS
         F0qSgwpTj19HwCLZuQ5/VqymocKDL9fmNtXngjG4hw9y/LiEtjX/racQ8UdhvRXcbUUu
         oYHz8JQ9FFwRGHsOXSB8+ZYOd3MJA6lJQrBLQdJZMzOtSWW6H9hAyOiZwv9UfhPQzpUs
         0Jqzmn2jcRfg7Fa9Lx5xfMz3wUM/GW7AZv9cFgzmVk3fosTWXsiqx5iz2A0i2yswVRQg
         7alXD9gi3PqGitRKAd9lsc5rc3Y/SIFoGkm3Mu+T5cS3uPGa1SXHgL2d6Qi8ImVl3p3g
         ZMFQ==
X-Gm-Message-State: APjAAAX2jRINuruQlVgUrOa1WZ/ZQS84rlABKMfZ+NTTTavUoL97atj3
        kLzVFQr7S/StsmNNsiDuu47/1925KSo0reKl+kg=
X-Google-Smtp-Source: APXvYqxuHJvBUgcTAIF7H6uuKf/TgeRQI8Gc97Xr2WBYZISyfbVN7S7r7p3sI20JELN7OjPaH4dM5N25VHb2Dddyzm8=
X-Received: by 2002:a9f:31a2:: with SMTP id v31mr12191937uad.15.1560894453845;
 Tue, 18 Jun 2019 14:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190618213406.7667-1-ezequiel@collabora.com> <20190618213406.7667-3-ezequiel@collabora.com>
In-Reply-To: <20190618213406.7667-3-ezequiel@collabora.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Tue, 18 Jun 2019 17:47:22 -0400
Message-ID: <CAKb7UvgvY0tJDV9A=4+8=iqraziyt8SGF-QrX=M8jz+R+5JC=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/rockchip: Add optional support for CRTC gamma LUT
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rockchip@lists.infradead.org,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 5:43 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Add an optional CRTC gamma LUT support, and enable it on RK3288.
> This is currently enabled via a separate address resource,
> which needs to be specified in the devicetree.
>
> The address resource is required because on some SoCs, such as
> RK3288, the LUT address is after the MMU address, and the latter
> is supported by a different driver. This prevents the DRM driver
> from requesting an entire register space.
>
> The current implementation works for RGB 10-bit tables, as that
> is what seems to work on RK3288.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> ---
> Changes from RFC:
> * Request (an optional) address resource for the LUT.
> * Drop support for RK3399, which doesn't seem to work
>   out of the box and needs more research.
> * Support pass-thru setting when GAMMA_LUT is NULL.
> * Add a check for the gamma size, as suggested by Ilia.
> * Move gamma setting to atomic_commit_tail, as pointed
>   out by Jacopo/Laurent, is the correct way.
> ---
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> index 12ed5265a90b..5b6edbe2673f 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
> +static void vop_crtc_gamma_set(struct vop *vop, struct drm_crtc *crtc,
> +                              struct drm_crtc_state *old_state)
> +{
> +       int idle, ret, i;
> +
> +       spin_lock(&vop->reg_lock);
> +       VOP_REG_SET(vop, common, dsp_lut_en, 0);
> +       vop_cfg_done(vop);
> +       spin_unlock(&vop->reg_lock);
> +
> +       ret = readx_poll_timeout(vop_dsp_lut_is_enable, vop,
> +                          idle, !idle, 5, 30 * 1000);
> +       if (ret)
> +               return;
> +
> +       spin_lock(&vop->reg_lock);
> +
> +       if (crtc->state->gamma_lut) {
> +               if (!old_state->gamma_lut || (crtc->state->gamma_lut->base.id !=
> +                                             old_state->gamma_lut->base.id))
> +                       vop_crtc_write_gamma_lut(vop, crtc);
> +       } else {
> +               for (i = 0; i < crtc->gamma_size; i++) {
> +                       u32 word;
> +
> +                       word = (i << 20) | (i << 10) | i;
> +                       writel(word, vop->lut_regs + i * 4);
> +               }

Note - I'm not in any way familiar with the hardware, so take with a
grain of salt --

Could you just leave dsp_lut_en turned off in this case?

Cheers,

  -ilia

> +       }
> +
> +       VOP_REG_SET(vop, common, dsp_lut_en, 1);
> +       vop_cfg_done(vop);
> +       spin_unlock(&vop->reg_lock);
> +}
