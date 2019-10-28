Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1882CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0E720717
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729818AbfJ1CPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:15:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:5377 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbfJ1CPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:15:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Oct 2019 19:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,238,1569308400"; 
   d="scan'208";a="189497387"
Received: from jestoute-mobl1.amr.corp.intel.com (HELO [10.251.144.224]) ([10.251.144.224])
  by orsmga007.jf.intel.com with ESMTP; 27 Oct 2019 19:15:36 -0700
Subject: Re: [PATCH] ASoC: SOF: ipc: Fix memory leak in
 sof_set_get_large_ctrl_data
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Slawomir Blauciak <slawomir.blauciak@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20191027215330.12729-1-navid.emamdoost@gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <fb4fa7f3-fefb-e2d0-da4d-842396a7c251@linux.intel.com>
Date:   Sun, 27 Oct 2019 21:15:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191027215330.12729-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/19 4:53 PM, Navid Emamdoost wrote:
> In the implementation of sof_set_get_large_ctrl_data() there is a memory
> leak in case an error. Release partdata if sof_get_ctrl_copy_params()
> fails.
> 
> Fixes: 54d198d5019d ("ASoC: SOF: Propagate sof_get_ctrl_copy_params() error properly")
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

May I ask which tool you used to find those issues, looks like we have a 
gap here?

> ---
>   sound/soc/sof/ipc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc.c b/sound/soc/sof/ipc.c
> index b2f359d2f7e5..086eeeab8679 100644
> --- a/sound/soc/sof/ipc.c
> +++ b/sound/soc/sof/ipc.c
> @@ -572,8 +572,10 @@ static int sof_set_get_large_ctrl_data(struct snd_sof_dev *sdev,
>   	else
>   		err = sof_get_ctrl_copy_params(cdata->type, partdata, cdata,
>   					       sparams);
> -	if (err < 0)
> +	if (err < 0) {
> +		kfree(partdata);
>   		return err;
> +	}
>   
>   	msg_bytes = sparams->msg_bytes;
>   	pl_size = sparams->pl_size;
> 
