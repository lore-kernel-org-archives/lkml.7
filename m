Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB2EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26CD20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfIDIEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:04:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:47680 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbfIDIEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:04:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2019 01:04:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,465,1559545200"; 
   d="scan'208";a="182406388"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 04 Sep 2019 01:04:04 -0700
Received: from [10.226.38.83] (rtanwar-mobl.gar.corp.intel.com [10.226.38.83])
        by linux.intel.com (Postfix) with ESMTP id 336DC580105;
        Wed,  4 Sep 2019 01:04:02 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        qi-ming.wu@intel.com, rahul.tanwar@intel.com, robh+dt@kernel.org,
        robh@kernel.org, sboyd@kernel.org, yixin.zhu@linux.intel.com
References: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190902222015.11360-1-martin.blumenstingl@googlemail.com>
 <d9e96dab-96be-0c14-b7af-e1f2dc07ebd2@linux.intel.com>
 <CAFBinCARQJ7q9q3r6c6Yr2SD0Oo_Drah-kxss3Obs-g=B1M28A@mail.gmail.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <b7920723-1df2-62df-61c7-98c3a1665aa1@linux.intel.com>
Date:   Wed, 4 Sep 2019 16:03:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCARQJ7q9q3r6c6Yr2SD0Oo_Drah-kxss3Obs-g=B1M28A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Martin,

On 4/9/2019 2:53 AM, Martin Blumenstingl wrote:
>> My understanding is that if we do not use syscon, then there is no
>> point in using regmap because this driver uses simple 32 bit register
>> access. Can directly read/write registers using readl() & writel().
>>
>> Would you agree ?
> if there was only the LGM SoC then I would say: drop regmap
>
> however, last year a driver for the GRX350/GRX550 SoCs was proposed: [0]
> this was never updated but it seems to use the same "framework" as the
> LGM driver
> with this in mind I am for keeping regmap support because.
> I think it will be easier to add support for old SoCs like
> GRX350/GRX550 (but also VRX200), because the PLL sub-driver (I am
> assuming that it is similar on all SoCs) or some other helpers can be
> re-used across various SoCs instead of "duplicating" code (where one
> variant would use regmap and the other readl/writel).


Earlier, we had discussed about it in our team.  There are no plans to

upstream mips based platform code, past up-streaming efforts for mips

platforms were also dropped. GRX350/GRX550/VRX200 are all mips

based platforms. Plan is to upstream only x86 based platforms. In-fact,

i had removed GRX & other older SoCs support from this driver before

sending for review. So we can consider only x86 based LGM family of

SoCs for this driver & all of them will be reusing same IP.

> [...]
>>> +     select OF_EARLY_FLATTREE
>>> there's not a single other "select OF_EARLY_FLATTREE" in driver/clk
>>> I'm not saying this is wrong but it makes me curious why you need this
>>
>> We need OF_EARLY_FLATTREE for LGM. But adding a new x86
>> platform for LGM is discouraged because that would lead to too
>> many platforms. Only differentiating factor for LGM is CPU model
>> ID but it can differentiate only at run time. So i had no option
>> other then enabling it with some LGM specific core system module
>> driver and CGU seemed perfect for this purpose.
> so when my x86 kernel maintainer enables CONFIG_INTEL_LGM_CGU_CLK then
> OF_EARLY_FLATTREE is enabled as well.
> does this hurt any existing x86 platform? if not: why can't we enable
> it for x86 unconditionally?


IMHO, it will not hurt any other existing x86 platform but enabling it for

x86 unconditionally also doesn't sound like a good idea. I now get your

point that enabling OF_EARLY_FLATTREE here is a bit odd. I will remove

it in next patch.

Regards,

Rahul

> I went through meson & qcom regmap clock code. Agree, it can be
> reused for mux, divider and gate. But as mentioned above, i am now
> considering to move away from using regmap.
> thank you for evaluating them. let's continue the discussion above
> whether regmap should be used - after that we decide (if needed) which
> regmap implementation to use
>
>
> Martin
>
>
> [0] https://patchwork.kernel.org/patch/10554401/
