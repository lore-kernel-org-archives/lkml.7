Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D4DC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757B62067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 15:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfFEPNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 11:13:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:58338 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728322AbfFEPNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 11:13:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 08:13:34 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Jun 2019 08:13:34 -0700
Received: from kwong4-mobl.amr.corp.intel.com (unknown [10.252.203.122])
        by linux.intel.com (Postfix) with ESMTP id 3C2B75800BD;
        Wed,  5 Jun 2019 08:13:33 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH 03/14] ALSA: hdac: Fix codec name after
 machine driver is unloaded and reloaded
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@intel.com>
References: <20190605134556.10322-1-amadeuszx.slawinski@linux.intel.com>
 <20190605134556.10322-4-amadeuszx.slawinski@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a171f010-6901-d256-4cfe-201cbed58970@linux.intel.com>
Date:   Wed, 5 Jun 2019 10:13:34 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605134556.10322-4-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/19 8:45 AM, Amadeusz Sławiński wrote:
> From: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
> 
> This resets internal index used for enumarating codecs. This will only
> work on assumption that platform has one codec. Anyway if there is more,
> it won't work with current machine drivers, because we can't guarantee
> order in which they are enumerated. This workarounds the fact that most
> intel machine drivers have the following defined:
> .codec_name = "ehdaudio0D2",
> However when we unload and reload machine driver idx gets incremented,
> so .codec_name would've needed to be set to ehdaudio1D2 on first reload
> and so on.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@intel.com>
> ---
>   sound/hda/ext/hdac_ext_bus.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
> index f33ba58b753c..c84d69c2eba4 100644
> --- a/sound/hda/ext/hdac_ext_bus.c
> +++ b/sound/hda/ext/hdac_ext_bus.c
> @@ -77,6 +77,8 @@ static const struct hdac_io_ops hdac_ext_default_io = {
>   	.dma_free_pages = hdac_ext_dma_free_pages,
>   };
>   
> +static int idx;
> +
>   /**
>    * snd_hdac_ext_bus_init - initialize a HD-audio extended bus
>    * @ebus: the pointer to extended bus object
> @@ -93,7 +95,6 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
>   			const struct hdac_ext_bus_ops *ext_ops)
>   {
>   	int ret;
> -	static int idx;
>   
>   	/* check if io ops are provided, if not load the defaults */
>   	if (io_ops == NULL)
> @@ -118,6 +119,14 @@ EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_init);
>   void snd_hdac_ext_bus_exit(struct hdac_bus *bus)
>   {
>   	snd_hdac_bus_exit(bus);
> +	/* FIXME: this is workaround
> +	 * reset index used for bus->idx, because machine drivers expect
> +	 * the codec name to be ehdaudio0D2, where 0 is bus->idx
> +	 * we only perform reset if there is one used device, if there is more
> +	 * all bets are off
> +	 */
> +	if (idx == 1)
> +		idx = 0;

The real fix would be to stop incrementing idx in snd_hdac_ext_bus_init, 
which would make sense only if we had multiple controllers. SOF pegged 
bus->idx to zero.


>   	WARN_ON(!list_empty(&bus->hlink_list));
>   }
>   EXPORT_SYMBOL_GPL(snd_hdac_ext_bus_exit);
> 

