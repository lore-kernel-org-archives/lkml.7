Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADD0C282DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A611D20663
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 08:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Fnv8tMY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbfDIInB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 04:43:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55309 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfDIInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 04:43:01 -0400
Received: by mail-wm1-f66.google.com with SMTP id o25so2404477wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 01:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=xujZFl7+mdLrITdSmQph4p4nUeZGxoKQhCsVJeIsGCI=;
        b=Fnv8tMY00LRKWvdQcKO3+D1iN3jujpEgawAVIcc/f29A5jD1oh9gXCKdKfuZgJfx0M
         5yUYYyHd/Jh3z1vi0QdHOFWJfZNXgQ5Hfo4vpLvTZmXVtFEUkchLIJzleYnmEv0rz2Sg
         d5+JCTmby3YSPXsMA+38wcNxSHE99tDn2GO2CHFB/seJsYu8sRiKGPf40NxThUwrYjj/
         BrAwyOWPzQc5h87iO6KzUO+jNUvr62uc5g8h8+iYi85tvdWqPgWujfG704KycP0yyW6q
         +NqjHYMXgphLBLtmvuVfOYLmIEXv+FrFh/SToEpwbk5Xys/jS3Bx88TE0rOx64l0Ef4q
         V/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=xujZFl7+mdLrITdSmQph4p4nUeZGxoKQhCsVJeIsGCI=;
        b=lrLoMnDqJsZJmzGK4Vab7WXadiQEZzNNUBiTra3ES2k5jWPkAebNcFZfc4iFbBx247
         jQd5e2nsrgeoW5fHTLucGUpbASgx5hNrlRxe1Ta+87p2T+RlCU8/sBvyPhM8bFsm47JJ
         tByaowZWLlsDFEDwdIcu6ggn1CHpFU0U7cF9Ij3iFcX99sSZ6dkegQe0hTmWLYvgm0dv
         5Bq5IKK+jzxfuszxtirkC+twVwS3j/NSoB4Kk/MY+ql7XOWa73iQpWgU+hh1UR4Jep2W
         Tr+YGCxMzyieBlUTUD5UBENSjjgxhi3f98QSsPnHFoHckfiKDVLqOB0n8vA4smdtWXQc
         uRHQ==
X-Gm-Message-State: APjAAAXi1LaxGa4HZLHLKD3RRjnv/P0QaqnhuT6QdxByHSNqWAyYF11E
        ZdDjRLcACTqeoJVQ3UIRelR5HbmXaF8=
X-Google-Smtp-Source: APXvYqwXlCbKIR4f2RliTNtIcOOhdK2k3B1AWnP1a3bXBKPQpcUVT17DOyrrL5Trg9+dxSLFsMC/7w==
X-Received: by 2002:a1c:9991:: with SMTP id b139mr19664950wme.53.1554799379124;
        Tue, 09 Apr 2019 01:42:59 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id q3sm42779575wrr.75.2019.04.09.01.42.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 09 Apr 2019 01:42:58 -0700 (PDT)
Message-ID: <824430c056a151003d82755a00a06263be1d877e.camel@baylibre.com>
Subject: Re: [PATCH 06/11] drm/meson: Add G12A Support for the Overlay video
 plane
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 09 Apr 2019 10:42:57 +0200
In-Reply-To: <20190325141824.21259-7-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
         <20190325141824.21259-7-narmstrong@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-25 at 15:18 +0100, Neil Armstrong wrote:
> Amlogic G12A SoC supports the same set of Video Planes, but now
> are handled by the new OSD plane blender module.
> 
> This patch uses the same VD1 plane for G12A, using the exact same scaler
> and VD11 setup registers, except using the new blender register to
> disable the plane.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/meson/meson_overlay.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_overlay.c b/drivers/gpu/drm/meson/meson_overlay.c
> index b54a22e483b9..bdbf925ff3e8 100644
> --- a/drivers/gpu/drm/meson/meson_overlay.c
> +++ b/drivers/gpu/drm/meson/meson_overlay.c
> @@ -516,8 +516,14 @@ static void meson_overlay_atomic_disable(struct drm_plane *plane,
>  	priv->viu.vd1_enabled = false;
>  
>  	/* Disable VD1 */
> -	writel_bits_relaxed(VPP_VD1_POSTBLEND | VPP_VD1_PREBLEND, 0,
> -			    priv->io_base + _REG(VPP_MISC));
> +	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
> +		writel_relaxed(0, priv->io_base + _REG(VD1_BLEND_SRC_CTRL));
> +		writel_relaxed(0, priv->io_base + _REG(VD2_BLEND_SRC_CTRL));
> +		writel_relaxed(0, priv->io_base + _REG(VD1_IF0_GEN_REG + 0x17b0));
> +		writel_relaxed(0, priv->io_base + _REG(VD2_IF0_GEN_REG + 0x17b0));

Is it possible to add a comment explaining this 0x17b0 value ?

> +	} else
> +		writel_bits_relaxed(VPP_VD1_POSTBLEND | VPP_VD1_PREBLEND, 0,
> +				    priv->io_base + _REG(VPP_MISC));
>  
>  }
>  


