Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFA7CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9895121929
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395306AbfJYOs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:48:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:61585 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389921AbfJYOs2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:48:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 07:48:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,229,1569308400"; 
   d="scan'208";a="223940563"
Received: from bnail-mobl.amr.corp.intel.com (HELO [10.252.140.167]) ([10.252.140.167])
  by fmsmga004.fm.intel.com with ESMTP; 25 Oct 2019 07:48:25 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level function
 for rt5514
To:     "Lu, Brent" <brent.lu@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "M, Naveen" <naveen.m@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1571994691-20199-1-git-send-email-brent.lu@intel.com>
 <3ce80285-ddb5-653d-cf60-febc9fd0bdee@linux.intel.com>
 <CF33C36214C39B4496568E5578BE70C740320822@PGSMSX108.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <219281e5-d685-d584-0d22-5dcf3ca2bec2@linux.intel.com>
Date:   Fri, 25 Oct 2019 09:48:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CF33C36214C39B4496568E5578BE70C740320822@PGSMSX108.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/19 9:43 AM, Lu, Brent wrote:
>> On 10/25/19 4:11 AM, Brent Lu wrote:
>>> The first DMIC capture always fail (zero sequence data from PCM port)
>>> after using DSP hotwording function (i.e. Google assistant).
>>
>> Can you clarify where the DSP hotwording is done? Intel DSP or rt5514?
>>
>> Turning on the MCLK with the BIAS info might force the Intel DSP to remain
>> on, which would impact power consumption if it was supposed to remain off.
>>
> 
> Hi Pierre,
> 
> It's done in rt5514's DSP and the interface is SPI instead of I2S for the voice wake
> up function.
> 
> There is a driver rt5514-spi.c which provides platform driver and DAI. User space
> application first uses the mixer to turn on the voice wake up function:
> 
> amixer -c0 cset name='DSP Voice Wake Up' on
> 
> Then open and read data from the PCM port which goes to the SPI platform and
> dai code. Finally it uses same mixer to turn off the function and return to normal
> codec mode. The DMIC recording (from I2S) and the voice wake on function should
> be mutually exclusive according to the driver design.
> 
> In the codec driver rt5514.c there is a rt5514_set_bias_level function. It's expected to
> turn on/off mclk here according to Realtek people's say but our ssp clock requires set
> rate function to be called in advance so I implement the code in machine driver.

Can you clarify if the rt5514 needs the MCLK while it's doing the 
hotword detection?

My point is really that this patch uses a card-level BIAS indication, 
and I'd like to make sure this does not interfere with the audio DSP 
being in D3 state.
