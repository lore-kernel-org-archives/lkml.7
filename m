Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69882C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CAAC20651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 14:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0bXGO2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfG3OJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 10:09:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42749 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbfG3OJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 10:09:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id x1so16042643wrr.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 07:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LZsG/s5jOtsbzlRKW8PKqAQkBM+xaVVYAfsSo2wPupA=;
        b=T0bXGO2XKLP4M7xqw5lCTKWqVX653o6KAihg4YH2utjTY7W8HvQFClzNjx+rRAwQfq
         BcZgRUsRyhpe1TXm4vmbFAK6UlT1BtFIdJ5s1/FIFnN26q/ATEWFjmSHY6qywRTKszvf
         V5NczzKud8EGdcbTZ8PaV0ei42m8Ix09VDdg2YWzFW1I140ajIuW+Ddq7fOg/SSBe+0G
         9MQmLc+WG3O+23Iz7u4S2GZZcyPlTsSIIxJyJpTC7mtPRuHoZ8ywrqZyMLKUqE3Nsd/h
         iMgW2NcNV42PbBBA/U4XdA4ytGyM61xXbyh03yMrg7+rT57kOpMI57mdKsZPfIUk1AQD
         vV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LZsG/s5jOtsbzlRKW8PKqAQkBM+xaVVYAfsSo2wPupA=;
        b=g+SWEWnU0POiQmEaFYy068DQbcBz8Ycwn1qie3M4eXaQeDVSZXbZkvcJtrMqUDNDv3
         txK2+JPECsjDloSPD6/GBxOBmitdVuvY2NOn9YmWKebn6fU9/fP/aeSPnw42ikWS/WrZ
         ag1rfMyjDi7uAp3miXPjFz1kzmFljpxn/9Mt92+Nmwg0tg3Svp33oVgv2bcK74PIwplA
         KKSQfEVoJ1E4+PEvVFel4KPC0xZyMGOF4+98+M/EaE6JC0tt0iQ96pP1rxC0VHKasXeq
         qRCksg2qLOXJm3VCwQp0uw6QNHh4OBfZkFCAM4U9IL5fbh2CW9kL/+Qwu57y08XBLZhw
         rl/g==
X-Gm-Message-State: APjAAAUXgaWXQXHx8i3tdY3eJybHrzLjilpyQkCedrZJBqKwpDX3KrlC
        EWtfoeaDO8CgR25RAngwpRE=
X-Google-Smtp-Source: APXvYqxMKz2wtegCn7OUJY6HW6Laq+z6G/oA++W8N45yWo9Ir6l7vzfB6T9+085tqTZO2YSw3tSppQ==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr126346630wrp.101.1564495762176;
        Tue, 30 Jul 2019 07:09:22 -0700 (PDT)
Received: from arch-x1c3 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
        by smtp.gmail.com with ESMTPSA id f192sm67862071wmg.30.2019.07.30.07.09.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 07:09:21 -0700 (PDT)
Date:   Tue, 30 Jul 2019 15:08:52 +0100
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.net>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] drm: uapi: add gdepaper uapi header
Message-ID: <20190730140852.GB12424@arch-x1c3>
References: <3c8fccc9-63f7-18bb-dcb5-dcd0b9e151d2@jaseg.net>
 <0e22c86a-3998-c2fd-cb14-203df547eb5c@jaseg.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e22c86a-3998-c2fd-cb14-203df547eb5c@jaseg.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 2019/07/30, Jan Sebastian Götte wrote:
> Signed-off-by: Jan Sebastian Götte <linux@jaseg.net>
> ---
>  include/uapi/drm/gdepaper_drm.h | 62 +++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 include/uapi/drm/gdepaper_drm.h
> 
> diff --git a/include/uapi/drm/gdepaper_drm.h b/include/uapi/drm/gdepaper_drm.h
> new file mode 100644
> index 000000000000..84ff6429bef5
> --- /dev/null
> +++ b/include/uapi/drm/gdepaper_drm.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/* gdepaper_drm.h
> + *
> + * Copyright (c) 2019 Jan Sebastian Götte
> + */
> +
I'm glad to see more devices using upstream KMS interface. Usually
custom UAPI should not be needed for such devices.

Can you elaborate why this is required? Is there an open-source
userspace that uses these?


> +#ifndef _UAPI_GDEPAPER_DRM_H_
> +#define _UAPI_GDEPAPER_DRM_H_
> +
> +#include "drm.h"
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
> +enum drm_gdepaper_vghl_lv {
> +	DRM_GDEP_PWR_VGHL_16V = 0,
> +	DRM_GDEP_PWR_VGHL_15V = 1,
> +	DRM_GDEP_PWR_VGHL_14V = 2,
> +	DRM_GDEP_PWR_VGHL_13V = 3,
> +};
> +
> +struct gdepaper_refresh_params {
> +	enum drm_gdepaper_vghl_lv vg_lv; /* gate voltage level */
From my experience, kernel drivers aim to avoid exposing voltage control
to userspace. AFAICT exceptions are present, but generally it's a no-go.


> +	__u32 vcom_sel; /* VCOM select bit according to datasheet */
> +	__s32 vdh_bw_mv; /* drive high level, b/w pixel (mV) */
> +	__s32 vdh_col_mv; /* drive high level, red/yellow pixel (mV) */
> +	__s32 vdl_mv; /* drive low level (mV) */
> +	__s32 vcom_dc_mv;
> +	__u32 vcom_data_ivl_hsync; /* data ivl len in hsync periods */
> +	__u32 border_data_sel; /* "vbd" in datasheet */
> +	__u32 data_polarity; /* "ddx" in datasheet */
These properties look like they should live in the device-tree bindings.

> +	__u32 use_otp_luts_flag; /* Use OTP LUTs */
> +	__u8 lut_vcom_dc[44];
> +	__u8 lut_ww[42];
> +	__u8 lut_bw[42];
> +	__u8 lut_bb[42];
> +	__u8 lut_wb[42];
There is UAPI to manage LUT (or was it WIP with patches on the list) via
the atomic API. Is that not flexible enough for your needs?

> +};
> +
> +/* Force a full display refresh */
> +#define DRM_GDEPAPER_FORCE_FULL_REFRESH		0x00
> +#define DRM_GDEPAPER_GET_REFRESH_PARAMS		0x01
> +#define DRM_GDEPAPER_SET_REFRESH_PARAMS		0x02
> +#define DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN	0x03
> +
> +#define DRM_IOCTL_GDEPAPER_FORCE_FULL_REFRESH \
> +	DRM_IO(DRM_COMMAND_BASE + DRM_GDEPAPER_FORCE_FULL_REFRESH)
> +#define DRM_IOCTL_GDEPAPER_GET_REFRESH_PARAMS \
> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_GET_REFRESH_PARAMS, \
> +	struct gdepaper_refresh_params)
> +#define DRM_IOCTL_GDEPAPER_SET_REFRESH_PARAMS \
> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_REFRESH_PARAMS, \
> +	struct gdepaper_refresh_params)
> +#define DRM_IOCTL_GDEPAPER_SET_PARTIAL_UPDATE_EN \
> +	DRM_IOR(DRM_COMMAND_BASE + DRM_GDEPAPER_SET_PARTIAL_UPDATE_EN, __u32)
> +
Similarly to the LUT above, the atomic UAPI has support for partial
updates. The property is called FB_DAMAGE_CLIPS and there is an example
in weston how to use it see 009b3cfa6f16bb361eb54efcc7435bfede4524bc.

HTH
Emil
