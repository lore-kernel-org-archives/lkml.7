Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54358C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB4621904
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfCVOnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:43:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:35664 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbfCVOnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:43:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP; 22 Mar 2019 07:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="157444854"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 22 Mar 2019 07:43:40 -0700
Received: from rrshenoy-mobl.gar.corp.intel.com (rrshenoy-mobl.gar.corp.intel.com [10.254.182.231])
        by linux.intel.com (Postfix) with ESMTP id CF57A580261;
        Fri, 22 Mar 2019 07:43:39 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: dapm: Fix NULL pointer dereference in
 snd_soc_dapm_free_kcontrol
To:     Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
References: <1553257809-9294-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <44b4ca5a-c76b-e2ae-0f57-294198a37b25@linux.intel.com>
Date:   Fri, 22 Mar 2019 09:43:39 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <1553257809-9294-1-git-send-email-pankaj.laxminarayan.bharadiya@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 7:30 AM, Pankaj Bharadiya wrote:
> w_text_param can be NULL and it is being dereferenced without checking.
> Add the missing sanity check to prevent  NULL pointer dereference.
> 
> Signed-off-by: Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>
> ---
>   sound/soc/soc-dapm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 1ec06ef..67b032c 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -3957,6 +3957,10 @@ snd_soc_dapm_free_kcontrol(struct snd_soc_card *card,
>   	int count;
>   
>   	devm_kfree(card->dev, (void *)*private_value);
> +
> +	if (!w_param_text)
> +		return;

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

next time, try using git format-patch -v2 to signal it's an updated 
version, it helps reviewers. Thanks!

> +
>   	for (count = 0 ; count < num_params; count++)
>   		devm_kfree(card->dev, (void *)w_param_text[count]);
>   	devm_kfree(card->dev, w_param_text);
> 

