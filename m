Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A3EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C63721850
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbfGZPrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:47:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:11389 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727389AbfGZPrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:47:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 08:47:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="345853999"
Received: from bcstewar-mobl1.amr.corp.intel.com (HELO [10.251.147.177]) ([10.251.147.177])
  by orsmga005.jf.intel.com with ESMTP; 26 Jul 2019 08:47:08 -0700
Subject: Re: [alsa-devel] [PATCH v4 1/1] ASoC: Intel: Skylake: Remove static
 table index when parsing topology
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <20190726090929.27946-1-amadeuszx.slawinski@linux.intel.com>
 <20190726090929.27946-2-amadeuszx.slawinski@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <99dcace6-8b46-4ecf-03e5-b48a219640ae@linux.intel.com>
Date:   Fri, 26 Jul 2019 10:47:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726090929.27946-2-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 4:09 AM, Amadeusz Sławiński wrote:
> Currently when we remove and reload driver we use previous ref_count
> value to start iterating over skl->modules which leads to out of table
> access. To fix this just inline the function and calculate indexes
> everytime we parse UUID token.
> 
> Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/skylake/skl-topology.c | 34 +++++++++-----------------
>   1 file changed, 12 insertions(+), 22 deletions(-)
> 
> diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
> index 118866cd5075..c1c37ce759bd 100644
> --- a/sound/soc/intel/skylake/skl-topology.c
> +++ b/sound/soc/intel/skylake/skl-topology.c
> @@ -3333,25 +3333,6 @@ static int skl_tplg_get_int_tkn(struct device *dev,
>   	return tkn_count;
>   }
>   
> -static int skl_tplg_get_manifest_uuid(struct device *dev,
> -				struct skl_dev *skl,
> -				struct snd_soc_tplg_vendor_uuid_elem *uuid_tkn)
> -{
> -	static int ref_count;
> -	struct skl_module *mod;
> -
> -	if (uuid_tkn->token == SKL_TKN_UUID) {
> -		mod = skl->modules[ref_count];
> -		guid_copy(&mod->uuid, (guid_t *)&uuid_tkn->uuid);
> -		ref_count++;
> -	} else {
> -		dev_err(dev, "Not an UUID token tkn %d\n", uuid_tkn->token);
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>   /*
>    * Fill the manifest structure by parsing the tokens based on the
>    * type.
> @@ -3362,6 +3343,7 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
>   {
>   	int tkn_count = 0, ret;
>   	int off = 0, tuple_size = 0;
> +	u8 uuid_index = 0;
>   	struct snd_soc_tplg_vendor_array *array;
>   	struct snd_soc_tplg_vendor_value_elem *tkn_elem;
>   
> @@ -3384,9 +3366,17 @@ static int skl_tplg_get_manifest_tkn(struct device *dev,
>   			continue;
>   
>   		case SND_SOC_TPLG_TUPLE_TYPE_UUID:
> -			ret = skl_tplg_get_manifest_uuid(dev, skl, array->uuid);
> -			if (ret < 0)
> -				return ret;
> +			if (array->uuid->token != SKL_TKN_UUID) {
> +				dev_err(dev, "Not an UUID token: %d\n",
> +					array->uuid->token);
> +				return -EINVAL;
> +			}
> +			if (uuid_index >= skl->nr_modules) {
> +				dev_err(dev, "Too many UUID tokens\n");
> +				return -EINVAL;
> +			}
> +			guid_copy(&skl->modules[uuid_index++]->uuid,
> +				  (guid_t *)&array->uuid->uuid);
>   
>   			tuple_size += sizeof(*array->uuid);
>   			continue;
> 
