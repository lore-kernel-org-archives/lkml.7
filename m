Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E07EC46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F53121670
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 16:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbfGEQh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 12:37:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:26026 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfGEQh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 12:37:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jul 2019 09:37:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,455,1557212400"; 
   d="scan'208";a="166571355"
Received: from unknown (HELO ranjani-desktop) ([10.252.203.115])
  by fmsmga007.fm.intel.com with ESMTP; 05 Jul 2019 09:37:25 -0700
Message-ID: <a3a96e0f84ee04bff6855701cd7b00a25a5a5de1.camel@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: debug: fix possible
 memory leak in sof_dfsentry_write()
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Pan Xiuli <xiuli.pan@linux.intel.com>
Cc:     kernel-janitors@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 05 Jul 2019 09:37:14 -0700
In-Reply-To: <20190705081637.157169-1-weiyongjun1@huawei.com>
References: <20190705081637.157169-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-07-05 at 08:16 +0000, Wei Yongjun wrote:
> 'string' is malloced in sof_dfsentry_write() and should be freed
> before leaving from the error handling cases, otherwise it will cause
> memory leak.
> 
> Fixes: 091c12e1f50c ("ASoC: SOF: debug: add new debugfs entries for
> IPC flood test")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Thanks for fixing this, Wei!
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

> ---
>  sound/soc/sof/debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/debug.c b/sound/soc/sof/debug.c
> index 54bb53bfc81b..2388477a965e 100644
> --- a/sound/soc/sof/debug.c
> +++ b/sound/soc/sof/debug.c
> @@ -162,7 +162,7 @@ static ssize_t sof_dfsentry_write(struct file
> *file, const char __user *buffer,
>  	else
>  		ret = kstrtoul(string, 0, &ipc_count);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
>  
>  	/* limit max duration/ipc count for flood test */
>  	if (flood_duration_test) {
> @@ -191,7 +191,7 @@ static ssize_t sof_dfsentry_write(struct file
> *file, const char __user *buffer,
>  				    "error: debugfs write failed to
> resume %d\n",
>  				    ret);
>  		pm_runtime_put_noidle(sdev->dev);
> -		return ret;
> +		goto out;
>  	}
>  
>  	/* flood test */
> 
> 
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

