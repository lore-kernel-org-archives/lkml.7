Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F265FC004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04E5214AF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfGILpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:45:24 -0400
Received: from mga07.intel.com ([134.134.136.100]:44480 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfGILpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:45:24 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 04:45:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,470,1557212400"; 
   d="scan'208";a="340730852"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by orsmga005.jf.intel.com with ESMTP; 09 Jul 2019 04:45:20 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hkoYh-0002Yq-Et; Tue, 09 Jul 2019 14:45:19 +0300
Date:   Tue, 9 Jul 2019 14:45:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alex Levin <levinale@chromium.org>
Cc:     alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        benzh@chromium.org, cujomalainey@chromium.org
Subject: Re: [PATCH] ASoC: Intel: Atom: read timestamp moved to period_elapsed
Message-ID: <20190709114519.GW9224@smile.fi.intel.com>
References: <20190709040147.111927-1-levinale@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190709040147.111927-1-levinale@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 09:01:47PM -0700, Alex Levin wrote:
> sst_platform_pcm_pointer is called from both snd_pcm_period_elapsed and
> from snd_pcm_ioctl. Calling read timestamp results in recalculating
> pcm_delay and buffer_ptr (sst_calc_tstamp) which consumes buffers in a
> faster rate than intended.
> In a tested BSW system with chtrt5650, for a rate of 48000, the
> measured rate was sometimes 10 times more than that.
> After moving the timestamp read to period elapsed, buffer consumption is
> as expected.

From code prospective it looks good. You may take mine
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Though I'm not an expert in the area, Pierre and / or Liam should give
their blessing.

> 
> Signed-off-by: Alex Levin <levinale@chromium.org>
> ---
>  sound/soc/intel/atom/sst-mfld-platform-pcm.c | 23 +++++++++++++-------
>  1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> index 0e8b1c5eec88..196af0b30b41 100644
> --- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> +++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
> @@ -265,16 +265,28 @@ static void sst_period_elapsed(void *arg)
>  {
>  	struct snd_pcm_substream *substream = arg;
>  	struct sst_runtime_stream *stream;
> -	int status;
> +	struct snd_soc_pcm_runtime *rtd;
> +	int status, ret_val;
>  
>  	if (!substream || !substream->runtime)
>  		return;
>  	stream = substream->runtime->private_data;
>  	if (!stream)
>  		return;
> +
> +	rtd = substream->private_data;
> +	if (!rtd)
> +		return;
> +
>  	status = sst_get_stream_status(stream);
>  	if (status != SST_PLATFORM_RUNNING)
>  		return;
> +
> +	ret_val = stream->ops->stream_read_tstamp(sst->dev, &stream->stream_info);
> +	if (ret_val) {
> +		dev_err(rtd->dev, "stream_read_tstamp err code = %d\n", ret_val);
> +		return;
> +	}
>  	snd_pcm_period_elapsed(substream);
>  }
>  
> @@ -658,20 +670,15 @@ static snd_pcm_uframes_t sst_platform_pcm_pointer
>  			(struct snd_pcm_substream *substream)
>  {
>  	struct sst_runtime_stream *stream;
> -	int ret_val, status;
> +	int status;
>  	struct pcm_stream_info *str_info;
> -	struct snd_soc_pcm_runtime *rtd = substream->private_data;
>  
>  	stream = substream->runtime->private_data;
>  	status = sst_get_stream_status(stream);
>  	if (status == SST_PLATFORM_INIT)
>  		return 0;
> +
>  	str_info = &stream->stream_info;
> -	ret_val = stream->ops->stream_read_tstamp(sst->dev, str_info);
> -	if (ret_val) {
> -		dev_err(rtd->dev, "sst: error code = %d\n", ret_val);
> -		return ret_val;
> -	}
>  	substream->runtime->delay = str_info->pcm_delay;
>  	return str_info->buffer_ptr;
>  }
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 

-- 
With Best Regards,
Andy Shevchenko


