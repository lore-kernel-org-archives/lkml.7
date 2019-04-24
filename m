Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CEAC282E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810521773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfDXNGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:06:35 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:45799 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbfDXNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:06:34 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud9.xs4all.net with ESMTPA
        id JHbYhA5sxNExlJHbbhR6iB; Wed, 24 Apr 2019 15:06:32 +0200
Subject: Re: [PATCH v9 3/4] [media] cxusb: add analog mode support for Medion
 MD95700
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
References: <cover.1553903063.git.mail@maciej.szmigiero.name>
 <0c30210a0d946cac6b17755e7d255541ff535023.1553903063.git.mail@maciej.szmigiero.name>
 <b33ebf2a-9507-9940-4474-6f37af4d8010@xs4all.nl>
 <3927f261-9052-0b89-62c2-6fe8b4876ba1@maciej.szmigiero.name>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5c01b351-7ea0-b057-32c7-1029af700fe5@xs4all.nl>
Date:   Wed, 24 Apr 2019 15:06:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3927f261-9052-0b89-62c2-6fe8b4876ba1@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMtKnHmO81JPcaeNKsbUlQBMa6PB25U/TySKUIkB/vOyVLeN17cUniGkKOs9A+gUY9i2O2O4YBft3B/tIzUzkBTflCyFDj128Quqkl3p2xDeL+yrFhyO
 ybbgzfR9oV9gsSNDdcPsuS4g3p9oU+gxgr2vQJ8vJnG8eft1w9JXkYqpUXe577+4wGlSqOK4hmCQeCfq6frxAmyjAENORA9aG0X2q0C36Yw7jn+SqqltKyVf
 bemarlasMxeQGiEsCFTe6u4+uLf1RIIR7VFWIJaSciM7Q3mKUcz2UDFtY5GdFRTChVHY1RGl4M0kBnL62/z8usIH7Fo91R0/j0Va3lIJScc7xXJAl8zRjcf4
 WypzgxeI55w39rCLSWv7lYu/Fa2eBsbSjcnRerJmjE2krEhv8PGueaNWSysCFhw1lYxd2Ps71Wqygmt5kf5bwUwMTVxYfzhFGZdVvW/R4feH+z6hCV4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 1:40 AM, Maciej S. Szmigiero wrote:
> On 12.04.2019 11:22, Hans Verkuil wrote:
>> On 3/30/19 12:51 AM, Maciej S. Szmigiero wrote:
>>> This patch adds support for analog part of Medion 95700 in the cxusb
>>> driver.
>>>
>>> What works:
>>> * Video capture at various sizes with sequential fields,
>>> * Input switching (TV Tuner, Composite, S-Video),
>>> * TV and radio tuning,
>>> * Video standard switching and auto detection,
>>> * Radio mode switching (stereo / mono),
>>> * Unplugging while capturing,
>>> * DVB / analog coexistence.
>>>
>>> What does not work yet:
>>> * Audio,
>>> * VBI,
>>> * Picture controls.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>> ---
> (..)
>>> +static int cxusb_medion_try_s_fmt_vid_cap(struct file *file,
>>> +					  struct v4l2_format *f,
>>> +					  bool isset)
>>> +{
>>> +	struct dvb_usb_device *dvbdev = video_drvdata(file);
>>> +	struct cxusb_medion_dev *cxdev = dvbdev->priv;
>>> +	struct v4l2_subdev_format subfmt;
>>> +	int ret;
>>> +
>>> +	if (isset && (vb2_start_streaming_called(&cxdev->videoqueue) ||
>>> +		      cxdev->stop_streaming))
>>
>> This should be:
>>
>> 	if (isset && vb2_is_busy(&cxdev->videoqueue))
>>
>> As long as buffers are allocated you can no longer change the format.
>>
>>> +		return -EBUSY;
>>> +
>>> +	memset(&subfmt, 0, sizeof(subfmt));
>>> +	subfmt.which = isset ? V4L2_SUBDEV_FORMAT_ACTIVE :
>>> +		V4L2_SUBDEV_FORMAT_TRY;
>>> +	subfmt.format.width = f->fmt.pix.width & ~1;
>>> +	subfmt.format.height = f->fmt.pix.height & ~1;
>>> +	subfmt.format.code = MEDIA_BUS_FMT_FIXED;
>>> +	subfmt.format.field = V4L2_FIELD_SEQ_TB;
>>
>> Why FIELD_SEQ_TB? If memory serves the cx25840 always uses FIELD_INTERLACED.
> 
> It looks like all the existing cx25840 users use an intelligent bridge
> chip (or a MPEG encoder), which normalize the video data received to
> a nice V4L2_FIELD_INTERLACED.
> 
> However, this device uses a "dumb" USB bridge chip which does not do any
> video processing (other than dropping parts of it if the host PC is not
> receiving it fast enough), so the output data matches what the cx25840
> chip produces - and it produces a sequential fields format.

Ah. But in that case it is SEQ_BT for NTSC and SEQ_TB for all other standards.

> 
>>> +	subfmt.format.colorspace = V4L2_COLORSPACE_SMPTE170M;
>>> +
>>> +	ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL, &subfmt);
>>> +	if (ret != 0) {
>>> +		if (ret != -ERANGE)
>>> +			return ret;
>>> +
>>> +		/* try some common formats */
>>> +		subfmt.format.width = 720;
>>> +		subfmt.format.height = 576;
>>> +		ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL,
>>> +				       &subfmt);
>>> +		if (ret != 0) {
>>> +			if (ret != -ERANGE)
>>> +				return ret;
>>> +
>>> +			subfmt.format.width = 640;
>>> +			subfmt.format.height = 480;
>>> +			ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt,
>>> +					       NULL, &subfmt);
>>> +			if (ret != 0)
>>> +				return ret;
>>> +		}
>>
>> Why these fallbacks? Is this really needed?
> 
> V4L2 docs say that VIDIOC_{S,TRY}_FMT ioctls "should not return an error
> code unless the type field is invalid", that is, they should not return
> an error for invalid or unsupported image widths or heights.
> They should instead return something sensible for these image parameters.
> 
> However, cx25840 driver set_fmt callback simply returns -ERANGE if it
> does not like the provided width or height.

