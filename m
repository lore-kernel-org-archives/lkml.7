Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EA4C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C48A223400
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 13:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbfHVNxL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 09:53:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:24281 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731483AbfHVNxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 09:53:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 06:53:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,416,1559545200"; 
   d="scan'208";a="203417795"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2019 06:53:09 -0700
Received: from tcwomach-mobl1.amr.corp.intel.com (unknown [10.255.34.51])
        by linux.intel.com (Postfix) with ESMTP id ABF455803A5;
        Thu, 22 Aug 2019 06:53:06 -0700 (PDT)
Subject: Re: [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire stream
 config/free callbacks
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
 <20190822071835.GA30262@ubuntu>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f73796d6-fcfa-97c8-69ae-0a183edbbd97@linux.intel.com>
Date:   Thu, 22 Aug 2019 08:53:06 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190822071835.GA30262@ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Guennadi

>> +static int sdw_config_stream(void *arg, void *s, void *dai,
>> +			     void *params, int link_id, int alh_stream_id)
> 
> I realise, that these function prototypes aren't being introduced by these
> patches, but just wondering whether such overly generic prototype is really
> a good idea here, whether some of those "void *" pointers could be given
> real types. The first one could be "struct device *" etc.

In this case the 'arg' parameter is actually a private 'struct 
snd_sof_dev', as shown below [1]. We probably want to keep this 
relatively opaque, this is a context that doesn't need to be exposed to 
the SoundWire code.

The dai and params are indeed cases where we could use stronger types, 
they are snd_soc_dai and hw_params respectively. I don't recall why the 
existing code is this way, Vinod and Sanyog may have the history of this.

> 
>> +{
>> +	struct snd_sof_dev *sdev = arg;
>> +	struct snd_soc_dai *d = dai;
[1]

>> +	struct sof_ipc_dai_config config;
>> +	struct sof_ipc_reply reply;
>> +	int ret;
>> +	u32 size = sizeof(config);
>> +
>> +	memset(&config, 0, size);
>> +	config.hdr.size = size;
>> +	config.hdr.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG;
>> +	config.type = SOF_DAI_INTEL_ALH;
>> +	config.dai_index = (link_id << 8) | (d->id);
>> +	config.alh.stream_id = alh_stream_id;
> 
> Entirely up to you, in such cases I usually do something like
> 
> +	struct sof_ipc_dai_config config = {
> +		.type = SOF_DAI_INTEL_ALH,
> +		.hre = {
> +			.size = sizeof(config),
> +			.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG,
> +			...
> 
> which then also avoids a memset(). But that's mostly a matter of personal
> preference, since this is on stack, the compiler would probably internally
> anyway translate the above initialisation to a memset() with all the
> following assignments.

I have no preference, so in this case I will go with consistency with 
existing code, which uses the suggested style for all IPCs.

> 
>> +
>> +	/* send message to DSP */
>> +	ret = sof_ipc_tx_message(sdev->ipc,
>> +				 config.hdr.cmd, &config, size, &reply,
>> +				 sizeof(reply));
>> +	if (ret < 0) {
>> +		dev_err(sdev->dev,
>> +			"error: failed to set DAI hw_params for link %d dai->id %d ALH %d\n",
> 
> Are readers really expected to understand what "dai->id" means? Wouldn't
> "DAI ID" be friendlier, although I understand you - who might not know
> what "x->y" stands for?.. ;-)

I was trying to avoid a confusion here, we have config->dai_index which 
are shared concepts between topology and firmware, and dai->id which is 
shared between topology and machine driver (which refers to the dai in 
the dai_link which has its own .id). In topology files we have the three 
indices and of course after a couple of weeks I can't recall which one 
maps to what.
I am afraid DAI ID might be confused with dai_index. If there are 
suggestions on this I am all ears, all I care about is avoiding 
ambiguity and having to ask Ranjani what index this really is :-)
