Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB48C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824BA2073F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731719AbfDQRlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:41:55 -0400
Received: from mga02.intel.com ([134.134.136.20]:10538 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbfDQRly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:41:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 10:41:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="135186965"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 17 Apr 2019 10:41:52 -0700
Received: from mhphan-mobl2.amr.corp.intel.com (unknown [10.255.84.70])
        by linux.intel.com (Postfix) with ESMTP id 56EAC580297;
        Wed, 17 Apr 2019 10:41:53 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH -next] ASoC: Intel: Haswell: Remove set but
 not used variable 'stage_type'
To:     Yue Haibing <yuehaibing@huawei.com>,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20190417151140.20320-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ba043cd7-07af-717f-7498-d6bda7d6b79e@linux.intel.com>
Date:   Wed, 17 Apr 2019 12:41:52 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417151140.20320-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 10:11 AM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
> sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in
> commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")

Thanks for the patch.

I think you could go further in the cleanup and remove both the variable 
declaration and the static inline mst_get_stage_type that will also be 
useless as a consequence of this assignment removal.

Care to send a v2?

> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
> index 31fcdf12..4d3de99 100644
> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
> @@ -672,7 +672,6 @@ static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
>   
>   	stream_msg = msg_get_stream_type(header);
>   	stream_id = msg_get_stream_id(header);
> -	stage_type = msg_get_stage_type(header);
>   
>   	stream = get_stream_by_id(hsw, stream_id);
>   	if (stream == NULL)
> 

