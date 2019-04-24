Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF8C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4621773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfDXKXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:23:15 -0400
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:35367 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727645AbfDXKXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:23:14 -0400
Received: from [IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676] ([IPv6:2001:420:44c1:2579:8575:c0e0:a08:6676])
        by smtp-cloud7.xs4all.net with ESMTPA
        id JF3ThJXcXZVjxJF3WhZzj3; Wed, 24 Apr 2019 12:23:11 +0200
Subject: Re: [PATCH] v4l: Add source event change for bit-depth
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20190415152723.2481-1-stanimir.varbanov@linaro.org>
 <20190423064326.lbi3gfprfegqecu4@kekkonen.localdomain>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <a61ded35-2dc1-edb9-9f9a-94bbf78c7abf@xs4all.nl>
Date:   Wed, 24 Apr 2019 12:23:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190423064326.lbi3gfprfegqecu4@kekkonen.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLCa3Ah4lBTleABLkvWMy37H1y28aM66nP2zzKGoggdVD5eemu57Faf7YmgF+LQryaXFz7tLm9y6nEriz7oRrWxtjqUw0S7e2tQZZ0BbMckbOjd9MREc
 UcSkdjdy6vEdS3m/98w9G99XyFObFiBf5lzI2Gt3cHwSb2JUFIkzRkLm4ZxVPkmVHF1l+URFPXhYZg553BauphkKMTVf91qf/cstZQtZeF0ATmZHeViVJUFl
 6TKRyOMnE3GFeAYQPJqMRvTKgcwSOUZnlvTXQCBq8Azqel4liCLUr8gvD35L6/X51RmPwaTDj2HAxnNsFTxAR3A+eKQKJuvC4/BtAk8CP7MAm6j2MVzjfdOZ
 3wjKa7GrEdqS71BBXk/j2YCt/X/UMhtS9Dr9Q0bk4gJrYLioB4M6I2+eXCBwQTmekUPR3FCyqmR1mEu7C+EVn1BHFzgFT32h5/lEt1FuSt4M8R+wpbyrgVxR
 gVLkRDvdbHiTqvxl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/19 8:43 AM, Sakari Ailus wrote:
> Hi Stan,
> 
> On Mon, Apr 15, 2019 at 06:27:23PM +0300, Stanimir Varbanov wrote:
>> This event indicate that the source bit-depth is changed during
>> run-time. The client must get the new format and re-allocate buffers
>> for it. This can usually happens with video decoder (encoders) when
>> the bit-stream depth is changed from 8 to 10bits or vice versa.
> 
> Thanks for the patch.
> 
> How about adding an event for pixelformat change, instead of bit depth? The
> application presumably knows the formats it can work with, and can adapt to
> that as well as a change to the bit depth.

I disagree with this. The pixelformat is set by the application, and it is
not set by the incoming video format. Of course, a change in the incoming
video format might force a pixelformat change, but that's not what is signaled
here. This event just indicates that something changed w.r.t. the video source
and the flag specifies that is it the bit depth.

So I think this patch is OK (but see the small comment below) since it
correctly describes what changed.

> 
>>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  Documentation/media/uapi/v4l/vidioc-dqevent.rst | 7 +++++++
>>  Documentation/media/videodev2.h.rst.exceptions  | 1 +
>>  include/uapi/linux/videodev2.h                  | 1 +
>>  3 files changed, 9 insertions(+)
>>
>> diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>> index dea9c0cc00ab..92573d7c3e05 100644
>> --- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>> +++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
>> @@ -397,6 +397,13 @@ call.
>>  	that many devices are not able to recover from a temporary loss of
>>  	signal and so restarting streaming I/O is required in order for the
>>  	hardware to synchronize to the video signal.
>> +    * - ``V4L2_EVENT_SRC_CH_BITDEPTH``
>> +      - 0x0002
>> +      - This event gets triggered when bit-depth change is detected from a
>> +	video decoder. Applications will have to query the new pixel format
>> +	and re-negotiate the queue. In most cases the streaming must be stopped
>> +	and restarted (:ref:`VIDIOC_STREAMOFF <VIDIOC_STREAMON>` followed by
>> +	:ref:`VIDIOC_STREAMON <VIDIOC_STREAMON>`).
>>  
>>  
>>  Return Value
>> diff --git a/Documentation/media/videodev2.h.rst.exceptions b/Documentation/media/videodev2.h.rst.exceptions
>> index 64d348e67df9..b4c35b347983 100644
>> --- a/Documentation/media/videodev2.h.rst.exceptions
>> +++ b/Documentation/media/videodev2.h.rst.exceptions
>> @@ -478,6 +478,7 @@ replace define V4L2_EVENT_CTRL_CH_FLAGS ctrl-changes-flags
>>  replace define V4L2_EVENT_CTRL_CH_RANGE ctrl-changes-flags
>>  
>>  replace define V4L2_EVENT_SRC_CH_RESOLUTION src-changes-flags
>> +replace define V4L2_EVENT_SRC_CH_BITDEPTH src-changes-flags
>>  
>>  replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
>>  
>> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
>> index 496e6453450c..7398f42eac7d 100644
>> --- a/include/uapi/linux/videodev2.h
>> +++ b/include/uapi/linux/videodev2.h
>> @@ -2271,6 +2271,7 @@ struct v4l2_event_frame_sync {
>>  };
>>  
>>  #define V4L2_EVENT_SRC_CH_RESOLUTION		(1 << 0)
>> +#define V4L2_EVENT_SRC_CH_BITDEPTH		(1 << 1)

It's two words, so BIT_DEPTH.

For the future I would also like to see a V4L2_EVENT_SRC_CH_COLORIMETRY flag
to indicate when the colorimetry of the video changes.

It's actually something that would be of use for vivid today.

Regards,

	Hans

>>  
>>  struct v4l2_event_src_change {
>>  	__u32 changes;
> 

