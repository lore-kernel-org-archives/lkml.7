Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B171C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5662133F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 15:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389777AbfJAPcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:32:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:41575 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388277AbfJAPcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 11:32:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 08:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="275026881"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 01 Oct 2019 08:32:00 -0700
Received: from abapat-mobl1.amr.corp.intel.com (unknown [10.251.1.101])
        by linux.intel.com (Postfix) with ESMTP id D8A92580696;
        Tue,  1 Oct 2019 08:31:58 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: imx: fix reverse
 CONFIG_SND_SOC_SOF_OF dependency
To:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc:     Hulk Robot <hulkci@huawei.com>, YueHaibing <yuehaibing@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20191001142026.1124917-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bb58c7cc-209d-7a2f-0e5b-95a9605ffe7b@linux.intel.com>
Date:   Tue, 1 Oct 2019 10:31:58 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001142026.1124917-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 9:20 AM, Arnd Bergmann wrote:
> CONFIG_SND_SOC_SOF_IMX depends on CONFIG_SND_SOC_SOF, but is in
> turn referenced by the sof-of-dev driver. This creates a reverse
> dependency that manifests in a link error when CONFIG_SND_SOC_SOF_OF
> is built-in but CONFIG_SND_SOC_SOF_IMX=m:
> 
> sound/soc/sof/sof-of-dev.o:(.data+0x118): undefined reference to `sof_imx8_ops'
> 
> Make the latter a 'bool' symbol and change the Makefile so the imx8
> driver is compiled the same way as the driver using it.
> 
> A nicer way would be to reverse the layering and move all
> the imx specific bits of sof-of-dev.c into the imx driver
> itself, which can then call into the common code. Doing this
> would need more testing and can be done if we add another
> driver like the first one.

Or use something like

config SND_SOC_SOF_IMX8_SUPPORT
	bool "SOF support for i.MX8"
    	depends on IMX_SCU
    	depends on IMX_DSP

config SND_SOC_SOF_IMX8
	tristate
	<i.mx selects>

config SND_SOC_SOF_OF
	depends on OF
	select SND_SOC_SOF_IMX8 if SND_SOC_SOF_IMX8_SUPPORT

That way you propagate the module/built-in information. That's how we 
fixed those issues for the Intel parts.

> 
> Fixes: f4df4e4042b0 ("ASoC: SOF: imx8: Fix COMPILE_TEST error")
> Fixes: 202acc565a1f ("ASoC: SOF: imx: Add i.MX8 HW support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/sof/imx/Kconfig  | 2 +-
>   sound/soc/sof/imx/Makefile | 4 +++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
> index 5acae75f5750..a3891654a1fc 100644
> --- a/sound/soc/sof/imx/Kconfig
> +++ b/sound/soc/sof/imx/Kconfig
> @@ -12,7 +12,7 @@ config SND_SOC_SOF_IMX_TOPLEVEL
>   if SND_SOC_SOF_IMX_TOPLEVEL
>   
>   config SND_SOC_SOF_IMX8
> -	tristate "SOF support for i.MX8"
> +	bool "SOF support for i.MX8"
>   	depends on IMX_SCU
>   	depends on IMX_DSP
>   	help
> diff --git a/sound/soc/sof/imx/Makefile b/sound/soc/sof/imx/Makefile
> index 6ef908e8c807..9e8f35df0ff2 100644
> --- a/sound/soc/sof/imx/Makefile
> +++ b/sound/soc/sof/imx/Makefile
> @@ -1,4 +1,6 @@
>   # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>   snd-sof-imx8-objs := imx8.o
>   
> -obj-$(CONFIG_SND_SOC_SOF_IMX8) += snd-sof-imx8.o
> +ifdef CONFIG_SND_SOC_SOF_IMX8
> +obj-$(CONFIG_SND_SOC_SOF_OF) += snd-sof-imx8.o
> +endif
> 

