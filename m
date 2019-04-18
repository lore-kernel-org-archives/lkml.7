Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F41C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A53120652
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388910AbfDRMyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:54:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:33966 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbfDRMyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:54:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Apr 2019 05:54:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,366,1549958400"; 
   d="scan'208";a="338646800"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2019 05:54:21 -0700
Received: from mhphan-mobl2.amr.corp.intel.com (unknown [10.255.84.70])
        by linux.intel.com (Postfix) with ESMTP id D956B58001E;
        Thu, 18 Apr 2019 05:54:20 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v2 -next] ASoC: Intel: Haswell: Remove set
 but not used variable 'stage_type'
To:     Yue Haibing <yuehaibing@huawei.com>,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20190417151140.20320-1-yuehaibing@huawei.com>
 <20190418024848.39112-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bc824d69-7afc-6acb-7251-57dbe6d4c3f1@linux.intel.com>
Date:   Thu, 18 Apr 2019 07:54:16 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418024848.39112-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/17/19 9:48 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
> sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]
> 
> It is never used since introduction in
> commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks!

> ---
> v2: also remove the variable declaration and the static inline mst_get_stage_type
> ---
>   sound/soc/intel/haswell/sst-haswell-ipc.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
> index 31fcdf12..74acf9c 100644
> --- a/sound/soc/intel/haswell/sst-haswell-ipc.c
> +++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
> @@ -345,11 +345,6 @@ static inline u32 msg_get_stream_type(u32 msg)
>   	return (msg & IPC_STR_TYPE_MASK) >>  IPC_STR_TYPE_SHIFT;
>   }
>   
> -static inline u32 msg_get_stage_type(u32 msg)
> -{
> -	return (msg & IPC_STG_TYPE_MASK) >>  IPC_STG_TYPE_SHIFT;
> -}
> -
>   static inline u32 msg_get_stream_id(u32 msg)
>   {
>   	return (msg & IPC_STR_ID_MASK) >>  IPC_STR_ID_SHIFT;
> @@ -666,13 +661,12 @@ static int hsw_module_message(struct sst_hsw *hsw, u32 header)
>   
>   static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
>   {
> -	u32 stream_msg, stream_id, stage_type;
> +	u32 stream_msg, stream_id;
>   	struct sst_hsw_stream *stream;
>   	int handled = 0;
>   
>   	stream_msg = msg_get_stream_type(header);
>   	stream_id = msg_get_stream_id(header);
> -	stage_type = msg_get_stage_type(header);
>   
>   	stream = get_stream_by_id(hsw, stream_id);
>   	if (stream == NULL)
> 

