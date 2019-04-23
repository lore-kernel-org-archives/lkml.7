Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C42C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 467C620645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfDWOFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:05:20 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:38539 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727500AbfDWOFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:05:19 -0400
Received: from [IPv6:2001:420:44c1:2579:c4cd:9df1:43f2:db66] ([IPv6:2001:420:44c1:2579:c4cd:9df1:43f2:db66])
        by smtp-cloud7.xs4all.net with ESMTPA
        id Iw2shDKyfZVjxIw2whWXxk; Tue, 23 Apr 2019 16:05:18 +0200
Subject: Re: Questions regarding Documentation/media/uapi/v4l/field-order.rst
To:     "Rodin, Michael (Ferchau; ADITG/ESM1)" <mrodin@de.adit-jv.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>
Cc:     "Friedrich, Eugen (ADITG/ESM1)" <efriedrich@de.adit-jv.com>,
        "Rosca, Eugeniu (ADITG/ESM1)" <erosca@de.adit-jv.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AC35D0CFBC66A84AAA9DF4334B52828D13614162@HI2EXCH01.adit-jv.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <187c237b-6b75-f408-ae41-6065baf5cd7f@xs4all.nl>
Date:   Tue, 23 Apr 2019 16:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <AC35D0CFBC66A84AAA9DF4334B52828D13614162@HI2EXCH01.adit-jv.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJ99XDwsgwnWujLspYqoa6+Ot6o2utRJpM6ognyzv7By/htZhGaOPqsmFN6sYPrGcI3SItiAe+jEIUH9ed6bBsVzDI+pXUdF9owqhp3E2Wd3IY/4xvze
 ++yJ40PohjBo5vSD5XexulltgAcYQTwo9EMnQQrjGPWHBNp8+gcRrYgJUSbU8MsgV2BbhmdT/B3zu508j6+HmnwU8uuzaHoUbfxBXBJdpSpB1C3DeMGGY8Pk
 kLm+WfKVT30t89+hndLT0kt8z5a7KoiQJ8ZKBQzEi03cCudM92YPINYQtEeEg/FQFRUHP8HaDcnjt/dCrcUwKyjB2lpflEZ4oKh3pc1zOn9HsjsUp3ULmewm
 SPJPHHmsGMwowOVSzPalSwU6aPEhP08LeTv9xIv3+kVhq70nbE5VfNhpEEDt/lTx80TBnFW89Mrg2wX5wLFQythLpub35qrZFiTdsGO5zPFNt7D4Bik05Lwr
 t2BdpgjmgDEi5B/S0TGgqqWt5q3qHuHscsr5mA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/19 3:54 PM, Rodin, Michael (Ferchau; ADITG/ESM1) wrote:
> Hi,
> 
> I would like to ask several questions regarding the documentation of the enum "v4l2_field" [1].
> These questions came up during my investigations of issues with interaction between
> the gstreamer plugin v4l2src and the rcar video input driver [2].
> 
> The documentation [1] specifies that:
> "All video capture and output devices must report the current field order.
> Some drivers may permit the selection of a different order, to this end
> applications initialize the field field of struct v4l2_pix_format before
> calling the VIDIOC_S_FMT ioctl. If this is not desired it should have
> the value V4L2_FIELD_ANY (0)."
> 
> If I have understood these lines correctly, this means that if userspace sets "field" member of
> the struct "v4l2_pix_format" to V4L2_FIELD_ANY and uses this as parameter for the VIDIOC_S_FMT ioctl,
> then a driver should select/report the field order, which was previously set by media-ctl utility
> in the next subdevice, which is connected to the /dev/videoX node
> (From my understanding this would be equivalent to the "current field order").
> 
> If the described behavior is correct, then the description in the table row for V4L2_FIELD_ANY in [1] is incomplete:
> "Applications request this field order when any one of the V4L2_FIELD_NONE, V4L2_FIELD_TOP, V4L2_FIELD_BOTTOM, or V4L2_FIELD_INTERLACED formats is acceptable."
> What if V4L2_FIELD_ALTERNATE or V4L2_FIELD_SEQ_TB or V4L2_FIELD_SEQ_BT are also acceptable for the application?
> I think that the specification is either unprecise or my understanding of the specification is wrong.

The spec is a bit out of date: those missing field values were probably added after this
text was written. I'll make a patch fixing this.

> 
> Another potential issue, which I found in this documentation is that it does not distinguish between
> multiple contexts in which enum v4l2_field can be used. I can think of at least two different contexts:
> - When used to select the field order with VIDIOC_S_FMT ioctl.
> - When used to report the field order in a buffer: for example application sets V4L2_FIELD_ALTERNATE in VIDIOC_S_FMT ioctl and then gets buffers, which have V4L2_FIELD_TOP/BOTTOM set.

