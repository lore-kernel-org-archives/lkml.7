Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55452C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19B5F20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfC1PGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:06:42 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:50609 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725816AbfC1PGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:06:42 -0400
Received: from [IPv6:2001:420:44c1:2579:7126:11db:5076:31b1] ([IPv6:2001:420:44c1:2579:7126:11db:5076:31b1])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 9Wbzh7DAYNG8z9Wc2hpjFZ; Thu, 28 Mar 2019 16:06:39 +0100
Subject: Re: [PATCH,v1] media: mtk-vcodec: enlarge struct vdec_pic_info fields
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1553307820-19681-1-git-send-email-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <f870a6fa-b9af-9064-f677-a9f52226e60b@xs4all.nl>
Date:   Thu, 28 Mar 2019 16:06:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553307820-19681-1-git-send-email-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAlBvQFxENi2wbSTvYUwPuVhU13KPP5+jQp1/avfsGT6zlXmFxuzks/v3WSzoWxkHZyUPT7DN+k57aJvUva+CVMoDCzwTjB8FP8xeZeqt2qnNmjmS+pR
 S6FKkJ9brXI0cq3bbzbZcn3QFefcsDIPcrpN5L79jZJRX7DiVneamLY7CgcCfwNkdobiDUsEe/WhaOgw40hFJPmD37jfUKpiuFBQzRjY9KtIiawUvmdr8zhK
 IR/RWliND3PnbInv1zhBle+BJepc6qBtP+UJUGH//xwC5/SEj3ajsVq8MCngTw8MoEpqOOfod2Zpz3zsy8JR8qaTjr5rDfZ/NQJmPHafPWKcRN0scwrq4P4C
 APrDI9nHi6vALpQOp1KUfF32tw8guDuIl6168BZDuf2SKI0ShtWTzNvRUQVDZFNkHLygnD3vu2iDu2SA5+1H7ZYc2J4Mc9vBNKUl3csKYRJCEL/GLrlgP8FD
 Vb41ZOb1tM+H+/K2RugZoAQZ3JuSAcM4yeLi1Sdw3XCOC9pGpKig6g2jAnZsFQK+987+20ZflWY/14NBaJfVJO8zJisEYD5DdJNOabIw2cHM8gMH0ZPVVDoy
 Cjiyg3P5U/U8R6dSj28xJIwN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/19 3:23 AM, Yunfei Dong wrote:
