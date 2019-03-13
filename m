Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23391C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89602171F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 12:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qquxyPd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbfCMMuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 08:50:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43856 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725888AbfCMMuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 08:50:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id d17so1848570wre.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 05:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hdQqXACzWtbqvQ1fYfm3kxt0Fsl6Q7LrCctJ8mgMNrc=;
        b=qquxyPd1wDm4IFZ9Z3lkfCMSypn7HrQAnW4RlVuZ7T2NXiaZTayPwRqkfIDV7LPoAD
         1B83c423VpI+bVb4vCwfzrtjmqn/Hnkn91nX50axdmhMA25GllkU5JoeHUEKijPvSnEz
         dDKmkoKo5ckK97OBftc9RQA9/0Q4TFti0D0ULgD3ZPPYMZwho36wys/exQZbqhLQzriO
         C722dv614EQsSnG+NkqDDtGCh+RPIRVQgHsJdkV7K8McKS8e6Y0Ev94PjZNsQIKL+kg1
         RfiVY37No3Z7papKEFjYfNzr2ZFURkQJo/EIyKYp3ztOUZ5W5L9N5CCEQffVYMsyFJpi
         kgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hdQqXACzWtbqvQ1fYfm3kxt0Fsl6Q7LrCctJ8mgMNrc=;
        b=jNsjKKmxVlRook/NuUCfW4w4iRKtJ43L6p5lypD05rHco3TjYZm4piAv7FDNwq/FKY
         E+g+ksEpdlHalwj29D4Lg/puWCjQwkJ6wgEBj4TEUQNbyR7K+W00fCySd5G7SMqPjaZl
         KVyCxCZOHiTsVdTSLxLD7oO8y2BfCdtoY6RD8O0ruk0r5eB9+6lNEBBMXgdj5qECQMUA
         4obRdrSm4hEPhAKuq5WZkDiB3y0jwneKBEyO1Y91+h5x+V5G/doRBbQb/IOHUkzGkLKF
         z9Ooi9dppK8cNzgmITnKHAA6VDrCaXGXYMdA8UAwlqbI2wWyykr0bv2xf1eJDN8uVIY5
         S5Yg==
X-Gm-Message-State: APjAAAVgeRZxrR8lvdGHWQzmvxq/q3khf3x/42t7Cskxl/w7Q0tx2Ry4
        1lZIugRIaPfieFPu9bDUXSBeBg==
X-Google-Smtp-Source: APXvYqyLCZjDU7zWtZKq5YZ+zWkKzr+yaz374D6AadXl4/Es7ixeIfVb1qFCQqYFi2RTJFXBp8sN+A==
X-Received: by 2002:a5d:52ca:: with SMTP id r10mr28746546wrv.187.1552481413311;
        Wed, 13 Mar 2019 05:50:13 -0700 (PDT)
Received: from [192.168.1.62] (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id v4sm2431885wmg.1.2019.03.13.05.50.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 05:50:12 -0700 (PDT)
Subject: Re: [PATCH 0/2] drm/meson: only allow using meson-canvas
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20190311105144.7276-1-mjourdan@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <375bb9db-50bb-000a-077b-6f090ae73039@baylibre.com>
Date:   Wed, 13 Mar 2019 13:50:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190311105144.7276-1-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2019 11:51, Maxime Jourdan wrote:
> This patch series aims at removing access to the DMC register range from
> the meson DRM driver, and is the final step at fully migrating it to using
> the meson canvas provider module.
> 
> Please see the commit notes of patch 1/2
> "dt-bindings: display: amlogic, meson-vpu: exclusively use amlogic,canvas"
> for more information.
> 
> This series also incorporates a probing fix proposed by Neil Armstrong [1]
> although rewritten because of heavy code changes in the corresponding
> location.
> 
> [1] https://lkml.org/lkml/2019/2/4/152
> 
> Maxime Jourdan (2):
>   dt-bindings: display: amlogic, meson-vpu: exclusively use
>     amlogic,canvas
>   drm/meson: exclusively use the canvas provider module
> 
>  .../bindings/display/amlogic,meson-vpu.txt    |  5 +-
>  drivers/gpu/drm/meson/Makefile                |  2 +-
>  drivers/gpu/drm/meson/meson_canvas.c          | 73 ----------------
>  drivers/gpu/drm/meson/meson_canvas.h          | 51 -----------
>  drivers/gpu/drm/meson/meson_crtc.c            | 84 ++++++-------------
>  drivers/gpu/drm/meson/meson_drv.c             | 68 ++++++---------
>  drivers/gpu/drm/meson/meson_drv.h             |  1 -
>  drivers/gpu/drm/meson/meson_overlay.c         |  8 --
>  drivers/gpu/drm/meson/meson_plane.c           |  6 +-
>  drivers/gpu/drm/meson/meson_viu.c             |  1 -
>  10 files changed, 53 insertions(+), 246 deletions(-)
>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
> 

Will apply on drm-misc-next for 5.2 when ready !

Neil
