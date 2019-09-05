Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3D4C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A82A2067D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbfIENPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:15:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:61741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388399AbfIENPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:15:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Sep 2019 06:15:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; 
   d="scan'208";a="177298824"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 05 Sep 2019 06:15:00 -0700
Received: from ravisha1-mobl1.amr.corp.intel.com (unknown [10.255.36.89])
        by linux.intel.com (Postfix) with ESMTP id 9C73B580105;
        Thu,  5 Sep 2019 06:14:58 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH -next] ASoC: SOF: imx8: Fix COMPILE_TEST
 error
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, daniel.baluta@nxp.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20190905064400.24800-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d5a4b443-7530-75de-731f-b13cde66aea7@linux.intel.com>
Date:   Thu, 5 Sep 2019 08:14:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905064400.24800-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/19 1:44 AM, YueHaibing wrote:
> When do compile test, if SND_SOC_SOF_OF is not set, we get:
> 
> sound/soc/sof/imx/imx8.o: In function `imx8_dsp_handle_request':
> imx8.c:(.text+0xb0): undefined reference to `snd_sof_ipc_msgs_rx'
> sound/soc/sof/imx/imx8.o: In function `imx8_ipc_msg_data':
> imx8.c:(.text+0xf4): undefined reference to `sof_mailbox_read'
> sound/soc/sof/imx/imx8.o: In function `imx8_dsp_handle_reply':
> imx8.c:(.text+0x160): undefined reference to `sof_mailbox_read'
> 
> Make SND_SOC_SOF_IMX_TOPLEVEL always depends on SND_SOC_SOF_OF
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/sof/imx/Kconfig | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> index fd73d84..5acae75 100644
> --- a/sound/soc/sof/imx/Kconfig
> +++ b/sound/soc/sof/imx/Kconfig
> @@ -2,7 +2,8 @@
>   
>   config SND_SOC_SOF_IMX_TOPLEVEL
>   	bool "SOF support for NXP i.MX audio DSPs"
> -	depends on ARM64 && SND_SOC_SOF_OF || COMPILE_TEST
> +	depends on ARM64|| COMPILE_TEST
> +	depends on SND_SOC_SOF_OF
>   	help
>             This adds support for Sound Open Firmware for NXP i.MX platforms.
>             Say Y if you have such a device.
> 