> Enlarge the plane number to support more complex case
> and add the support for fmt change case.
> 
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../platform/mtk-vcodec/mtk_vcodec_dec.c      | 62 +++++++++++++------
>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      | 16 ++---
>  .../platform/mtk-vcodec/vdec/vdec_h264_if.c   |  4 +-
>  .../platform/mtk-vcodec/vdec/vdec_vp8_if.c    |  4 +-
>  .../platform/mtk-vcodec/vdec/vdec_vp9_if.c    | 11 ++--
>  5 files changed, 57 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> index d022c65bb34c..43587c0cb022 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
> @@ -129,9 +129,9 @@ static struct vb2_buffer *get_display_buffer(struct mtk_vcodec_ctx *ctx)
>  	mutex_lock(&ctx->lock);
>  	if (dstbuf->used) {
>  		vb2_set_plane_payload(&dstbuf->vb.vb2_buf, 0,
> -					ctx->picinfo.y_bs_sz);
> +					ctx->picinfo.fb_sz[0]);
>  		vb2_set_plane_payload(&dstbuf->vb.vb2_buf, 1,
> -					ctx->picinfo.c_bs_sz);
> +					ctx->picinfo.fb_sz[1]);
>  
>  		dstbuf->ready_to_display = true;
>  
> @@ -278,6 +278,27 @@ static void mtk_vdec_flush_decoder(struct mtk_vcodec_ctx *ctx)
>  	clean_free_buffer(ctx);
>  }
>  
> +static void mtk_vdec_update_fmt(struct mtk_vcodec_ctx *ctx,
> +				unsigned int pixelformat)
> +{
> +	struct mtk_video_fmt *fmt;
> +	struct mtk_q_data *dst_q_data;
> +	unsigned int k;
> +
> +	dst_q_data = &ctx->q_data[MTK_Q_DATA_DST];
> +	for (k = 0; k < NUM_FORMATS; k++) {
> +		fmt = &mtk_video_formats[k];
> +		if (fmt->fourcc == pixelformat) {
> +			mtk_v4l2_debug(1, "Update cap fourcc(%d -> %d)",
> +				dst_q_data->fmt.fourcc, pixelformat);
> +			dst_q_data->fmt = fmt;
> +			return;
> +		}
> +	}
> +
> +	mtk_v4l2_err("Cannot get fourcc(%d), using init value", pixelformat);
> +}
> +
>  static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
>  {
>  	unsigned int dpbsize = 0;
> @@ -299,6 +320,10 @@ static int mtk_vdec_pic_info_update(struct mtk_vcodec_ctx *ctx)
>  		return -EINVAL;
>  	}
>  
> +	if (ctx->last_decoded_picinfo.cap_fourcc != ctx->picinfo.cap_fourcc &&
> +		ctx->picinfo.cap_fourcc != 0)
> +		mtk_vdec_update_fmt(ctx, ctx->picinfo.cap_fourcc);
> +
>  	if ((ctx->last_decoded_picinfo.pic_w == ctx->picinfo.pic_w) ||
>  	    (ctx->last_decoded_picinfo.pic_h == ctx->picinfo.pic_h))
>  		return 0;
> @@ -352,11 +377,11 @@ static void mtk_vdec_worker(struct work_struct *work)
>  	pfb = &dst_buf_info->frame_buffer;
>  	pfb->base_y.va = vb2_plane_vaddr(&dst_buf->vb2_buf, 0);
>  	pfb->base_y.dma_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
> -	pfb->base_y.size = ctx->picinfo.y_bs_sz + ctx->picinfo.y_len_sz;
> +	pfb->base_y.size = ctx->picinfo.fb_sz[0];
>  
>  	pfb->base_c.va = vb2_plane_vaddr(&dst_buf->vb2_buf, 1);
>  	pfb->base_c.dma_addr = vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 1);
> -	pfb->base_c.size = ctx->picinfo.c_bs_sz + ctx->picinfo.c_len_sz;
> +	pfb->base_c.size = ctx->picinfo.fb_sz[1];
>  	pfb->status = 0;
>  	mtk_v4l2_debug(3, "===>[%d] vdec_if_decode() ===>", ctx->id);
>  
> @@ -976,14 +1001,13 @@ static int vidioc_vdec_g_fmt(struct file *file, void *priv,
>  		 * So we just return picinfo yet, and update picinfo in
>  		 * stop_streaming hook function
>  		 */
> -		q_data->sizeimage[0] = ctx->picinfo.y_bs_sz +
> -					ctx->picinfo.y_len_sz;
> -		q_data->sizeimage[1] = ctx->picinfo.c_bs_sz +
> -					ctx->picinfo.c_len_sz;
> +		q_data->sizeimage[0] = ctx->picinfo.fb_sz[0];
> +		q_data->sizeimage[1] = ctx->picinfo.fb_sz[1];
>  		q_data->bytesperline[0] = ctx->last_decoded_picinfo.buf_w;
>  		q_data->bytesperline[1] = ctx->last_decoded_picinfo.buf_w;
>  		q_data->coded_width = ctx->picinfo.buf_w;
>  		q_data->coded_height = ctx->picinfo.buf_h;
> +		ctx->last_decoded_picinfo.cap_fourcc = q_data->fmt->fourcc;
>  
>  		/*
>  		 * Width and height are set to the dimensions
> @@ -1103,10 +1127,11 @@ static void vb2ops_vdec_buf_queue(struct vb2_buffer *vb)
>  	struct mtk_vcodec_mem src_mem;
>  	bool res_chg = false;
>  	int ret = 0;
> -	unsigned int dpbsize = 1;
> +	unsigned int dpbsize = 1, i = 0;
>  	struct mtk_vcodec_ctx *ctx = vb2_get_drv_priv(vb->vb2_queue);
>  	struct vb2_v4l2_buffer *vb2_v4l2 = NULL;
>  	struct mtk_video_dec_buf *buf = NULL;
> +	struct mtk_q_data *dst_q_data;
>  
>  	mtk_v4l2_debug(3, "[%d] (%d) id=%d, vb=%p",
>  			ctx->id, vb->vb2_queue->type,
> @@ -1194,21 +1219,18 @@ static void vb2ops_vdec_buf_queue(struct vb2_buffer *vb)
>  	}
>  
>  	ctx->last_decoded_picinfo = ctx->picinfo;
> -	ctx->q_data[MTK_Q_DATA_DST].sizeimage[0] =
> -						ctx->picinfo.y_bs_sz +
> -						ctx->picinfo.y_len_sz;
> -	ctx->q_data[MTK_Q_DATA_DST].bytesperline[0] =
> -						ctx->picinfo.buf_w;
> -	ctx->q_data[MTK_Q_DATA_DST].sizeimage[1] =
> -						ctx->picinfo.c_bs_sz +
> -						ctx->picinfo.c_len_sz;
> -	ctx->q_data[MTK_Q_DATA_DST].bytesperline[1] = ctx->picinfo.buf_w;
> +	dst_q_data = &ctx->q_data[MTK_Q_DATA_DST];
> +	for (i = 0; i < dst_q_data->fmt->num_planes; i++) {
> +		dst_q_data->sizeimage[i] = ctx->picinfo.fb_sz[i];
> +		dst_q_data->bytesperline[i] = ctx->picinfo.buf_w;
> +	}
> +
>  	mtk_v4l2_debug(2, "[%d] vdec_if_init() OK wxh=%dx%d pic wxh=%dx%d sz[0]=0x%x sz[1]=0x%x",
>  			ctx->id,
>  			ctx->picinfo.buf_w, ctx->picinfo.buf_h,
>  			ctx->picinfo.pic_w, ctx->picinfo.pic_h,
> -			ctx->q_data[MTK_Q_DATA_DST].sizeimage[0],
> -			ctx->q_data[MTK_Q_DATA_DST].sizeimage[1]);
> +			dst_q_data->sizeimage[0],
> +			dst_q_data->sizeimage[1]);
>  
>  	ret = vdec_if_get_param(ctx, GET_PARAM_DPB_SIZE, &dpbsize);
>  	if (dpbsize == 0)
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> index e7e2a108def9..2899028b53a1 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> @@ -211,12 +211,9 @@ struct mtk_vcodec_pm {
>   * @pic_h: picture height
>   * @buf_w: picture buffer width (64 aligned up from pic_w)
>   * @buf_h: picture buffer heiht (64 aligned up from pic_h)
> - * @y_bs_sz: Y bitstream size
> - * @c_bs_sz: CbCr bitstream size
> - * @y_len_sz: additional size required to store decompress information for y
> - *		plane
> - * @c_len_sz: additional size required to store decompress information for cbcr
> - *		plane
> + * @fb_sz: bitstream size of each plane
> + * @cap_fourcc: fourcc number(may changed when resolutin change)

resolutin -> resolution

> + * @reserved: reserved for future use.
>   * E.g. suppose picture size is 176x144,
>   *      buffer size will be aligned to 176x160.

I think this last comment belongs after field fb_sz, right?

>   */
> @@ -225,10 +222,9 @@ struct vdec_pic_info {
>  	unsigned int pic_h;
>  	unsigned int buf_w;
>  	unsigned int buf_h;
> -	unsigned int y_bs_sz;
> -	unsigned int c_bs_sz;
> -	unsigned int y_len_sz;
> -	unsigned int c_len_sz;
> +	unsigned int fb_sz[VIDEO_MAX_PLANES];
> +	unsigned int cap_fourcc;
> +	unsigned int reserved;

Why add a reserved field? Isn't this an internal structure?

>  };
>  
>  /**
> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
> index 02c960c63ac0..cdbcd6909728 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
> +++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_h264_if.c
> @@ -253,8 +253,8 @@ static void get_pic_info(struct vdec_h264_inst *inst,
>  	*pic = inst->vsi->pic;
>  	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
>  			 pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> -	mtk_vcodec_debug(inst, "Y(%d, %d), C(%d, %d)", pic->y_bs_sz,
> -			 pic->y_len_sz, pic->c_bs_sz, pic->c_len_sz);
> +	mtk_vcodec_debug(inst, "fb size: Y(%d), C(%d)",
> +			 pic->fb_sz[0], pic->fb_sz[1]);
>  }
>  
>  static void get_crop_info(struct vdec_h264_inst *inst, struct v4l2_rect *cr)
> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
> index bac3723038de..ba79136421ef 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp8_if.c
> @@ -294,8 +294,8 @@ static void get_pic_info(struct vdec_vp8_inst *inst, struct vdec_pic_info *pic)
>  
>  	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
>  			 pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> -	mtk_vcodec_debug(inst, "Y(%d, %d), C(%d, %d)", pic->y_bs_sz,
> -			 pic->y_len_sz, pic->c_bs_sz, pic->c_len_sz);
> +	mtk_vcodec_debug(inst, "fb size: Y(%d), C(%d)",
> +			 pic->fb_sz[0], pic->fb_sz[1]);
>  }
>  
>  static void vp8_dec_finish(struct vdec_vp8_inst *inst)
> diff --git a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> index bc8349bc2e80..6fe83207bbc4 100644
> --- a/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> +++ b/drivers/media/platform/mtk-vcodec/vdec/vdec_vp9_if.c
> @@ -702,10 +702,8 @@ static void init_all_fb_lists(struct vdec_vp9_inst *inst)
>  
>  static void get_pic_info(struct vdec_vp9_inst *inst, struct vdec_pic_info *pic)
>  {
> -	pic->y_bs_sz = inst->vsi->buf_sz_y_bs;
> -	pic->c_bs_sz = inst->vsi->buf_sz_c_bs;
> -	pic->y_len_sz = inst->vsi->buf_len_sz_y;
> -	pic->c_len_sz = inst->vsi->buf_len_sz_c;
> +	pic->fb_sz[0] = inst->vsi->buf_sz_y_bs + inst->vsi->buf_len_sz_y;
> +	pic->fb_sz[1] = inst->vsi->buf_sz_c_bs + inst->vsi->buf_len_sz_c;
>  
>  	pic->pic_w = inst->vsi->pic_w;
>  	pic->pic_h = inst->vsi->pic_h;
> @@ -714,8 +712,9 @@ static void get_pic_info(struct vdec_vp9_inst *inst, struct vdec_pic_info *pic)
>  
>  	mtk_vcodec_debug(inst, "pic(%d, %d), buf(%d, %d)",
>  		 pic->pic_w, pic->pic_h, pic->buf_w, pic->buf_h);
> -	mtk_vcodec_debug(inst, "Y(%d, %d), C(%d, %d)", pic->y_bs_sz,
> -		 pic->y_len_sz, pic->c_bs_sz, pic->c_len_sz);
> +	mtk_vcodec_debug(inst, "fb size: Y(%d), C(%d)",
> +		pic->fb_sz[0],
> +		pic->fb_sz[1]);
>  }
>  
>  static void get_disp_fb(struct vdec_vp9_inst *inst, struct vdec_fb **out_fb)
> 

Regards,

	Hans