IMHO the text is reasonably clear on that. But if you have suggestions to
improve it, then make a proposal.

> Now with this in mind, when I read the description of V4L2_FIELD_NONE:
> "The driver may also indicate this order when it cannot distinguish between V4L2_FIELD_TOP and V4L2_FIELD_BOTTOM."

Whoops, that makes no sense. There are no drivers that do this. I'll remove this
line. If a driver can't tell the difference, then it should just pick FIELD_TOP
or BOTTOM.

> I see two possible meanings/interpretations:
> - If application sets V4L2_FIELD_ALTERNATE in VIDIOC_S_FMT ioctl, report V4L2_FIELD_NONE back
>    so the application knows that the driver can not provide any TOP/BOTTOM metadata in the buffers
>    (which may be necessary for the application for example for deinterlacing) before it has got any buffer.
> - If application sets V4L2_FIELD_ALTERNATE in VIDIOC_S_FMT ioctl, driver reports V4L2_FIELD_ALTERNATE back,
>    even if it can not distinguish between TOP/BOTTOM. But when the application starts to read buffers,
>    they have V4L2_FIELD_NONE set if it's not possible to distinguish between TOP/BOTTOM.

Actually, drivers cannot ever return NONE for a top or bottom field. FIELD_NONE
indicates that a full frame has arrived, and doing something else would break
userspace.

> 
> Also there is another ambiguity in the description of V4L2_FIELD_NONE:
> "Images are in progressive format, not interlaced."
> What does "interlaced" mean in this case? Does it mean the other possible enum values or just the V4L2_FIELD_INTERLACED?

It means that the source video transmitted full frames, not top and bottom
fields. I clarified the text a bit.

> If this just means V4L2_FIELD_INTERLACED, then it would imply that for example V4L2_FIELD_SEQ_TB 
> and V4L2_FIELD_ALTERNATE are progressive formats, which is obviously not true.
> And also generally, in which of described contexts should be V4L2_FIELD_NONE set or reported (buffer or VIDIOC_S_FMT ioctl)?

For video capture (that's what we are talking about here) it is returned by the
driver in v4l2_buffer, never by userspace. Userspace can try to request a specific
field value when calling S_FMT, but the driver can overwrite it.

The possible field values that a driver can support are dependent on the video
source (i.e. sensors are always FIELD_NONE) and the hardware capabilities.

> Another point is that V4L2_FIELD_INTERLACED is also used by v4l2src to tell rcar-vin driver to combine the fields before giving them to application,
> so basically it requests progressive signal. So the meanings of V4L2_FIELD_INTERLACED and V4L2_FIELD_NONE are basically the same in this case.

Certainly not. FIELD_INTERLACED combines two fields into a single buffer, but the
odd and even lines in the frame were captured at different times. Whereas for
FIELD_NONE all lines were captured at the same time.

So a FIELD_INTERLACED buffer may need to undergo additional deinterlacing.

If the hardware already does high-quality deinterlacing then that might be
a reason for the driver to return FIELD_NONE to avoid additional deinterlacing
in userspace.

In practice there are three main categories in the way the field is handled:

1) The video source is a webcam: field is always FIELD_NONE, set by the driver.

2) The video source is HDMI: if the video is progressive, then the field is always
   FIELD_NONE. If the video is interlaced, then the field is always FIELD_ALTERNATE
   in v4l2_format and alternating FIELD_TOP and BOTTOM in v4l2_buffer.

3) The video source is SDTV (i.e. S-Video or composite): the video is always
   interlaced, and it depends on the hardware which field values are supported,
   except for FIELD_NONE, which is never returned as far as I am aware.

Regards,

	Hans

> 
> Thank you in advance and sorry for the long mail!
> 
> [1] Documentation/media/uapi/v4l/field-order.rst
> [2] drivers/media/platform/rcar-vin
> 
> Best regards
> 
> Michael Rodin
> 
> Advanced Driver Information Technology GmbH
> Engineering Software Multimedia 1 (ADITG/ESM1)
> Robert-Bosch-Str. 200
> 31139 Hildesheim
> Germany
> 
> Tel. +49 5121 49 6936
> Fax +49 5121 49 6999
> mrodin@de.adit-jv.com
> Web: www.adit-jv.com
> 
> ADIT is a joint venture company of Robert Bosch GmbH/Robert Bosch Car Multimedia GmbH and DENSO Corporation
> Sitz: Hildesheim, Registergericht: Amtsgericht Hildesheim HRB 3438
> Geschaeftsfuehrung: Wilhelm Grabow, Ken Yaguchi
> 

