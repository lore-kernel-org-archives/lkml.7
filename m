Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106E8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2DAB2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553868880;
	bh=jcV2spMI05TxqX+wfgoyK/0C/yiPgbshR60qInCAj2A=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=f+UlCrG9OVDFwNtPSY8MVVpH6UGdDrcMtYQukgzs3v2vY95emkIjhkWqwghrnuP4Y
	 IEUci6oaSW7wHqu017JlRNEHFvpBe337fWWWAjXhIk1PqR4U2PWrNn5G0RSaO1+ZBa
	 soni9UJgTNKLTEmFtCNJYNwnwLyiAK61jBCw7Xms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfC2OOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:14:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728804AbfC2OOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:14:39 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B591F206C0;
        Fri, 29 Mar 2019 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553868878;
        bh=jcV2spMI05TxqX+wfgoyK/0C/yiPgbshR60qInCAj2A=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=qQGTH7bwLgU1YALt7Om298YfAiwYg1XjU1vAv9+2vt6OyXRm2H5posBLpjuYQEue7
         jLRwIZdGunli9oDM5jtvQK/bF1JZCWpmccWYC4R46cLT/yIyaht5Vjpm0PH1qkgIoa
         SSLzgind37OyXBG3yhsUbaqaXoXEzMo7zQFyF2do=
Subject: Re: [PATCH v13 2/6] media: change au0828 to use Media Device
 Allocator API
To:     Hans Verkuil <hverkuil@xs4all.nl>, mchehab@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, shuah <shuah@kernel.org>
References: <cover.1553814518.git.shuah@kernel.org>
 <05ec250a56d9eaa868e7c8cf6376d6f8e29bb102.1553814518.git.shuah@kernel.org>
 <693a4487-b4dd-b3e0-953e-22c342708f1f@xs4all.nl>
From:   shuah <shuah@kernel.org>
Message-ID: <232cd798-4c0a-78d2-5eac-4c2870b4d6eb@kernel.org>
Date:   Fri, 29 Mar 2019 08:14:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <693a4487-b4dd-b3e0-953e-22c342708f1f@xs4all.nl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 2:27 AM, Hans Verkuil wrote:
> On 3/29/19 1:04 AM, Shuah Khan wrote:
>> Media Device Allocator API to allows multiple drivers share a media device.
>> This API solves a very common use-case for media devices where one physical
>> device (an USB stick) provides both audio and video. When such media device
>> exposes a standard USB Audio class, a proprietary Video class, two or more
>> independent drivers will share a single physical USB bridge. In such cases,
>> it is necessary to coordinate access to the shared resource.
>>
>> Using this API, drivers can allocate a media device with the shared struct
>> device as the key. Once the media device is allocated by a driver, other
>> drivers can get a reference to it. The media device is released when all
>> the references are released.
>>
>> Change au0828 to use Media Device Allocator API to allocate media device
>> with the parent usb struct device as the key, so it can be shared with the
>> snd_usb_audio driver.
>>
>> Signed-off-by: Shuah Khan <shuah@kernel.org>
>> ---
>>   drivers/media/usb/au0828/Kconfig       |  2 ++
>>   drivers/media/usb/au0828/au0828-core.c | 13 +++++--------
>>   drivers/media/usb/au0828/au0828.h      |  1 +
>>   3 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/media/usb/au0828/Kconfig b/drivers/media/usb/au0828/Kconfig
>> index 65fc067eb864..98de6e24329e 100644
>> --- a/drivers/media/usb/au0828/Kconfig
>> +++ b/drivers/media/usb/au0828/Kconfig
>> @@ -2,6 +2,8 @@
>>   config VIDEO_AU0828
>>   	tristate "Auvitek AU0828 support"
>>   	depends on I2C && INPUT && DVB_CORE && USB && VIDEO_V4L2
>> +	select MEDIA_CONTROLLER
>> +	select MEDIA_CONTROLLER_DVB
> 
> Is it required to select MEDIA_CONTROLLER_DVB? Does something fail to work
> if this is unset?
> 

Need this enabled for dvb driver to use media controller. api.

e.g dvb_register_media_device() does all its media controller code
when MEDIA_CONTROLLER_DVB is enabled.

See drivers/media/dvb-core/dvbdev.c

The config still says experimental:

config MEDIA_CONTROLLER_DVB
         bool "Enable Media controller for DVB (EXPERIMENTAL)"
         depends on MEDIA_CONTROLLER && DVB_CORE
         ---help---
           Enable the media controller API support for DVB.

           This is currently experimental.

Is that still accurate? Should be updated?

thanks,
-- Shuah
