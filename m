Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2B8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F3A217F5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfC1ObL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:31:11 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:45387 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726242AbfC1ObK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:31:10 -0400
Received: from [IPv6:2001:420:44c1:2579:7126:11db:5076:31b1] ([IPv6:2001:420:44c1:2579:7126:11db:5076:31b1])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 9W3bh6x9cNG8z9W3fhpSaY; Thu, 28 Mar 2019 15:31:07 +0100
Subject: Re: [PATCH v2 1/2] media: atmel: atmel-isc: reworked driver and
 formats
To:     Eugen.Hristev@microchip.com, Nicolas.Ferre@microchip.com,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mchehab@kernel.org
Cc:     ksloat@aampglobal.com
References: <1552461639-8708-1-git-send-email-eugen.hristev@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <d924b607-14c2-51e3-8999-f8d5f8fc6e0e@xs4all.nl>
Date:   Thu, 28 Mar 2019 15:31:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1552461639-8708-1-git-send-email-eugen.hristev@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGRxtCx/Ttnk9i3CwEmmRfzELBB8RTvT6ON7++9mjKNHvulgRRFbS3IpW4Hv6BnlJtjSXN73xAU2jnyFDFjpI+cZHU/UUWSZcyHSXj4dqYL1/34m+3tL
 La7XhII7gBmHltZZGCm2kvNVDZ6wVisJnjONmOG6AyI61skfVl1WCAYgGbMl4zJflyVwR/s+0nONFG7eLdpyhKEBHRwygDwo+h36lN4uGGEw3d5tB8OLx+US
 Vheu1DojiyKgyrbbh/g7BVs/TSxk1k2DsXnmsUH5cJif4QKluFIAN9aeC1OOBYQewRZSkEzPHgZ16NlHLkySBRCHlwWhvoGIFO1lkHlE63/E3Gkm/cA5Gvs8
 2iMivWb48cJKIofjzSoWluwZuP+22qnuXCSZPH24hM/4St9E2LXtgBRL4i8g119yN/zCeBcOcMTWb1nNUqk0Mf9wIgphq5LsJnt5QbqDI6W+SueRBhncOhxR
 v502Bv682G7g0ZNXzaX5WzVo8c1zBnJ4mHKvBTiQ5PSMsR4jodSYmOm3Xs0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugen,

Just a few small comments:

