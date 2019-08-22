Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B39FC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42540214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbfHVHSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:18:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:43722 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbfHVHSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:18:42 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 00:18:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="203294576"
Received: from gliakhov-mobl2.ger.corp.intel.com (HELO ubuntu) ([10.249.36.176])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2019 00:18:37 -0700
Date:   Thu, 22 Aug 2019 09:18:36 +0200
From:   Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
Subject: Re: [RFC PATCH 4/5] ASoC: SOF: Intel: hda: add SoundWire stream
 config/free callbacks
Message-ID: <20190822071835.GA30262@ubuntu>
References: <20190821201720.17768-1-pierre-louis.bossart@linux.intel.com>
 <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821201720.17768-5-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

A couple of comments below

On Wed, Aug 21, 2019 at 03:17:19PM -0500, Pierre-Louis Bossart wrote:
> These callbacks are invoked when a matching hw_params/hw_free() DAI
> operation takes place, and will result in IPC operations with the SOF
> firmware.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/sof/intel/hda.c | 66 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index e754058e3679..1e84ea9e6fce 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -53,6 +53,70 @@ static void hda_sdw_int_enable(struct snd_sof_dev *sdev, bool enable)
>  					0);
>  }
>  
> +static int sdw_config_stream(void *arg, void *s, void *dai,
> +			     void *params, int link_id, int alh_stream_id)

I realise, that these function prototypes aren't being introduced by these 
patches, but just wondering whether such overly generic prototype is really 
a good idea here, whether some of those "void *" pointers could be given 
real types. The first one could be "struct device *" etc.

> +{
> +	struct snd_sof_dev *sdev = arg;
> +	struct snd_soc_dai *d = dai;
> +	struct sof_ipc_dai_config config;
> +	struct sof_ipc_reply reply;
> +	int ret;
> +	u32 size = sizeof(config);
> +
> +	memset(&config, 0, size);
> +	config.hdr.size = size;
> +	config.hdr.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG;
> +	config.type = SOF_DAI_INTEL_ALH;
> +	config.dai_index = (link_id << 8) | (d->id);
> +	config.alh.stream_id = alh_stream_id;

Entirely up to you, in such cases I usually do something like

+	struct sof_ipc_dai_config config = {
+		.type = SOF_DAI_INTEL_ALH,
+		.hre = {
+			.size = sizeof(config),
+			.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG,
+			...

which then also avoids a memset(). But that's mostly a matter of personal 
preference, since this is on stack, the compiler would probably internally 
anyway translate the above initialisation to a memset() with all the 
following assignments.

> +
> +	/* send message to DSP */
> +	ret = sof_ipc_tx_message(sdev->ipc,
> +				 config.hdr.cmd, &config, size, &reply,
> +				 sizeof(reply));
> +	if (ret < 0) {
> +		dev_err(sdev->dev,
> +			"error: failed to set DAI hw_params for link %d dai->id %d ALH %d\n",

Are readers really expected to understand what "dai->id" means? Wouldn't 
"DAI ID" be friendlier, although I understand you - who might not know 
what "x->y" stands for?.. ;-)

> +			link_id, d->id, alh_stream_id);
> +	}
> +
> +	return ret;
> +}
> +
> +static int sdw_free_stream(void *arg, void *s, void *dai, int link_id)
> +{
> +	struct snd_sof_dev *sdev = arg;
> +	struct snd_soc_dai *d = dai;
> +	struct sof_ipc_dai_config config;
> +	struct sof_ipc_reply reply;
> +	int ret;
> +	u32 size = sizeof(config);
> +
> +	memset(&config, 0, size);
> +	config.hdr.size = size;
> +	config.hdr.cmd = SOF_IPC_GLB_DAI_MSG | SOF_IPC_DAI_CONFIG;
> +	config.type = SOF_DAI_INTEL_ALH;
> +	config.dai_index = (link_id << 8) | d->id;
> +	config.alh.stream_id = 0xFFFF; /* invalid value on purpose */

ditto

> +
> +	/* send message to DSP */
> +	ret = sof_ipc_tx_message(sdev->ipc,
> +				 config.hdr.cmd, &config, size, &reply,
> +				 sizeof(reply));
> +	if (ret < 0) {
> +		dev_err(sdev->dev,
> +			"error: failed to free stream for link %d dai->id %d\n",
> +			link_id, d->id);

ditto

> +	}
> +
> +	return ret;
> +}
> +
> +static const struct sdw_intel_ops sdw_callback = {
> +	.config_stream = sdw_config_stream,
> +	.free_stream = sdw_free_stream,
> +};
> +
>  static int hda_sdw_init(struct snd_sof_dev *sdev)
>  {
>  	acpi_handle handle;
> @@ -67,6 +131,8 @@ static int hda_sdw_init(struct snd_sof_dev *sdev)
>  	res.mmio_base = sdev->bar[HDA_DSP_BAR];
>  	res.irq = sdev->ipc_irq;
>  	res.parent = sdev->dev;
> +	res.ops = &sdw_callback;
> +	res.arg = sdev;
>  
>  	sdw = sdw_intel_init(handle, &res);
>  	if (!sdw) {

Hm, looks like this function is using spaces for indentation... Let me check 
if this is coming from an earlier patch

Thanks
Guennadi

> -- 
> 2.20.1
> 
