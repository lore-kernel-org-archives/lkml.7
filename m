Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AEEECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A760221D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 14:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406198AbfJQOt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 10:49:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:25834 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727138AbfJQOt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 10:49:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 07:49:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="190045703"
Received: from albeaudr-mobl1.amr.corp.intel.com (HELO [10.252.136.206]) ([10.252.136.206])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2019 07:49:24 -0700
Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: sof-rt5682: add a check for
 devm_clk_get
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20191017025044.31474-1-hslester96@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <31fb322b-c0c2-b783-47bc-52be842f8661@linux.intel.com>
Date:   Thu, 17 Oct 2019 08:16:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191017025044.31474-1-hslester96@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/19 9:50 PM, Chuhong Yuan wrote:
> sof_audio_probe misses a check for devm_clk_get and may cause problems.
> Add a check for it to fix the bug.

Indeed this is a miss, we have this test in all machine drivers except 
this one. Thanks for the patch!

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
>   sound/soc/intel/boards/sof_rt5682.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index a437567b8cee..6d15c7ff66bf 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -576,6 +576,15 @@ static int sof_audio_probe(struct platform_device *pdev)
>   	/* need to get main clock from pmc */
>   	if (sof_rt5682_quirk & SOF_RT5682_MCLK_BYTCHT_EN) {
>   		ctx->mclk = devm_clk_get(&pdev->dev, "pmc_plt_clk_3");
> +		if (IS_ERR(ctx->mclk)) {
> +			ret = PTR_ERR(ctx->mclk);
> +
> +			dev_err(&pdev->dev,
> +				"Failed to get MCLK from pmc_plt_clk_3: %d\n",
> +				ret);
> +			return ret;
> +		}
> +
>   		ret = clk_prepare_enable(ctx->mclk);
>   		if (ret < 0) {
>   			dev_err(&pdev->dev,
> 
