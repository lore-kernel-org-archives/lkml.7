Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24287C282DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A3421738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbfDWLkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:40:47 -0400
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:44123 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726421AbfDWLkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:40:47 -0400
Received: from [IPv6:2001:420:44c1:2579:c4cd:9df1:43f2:db66] ([IPv6:2001:420:44c1:2579:c4cd:9df1:43f2:db66])
        by smtp-cloud8.xs4all.net with ESMTPA
        id ItmohttJvb8gSItmshZhAB; Tue, 23 Apr 2019 13:40:44 +0200
Subject: Re: [PATCH v9 4/4] media: cedrus: Add H264 decoding support
To:     Maxime Ripard <maxime.ripard@bootlin.com>, acourbot@chromium.org,
        sakari.ailus@linux.intel.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     tfiga@chromium.org, posciak@chromium.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        nicolas.dufresne@collabora.com, jenskuske@gmail.com,
        jernej.skrabec@gmail.com, jonas@kwiboo.se, ezequiel@collabora.com,
        linux-sunxi@googlegroups.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.dec5630d6b289e0a50e1880be436050471a05269.1554975396.git-series.maxime.ripard@bootlin.com>
 <6b92ca41b62929ae2f9dd3872ae0a2c5aa5690d8.1554975396.git-series.maxime.ripard@bootlin.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <1a5dc054-e3dd-94b0-bd34-58c08c0a45ec@xs4all.nl>
Date:   Tue, 23 Apr 2019 13:40:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <6b92ca41b62929ae2f9dd3872ae0a2c5aa5690d8.1554975396.git-series.maxime.ripard@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPh3RfFfFTpkNeekdpJJQ/mw7haiKrQFbMBfakQgGUOiKC1lMRgMPh+l30zp0J+ThLHZuumSbSOPQeFVSED8WYNQ6EYyfZAaQ1374+2BTL44Mdl9GZu/
 Z7XGYfGeI5Q/Kggtv8FF/Dvchc5yvAr/hK6FJGhsQ04UqciqhsdtI1P4c+aFkTNiTqVZ7Hs88aLApFHcgKPvDw42Ip9ZSKZjEj9U1RQ0BGWsjFnal1iOvbnA
 cFcoS8aqPGVBYLDehVI8VhPGIjMgpsETL2URPRvXzKyeC14vzS5e/GFAeNVB/leu12kTtIoaV9/a8/kM/yaUv/Y2LPvqfejgYKtKx5IWlIDyorIGgRvMng5e
 LIMg0hbuVJL6V4bX3Odv+X/MUgmaYgJMwrTt1qLX2o+3Z5WhcRwC1kv2JhmHywyT1XR0dWCiAFi5rG6oCZVSFm3nfztUDiycMY7k1USexoUDmRhZY44Td5xa
 /5m+HJU2Y01P6h4eT5L8VONH+QJfAd0djFaFZ6tS0CI7LFCKylH/QKpz8pGdigIPvQT+kQ2lQbaT31B6rhzhW0GhM3UJG1w3CYklh0imCWzpQzCmh5MTF6mL
 dQWROIjnYZdW3HEem1RIMtrPfdldBBkazS7GIRnf3S/qyKD+wuvXq84y/rwN9mfXD2WQLr3WLfMjJ5tDwmLaTJcVp4X65OKudC+wXfKF5nserebd4M5YZY6Q
 l2BO+00YZRdJAC3k4YuUFl/jgvXcGHDNSPWqjS/1CPzB4Uc72WmF1lbBw49qkIqRHZ9GowOMp5yfcDJl3rEjCQZ5FxzJfMxWzVvTpuSZvreUgGHWtrACLmq1
 x+XmWvxVEjTLRdytLaySVhcq5WdLAOVibqvKfqFmGVnyeodZpkJapWTvje/VI40sAf5nl2dF+JyGPx45DVLyEd10aT0t4BPPnJ1+j2Qf4JAmofrOm1dRH3NO
 5G18jsc9KOqD+rVDtf0XSuad/Ic=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

While rebasing my cedrus-h264 pull request and running sparse over the
newly rebased code I found these sparse warnings:

SPARSE:drivers/staging/media/sunxi/cedrus/cedrus_h264.c drivers/staging/media/sunxi/cedrus/cedrus_h264.c:80:34:  warning: incorrect type in assignment (different base types)
SPARSE:drivers/staging/media/sunxi/cedrus/cedrus_h264.c drivers/staging/media/sunxi/cedrus/cedrus_h264.c:81:37:  warning: incorrect type in assignment (different base types)
SPARSE:drivers/staging/media/sunxi/cedrus/cedrus_h264.c drivers/staging/media/sunxi/cedrus/cedrus_h264.c:82:25:  warning: incorrect type in assignment (different base types)
SPARSE:drivers/staging/media/sunxi/cedrus/cedrus_h264.c drivers/staging/media/sunxi/cedrus/cedrus_h264.c:84:23:  warning: incorrect type in assignment (different base types)
SPARSE:drivers/staging/media/sunxi/cedrus/cedrus_h264.c drivers/staging/media/sunxi/cedrus/cedrus_h264.c:85:25:  warning: incorrect type in assignment (different base types)
SPARSE:drivers/staging/media/sunxi/cedrus/cedrus_h264.c drivers/staging/media/sunxi/cedrus/cedrus_h264.c:86:29:  warning: incorrect type in assignment (different base types)
SPARSE:drivers/staging/media/sunxi/cedrus/cedrus_h264.c drivers/staging/media/sunxi/cedrus/cedrus_h264.c:87:29:  warning: incorrect type in assignment (different base types)