I think the right approach here is to modify cx25840 so that it updates
the width/height to stay within the limits of the HW.

BTW, a quick scan shows that none of the drivers that call set_fmt actually
check the return value :-)

So changing the cx25840 behavior certainly won't make things worse for
existing drivers.

> In this case the code above simply tries first the bigger PAL capture
> resolution then the smaller NTSC one.
> Which one will be accepted by the cx25840 depends on the currently set
> broadcast standard and parameters of the last signal that was received,
> at least one of these resolutions seem to work even without any
> signal being received since the chip was powered up.
> 
> This way the API guarantees should be kept by the driver.

This is basically a work-around for a cx25840 bug.

In any case, since the driver initializes to PAL the 720x576 resolution
should be fine.

BTW, I noticed that cxdev->norm is initialized to 0. Why isn't that
PAL?

> 
>>> +int cxusb_medion_analog_init(struct dvb_usb_device *dvbdev)
>>> +{
>>> +	struct cxusb_medion_dev *cxdev = dvbdev->priv;
>>> +	u8 tuner_analog_msg_data[] = { 0x9c, 0x60, 0x85, 0x54 };
>>> +	struct i2c_msg tuner_analog_msg = { .addr = 0x61, .flags = 0,
>>> +					    .buf = tuner_analog_msg_data,
>>> +					    .len =
>>> +					    sizeof(tuner_analog_msg_data) };
>>> +	struct v4l2_subdev_format subfmt;
>>> +	int ret;
>>> +
>>> +	/* switch tuner to analog mode so IF demod will become accessible */
>>> +	ret = i2c_transfer(&dvbdev->i2c_adap, &tuner_analog_msg, 1);
>>> +	if (ret != 1)
>>> +		dev_warn(&dvbdev->udev->dev,
>>> +			 "tuner analog switch failed (%d)\n", ret);
>>> +
>>> +	/*
>>> +	 * cx25840 might have lost power during mode switching so we need
>>> +	 * to set it again
>>> +	 */
>>> +	ret = v4l2_subdev_call(cxdev->cx25840, core, reset, 0);
>>> +	if (ret != 0)
>>> +		dev_warn(&dvbdev->udev->dev,
>>> +			 "cx25840 reset failed (%d)\n", ret);
>>> +
>>> +	ret = v4l2_subdev_call(cxdev->cx25840, video, s_routing,
>>> +			       CX25840_COMPOSITE1, 0, 0);
>>> +	if (ret != 0)
>>> +		dev_warn(&dvbdev->udev->dev,
>>> +			 "cx25840 initial input setting failed (%d)\n", ret);
>>> +
>>> +	/* composite */
>>> +	cxdev->input = 1;
>>> +	cxdev->norm = 0;
>>> +
>>> +	/* TODO: setup audio samples insertion */
>>> +
>>> +	ret = v4l2_subdev_call(cxdev->cx25840, core, s_io_pin_config,
>>> +			       sizeof(cxusub_medion_pin_config) /
>>> +			       sizeof(cxusub_medion_pin_config[0]),
>>> +			       cxusub_medion_pin_config);
>>> +	if (ret != 0)
>>> +		dev_warn(&dvbdev->udev->dev,
>>> +			"cx25840 pin config failed (%d)\n", ret);
>>> +
>>> +	/* make sure that we aren't in radio mode */
>>> +	v4l2_subdev_call(cxdev->tda9887, video, s_std, V4L2_STD_PAL);
>>> +	v4l2_subdev_call(cxdev->tuner, video, s_std, V4L2_STD_PAL);
>>> +	v4l2_subdev_call(cxdev->cx25840, video, s_std, cxdev->norm);
>>> +
>>> +	memset(&subfmt, 0, sizeof(subfmt));
>>> +	subfmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
>>> +	subfmt.format.width = cxdev->width;
>>> +	subfmt.format.height = cxdev->height;
>>> +	subfmt.format.code = MEDIA_BUS_FMT_FIXED;
>>> +	subfmt.format.field = V4L2_FIELD_SEQ_TB;
>>> +	subfmt.format.colorspace = V4L2_COLORSPACE_SMPTE170M;
>>> +
>>> +	ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL, &subfmt);
>>> +	if (ret != 0) {
>>> +		subfmt.format.width = 640;
>>> +		subfmt.format.height = 480;
>>
>> Why the fallback to 640x480?
> 
> This resolution seems to work even without any signal being received,
> and it is a sensible NTSC-like resolution so it makes a good fallback
> if restoring the previously used resolution has failed.

But it is really a work-around for a cx25840 bug. Just fix set_fmt
and you should not need this anymore.

Regards.

	Hans

> 
>>> +		ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL,
>>> +				       &subfmt);
>>> +		if (ret != 0)
>>> +			dev_warn(&dvbdev->udev->dev,
>>> +				 "cx25840 format set failed (%d)\n", ret);
>>> +	}
>>> +
>>> +	if (ret == 0) {
>>> +		cxdev->width = subfmt.format.width;
>>> +		cxdev->height = subfmt.format.height;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
> 
>>
>> Regards,
>>
>> 	Hans
>>
> 
> Thanks and best regards,
> Maciej
> 

