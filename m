Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBD9C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453652173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 15:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfGQPab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 11:30:31 -0400
Received: from mga07.intel.com ([134.134.136.100]:31551 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725993AbfGQPab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 11:30:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 08:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,274,1559545200"; 
   d="scan'208";a="172898749"
Received: from szrederp-mobl.amr.corp.intel.com (HELO [10.252.199.30]) ([10.252.199.30])
  by orsmga006.jf.intel.com with ESMTP; 17 Jul 2019 08:30:27 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Atom: read timestamp moved to
 period_elapsed
To:     Curtis Malainey <cujomalainey@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Ben Zhang <benzh@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Alex Levin <levinale@chromium.org>
References: <20190709040147.111927-1-levinale@chromium.org>
 <20190709114519.GW9224@smile.fi.intel.com>
 <CAOReqxirZdKJQ59Z4789wT5Cxh2fyQrUcuB1pm9AidYLiPEs1A@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <029bc013-608b-031b-780e-c48486fd9c15@linux.intel.com>
Date:   Wed, 17 Jul 2019 10:30:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAOReqxirZdKJQ59Z4789wT5Cxh2fyQrUcuB1pm9AidYLiPEs1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/19 6:15 PM, Curtis Malainey wrote:
> On Tue, Jul 9, 2019 at 4:45 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>>
>> On Mon, Jul 08, 2019 at 09:01:47PM -0700, Alex Levin wrote:
>>> sst_platform_pcm_pointer is called from both snd_pcm_period_elapsed and
>>> from snd_pcm_ioctl. Calling read timestamp results in recalculating
>>> pcm_delay and buffer_ptr (sst_calc_tstamp) which consumes buffers in a
>>> faster rate than intended.
>>> In a tested BSW system with chtrt5650, for a rate of 48000, the
>>> measured rate was sometimes 10 times more than that.
>>> After moving the timestamp read to period elapsed, buffer consumption is
>>> as expected.
>>
>>  From code prospective it looks good. You may take mine
>> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>>
>> Though I'm not an expert in the area, Pierre and / or Liam should give
>> their blessing.
>>
> Agreed, Liam or Pierre should also give their ok since this is one of
> the closed source firmware drivers.
> 
> Reviewed-by: Curtis Malainey <cujomalainey@chromium.org>

Humm, this first review after my Summer break isn't straightforward.

By moving the timestamp update to the period elapsed event, don't you 
prevent the use of this driver in no-interrupt mode - which I understood 
as the baseline for Chrome?

And I also don't get how this timestamp might lead to 10x speed issues, 
this driver has been around for a number of years and that specific 
error was never seen. What is different in this platform and can this be 
seen e.g. on a Cyan device?


>>>
>>> Signed-off-by: Alex Levin <levinale@chromium.org>
>>> ---
>>>   sound/soc/intel/atom/sst-mfld-platform-pcm.c | 23 +++++++++++++-------
>>>   1 file changed, 15 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>> index 0e8b1c5eec88..196af0b30b41 100644
>>> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
>>> @@ -265,16 +265,28 @@ static void sst_period_elapsed(void *arg)
>>>   {
>>>        struct snd_pcm_substream *substream = arg;
>>>        struct sst_runtime_stream *stream;
>>> -     int status;
>>> +     struct snd_soc_pcm_runtime *rtd;
>>> +     int status, ret_val;
>>>
>>>        if (!substream || !substream->runtime)
>>>                return;
>>>        stream = substream->runtime->private_data;
>>>        if (!stream)
>>>                return;
>>> +
>>> +     rtd = substream->private_data;
>>> +     if (!rtd)
>>> +             return;
>>> +
>>>        status = sst_get_stream_status(stream);
>>>        if (status != SST_PLATFORM_RUNNING)
>>>                return;
>>> +
>>> +     ret_val = stream->ops->stream_read_tstamp(sst->dev, &stream->stream_info);
>>> +     if (ret_val) {
>>> +             dev_err(rtd->dev, "stream_read_tstamp err code = %d\n", ret_val);
>>> +             return;
>>> +     }
>>>        snd_pcm_period_elapsed(substream);
>>>   }
>>>
>>> @@ -658,20 +670,15 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
>>>                        (struct snd_pcm_substream *substream)
>>>   {
>>>        struct sst_runtime_stream *stream;
>>> -     int ret_val, status;
>>> +     int status;
>>>        struct pcm_stream_info *str_info;
>>> -     struct snd_soc_pcm_runtime *rtd = substream->private_data;
>>>
>>>        stream = substream->runtime->private_data;
>>>        status = sst_get_stream_status(stream);
>>>        if (status == SST_PLATFORM_INIT)
>>>                return 0;
>>> +
>>>        str_info = &stream->stream_info;
>>> -     ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
>>> -     if (ret_val) {
>>> -             dev_err(rtd->dev, "sst: error code = %d\n", ret_val);
>>> -             return ret_val;
>>> -     }
>>>        substream->runtime->delay = str_info->pcm_delay;
>>>        return str_info->buffer_ptr;
>>>   }
>>> --
>>> 2.22.0.410.gd8fdbe21b5-goog
>>>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
