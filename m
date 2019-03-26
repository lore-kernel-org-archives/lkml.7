Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDCC320830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731238AbfCZIMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:12:47 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:49724 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbfCZIMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:12:45 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id A24F63C00DD;
        Tue, 26 Mar 2019 09:12:41 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KEtSQgcksQyD; Tue, 26 Mar 2019 09:12:35 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 55E203C00C4;
        Tue, 26 Mar 2019 09:12:35 +0100 (CET)
Received: from [10.72.93.172] (10.72.93.172) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.435.0; Tue, 26 Mar
 2019 09:12:34 +0100
Subject: Re: [PATCH 04/10] ALSA: aloop: Use always spin_lock_irqsave() for
 cable->lock
To:     Takashi Iwai <tiwai@suse.de>
CC:     <broonie@kernel.org>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
References: <1553529644-5654-1-git-send-email-twischer@de.adit-jv.com>
 <1553529644-5654-5-git-send-email-twischer@de.adit-jv.com>
 <s5htvfr6iqh.wl-tiwai@suse.de>
 <237e2d2d-9a8f-a273-4c40-db2c670c6858@de.adit-jv.com>
 <s5hlg127uww.wl-tiwai@suse.de>
From:   Timo Wischer <twischer@de.adit-jv.com>
Message-ID: <3423ff53-7ee3-01e7-c4bf-a4f730fdfe94@de.adit-jv.com>
Date:   Tue, 26 Mar 2019 09:12:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <s5hlg127uww.wl-tiwai@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.72.93.172]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 17:58, Takashi Iwai wrote:
> On Mon, 25 Mar 2019 17:40:23 +0100,
> Timo Wischer wrote:
>> Best regards
>> Timo Wischer
>> Engineering Software Base (ADITG/ESB)
>>
>> Tel. +49 5121 49 6938
>> On 3/25/19 17:07, Takashi Iwai wrote:
>>
>>      On Mon, 25 Mar 2019 17:00:38 +0100,
>>      <twischer@de.adit-jv.com> wrote:
>>      
>>          From: Timo Wischer <twischer@de.adit-jv.com>
>>          
>>          to allow the usage of timer callbacks from interrupt context.
>>          For example the sound timer.
>>          
>>      The trigger callback is already irq-disabled.  And, open/close must
>>      not be irq-disabled OTOH.  So these changes must be superfluous.
>>      
>> Hello Takashi,
>>
>> could you explain why open/close must not be irq-disabled?
> The open/close callbacks get called always in sleepable context where
> you can use mutex & co gracefully.  The only non-sleepable (atomic)
> context is pointer and trigger callbacks.  So it's safe to use
> spin_lock() without irq in these callbacks.
> OTOH, the rest (open, close,hw_params, hw_free, prepare) callbacks are
> always sleepable, hence it's safe to use spin_lock_irq() (not
> save/restore) variant.
>
> When a driver declares as non-atomic via PCM flag, all callbacks
> become sleepable, but this isn't the case for aloop driver.
>
>> I see a potential deadlock in case of free_cable() uses only spin_lock()
>> instead of spin_lock_irqsave().
>> For example the following will be executed:
>>
>> loopback_close()
>> free_cable()
>> spin_lock(&dpcm->cable->lock)
> Which spin_lock() call?  The free_cable() calls spin_lock_irq().
>
>>>> Interrupted by jiffies timer IRQ before calling spin_unlock()
>> loopback_jiffies_timer_function()
>> spin_lock_irqsave(&dpcm->cable->lock)
>>>> DEADLOCK due to dpcm->cable->lock is already locked
>> Do you also see this deadlock or do you see any reason why this could not
>> happen?
> If spin_lock_irq() is used in free_cable(), it must be OK.
>
>
> Takashi
Thanks for the detailed explanation.

@all:
Please simple ignore this patch.

Best regards

Timo

