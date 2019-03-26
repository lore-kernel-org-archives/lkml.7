Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7B3C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE9C2070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 15:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbfCZPRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 11:17:05 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:53094 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbfCZPRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 11:17:04 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 3AC5A3C013A;
        Tue, 26 Mar 2019 16:17:01 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rORdif1CvVl9; Tue, 26 Mar 2019 16:16:54 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id A7E223C00C4;
        Tue, 26 Mar 2019 16:16:54 +0100 (CET)
Received: from [10.72.93.172] (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Tue, 26 Mar
 2019 16:16:54 +0100
Subject: Re: [PATCH 09/10] ALSA: pcm: Add snd_pcm_ops for snd_pcm_link()
To:     Takashi Iwai <tiwai@suse.de>
CC:     <broonie@kernel.org>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
 <1553586574-18608-1-git-send-email-twischer@de.adit-jv.com>
 <1553586574-18608-5-git-send-email-twischer@de.adit-jv.com>
 <s5ho95ym3s7.wl-tiwai@suse.de>
 <3ad5c313-ba2c-b541-8930-3f2515dfca72@de.adit-jv.com>
 <s5hr2at67ew.wl-tiwai@suse.de>
From:   Timo Wischer <twischer@de.adit-jv.com>
Message-ID: <68cfbf7a-5f1e-50d2-2b97-4d3c5d360b36@de.adit-jv.com>
Date:   Tue, 26 Mar 2019 16:16:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <s5hr2at67ew.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/19 15:23, Takashi Iwai wrote:
> On Tue, 26 Mar 2019 12:25:37 +0100,
> Timo Wischer wrote:
>> On 3/26/19 09:35, Takashi Iwai wrote:
>>
>>      On Tue, 26 Mar 2019 08:49:33 +0100,
>>      <twischer@de.adit-jv.com> wrote:
>>      
>>          From: Timo Wischer <twischer@de.adit-jv.com>
>>          
>>          snd_pcm_link() can be called by the user as long as the device is not
>>          yet started. Therefore currently a driver which wants to iterate over
>>          the linked substreams has to do this at the start trigger. But the start
>>          trigger should not block for a long time. Therefore there is no callback
>>          which can be used to iterate over the linked substreams without delaying
>>          the start trigger.
>>          This patch introduces a new callback function which will be called after
>>          the linked substream list was updated by snd_pcm_link(). This callback
>>          function is allowed to block for a longer time without interfering the
>>          synchronized start up of linked substreams.
>>          
>>          Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
>>          
>>      Well, the idea appears interesting, but I'm afraid that the
>>      implementation is still racy.  The place you're calling the new
>>      callback isn't protected, hence the stream can be triggered while
>>      calling it.  That is, even during operating your loopback link_changed
>>      callback, another thread is able to start the stream.
>>      
>> Hi Takashi,
>>
>> As far as I got you mean the following scenario:
>>
>>    * snd_pcm_link() is called for a HW sound card
>>        + loopback_snd_timer_link_changed()
> The start may happen at this point.

In this case the last link status will be used and aloop will print a 
warning "Another sound timer was requested but at least one device is 
already running...".

Without this patch set a similar issue already exists. When calling 
snd_pcm_start() before snd_pcm_link() was done the additional device 
linked by the snd_pcm_link() will not be started.
Therefore the application has already to take care about the order of 
the calls.

>
>>        + loopback_snd_timer_open()
>>        + spin_lock_irqsave(&dpcm->cable->lock, flags);
>>    * snd_pcm_start() called for aloop sound card
>>        + loopback_trigger()
>>        + spin_lock(&cable->lock) -> has to wait till loopback_snd_timer_open()
>>          calls spin_unlock_irqrestore()
>>
>> So far snd_pcm_start() has to wait for loopback_snd_timer_open().
>>
>>    * loopback_snd_timer_open() will continue with
>>        + dpcm->cable->snd_timer.instance = NULL;
>>        + spin_unlock_irqrestore()
>>    * loopback_trigger() can enter the lock
>>        + loopback_snd_timer_start() will fail with -EINVAL due to
>>          (loopback_trigger == NULL)
>>
>> At least this will not result into memory corruption due to race or any other
>> wired behavior.
> I don't expect the memory corruption, but my point is that dealing
> with linked streams is still tricky.  It was considered for the
> lightweight coupled start/stop operation, and something intensively
> depending on the linked status was out of the original design...
>
>> But my expectation is that snd_pcm_link(hw, aloop) or snd_pcm_link(aloop, hw)
>> is only called by the application calling snd_pcm_start(aloop)
>> because the same aloop device cannot be opened by multiple applications at the
>> same time.
>>
>> Do you see an use case where one application would call snd_pcm_start() in
>> parallel with snd_pcm_link() (somehow configuring the device)?
> It's not about the actual application usages but rather against the
> malicious attacks.  Especially aloop is a virtual device that is
> available allover the places, it may be deployed / attacked easily.
The attack we are identifying here can only be done by the application 
opening the aloop device.
An application allowed to open the aloop device is anyway able to 
manipulate the audio streaming.
Or do you see an attack which would influence any other device/stream 
not opened by this application?
>
>> May be we should add an additional synchronization mechanism in pcm_native.c
>> to avoid call of snd_pcm_link() in parallel with snd_pcm_start().
> If it really matters...  Honestly speaking, I'm not fully convinced
> whether we want to deal with this using the PCM link mechanism.
>
> What's the motivation for using the linked streams at the first place?
> That's one of the biggest missing piece in the whole picture.
In general when the user uses snd_pcm_link() it expects that the linked 
devices are somehow synchronized.
Any applications already using snd_pcm_link() do not need to be adapted 
to use the new feature of aloop (for example JACK or ALSA multi plugin)

But when linking a HW sound card and aloop without this patch set, both 
devices will be started in sync but
the snd_pcm_period_eleapsed() calls of the different devices will drift. 
To avoid this the aloop plugin can automatically use the right timer.
If this feature is not implemented the user has to use snd_pcm_link() to 
trigger snd_pcm_start() in sync but also has to configure the aloop 
plugin to use the right sound timer.
May be the linked cards can change during runtime of the system. Without 
this feature the aloop kernel driver has to be loaded with different 
kernel parameters
to select the right timer.

ALSA controls cannot be used easily. Selecting the sound timer by the 
card number could be error prone because the card ID could change 
between system starts.
Therefore an ALSA control supporting the card name should be used. This 
could be for example done via an ALSA enum control. But in this case the 
names of all sound cards of the system has to be available
on aloop probe() call. But at this point in time the sound cards probed 
after aloop are not available. Therefore only the sound timers of the 
sound cards probed before aloop are selectable.

>
>
> thanks,
>
> Takashi
