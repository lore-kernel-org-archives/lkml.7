Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C3AC32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C6221BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 15:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfHGPJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 11:09:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:53747 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGPJa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 11:09:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 08:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="373801730"
Received: from knguye7-mobl.amr.corp.intel.com (HELO [10.255.81.127]) ([10.255.81.127])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2019 08:09:27 -0700
Subject: Re: [alsa-devel] [PATCH] soundwire: fix regmap dependencies and align
 with other serial links
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        jank@cadence.com, Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190718230215.18675-1-pierre-louis.bossart@linux.intel.com>
 <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <52a2cb0c-92a6-59d5-72da-832edd6481f3@linux.intel.com>
Date:   Wed, 7 Aug 2019 10:09:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0g5Hk9JYLvRXfLk5-o=n_RVPKtWD=QONpiimCWyQOFELQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/19 4:04 AM, Rafael J. Wysocki wrote:
> On Fri, Jul 19, 2019 at 1:02 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>> The existing code has a mixed select/depend usage which makes no sense.
>>
>> config SOUNDWIRE_BUS
>>         tristate
>>         select REGMAP_SOUNDWIRE
>>
>> config REGMAP_SOUNDWIRE
>>          tristate
>>          depends on SOUNDWIRE_BUS
>>
>> Let's remove one layer of Kconfig definitions and align with the
>> solutions used by all other serial links.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> No issues found:
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Vinod, Mark, any feedback?

There will be a set of SoundWire codec drivers provided upstream soonish 
and we'll get a number of kbuild errors without this patch.

> 
>> ---
>>   drivers/base/regmap/Kconfig | 2 +-
>>   drivers/soundwire/Kconfig   | 7 +------
>>   drivers/soundwire/Makefile  | 2 +-
>>   3 files changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
>> index 6ad5ef48b61e..8cd2ac650b50 100644
>> --- a/drivers/base/regmap/Kconfig
>> +++ b/drivers/base/regmap/Kconfig
>> @@ -44,7 +44,7 @@ config REGMAP_IRQ
>>
>>   config REGMAP_SOUNDWIRE
>>          tristate
>> -       depends on SOUNDWIRE_BUS
>> +       depends on SOUNDWIRE
>>
>>   config REGMAP_SCCB
>>          tristate
>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
>> index 3a01cfd70fdc..f518273cfbe3 100644
>> --- a/drivers/soundwire/Kconfig
>> +++ b/drivers/soundwire/Kconfig
>> @@ -4,7 +4,7 @@
>>   #
>>
>>   menuconfig SOUNDWIRE
>> -       bool "SoundWire support"
>> +       tristate "SoundWire support"
>>          help
>>            SoundWire is a 2-Pin interface with data and clock line ratified
>>            by the MIPI Alliance. SoundWire is used for transporting data
>> @@ -17,17 +17,12 @@ if SOUNDWIRE
>>
>>   comment "SoundWire Devices"
>>
>> -config SOUNDWIRE_BUS
>> -       tristate
>> -       select REGMAP_SOUNDWIRE
>> -
>>   config SOUNDWIRE_CADENCE
>>          tristate
>>
>>   config SOUNDWIRE_INTEL
>>          tristate "Intel SoundWire Master driver"
>>          select SOUNDWIRE_CADENCE
>> -       select SOUNDWIRE_BUS
>>          depends on X86 && ACPI && SND_SOC
>>          help
>>            SoundWire Intel Master driver.
>> diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
>> index fd99a831b92a..45b7e5001653 100644
>> --- a/drivers/soundwire/Makefile
>> +++ b/drivers/soundwire/Makefile
>> @@ -5,7 +5,7 @@
>>
>>   #Bus Objs
>>   soundwire-bus-objs := bus_type.o bus.o slave.o mipi_disco.o stream.o
>> -obj-$(CONFIG_SOUNDWIRE_BUS) += soundwire-bus.o
>> +obj-$(CONFIG_SOUNDWIRE) += soundwire-bus.o
>>
>>   #Cadence Objs
>>   soundwire-cadence-objs := cadence_master.o
>> --
>> 2.20.1
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