On 3/13/19 8:25 AM, Eugen.Hristev@microchip.com wrote:
> From: Eugen Hristev <eugen.hristev@microchip.com>
> 
> This change is a redesign in the formats and the way the ISC is
> configured w.r.t. sensor format and the output format from the ISC.
> I have changed the splitting between sensor output (which is also ISC input)
> and ISC output.
> The sensor format represents the way the sensor is configured, and what ISC
> is receiving.
> The format configuration represents the way ISC is interpreting the data and
> formatting the output to the subsystem.
> Now it's much easier to figure out what is the ISC configuration for input, and
> what is the configuration for output.
> The non-raw format can be obtained directly from sensor or it can be done
> inside the ISC. The controller format list will include a configuration for
> each format.
> The old supported formats are still in place, if we want to dump the sensor
> format directly to the output, the try format routine will detect and
> configure the pipeline accordingly.
> This also fixes the previous issues when the raw format was NULL which
> resulted in many crashes for sensors which did not have the expected/tested
> formats.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> 
> Hello,
> 
> I have changed the try vs set settings, with having another configuration for
> try, which will be copied to the actual configuration only after set will
> be called.
> 
> This patch keeps the original formats. I added a second patch that fixes ARGB
> format w.r.t. byte endianess inside the format.
> 
> Changes in v2:
>  - now have try_config and also config, all configuration setting will be done
> initially on try_config, and then if everything is OK, in set_fmt, it will be
> copied to the actual config.
>  - changed macro IS_RAW to apply on mbus code and not isc structure, it's now
> called ISC_IS_FORMAT_RAW and it's called everywhere it's needed.
>  - renamed all functions for configure modules (dma, rlp, pipeline, formats)
> with 'try' prefix
> 
> tested with sensors ov7670, ov7740, ov5640
> 
> v4l2-compliance:
> 
> v4l2-compliance SHA: 32cf495ff5da24df54936fae3bf0eb91fba77f3a, 32 bits
> 
> Compliance test for atmel_isc device /atmel_deo0:isc f0008000.isc: =================  START STATUS  =================
> atmel_isc f0008000.isc: Brightness: 0
> atmel_isc f0008000.isc: Contrast: 256
> atmel_isc f0008000.isc: Gamma: 2
> 
> atmeiver Info:
>         Driver name      : atmel_isc
>         Card type        : Atmel Image Sensor Controller
>         Bus info         : platform:atmel_isc f0008000.isc
>         Driver version   : 5.0.0
>         Capabilities     : 0x84200001
>                 Video Capture
>                 Streaming
>                 Extended Pix Format
>                 Device Capabilities
>         Device Caps      : 0x04200001
>                 Video Capture
>                 Streaming
>                 Extended Pix Format
> 
> Required ioctls:
>         test VIDIOC_QUERYCAP: OK
> 
> Allow for multiple opens:
>         test second /dev/video0 open: OK
>         test VIDIOC_QUERYCAP: OK
>         test VIDIOC_G/S_PRIORITY: OK
>         test for unlimited opens: OK
> 
> Debug ioctls:
>         test VIDIOC_DBG_G/S_REGISTER: OK (Not Supported)
> l_isc f0008000.isc: White Balance, Automatic: true
> atmel_isc f0008000.isc: ==================  END STATUS  ==================
>         test VIDIOC_LOG_STATUS: OK
> 
> Input ioctls:
>         test VIDIOC_G/S_TUNER/ENUM_FREQ_BANDS: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_S_HW_FREQ_SEEK: OK (Not Supported)
>         test VIDIOC_ENUMAUDIO: OK (Not Supported)
>         test VIDIOC_G/S/ENUMINPUT: OK
>         test VIDIOC_G/S_AUDIO: OK (Not Supported)
>         Inputs: 1 Audio Inputs: 0 Tuners: 0
> 
> Output ioctls:
>         test VIDIOC_G/S_MODULATOR: OK (Not Supported)
>         test VIDIOC_G/S_FREQUENCY: OK (Not Supported)
>         test VIDIOC_ENUMAUDOUT: OK (Not Supported)
>         test VIDIOC_G/S/ENUMOUTPUT: OK (Not Supported)
>         test VIDIOC_G/S_AUDOUT: OK (Not Supported)
>         Outputs: 0 Audio Outputs: 0 Modulators: 0
> 
> Input/Output configuration ioctls:
>         test VIDIOC_ENUM/G/S/QUERY_STD: OK (Not Supported)
>         test VIDIOC_ENUM/G/S/QUERY_DV_TIMINGS: OK (Not Supported)
>         test VIDIOC_DV_TIMINGS_CAP: OK (Not Supported)
>         test VIDIOC_G/S_EDID: OK (Not Supported)
> 
> Control ioctls (Input 0):
>         test VIDIOC_QUERY_EXT_CTRL/QUERYMENU: OK
>         test VIDIOC_QUERYCTRL: OK
>         test VIDIOC_G/S_CTRL: OK
>         test VIDIOC_G/S/TRY_EXT_CTRLS: OK
>         test VIDIOC_(UN)SUBSCRIBE_EVENT/DQEVENT: OK
>         test VIDIOC_G/S_JPEGCOMP: OK (Not Supported)
>         Standard Controls: 5 Private Controls: 0
> 
> Format ioctls (Input 0):
>         test VIDIOC_ENUM_FMT/FRAMESIZES/FRAMEINTERVALS: OK
>         test VIDIOC_G/S_PARM: OK
>         test VIDIOC_G_FBUF: OK (Not Supported)
>         test VIDIOC_G_FMT: OK
>         test VIDIOC_TRY_FMT: OK
>         test VIDIOC_S_FMT: OK
>         test VIDIOC_G_SLICED_VBI_CAP: OK (Not Supported)
>         test Cropping: OK (Not Supported)
>         test Composing: OK (Not Supported)
>         test Scaling: OK (Not Supported)
> 
> Codec ioctls (Input 0):
>         test VIDIOC_(TRY_)ENCODER_CMD: OK (Not Supported)
>         test VIDIOC_G_ENC_INDEX: OK (Not Supported)
>         test VIDIOC_(TRY_)DECODER_CMD: OK (Not Supported)
> 
> Buffer ioctls (Input 0):
>         test VIDIOC_REQBUFS/CREATE_BUFS/QUERYBUF: OK
>         test VIDIOC_EXPBUF: OK
>         test Requests: OK (Not Supported)
> 
> Total for atmel_isc device /dev/video0: 44, Succeeded: 44, Failed: 0, Warnings: 0
> 
> 
>  drivers/media/platform/atmel/atmel-isc.c | 888 ++++++++++++++++---------------
>  1 file changed, 471 insertions(+), 417 deletions(-)
> 
> diff --git a/drivers/media/platform/atmel/atmel-isc.c b/drivers/media/platform/atmel/atmel-isc.c
> index 5017896..f4ecb24 100644
> --- a/drivers/media/platform/atmel/atmel-isc.c
> +++ b/drivers/media/platform/atmel/atmel-isc.c

