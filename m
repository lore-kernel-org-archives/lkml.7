Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF03BC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BF920663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XWtBPn9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbfFXUD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:03:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:39306 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731334AbfFXUD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:03:28 -0400
Received: by mail-io1-f65.google.com with SMTP id r185so95561iod.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5G5TGMZ6AYi5gRQNnYnWdNq47kMogCEidAxRTjgan2s=;
        b=XWtBPn9ibpqotN/2oTx9ERROro6K607uDjcBZubtfZ7AWCAdk2ckqc80ebr81hYsSI
         ManUcxBZ7CpcbYP/eRkdTt7HCnpsIIeyh7Uo6Vn3wjXexTEfwL+8zXXVp43P6HvcPOaq
         hP0kyexxzW11HpYpHOyzzIY/K7o6DbmZCV9D4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5G5TGMZ6AYi5gRQNnYnWdNq47kMogCEidAxRTjgan2s=;
        b=FDHHU6e9FmJSwbL8kX8+W4jD3/NGFrYBSPVuEkDoqStLJAJ69QVQuZ+eWxtcJj+n1i
         J4+g/g1Mx5c2GBSoCISyQIePv8kMOw3iChmuvxMw3lde+mNfsgWhWsJJlGR5ZtudMgkb
         V3F+WsCZBSU/8lN8aJ1PHTLA02bdjleZnSwpB12kVHpyCz9UHE2uw7gE85iw0tRHZ8k7
         wn3RuVw+XglUYt3+530ysvD4s9uRa6h3nMrNSPI+fQeh5fVwkarMd1IHcTFIO0zhGyfD
         La1QRUd6FdV8OU6CUcfiyWHpt2uOCrt+eC77sJ4xl1zVJunmqzRkLzkP9wYnHqlD8PdO
         Lwlw==
X-Gm-Message-State: APjAAAWji1SpvGpfcGLET6GJsaf9EZyFbah3f1V4/DsS9jNZGUh6qQkD
        FJlcJlj3S6l6OjJjy2DTnew3M/qPhr8=
X-Google-Smtp-Source: APXvYqyO0lavY4TEOnoQhAc708AK2czv0bLIkz3oB4sjYWaSJ9m7SOZM28PY9PNcCv5QbYLO+8D9+g==
X-Received: by 2002:a5e:9e0a:: with SMTP id i10mr35371913ioq.44.1561406607191;
        Mon, 24 Jun 2019 13:03:27 -0700 (PDT)
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com. [209.85.166.41])
        by smtp.gmail.com with ESMTPSA id o5sm12557654iob.7.2019.06.24.13.03.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:03:25 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id u13so402155iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:03:24 -0700 (PDT)
X-Received: by 2002:a5d:8ccc:: with SMTP id k12mr30848489iot.141.1561406604290;
 Mon, 24 Jun 2019 13:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190621211346.1324-1-ezequiel@collabora.com> <20190621211346.1324-3-ezequiel@collabora.com>
In-Reply-To: <20190621211346.1324-3-ezequiel@collabora.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 24 Jun 2019 13:03:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V3dq0qS2Finw7gxbZqyRvuLqGv-573LHX+41odjBOTxA@mail.gmail.com>
Message-ID: <CAD=FV=V3dq0qS2Finw7gxbZqyRvuLqGv-573LHX+41odjBOTxA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] drm/rockchip: Add optional support for CRTC gamma LUT
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 21, 2019 at 2:14 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
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
> Changes from v1:
> * drop explicit linear LUT after finding a proper
>   way to disable gamma correction.
> * avoid setting gamma is the CRTC is not active.
> * s/int/unsigned int as suggested by Jacopo.
> * only enable color management and set gamma size
>   if gamma LUT is supported, suggested by Doug.
> * drop the reg-names usage, and instead just use indexed reg
>   specifiers, suggested by Doug.
>
> Changes from RFC:
> * Request (an optional) address resource for the LUT.
> * Drop support for RK3399, which doesn't seem to work
>   out of the box and needs more research.
> * Support pass-thru setting when GAMMA_LUT is NULL.
> * Add a check for the gamma size, as suggested by Ilia.
> * Move gamma setting to atomic_commit_tail, as pointed
>   out by Jacopo/Laurent, is the correct way.
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_fb.c  |   3 +
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 114 ++++++++++++++++++++
>  drivers/gpu/drm/rockchip/rockchip_drm_vop.h |   7 ++
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c |   2 +
>  4 files changed, 126 insertions(+)

Looks happy to me now.  Since I'm not a DRM expert and almost
certainly don't know much about gamma LUT, take this as you will:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

I'm not in front of my veyron device at the moment, so I can't re-test
exactly this patch so I won't add a Tested-by tag.  However, I'll note
that earlier versions worked for the test app I was able to find in
Chrome OS and I'd imagine this one does too.

-Doug