>
>
>> Best regards
>>
>> Timo
>>
>>      thanks,
>>      
>>      Takashi
>>
>>          Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
>>          ---
>>           sound/drivers/aloop.c | 33 +++++++++++++++++++--------------
>>           1 file changed, 19 insertions(+), 14 deletions(-)
>>          
>>          diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
>>          index 11e8ed6..c6217c4 100644
>>          --- a/sound/drivers/aloop.c
>>          +++ b/sound/drivers/aloop.c
>>          @@ -272,6 +272,7 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
>>                struct loopback_pcm *dpcm = runtime->private_data;
>>                struct loopback_cable *cable = dpcm->cable;
>>                int err = 0, stream = 1 << substream->stream;
>>          +     unsigned long flags;
>>           
>>                switch (cmd) {
>>                case SNDRV_PCM_TRIGGER_START:
>>          @@ -281,39 +282,39 @@ static int loopback_trigger(struct snd_pcm_substream *substream, int cmd)
>>                                      dpcm->last_jiffies = jiffies;
>>                                      dpcm->pcm_rate_shift = 0;
>>                                      dpcm->last_drift = 0;
>>          -                           spin_lock(&cable->lock);
>>          +                           spin_lock_irqsave(&cable->lock, flags);
>>                                      cable->running |= stream;
>>                                      cable->pause &= ~stream;
>>                                      err = loopback_timer_start(dpcm);
>>          -                           spin_unlock(&cable->lock);
>>          +                           spin_unlock_irqrestore(&cable->lock, flags);
>>                                      if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>                                                            loopback_active_notify(dpcm);
>>                                      break;
>>                case SNDRV_PCM_TRIGGER_STOP:
>>          -                           spin_lock(&cable->lock);
>>          +                           spin_lock_irqsave(&cable->lock, flags);
>>                                      cable->running &= ~stream;
>>                                      cable->pause &= ~stream;
>>                                      err = loopback_timer_stop(dpcm);
>>          -                           spin_unlock(&cable->lock);
>>          +                           spin_unlock_irqrestore(&cable->lock, flags);
>>                                      if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>                                                            loopback_active_notify(dpcm);
>>                                      break;
>>                case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>>                case SNDRV_PCM_TRIGGER_SUSPEND:
>>          -                           spin_lock(&cable->lock);
>>          +                           spin_lock_irqsave(&cable->lock, flags);
>>                                      cable->pause |= stream;
>>                                      err = loopback_timer_stop(dpcm);
>>          -                           spin_unlock(&cable->lock);
>>          +                           spin_unlock_irqrestore(&cable->lock, flags);
>>                                      if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>                                                            loopback_active_notify(dpcm);
>>                                      break;
>>                case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>>                case SNDRV_PCM_TRIGGER_RESUME:
>>          -                           spin_lock(&cable->lock);
>>          +                           spin_lock_irqsave(&cable->lock, flags);
>>                                      dpcm->last_jiffies = jiffies;
>>                                      cable->pause &= ~stream;
>>                                      err = loopback_timer_start(dpcm);
>>          -                           spin_unlock(&cable->lock);
>>          +                           spin_unlock_irqrestore(&cable->lock, flags);
>>                                      if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>>                                                            loopback_active_notify(dpcm);
>>                                      break;
>>          @@ -557,12 +558,13 @@ static snd_pcm_uframes_t loopback_pointer(struct snd_pcm_substream *substream)
>>           {
>>                struct snd_pcm_runtime *runtime = substream->runtime;
>>                struct loopback_pcm *dpcm = runtime->private_data;
>>          +     unsigned long flags;
>>                snd_pcm_uframes_t pos;
>>           
>>          -     spin_lock(&dpcm->cable->lock);
>>          +     spin_lock_irqsave(&dpcm->cable->lock, flags);
>>                loopback_pos_update(dpcm->cable);
>>                pos = dpcm->buf_pos;
>>          -     spin_unlock(&dpcm->cable->lock);
>>          +     spin_unlock_irqrestore(&dpcm->cable->lock, flags);
>>                return bytes_to_frames(runtime, pos);
>>           }
>>           
>>          @@ -679,10 +681,12 @@ static void free_cable(struct snd_pcm_substream *substream)
>>                if (!cable)
>>                                      return;
>>                if (cable->streams[!substream->stream]) {
>>          +                           unsigned long flags;
>>          +
>>                                      /* other stream is still alive */
>>          -                           spin_lock_irq(&cable->lock);
>>          +                           spin_lock_irqsave(&cable->lock, flags);
>>                                      cable->streams[substream->stream] = NULL;
>>          -                           spin_unlock_irq(&cable->lock);
>>          +                           spin_unlock_irqrestore(&cable->lock, flags);
>>                } else {
>>                                      /* free the cable */
>>                                      loopback->cables[substream->number][dev] = NULL;
>>          @@ -698,6 +702,7 @@ static int loopback_open(struct snd_pcm_substream *substream)
>>                struct loopback_cable *cable = NULL;
>>                int err = 0;
>>                int dev = get_cable_index(substream);
>>          +     unsigned long flags;
>>           
>>                mutex_lock(&loopback->cable_lock);
>>                dpcm = kzalloc(sizeof(*dpcm), GFP_KERNEL);
>>          @@ -753,9 +758,9 @@ static int loopback_open(struct snd_pcm_substream *substream)
>>                else
>>                                      runtime->hw = cable->hw;
>>           
>>          -     spin_lock_irq(&cable->lock);
>>          +     spin_lock_irqsave(&cable->lock, flags);
>>                cable->streams[substream->stream] = dpcm;
>>          -     spin_unlock_irq(&cable->lock);
>>          +     spin_unlock_irqrestore(&cable->lock, flags);
>>           
>>            unlock:
>>                if (err < 0) {
>>          --
>>          2.7.4
>>
>>
