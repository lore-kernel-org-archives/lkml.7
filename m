Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AD5C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF3A21953
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 17:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEaRYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 13:24:12 -0400
Received: from mga18.intel.com ([134.134.136.126]:18741 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfEaRYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 13:24:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 10:24:11 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 31 May 2019 10:24:11 -0700
Received: from mayurda-mobl.amr.corp.intel.com (unknown [10.252.130.8])
        by linux.intel.com (Postfix) with ESMTP id 8F7C35802C9;
        Fri, 31 May 2019 10:24:10 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: Intel: hda: Fix COMPILE_TEST
 build error
To:     YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        yingjiang.zhu@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20190531142526.12712-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <63b3a080-60c4-64e2-6f72-8075bb3bb45a@linux.intel.com>
Date:   Fri, 31 May 2019 12:24:09 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531142526.12712-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/19 9:25 AM, YueHaibing wrote:
> while building without PCI:
> 
> sound/soc/sof/intel/hda.o: In function `hda_dsp_probe':
> hda.c:(.text+0x79c): undefined reference to `pci_ioremap_bar'
> hda.c:(.text+0x79c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'
> hda.c:(.text+0x7c4): undefined reference to `pci_ioremap_bar'
> hda.c:(.text+0x7c4): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `pci_ioremap_bar'
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: e13ef82a9ab8 ("ASoC: SOF: add COMPILE_TEST for PCI options")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Gah, my bad. My cross-compilation script assumed sound was enabled with 
defconfig but it's not in all cases, thanks for the fix.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


> ---
>   sound/soc/sof/intel/hda.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index 68db2ac..c1703c4 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -231,7 +231,9 @@ static int hda_init(struct snd_sof_dev *sdev)
>   
>   	/* initialise hdac bus */
>   	bus->addr = pci_resource_start(pci, 0);
> +#if IS_ENABLED(CONFIG_PCI)
>   	bus->remap_addr = pci_ioremap_bar(pci, 0);
> +#endif
>   	if (!bus->remap_addr) {
>   		dev_err(bus->dev, "error: ioremap error\n");
>   		return -ENXIO;
> @@ -458,7 +460,9 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
>   		goto hdac_bus_unmap;
>   
>   	/* DSP base */
> +#if IS_ENABLED(CONFIG_PCI)
>   	sdev->bar[HDA_DSP_BAR] = pci_ioremap_bar(pci, HDA_DSP_BAR);
> +#endif
>   	if (!sdev->bar[HDA_DSP_BAR]) {
>   		dev_err(sdev->dev, "error: ioremap error\n");
>   		ret = -ENXIO;
> 