These warnings seem valid:

On 4/11/19 11:37 AM, Maxime Ripard wrote:
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_h264.c b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> new file mode 100644
> index 000000000000..2c98a3e46d2b
> --- /dev/null
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_h264.c
> @@ -0,0 +1,574 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Cedrus VPU driver
> + *
> + * Copyright (c) 2013 Jens Kuske <jenskuske@gmail.com>
> + * Copyright (c) 2018 Bootlin
> + */
> +
> +#include <linux/types.h>
> +
> +#include <media/videobuf2-dma-contig.h>
> +
> +#include "cedrus.h"
> +#include "cedrus_hw.h"
> +#include "cedrus_regs.h"
> +
> +enum cedrus_h264_sram_off {
> +	CEDRUS_SRAM_H264_PRED_WEIGHT_TABLE	= 0x000,
> +	CEDRUS_SRAM_H264_FRAMEBUFFER_LIST	= 0x100,
> +	CEDRUS_SRAM_H264_REF_LIST_0		= 0x190,
> +	CEDRUS_SRAM_H264_REF_LIST_1		= 0x199,
> +	CEDRUS_SRAM_H264_SCALING_LIST_8x8_0	= 0x200,
> +	CEDRUS_SRAM_H264_SCALING_LIST_8x8_1	= 0x210,
> +	CEDRUS_SRAM_H264_SCALING_LIST_4x4	= 0x220,
> +};
> +
> +struct cedrus_h264_sram_ref_pic {
> +	__le32	top_field_order_cnt;
> +	__le32	bottom_field_order_cnt;
> +	__le32	frame_info;
> +	__le32	luma_ptr;
> +	__le32	chroma_ptr;
> +	__le32	mv_col_top_ptr;
> +	__le32	mv_col_bot_ptr;
> +	__le32	reserved;

These types are __le32, but...

> +} __packed;
> +
> +#define CEDRUS_H264_FRAME_NUM		18
> +
> +#define CEDRUS_NEIGHBOR_INFO_BUF_SIZE	(16 * SZ_1K)
> +#define CEDRUS_PIC_INFO_BUF_SIZE	(128 * SZ_1K)
> +
> +static void cedrus_h264_write_sram(struct cedrus_dev *dev,
> +				   enum cedrus_h264_sram_off off,
> +				   const void *data, size_t len)
> +{
> +	const u32 *buffer = data;
> +	size_t count = DIV_ROUND_UP(len, 4);
> +
> +	cedrus_write(dev, VE_AVC_SRAM_PORT_OFFSET, off << 2);
> +
> +	while (count--)
> +		cedrus_write(dev, VE_AVC_SRAM_PORT_DATA, *buffer++);
> +}
> +
> +static dma_addr_t cedrus_h264_mv_col_buf_addr(struct cedrus_ctx *ctx,
> +					      unsigned int position,
> +					      unsigned int field)
> +{
> +	dma_addr_t addr = ctx->codec.h264.mv_col_buf_dma;
> +
> +	/* Adjust for the position */
> +	addr += position * ctx->codec.h264.mv_col_buf_field_size * 2;
> +
> +	/* Adjust for the field */
> +	addr += field * ctx->codec.h264.mv_col_buf_field_size;
> +
> +	return addr;
> +}
> +
> +static void cedrus_fill_ref_pic(struct cedrus_ctx *ctx,
> +				struct cedrus_buffer *buf,
> +				unsigned int top_field_order_cnt,
> +				unsigned int bottom_field_order_cnt,
> +				struct cedrus_h264_sram_ref_pic *pic)
> +{
> +	struct vb2_buffer *vbuf = &buf->m2m_buf.vb.vb2_buf;
> +	unsigned int position = buf->codec.h264.position;
> +
> +	pic->top_field_order_cnt = top_field_order_cnt;
> +	pic->bottom_field_order_cnt = bottom_field_order_cnt;
> +	pic->frame_info = buf->codec.h264.pic_type << 8;
> +
> +	pic->luma_ptr = cedrus_buf_addr(vbuf, &ctx->dst_fmt, 0);
> +	pic->chroma_ptr = cedrus_buf_addr(vbuf, &ctx->dst_fmt, 1);
> +	pic->mv_col_top_ptr = cedrus_h264_mv_col_buf_addr(ctx, position, 0);
> +	pic->mv_col_bot_ptr = cedrus_h264_mv_col_buf_addr(ctx, position, 1);

... here regular types are assigned to the pic fields.

I assume that cpu_to_le32() is needed here.

I'm not sure how I missed this when I made the initial pull request,
but I think it would make sense if you post a rebased and fixed v10.

Regards,

	Hans
