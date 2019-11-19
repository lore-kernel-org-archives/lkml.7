Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F0AC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15407222A9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 14:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfKSOZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 09:25:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:32089 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbfKSOZp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 09:25:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 06:25:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; 
   d="scan'208";a="215551241"
Received: from trgallx-mobl.amr.corp.intel.com (HELO [10.251.154.79]) ([10.251.154.79])
  by fmsmga001.fm.intel.com with ESMTP; 19 Nov 2019 06:25:44 -0800
Subject: Re: [PATCH] ASoC: Intel: mrfld: fix incorrect check on p->sink
To:     Colin King <colin.king@canonical.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20191119113640.166940-1-colin.king@canonical.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f084c578-2fd5-e090-7d90-1ddffa1e22be@linux.intel.com>
Date:   Tue, 19 Nov 2019 08:23:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191119113640.166940-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/19/19 5:36 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check on p->sink looks bogus, I believe it should be p->source
> since the following code blocks are related to p->source. Fix
> this by replacing p->sink with p->source.
> 
> Addresses-Coverity: ("Copy-paste error")
> Fixes: 24c8d14192cc ("ASoC: Intel: mrfld: add DSP core controls")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> 
> [ Note: this has not been tested ]
> 

wow, nice catch. this dates from October 2014 and was merged in Linux 3.19.

I did look at the entire function and indeed it does not seem logical at 
all and rather an unintentional bad copy-paste, probably undetected 
since changing the gains on capture is less straightforward to test.

	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
		dev_dbg(dai->dev, "Stream name=%s\n",
				dai->playback_widget->name);
		w = dai->playback_widget;
		snd_soc_dapm_widget_for_each_sink_path(w, p) {
			if (p->connected && !p->connected(w, p->sink))
				continue;
[snip]
		}
	} else {
		dev_dbg(dai->dev, "Stream name=%s\n",
				dai->capture_widget->name);
		w = dai->capture_widget;
		snd_soc_dapm_widget_for_each_source_path(w, p) {
			if (p->connected && !p->connected(w, p->sink))

<< here it doesn't look right to use sink here.

				continue;

This macro snd_soc_dapm_widget_for_each_source_path() is also used in 
the skylake/skl-topology.c but without any source/sink inversion.

I don't think anyone on the Intel side will have time to investigate 
further, and unless someone from the initial contributors states this 
was intentional (Vinod/Sanyog?), we should merge this.

let's see if there's any feedback and if not I'll ack this.


> ---
>   sound/soc/intel/atom/sst-atom-controls.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
> index baef461a99f1..f883c9340eee 100644
> --- a/sound/soc/intel/atom/sst-atom-controls.c
> +++ b/sound/soc/intel/atom/sst-atom-controls.c
> @@ -1333,7 +1333,7 @@ int sst_send_pipe_gains(struct snd_soc_dai *dai, int stream, int mute)
>   				dai->capture_widget->name);
>   		w = dai->capture_widget;
>   		snd_soc_dapm_widget_for_each_source_path(w, p) {
> -			if (p->connected && !p->connected(w, p->sink))
> +			if (p->connected && !p->connected(w, p->source))
>   				continue;
>   
>   			if (p->connect &&  p->source->power &&
> 
