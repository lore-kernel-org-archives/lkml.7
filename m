Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38700C433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D31218FD
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 16:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388928AbfHGQIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 12:08:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:3597 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGQIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 12:08:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 09:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="165358705"
Received: from knguye7-mobl.amr.corp.intel.com (HELO [10.255.81.127]) ([10.255.81.127])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2019 09:01:21 -0700
Subject: Re: [Sound-open-firmware] [PATCH v2 3/5] ASoC: SOF: Add DT DSP device
 support
To:     Daniel Baluta <daniel.baluta@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Anson Huang <anson.huang@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Olaru <paul.olaru@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        sound-open-firmware@alsa-project.org
References: <20190723084104.12639-1-daniel.baluta@nxp.com>
 <20190723084104.12639-4-daniel.baluta@nxp.com>
 <d85909d6-c7cb-c64b-dfa9-6cee6c0da2cb@linux.intel.com>
 <CAEnQRZARFQjutkvW3_xkQAQznNm8c5jSjtAG715VtrZnDxztoA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <123a1cf0-1eac-03bd-6628-8c67004eadc5@linux.intel.com>
Date:   Wed, 7 Aug 2019 11:01:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEnQRZARFQjutkvW3_xkQAQznNm8c5jSjtAG715VtrZnDxztoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/19 10:29 AM, Daniel Baluta wrote:
> On Tue, Jul 23, 2019 at 6:19 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>>> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
>>> index 61b97fc55bb2..2aa3a1cdf60c 100644
>>> --- a/sound/soc/sof/Kconfig
>>> +++ b/sound/soc/sof/Kconfig
>>> @@ -36,6 +36,15 @@ config SND_SOC_SOF_ACPI
>>>          Say Y if you need this option
>>>          If unsure select "N".
>>>
>>> +config SND_SOC_SOF_DT
>>> +     tristate "SOF DT enumeration support"
>>> +     select SND_SOC_SOF
>>> +     select SND_SOC_SOF_OPTIONS
>>> +     help
>>> +       This adds support for Device Tree enumeration. This option is
>>> +       required to enable i.MX8 devices.
>>> +       Say Y if you need this option. If unsure select "N".
>>> +
>>
>> [snip]
>>
>>> diff --git a/sound/soc/sof/imx/Kconfig b/sound/soc/sof/imx/Kconfig
>>> index fff64a9970f0..fa35994a79c4 100644
>>> --- a/sound/soc/sof/imx/Kconfig
>>> +++ b/sound/soc/sof/imx/Kconfig
>>> @@ -12,6 +12,7 @@ if SND_SOC_SOF_IMX_TOPLEVEL
>>>
>>>    config SND_SOC_SOF_IMX8
>>>        tristate "SOF support for i.MX8"
>>> +     select SND_SOC_SOF_DT
>>
>> This looks upside down. You should select SOF_DT first then include the
>> NXP stuff.
> 
> One more thing: So this should be 'depends on SND_SOC_SOF_DT' right?

I would do this:

config SND_SOC_SOF_DT
      	tristate "SOF DT enumeration support"
      	depends on OF # or whatever the top-level DT dependency is
      	select SND_SOC_SOF
      	select SND_SOC_SOF_OPTIONS


config SND_SOC_SOF_IMX_TOPLEVEL
	bool "SOF support for NXP i.MX audio DSPs"
	depends on ARM64 && SND_SOC_SOF_DT || COMPILE_TEST
	
if SND_SOC_SOF_IMX_TOPLEVEL

config SND_SOC_SOF_IMX8
	tristate "SOF support for i.MX8"

In other words push the dependencies at a higher level.
