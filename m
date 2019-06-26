Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D01FC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AFE21726
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfFZVU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:20:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:62816 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbfFZVU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:20:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 14:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="188793233"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jun 2019 14:20:26 -0700
Received: from iriji-mobl1.ger.corp.intel.com (unknown [10.252.28.127])
        by linux.intel.com (Postfix) with ESMTP id A171658046A;
        Wed, 26 Jun 2019 14:20:23 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH 1/2] ASoC: soc-core: defer card registration
 if codec component is missing
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190626133617.25959-1-jbrunet@baylibre.com>
 <20190626133617.25959-2-jbrunet@baylibre.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8b4822f7-6671-1c23-572d-37f7e94ea8cc@linux.intel.com>
Date:   Wed, 26 Jun 2019 23:20:22 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190626133617.25959-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/19 3:36 PM, Jerome Brunet wrote:
> Like cpus and platforms, defer sound card initialization if the codec
> component is missing when initializing the dai_link
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>   sound/soc/soc-core.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 358f1fbf9a30..002ddbf4e5a3 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1064,12 +1064,20 @@ static int soc_init_dai_link(struct snd_soc_card *card,
>   				link->name);
>   			return -EINVAL;
>   		}
> +
>   		/* Codec DAI name must be specified */
>   		if (!codec->dai_name) {
>   			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
>   				link->name);
>   			return -EINVAL;
>   		}
> +
> +		/*
> +		 * Defer card registartion if codec component is not added to

registration

> +		 * component list.
> +		 */
> +		if (!soc_find_component(codec))
> +			return -EPROBE_DEFER;
>   	}
>   
>   	/*
> 

