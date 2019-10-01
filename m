Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E405AECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C479121855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 16:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732676AbfJAQDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 12:03:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:44854 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727274AbfJAQDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 12:03:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2019 09:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,571,1559545200"; 
   d="scan'208";a="216117152"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2019 09:03:46 -0700
Received: from abapat-mobl1.amr.corp.intel.com (unknown [10.251.1.101])
        by linux.intel.com (Postfix) with ESMTP id 1AC725803FA;
        Tue,  1 Oct 2019 09:03:46 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH] ASoC: SOF: imx: fix reverse
 CONFIG_SND_SOC_SOF_OF dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20191001142026.1124917-1-arnd@arndb.de>
 <bb58c7cc-209d-7a2f-0e5b-95a9605ffe7b@linux.intel.com>
 <CAK8P3a3Js2dNhnRhP7PLadWZ69DZr1mz6DowN9HDJL4CFDAAFw@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e4b90233-846c-bfc1-68a3-a7b7c28b60bd@linux.intel.com>
Date:   Tue, 1 Oct 2019 11:03:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3Js2dNhnRhP7PLadWZ69DZr1mz6DowN9HDJL4CFDAAFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 10:41 AM, Arnd Bergmann wrote:
> On Tue, Oct 1, 2019 at 5:32 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> On 10/1/19 9:20 AM, Arnd Bergmann wrote:
>>> CONFIG_SND_SOC_SOF_IMX depends on CONFIG_SND_SOC_SOF, but is in
>>> turn referenced by the sof-of-dev driver. This creates a reverse
>>> dependency that manifests in a link error when CONFIG_SND_SOC_SOF_OF
>>> is built-in but CONFIG_SND_SOC_SOF_IMX=m:
>>>
>>> sound/soc/sof/sof-of-dev.o:(.data+0x118): undefined reference to `sof_imx8_ops'
>>>
>>> Make the latter a 'bool' symbol and change the Makefile so the imx8
>>> driver is compiled the same way as the driver using it.
>>>
>>> A nicer way would be to reverse the layering and move all
>>> the imx specific bits of sof-of-dev.c into the imx driver
>>> itself, which can then call into the common code. Doing this
>>> would need more testing and can be done if we add another
>>> driver like the first one.
>>
>> Or use something like
>>
>> config SND_SOC_SOF_IMX8_SUPPORT
>>          bool "SOF support for i.MX8"
>>          depends on IMX_SCU
>>          depends on IMX_DSP
>>
>> config SND_SOC_SOF_IMX8
>>          tristate
>>          <i.mx selects>
>>
>> config SND_SOC_SOF_OF
>>          depends on OF
>>          select SND_SOC_SOF_IMX8 if SND_SOC_SOF_IMX8_SUPPORT
>>
>> That way you propagate the module/built-in information. That's how we
>> fixed those issues for the Intel parts.
> 
> Yes, I think that would work here as well, but it keeps even more
> information about the specific drivers in the generic code. It also
> requires adding more 'select' statements that tend to cause more
> problems.
> 
> The same could be done with a Kconfig-only solution avoiding
> 'select' such as:
> 
> config SND_SOC_SOF_IMX8_SUPPORT
>           bool "SOF support for i.MX8"
>           depends on IMX_SCU
>           depends on IMX_DSP
> 
>   config SND_SOC_SOF_IMX8
>           def_tristate SND_SOC_SOF_OF
>           depends on SND_SOC_SOF_IMX8_SUPPORT

Ah, nice, thanks for the suggestion! That would be my preference, we 
have a similar select for PCI and ACPI parts in sound/soc/sof/Kconfig 
and I was looking for a means to do this more elegantly.
I can submit a new fix or let you sent a v2, whatever is more convenient.

