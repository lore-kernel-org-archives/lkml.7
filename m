Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61406C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DDDE206DB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 21:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgAFVz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 16:55:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:51764 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgAFVz4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 16:55:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 13:55:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="245719807"
Received: from chewang-mobl.amr.corp.intel.com (HELO [10.254.185.10]) ([10.254.185.10])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jan 2020 13:55:53 -0800
Subject: Re: [PATCH] ASoC: rt5677: add SPI_MASTER dependency
To:     Jon Hunter <jonathanh@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>
Cc:     Ben Zhang <benzh@chromium.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        KaiChieh Chuang <kaichieh.chuang@mediatek.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20191210195333.648018-1-arnd@arndb.de>
 <d739240f-aaa6-c310-9c68-16c1a08ce759@nvidia.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9c9169cc-0da5-f247-c8f7-f6913ca2bfb5@linux.intel.com>
Date:   Mon, 6 Jan 2020 15:55:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d739240f-aaa6-c310-9c68-16c1a08ce759@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/11/19 4:59 AM, Jon Hunter wrote:
> 
> On 10/12/2019 19:52, Arnd Bergmann wrote:
>> When CONFIG_SPI is disabled, the newly added code for the DSP
>> firmware loading fails to link:
>>
>> ERROR: "rt5677_spi_hotword_detected" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
>> ERROR: "rt5677_spi_write" [sound/soc/codecs/snd-soc-rt5677.ko] undefined!
> 
> Would it be better if the above functions or the functions that call
> these are conditional on CONFIG_SND_SOC_RT5677_SPI?

they are already conditional, with a fallback provided:

#if IS_ENABLED(CONFIG_SND_SOC_RT5677_SPI)
int rt5677_spi_read(u32 addr, void *rxbuf, size_t len);
int rt5677_spi_write(u32 addr, const void *txbuf, size_t len);
int rt5677_spi_write_firmware(u32 addr, const struct firmware *fw);
void rt5677_spi_hotword_detected(void);
#else
static inline int rt5677_spi_read(u32 addr, void *rxbuf, size_t len)
{
	return -EINVAL;
}
static inline int rt5677_spi_write(u32 addr, const void *txbuf, size_t len)
{
	return -EINVAL;
}
static inline int rt5677_spi_write_firmware(u32 addr, const struct 
firmware *fw)
{
	return -EINVAL;
}
static inline void rt5677_spi_hotword_detected(void){}
#endif

and since we have the following definition

config SND_SOC_RT5677_SPI
	tristate
	default SND_SOC_RT5677 && SPI

in theory if SPI is not enabled the fallback static inlines would always 
be selected?

Arnd, if you can share the .config that exposes this problem it'd be nice

FWIW, there are other missing dependencies, the SPI controller was not 
explicitly enabled so depending on the Kconfigs used by a distro the 
machine driver probe could fail with the spi-RT5677AA component never 
registered. The patch below seems to work for me (more testing needed)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index b149e28a2076..cf1a2fde4c47 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -50,6 +50,9 @@ config SND_SOC_INTEL_BDW_RT5677_MACH
         depends on I2C_DESIGNWARE_PLATFORM || COMPILE_TEST
         depends on GPIOLIB || COMPILE_TEST
         depends on X86_INTEL_LPSS || COMPILE_TEST
+       depends on SPI_MASTER
+       select SPI_PXA2XX
+       select SND_SOC_RT5677_SPI
         select SND_SOC_RT5677
         help
           This adds support for Intel Broadwell platform based boards with
