Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCC2C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C6621848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hVmQr1Gn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbfJIOuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:50:16 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35717 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIOuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:50:16 -0400
Received: by mail-ed1-f65.google.com with SMTP id v8so2314067eds.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 07:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pPIM3FVIyT4/97LZJrg01pJy7drmhWtVlls1Zso13no=;
        b=hVmQr1GnBuN40rDT4E/BRln+PJoMbsljTx3gzRJTOJM0UUYm8V9NUURUafrM4bJqsw
         WlpvqyEy6xMYETra2Uss7YjZaW5Lfyv4K2oVU+Ak7xSxoNmZdSkJ97LaUlomVfv6xgEQ
         qirtaSShBcRrHxGhZmzzUYOIw3ST6+UNKeZ2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=pPIM3FVIyT4/97LZJrg01pJy7drmhWtVlls1Zso13no=;
        b=D6HRVSnRiRMFTrOpP6PgbMEo/BOqUx2Ex60q5TJV+RoSZoxyFczCszOPxNDVNw06Rd
         db0gS4OQeYQsHNtI7oRGpo128GRODkk4OzLpHJDH15i9U3Gk42IRbkD3eKkfzePXvaiq
         vwFc738wnO5xcBcUREWcp9Pf0d8YDsi5Con1MmBCnlY3LXahYMTEFnX7gegFjQFTRI9T
         XmIOmHlEQKoprIR90drFpZIx9PoSbgWBgSV+5gwsHx5++bs1rpfGrdcSLB1zoYZBouQ4
         kEvfeA3bt00d2Mev5S9ZSYZ4QKvoTpezn+eMPZYBYmy+8lmCsQjYNOvJiBWiQRm3zfFM
         oSGg==
X-Gm-Message-State: APjAAAWiGfmhmPsi+Vx7vSCZkIjWhBDxyzYzPYX3NscREz2HXno+BbhM
        LVPuHkgUF6dkK0oX/QxqJGeRJg==
X-Google-Smtp-Source: APXvYqzC/vaAU5Hwqs5iVlB9k9gKRt59IN2idRdOSETZNdFWZMypkQIsONWbgpgTS741jKSCwurSVw==
X-Received: by 2002:a50:8f65:: with SMTP id 92mr3485562edy.9.1570632612053;
        Wed, 09 Oct 2019 07:50:12 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id f36sm384659ede.28.2019.10.09.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 07:50:10 -0700 (PDT)
Date:   Wed, 9 Oct 2019 16:50:08 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sandy Huang <hjc@rock-chips.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, heiko@sntech.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm: Add some new format DRM_FORMAT_NVXX_10
Message-ID: <20191009145008.GB16989@phenom.ffwll.local>
Mail-Followup-To: Sandy Huang <hjc@rock-chips.com>,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        heiko@sntech.de, linux-kernel@vger.kernel.org
References: <1569486289-152061-1-git-send-email-hjc@rock-chips.com>
 <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569486289-152061-2-git-send-email-hjc@rock-chips.com>
X-Operating-System: Linux phenom 5.2.0-2-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 04:24:47PM +0800, Sandy Huang wrote:
> These new format is supported by some rockchip socs:
> 
> DRM_FORMAT_NV12_10/DRM_FORMAT_NV21_10
> DRM_FORMAT_NV16_10/DRM_FORMAT_NV61_10
> DRM_FORMAT_NV24_10/DRM_FORMAT_NV42_10
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 18 ++++++++++++++++++
>  include/uapi/drm/drm_fourcc.h | 14 ++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index c630064..ccd78a3 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -261,6 +261,24 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_P016,		.depth = 0,  .num_planes = 2,
>  		  .char_per_block = { 2, 4, 0 }, .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 },
>  		  .hsub = 2, .vsub = 2, .is_yuv = true},
> +		{ .format = DRM_FORMAT_NV12_10,		.depth = 0,  .num_planes = 2,
> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> +		{ .format = DRM_FORMAT_NV21_10,		.depth = 0,  .num_planes = 2,
> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> +		  .hsub = 2, .vsub = 2, .is_yuv = true},
> +		{ .format = DRM_FORMAT_NV16_10,		.depth = 0,  .num_planes = 2,
> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> +		  .hsub = 2, .vsub = 1, .is_yuv = true},
> +		{ .format = DRM_FORMAT_NV61_10,		.depth = 0,  .num_planes = 2,
> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> +		  .hsub = 2, .vsub = 1, .is_yuv = true},
> +		{ .format = DRM_FORMAT_NV24_10,		.depth = 0,  .num_planes = 2,
> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> +		  .hsub = 1, .vsub = 1, .is_yuv = true},
> +		{ .format = DRM_FORMAT_NV42_10,		.depth = 0,  .num_planes = 2,
> +		  .char_per_block = { 5, 10, 0 }, .block_w = { 4, 4, 0 }, .block_h = { 4, 4, 0 },
> +		  .hsub = 1, .vsub = 1, .is_yuv = true},
>  		{ .format = DRM_FORMAT_P210,		.depth = 0,
>  		  .num_planes = 2, .char_per_block = { 2, 4, 0 },
>  		  .block_w = { 1, 0, 0 }, .block_h = { 1, 0, 0 }, .hsub = 2,

Yup this is what I had in mind with using the block stuff to describe your
new 10bit yuv formats. Thanks for respining.

Once we've nailed the exact bit description of the format precisely this
can be merged imo.
-Daniel

> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 3feeaa3..08e2221 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -238,6 +238,20 @@ extern "C" {
>  #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
>  
>  /*
> + * 2 plane YCbCr
> + * index 0 = Y plane, Y3:Y2:Y1:Y0 10:10:10:10
> + * index 1 = Cb:Cr plane, Cb3:Cr3:Cb2:Cr2:Cb1:Cr1:Cb0:Cr0 10:10:10:10:10:10:10:10
> + * or
> + * index 1 = Cr:Cb plane, Cr3:Cb3:Cr2:Cb2:Cr1:Cb1:Cr0:Cb0 10:10:10:10:10:10:10:10
> + */
> +#define DRM_FORMAT_NV12_10	fourcc_code('N', 'A', '1', '2') /* 2x2 subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV21_10	fourcc_code('N', 'A', '2', '1') /* 2x2 subsampled Cb:Cr plane */
> +#define DRM_FORMAT_NV16_10	fourcc_code('N', 'A', '1', '6') /* 2x1 subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV61_10	fourcc_code('N', 'A', '6', '1') /* 2x1 subsampled Cb:Cr plane */
> +#define DRM_FORMAT_NV24_10	fourcc_code('N', 'A', '2', '4') /* non-subsampled Cr:Cb plane */
> +#define DRM_FORMAT_NV42_10	fourcc_code('N', 'A', '4', '2') /* non-subsampled Cb:Cr plane */
> +
> +/*
>   * 2 plane YCbCr MSB aligned
>   * index 0 = Y plane, [15:0] Y:x [10:6] little endian
>   * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
> -- 
> 2.7.4
> 
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