<snip>

>  static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
> -			struct isc_format **current_fmt, u32 *code)
> +			u32 *code)
>  {
> -	struct isc_format *isc_fmt;
> +	int i;
> +	struct isc_format *sd_fmt = NULL, *direct_fmt = NULL;
>  	struct v4l2_pix_format *pixfmt = &f->fmt.pix;
>  	struct v4l2_subdev_pad_config pad_cfg;
>  	struct v4l2_subdev_format format = {
> @@ -1297,48 +1296,114 @@ static int isc_try_fmt(struct isc_device *isc, struct v4l2_format *f,
>  	};
>  	u32 mbus_code;
>  	int ret;
> +	bool rlp_dma_direct_dump = false;
>  
>  	if (f->type != V4L2_BUF_TYPE_VIDEO_CAPTURE)
>  		return -EINVAL;
>  
> -	isc_fmt = find_format_by_fourcc(isc, pixfmt->pixelformat);
> -	if (!isc_fmt) {
> -		v4l2_warn(&isc->v4l2_dev, "Format 0x%x not found\n",
> -			  pixfmt->pixelformat);
> -		isc_fmt = isc->user_formats[isc->num_user_formats - 1];
> -		pixfmt->pixelformat = isc_fmt->fourcc;
> +	/* Step 1: find a RAW format that is supported */
> +	for (i = 0; i < isc->num_user_formats; i++) {
> +		if (ISC_IS_FORMAT_RAW(isc->user_formats[i]->mbus_code)) {
> +			sd_fmt = isc->user_formats[i];
> +			break;
> +		}
> +	}
> +	/* Step 2: We can continue with this RAW format, or we can look
> +	 * for better: maybe sensor supports directly what we need.
> +	 */
> +	direct_fmt = find_format_by_fourcc(isc, pixfmt->pixelformat);
> +
> +	/* Step 3: We have both. We decide given the module parameter which
> +	 * one to use.
> +	 */
> +	if (direct_fmt && sd_fmt && sensor_preferred)
> +		sd_fmt = direct_fmt;
> +
> +	/* Step 4: we do not have RAW but we have a direct format. Use it. */
> +	if (direct_fmt && !sd_fmt)
> +		sd_fmt = direct_fmt;
> +
> +	/* Step 5: if we are using a direct format, we need to package
> +	 * everything as 8 bit data and just dump it
> +	 */
> +	if (sd_fmt == direct_fmt)
> +		rlp_dma_direct_dump = true;
> +
> +	/* Step 6: We have no format. This can happen if the userspace
> +	 * requests some weird/invalid format.
> +	 * In this case, default to whatever we have
> +	 */
> +	if (!sd_fmt && !direct_fmt) {
> +		sd_fmt = isc->user_formats[isc->num_user_formats - 1];
> +		v4l2_dbg(1, debug, &isc->v4l2_dev,
> +			 "Sensor not supporting %.4s, using %.4s\n",
> +			 (char *)&pixfmt->pixelformat, (char *)&sd_fmt->fourcc);
>  	}
>  
> +	/* Step 7: Print out what we decided for debugging */
> +	v4l2_dbg(1, debug, &isc->v4l2_dev,
> +		 "Preferring to have sensor using format %.4s\n",
> +		 (char *)&sd_fmt->fourcc);
> +
> +	/* Step 8: at this moment we decided which format the subdev will use */
> +	isc->try_config.sd_format = sd_fmt;
> +
>  	/* Limit to Atmel ISC hardware capabilities */
>  	if (pixfmt->width > ISC_MAX_SUPPORT_WIDTH)
>  		pixfmt->width = ISC_MAX_SUPPORT_WIDTH;
>  	if (pixfmt->height > ISC_MAX_SUPPORT_HEIGHT)
>  		pixfmt->height = ISC_MAX_SUPPORT_HEIGHT;
>  
> -	if (sensor_is_preferred(isc_fmt))
> -		mbus_code = isc_fmt->mbus_code;
> -	else
> -		mbus_code = isc->raw_fmt->mbus_code;
> +	/*
> +	 * The mbus format is the one the subdev outputs.
> +	 * The pixels will be transferred in this format Sensor -> ISC
> +	 */
> +	mbus_code = sd_fmt->mbus_code;
> +
> +	/*
> +	 * Validate formats. If the required format is not OK, default to raw.
> +	 */
> +
> +	isc->try_config.fourcc = pixfmt->pixelformat;
> +
> +	if (isc_try_validate_formats(isc)) {
> +		pixfmt->pixelformat = isc->try_config.fourcc = sd_fmt->fourcc;
> +		/* This should be redundant, format should be supported */
> +		ret = isc_try_validate_formats(isc);

Hmm, either it is redundant, in which case you shouldn't bother calling this,
or it can actually fail, in which case the comment is wrong.

My guess is that you are actually not quite certain about this :-)

So either drop the second call, or rephrase the comment.

E.g.:

		/* Re-validate the new format */

> +		if (ret)
> +			goto isc_try_fmt_err;
> +	}
> +
> +	ret = isc_try_configure_rlp_dma(isc, rlp_dma_direct_dump);
> +	if (ret)
> +		goto isc_try_fmt_err;
> +
> +	ret = isc_try_configure_pipeline(isc);
> +	if (ret)
> +		goto isc_try_fmt_err;
>  
>  	v4l2_fill_mbus_format(&format.format, pixfmt, mbus_code);
>  	ret = v4l2_subdev_call(isc->current_subdev->sd, pad, set_fmt,
>  			       &pad_cfg, &format);
>  	if (ret < 0)
> -		return ret;
> +		goto isc_try_fmt_err;
>  
>  	v4l2_fill_pix_format(pixfmt, &format.format);
>  
>  	pixfmt->field = V4L2_FIELD_NONE;
> -	pixfmt->bytesperline = (pixfmt->width * isc_fmt->bpp) >> 3;
> +	pixfmt->bytesperline = (pixfmt->width * isc->try_config.bpp) >> 3;
>  	pixfmt->sizeimage = pixfmt->bytesperline * pixfmt->height;
>  
> -	if (current_fmt)
> -		*current_fmt = isc_fmt;
> -
>  	if (code)
>  		*code = mbus_code;
>  
>  	return 0;
> +
> +isc_try_fmt_err:
> +	v4l2_err(&isc->v4l2_dev, "Could not find any possible format for a working pipeline\n");
> +	memset(&isc->try_config, 0, sizeof(isc->try_config));
> +
> +	return ret;
>  }
>  
>  static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
> @@ -1346,11 +1411,10 @@ static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
>  	struct v4l2_subdev_format format = {
>  		.which = V4L2_SUBDEV_FORMAT_ACTIVE,
>  	};
> -	struct isc_format *current_fmt;
> -	u32 mbus_code;
> +	u32 mbus_code = 0;
>  	int ret;
>  
> -	ret = isc_try_fmt(isc, f, &current_fmt, &mbus_code);
> +	ret = isc_try_fmt(isc, f, &mbus_code);
>  	if (ret)
>  		return ret;
>  
> @@ -1361,7 +1425,10 @@ static int isc_set_fmt(struct isc_device *isc, struct v4l2_format *f)
>  		return ret;
>  
>  	isc->fmt = *f;
> -	isc->current_fmt = current_fmt;
> +	/* make the try configuration active */
> +	memcpy(&isc->config, &isc->try_config, sizeof(isc->config));

Just do an assignment here:

	isc->config = isc->try_config;

> +
> +	v4l2_dbg(1, debug, &isc->v4l2_dev, "New ISC configuration in place\n");
>  
>  	return 0;
>  }
> @@ -1382,7 +1449,7 @@ static int isc_try_fmt_vid_cap(struct file *file, void *priv,
>  {
>  	struct isc_device *isc = video_drvdata(file);
>  
> -	return isc_try_fmt(isc, f, NULL, NULL);
> +	return isc_try_fmt(isc, f, NULL);
>  }

Once this is fixed I can merge this series.

Regards,

	Hans
