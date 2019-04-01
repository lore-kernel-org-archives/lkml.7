Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C6DC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605FD20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554130416;
	bh=RdaDGORdpzjoehK9tBaeaKnzeTyhjMIoFtQH7bHJCOM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=qeuS5Zs/6CBDp12vem6HCY5V4rFcMd08U7udPfOHqWLbGw+Pchze0KUJmfIm/KmRZ
	 6iNpImJaTEgIsH1KTJ8+4Why35sD7RVjVeTpnRrFqDIKu0Gir/SPTtvGwKl5JPq2Hr
	 mDJv/lfkzMjHqKJzdRabWP5/ihRzrb/YMrxf2tjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfDAOxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:53:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfDAOxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:53:34 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E64720856;
        Mon,  1 Apr 2019 14:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554130413;
        bh=RdaDGORdpzjoehK9tBaeaKnzeTyhjMIoFtQH7bHJCOM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Udot1LWTBea5LijSN5QwUEKS9M3cYeaVs02p6eYbquzNRomeyHsHzIXap0TyiFJgS
         cnYSSvfEGjM3nuwwxZD7E+wGaYKFl14/jJtFjh//ZDCQBuxjbPCV954kS+PMz+GAWk
         YDxK9VlkiZOpuZ0MzKA5IRgqXTywd590rkxDap80=
Subject: Re: [PATCH v14 5/6] au0828: fix enable and disable source audio and
 video inconsistencies
To:     Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
References: <cover.1553909892.git.shuah@kernel.org>
 <a314cc4fbfa5ae928cd9f13b8e16046e38418273.1553909893.git.shuah@kernel.org>
 <b67b2a75-ef2a-08df-c67c-c14bd9e33303@xs4all.nl>
From:   shuah <shuah@kernel.org>
Message-ID: <43ad656a-47d7-9723-d5af-06f86d40e8a0@kernel.org>
Date:   Mon, 1 Apr 2019 08:53:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <b67b2a75-ef2a-08df-c67c-c14bd9e33303@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/19 5:14 AM, Hans Verkuil wrote:
> Hi Shuah,
> 
> On 3/30/19 2:54 AM, Shuah Khan wrote:
>> Enable and disable source interfaces aren't consistent in enforcing
>> how video and audio share the tuner resource.
>>
>> Fix these issues to enforce the following rules and allow
>> sharing between audio and video applications.
>>
>> - When DVB is streaming, audio/video/vbi/s-video/composite
>>    should find the resource busy. DVB holds the tuner in
>>    exclusive mode.
>> - When video is streaming, audio can share the tuner and vice versa.
>> - v4l2 allows multiple applications to open video device.
>> - Video applications call enable source multiple times during their
>>    run-time. Resource should stay locked until the last application
>>    releases it.
>> - A shared resource should stay in shared state and locked when it is
>>    in use by audio and video. More than one video application is allowed
>>    to use the tuner as long as video streaming protocol allows such usage.
>>    Resource is released when the last video/audio application releases it.
>> - S-Video and Composite hold the resource in exclusive mode.
>> - VBI allows more than vbi applications sharing and will not share
>>    with another type. When resource is locked by VBI and in use by
>>    multiple VBI applications, it should stay locked until the last
>>    application disables it.
> 
> This isn't correct: only one application at most can stream VBI, but
> VBI can be shared with video and audio streaming.
> 
> All three come from the same source (analog TV), so as long as one of
> these is streaming the analog tuner resource is in use.
> 
> With this patch it seems that streaming VBI blocks streaming audio/video
> and vice versa. That's wrong.

Right. The reason I went this route is that VBI streaming stops even
when another VBI starts to stream. I am debugging this. Looks like
you have a fix for this from reading below.

> 
> Otherwise everything looks OK, except for a typo below.
> 

Will fix the typos and also I noticed, I forgot to catch updating
Copyright in one of the files.

>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   drivers/media/usb/au0828/au0828-core.c | 182 +++++++++++++++++++------
>>   drivers/media/usb/au0828/au0828.h      |   5 +-
>>   2 files changed, 148 insertions(+), 39 deletions(-)
>>
>> diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
>> index 4f8ba6f64d3c..b8bcab2fa1dc 100644
>> --- a/drivers/media/usb/au0828/au0828-core.c
>> +++ b/drivers/media/usb/au0828/au0828-core.c
>> @@ -272,6 +272,27 @@ static void au0828_media_graph_notify(struct media_entity *new,
>>   	}
>>   }
>>   
>> +static bool au0828_is_link_sharable(struct media_entity *owner,
>> +				    struct media_entity *entity)
>> +{
>> +	bool sharable = false;
> 
> typo: sharable -> shareable
> 
> Also in the function name: do a search-and-replace for this.

Will do.

> 
>> +
>> +	/* Tuner link can be shared by audio and video */
> 
> add: and VBI
> 
> I think the core issue is here since VBI should be included with
> IO_V4L and AUDIO_CAPTURE.
> 
>> +	switch (owner->function) {
>> +	case MEDIA_ENT_F_IO_V4L:
>> +	case MEDIA_ENT_F_AUDIO_CAPTURE:
>> +		if (entity->function == MEDIA_ENT_F_IO_V4L ||
>> +		    entity->function == MEDIA_ENT_F_AUDIO_CAPTURE)
>> +			sharable = true;
>> +		break;
>> +	case MEDIA_ENT_F_DTV_DEMOD:
>> +	case MEDIA_ENT_F_IO_VBI:
>> +	default:
>> +		break;
>> +	}
>> +	return sharable;
> 
> I hacked this function so VBI is included with IO_V4L/AUDIO_CAPTURE
> and now it works.
> 

Yes. Y have been debugging with VBI included in the sharing, however
running into the below problem. Do you have the patch I can use to
test with this series?

> There is one remaining issue (but that was always a problem with au0828):
> when streaming is in progress from both video and vbi, and then you stop
> the video streaming, then vbi stops as well.
> 
> au0828_stop_streaming() calls v4l2_device_call_all(&dev->v4l2_dev, 0, video, s_stream, 0);
> which it should only do when the last user disappears. I'll post a patch
> for au0828 to fix this.
> 

Thanks for finding this problem. I narrowed it to close and didn't get
a chance to play with it.

thanks,
-- Shuah

