Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA33C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D85218AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 20:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391617AbfIIUjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 16:39:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:1098 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbfIIUjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 16:39:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 13:39:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,487,1559545200"; 
   d="scan'208";a="268191536"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 09 Sep 2019 13:38:59 -0700
Received: from wkhong-mobl2.amr.corp.intel.com (unknown [10.255.34.248])
        by linux.intel.com (Postfix) with ESMTP id 16E405807F9;
        Mon,  9 Sep 2019 13:38:57 -0700 (PDT)
Subject: Re: [PATCH] ASoC: SOF: Intel: work around snd_hdac_aligned_read link
 failure
To:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Pan Xiuli <xiuli.pan@linux.intel.com>,
        Evan Green <evgreen@chromium.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190909195159.3326134-1-arnd@arndb.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3b69e0ec-63cb-4888-9faa-acb7638d71dc@linux.intel.com>
Date:   Mon, 9 Sep 2019 15:38:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190909195159.3326134-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/19 2:51 PM, Arnd Bergmann wrote:
> When CONFIG_SND_HDA_ALIGNED_MMIO is selected by another driver
> (i.e. Tegra) that selects CONFIG_SND_HDA_CORE as a loadable
> module, but SND_SOC_SOF_HDA_COMMON is built-in, we get a
> link failure from some functions that access the hda register:
> 
> sound/soc/sof/intel/hda.o: In function `hda_ipc_irq_dump':
> hda.c:(.text+0x784): undefined reference to `snd_hdac_aligned_read'
> sound/soc/sof/intel/hda-stream.o: In function `hda_dsp_stream_threaded_handler':
> hda-stream.c:(.text+0x12e4): undefined reference to `snd_hdac_aligned_read'
> hda-stream.c:(.text+0x12f8): undefined reference to `snd_hdac_aligned_write'
> 
> Add an explicit 'select' statement as a workaround. This is
> not a great solution, but it's the easiest way I could come
> up with.

Thanks for spotting this, I don't think anyone on the SOF team looked at 
this. Maybe we can filter with depends on !TEGRA or 
!SND_HDA_ALIGNED_MMIO at the SOF Intel top-level instead?

If you can share your config off-list I can try to simplify this further.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/sof/intel/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
> index 479ba249e219..9180184026e1 100644
> --- a/sound/soc/sof/intel/Kconfig
> +++ b/sound/soc/sof/intel/Kconfig
> @@ -248,6 +248,7 @@ config SND_SOC_SOF_HDA_COMMON
>   	tristate
>   	select SND_SOC_SOF_INTEL_COMMON
>   	select SND_SOC_SOF_HDA_LINK_BASELINE
> +	select SND_HDA_CORE if SND_HDA_ALIGNED_MMIO
>   	help
>   	  This option is not user-selectable but automagically handled by
>   	  'select' statements at a higher level
> 

