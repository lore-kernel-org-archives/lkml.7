Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2435BC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04614240CF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfE2TBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 15:01:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:5371 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfE2TBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 15:01:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 12:00:59 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 29 May 2019 12:00:59 -0700
Received: from msakib-mobl2.amr.corp.intel.com (unknown [10.254.189.121])
        by linux.intel.com (Postfix) with ESMTP id F18B05802C9;
        Wed, 29 May 2019 12:00:53 -0700 (PDT)
Subject: Re: ERROR: "hdac_hdmi_jack_port_init"
 [sound/soc/intel/boards/snd-soc-sof_rt5682.ko] undefined!
To:     Randy Dunlap <rdunlap@infradead.org>,
        kbuild test robot <lkp@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <201905281758.K64LbM6G%lkp@intel.com>
 <30d084d6-207a-053d-6ab4-0096a1d8d216@infradead.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <03c70038-4ec7-c218-fb85-feda40c3dcd3@linux.intel.com>
Date:   Wed, 29 May 2019 14:00:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <30d084d6-207a-053d-6ab4-0096a1d8d216@infradead.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/19 12:54 PM, Randy Dunlap wrote:
> On 5/28/19 2:54 AM, kbuild test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   cd6c84d8f0cdc911df435bb075ba22ce3c605b07
>> commit: f70abd75b7c6c04d3219d0b3a0f3f15411b042fb ASoC: Intel: add sof-rt5682 machine driver
>> date:   4 weeks ago
>> config: x86_64-randconfig-b005272310-05281357 (attached as .config)
>> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
>> reproduce:
>>          git checkout f70abd75b7c6c04d3219d0b3a0f3f15411b042fb
>>          # save the attached .config to linux build tree
>>          make ARCH=x86_64
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> ERROR: "hdac_hdmi_jack_port_init" [sound/soc/intel/boards/snd-soc-sof_rt5682.ko] undefined!
>>>> ERROR: "hdac_hdmi_jack_init" [sound/soc/intel/boards/snd-soc-sof_rt5682.ko] undefined!
> 
> Confirmed on 5.2-rc2.

fixed yesterday by patch "ASoC: Intel: sof-rt5682: fix undefined 
references with Baytrail-only support", already merged by Mark.

> 
> Needs CONFIG_SND_SOC_HDAC_HDMI to be set for those functions to be built.
> 
> CONFIG_SND_SOC_SOF_BAYTRAIL=m
> CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=m
> 
> CONFIG_SND_SOC_SOF_HDA_COMMON is not set; the "select ... if" in the middle
> [<<<<<<<<<<] of this Kconfig entry is preventing SND_SOC_HDAC_HDMI from being set:
> 
> if SND_SOC_SOF_HDA_COMMON || SND_SOC_SOF_BAYTRAIL
> config SND_SOC_INTEL_SOF_RT5682_MACH
> 	tristate "SOF with rt5682 codec in I2S Mode"
> 	depends on I2C && ACPI
> 	depends on (SND_SOC_SOF_HDA_COMMON && MFD_INTEL_LPSS) ||\
> 		   (SND_SOC_SOF_BAYTRAIL && X86_INTEL_LPSS)
> 	select SND_SOC_RT5682
> 	select SND_SOC_DMIC
> 	select SND_SOC_HDAC_HDMI if SND_SOC_SOF_HDA_COMMON <<<<<<<<<<
> 	help
> 	   This adds support for ASoC machine driver for SOF platforms
> 	   with rt5682 codec.
> 	   Say Y if you have such a device.
> 	   If unsure select "N".
> endif ## SND_SOC_SOF_HDA_COMMON || SND_SOC_SOF_BAYTRAIL
> 
> 
> 
> 

