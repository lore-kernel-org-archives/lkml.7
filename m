Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A0DC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7368520989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 15:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfGBPwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 11:52:08 -0400
Received: from mga07.intel.com ([134.134.136.100]:11936 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBPwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 11:52:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 08:52:07 -0700
X-IronPort-AV: E=Sophos;i="5.63,443,1557212400"; 
   d="scan'208";a="157681050"
Received: from mwasko-mobl.ger.corp.intel.com (HELO [10.249.140.55]) ([10.249.140.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/AES256-SHA; 02 Jul 2019 08:52:03 -0700
Subject: Re: [alsa-devel] [PATCH] ALSA: usb-audio: fix Line6 Helix audio
 format rates
To:     Takashi Iwai <tiwai@suse.de>, Nicola Lunghi <nick83ola@gmail.com>
Cc:     alsa-devel@alsa-project.org, info@jensverwiebe.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Jussi Laako <jussi@sonarnerd.net>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
References: <20190702004439.30131-1-nick83ola@gmail.com>
 <s5hlfxg4i4r.wl-tiwai@suse.de>
From:   "Wasko, Michal" <michal.wasko@linux.intel.com>
Message-ID: <4181a467-5332-c256-5124-513a0343ec70@linux.intel.com>
Date:   Tue, 2 Jul 2019 17:52:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <s5hlfxg4i4r.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/2019 4:37 PM, Takashi Iwai wrote:
> On Tue, 02 Jul 2019 02:43:14 +0200,
> Nicola Lunghi wrote:
>> Line6 Helix and HX stomp don't support retrieving
>> the number of clock sample rate.
>>
>> Add a quirk to return the default value of 48Khz.
>>
>> Signed-off-by: Nicola Lunghi <nick83ola@gmail.com>
> It's not particularly good place to put a quirk, but there seems no
> other better place, unfortunately.  Is this specific to certain unit
> or all I/Os on the device suffer from this problem?
>
> In anyway, if the behavior is expected, we don't need to use
> dev_warn() to annoy users unnecessarily.  Replace it with dev_info().
>
> Also, the code that creates a single 48k entry would be better to be
> put into a function for readability.
>
> Could you resubmit with that change?
>
>
> Thanks!
>
> Takashi

If the listed USB devices do not support sample rate format retrieval
then maybe it would be a better idea to perform below check before
sending message?

Have you also considered new function or macro that check device
support? This would separate formatfunctionality code from routine
that identifies applicable devices- in case if in future more devices
will require quirk.

Michal W.

>> ---
>>   sound/usb/format.c | 28 +++++++++++++++++++++++++---
>>   1 file changed, 25 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/usb/format.c b/sound/usb/format.c
>> index c02b51a82775..05442f6ada62 100644
>> --- a/sound/usb/format.c
>> +++ b/sound/usb/format.c
>> @@ -313,10 +313,32 @@ static int parse_audio_format_rates_v2v3(struct snd_usb_audio *chip,
>>   			      tmp, sizeof(tmp));
>>   
>>   	if (ret < 0) {
>> -		dev_err(&dev->dev,
>> -			"%s(): unable to retrieve number of sample rates (clock %d)\n",
>> +		switch (chip->usb_id) {
>> +		/* LINE 6 HX pedals don't support getting the clock sample rate.
>> +		 * Set the framerate to 48khz by default
>> +		 */
>> +		case USB_ID(0x0E41, 0x4244): /* HELIX */
>> +		case USB_ID(0x0E41, 0x4246): /* HX STOMP */
>> +			dev_warn(&dev->dev,
>> +				"%s(): line6 helix: unable to retrieve number of sample rates. Set it to default value (clock %d).\n",
>>   				__func__, clock);
>> -		goto err;
>> +			fp->nr_rates = 1;
>> +			fp->rate_min = 48000;
>> +			fp->rate_max = 48000;
>> +			fp->rates = SNDRV_PCM_RATE_48000;
>> +			fp->rate_table = kmalloc(sizeof(int), GFP_KERNEL);
>> +			if (!fp->rate_table) {
>> +				ret = -ENOMEM;
>> +				goto err_free;
>> +			}
>> +			fp->rate_table[0] = 48000;
>> +			return 0;
>> +		default:
>> +			dev_err(&dev->dev,
>> +				"%s(): unable to retrieve number of sample rates (clock %d)\n",
>> +					__func__, clock);
>> +			goto err;
>> +		}
>>   	}
>>   
>>   	nr_triplets = (tmp[1] << 8) | tmp[0];
>> -- 
>> 2.19.1
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
