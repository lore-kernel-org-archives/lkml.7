Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753A7C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F486217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 07:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfDYHdh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 03:33:37 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:58967 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730224AbfDYHdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 03:33:36 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JYsshQP5TZVjxJYsvhdikA; Thu, 25 Apr 2019 09:33:34 +0200
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
 <5c01b351-7ea0-b057-32c7-1029af700fe5@xs4all.nl>
 <611fe1d8-6dc6-fc16-6071-3af5dc285b22@maciej.szmigiero.name>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <904a5107-3188-6f55-35a1-2a3076de8f18@xs4all.nl>
Date:   Thu, 25 Apr 2019 09:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <611fe1d8-6dc6-fc16-6071-3af5dc285b22@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfFmB1YW5QKJbeV+Uz27fg3+OFmSjy/V8raIEYkFVwZYmUske5XO1iLwjqrvpz+9+yQAl98mFSKSa5by8EcW5WaqciPPI7IZM8BlXQXTVlU/vlQcsrNbb
 aNGyqEHTfej2/5VGhr6NHdd4q+96vlf/OHUp12ViUSIngWgFWDzU3axeI/oxEpDqBugZ0C3jaHR0uXPy/QpvHmEHs3+kySIuG+jNxqOjH328jdmJ7HTqoZgh
 7+xN5qrAp1pLzaTzOzTl02S8dcP9U2U4+cutN50bMegIvxwV9ooYwfTjsds4JO6efHTrTDVZyS3IlT1cWQ9lbQ+L5bA18P/s4YP9cB4XaalwUmhB64PDsSKl
 c/d6gPWA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/19 10:58 PM, Maciej S. Szmigiero wrote:
> On 24.04.2019 15:06, Hans Verkuil wrote:
>> On 4/16/19 1:40 AM, Maciej S. Szmigiero wrote:
>>> On 12.04.2019 11:22, Hans Verkuil wrote:
>>>> On 3/30/19 12:51 AM, Maciej S. Szmigiero wrote:
>>>>> This patch adds support for analog part of Medion 95700 in the cxusb
>>>>> driver.
>>>>>
>>>>> What works:
>>>>> * Video capture at various sizes with sequential fields,
>>>>> * Input switching (TV Tuner, Composite, S-Video),
>>>>> * TV and radio tuning,
>>>>> * Video standard switching and auto detection,
>>>>> * Radio mode switching (stereo / mono),
>>>>> * Unplugging while capturing,
>>>>> * DVB / analog coexistence.
>>>>>
>>>>> What does not work yet:
>>>>> * Audio,
>>>>> * VBI,
>>>>> * Picture controls.
>>>>>
>>>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>>>> ---
> (..)
>>> In this case the code above simply tries first the bigger PAL capture
>>> resolution then the smaller NTSC one.
>>> Which one will be accepted by the cx25840 depends on the currently set
>>> broadcast standard and parameters of the last signal that was received,
>>> at least one of these resolutions seem to work even without any
>>> signal being received since the chip was powered up.
>>>
>>> This way the API guarantees should be kept by the driver.
>>
>> This is basically a work-around for a cx25840 bug.
>>
>> In any case, since the driver initializes to PAL the 720x576 resolution
>> should be fine.
>>
>> BTW, I noticed that cxdev->norm is initialized to 0. Why isn't that
>> PAL?
> 
> cxdev->norm is initialized to 0 since this will allow autodetection on
> the default Composite input (Composite and S-Video inputs accept any
> standard that a cx25840 chip can accept, including NTSC and SECAM).
> 
> The tuner and tda9887 are initialized to PAL since it is all they can
> accept.

Never autodetect. Just initialize it to PAL.

You can't rely on autodetect since changing the standard will also change
the resolution and therefor change the buffer sizes.

Instead userspace just calls s_std explicitly. Even better if the driver
would support VIDIOC_QUERYSTD, but it seems that was never implented in
cx25840.

Regards,

	Hans

> 
>>>
>>>>> +int cxusb_medion_analog_init(struct dvb_usb_device *dvbdev)
>>>>> +{
>>>>> +	struct cxusb_medion_dev *cxdev = dvbdev->priv;
>>>>> +	u8 tuner_analog_msg_data[] = { 0x9c, 0x60, 0x85, 0x54 };
>>>>> +	struct i2c_msg tuner_analog_msg = { .addr = 0x61, .flags = 0,
>>>>> +					    .buf = tuner_analog_msg_data,
>>>>> +					    .len =
>>>>> +					    sizeof(tuner_analog_msg_data) };
>>>>> +	struct v4l2_subdev_format subfmt;
>>>>> +	int ret;
>>>>> +
>>>>> +	/* switch tuner to analog mode so IF demod will become accessible */
>>>>> +	ret = i2c_transfer(&dvbdev->i2c_adap, &tuner_analog_msg, 1);
>>>>> +	if (ret != 1)
>>>>> +		dev_warn(&dvbdev->udev->dev,
>>>>> +			 "tuner analog switch failed (%d)\n", ret);
>>>>> +
>>>>> +	/*
>>>>> +	 * cx25840 might have lost power during mode switching so we need
>>>>> +	 * to set it again
>>>>> +	 */
>>>>> +	ret = v4l2_subdev_call(cxdev->cx25840, core, reset, 0);
>>>>> +	if (ret != 0)
>>>>> +		dev_warn(&dvbdev->udev->dev,
>>>>> +			 "cx25840 reset failed (%d)\n", ret);
>>>>> +
>>>>> +	ret = v4l2_subdev_call(cxdev->cx25840, video, s_routing,
>>>>> +			       CX25840_COMPOSITE1, 0, 0);
>>>>> +	if (ret != 0)
>>>>> +		dev_warn(&dvbdev->udev->dev,
>>>>> +			 "cx25840 initial input setting failed (%d)\n", ret);
>>>>> +
>>>>> +	/* composite */
>>>>> +	cxdev->input = 1;
>>>>> +	cxdev->norm = 0;
>>>>> +
>>>>> +	/* TODO: setup audio samples insertion */
>>>>> +
>>>>> +	ret = v4l2_subdev_call(cxdev->cx25840, core, s_io_pin_config,
>>>>> +			       sizeof(cxusub_medion_pin_config) /
>>>>> +			       sizeof(cxusub_medion_pin_config[0]),
>>>>> +			       cxusub_medion_pin_config);
>>>>> +	if (ret != 0)
>>>>> +		dev_warn(&dvbdev->udev->dev,
>>>>> +			"cx25840 pin config failed (%d)\n", ret);
>>>>> +
>>>>> +	/* make sure that we aren't in radio mode */
>>>>> +	v4l2_subdev_call(cxdev->tda9887, video, s_std, V4L2_STD_PAL);
>>>>> +	v4l2_subdev_call(cxdev->tuner, video, s_std, V4L2_STD_PAL);
>>>>> +	v4l2_subdev_call(cxdev->cx25840, video, s_std, cxdev->norm);
>>>>> +
>>>>> +	memset(&subfmt, 0, sizeof(subfmt));
>>>>> +	subfmt.which = V4L2_SUBDEV_FORMAT_ACTIVE;
>>>>> +	subfmt.format.width = cxdev->width;
>>>>> +	subfmt.format.height = cxdev->height;
>>>>> +	subfmt.format.code = MEDIA_BUS_FMT_FIXED;
>>>>> +	subfmt.format.field = V4L2_FIELD_SEQ_TB;
>>>>> +	subfmt.format.colorspace = V4L2_COLORSPACE_SMPTE170M;
>>>>> +
>>>>> +	ret = v4l2_subdev_call(cxdev->cx25840, pad, set_fmt, NULL, &subfmt);
>>>>> +	if (ret != 0) {
>>>>> +		subfmt.format.width = 640;
>>>>> +		subfmt.format.height = 480;
>>>>
>>>> Why the fallback to 640x480?
>>>
>>> This resolution seems to work even without any signal being received,
>>> and it is a sensible NTSC-like resolution so it makes a good fallback
>>> if restoring the previously used resolution has failed.
>>
>> But it is really a work-around for a cx25840 bug. Just fix set_fmt
>> and you should not need this anymore.
>>
>> Regards.
>>
>> 	Hans
> 
> Thanks,
> Maciej
> 

