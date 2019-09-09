Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E09C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 524BA206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 14:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405363AbfIIOQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 10:16:35 -0400
Received: from mga09.intel.com ([134.134.136.24]:33539 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730690AbfIIOQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 10:16:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Sep 2019 07:16:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="185204986"
Received: from cheolyon-mobl.gar.corp.intel.com (HELO [10.249.76.127]) ([10.249.76.127])
  by fmsmga007.fm.intel.com with ESMTP; 09 Sep 2019 07:16:30 -0700
Subject: Re: [PATCH v1 1/2] clk: intel: Add CGU clock driver for a new SoC
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>, sboyd@kernel.org
Cc:     andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com,
        qi-ming.wu@intel.com, rahul.tanwar@intel.com, robh+dt@kernel.org,
        robh@kernel.org, yixin.zhu@linux.intel.com
References: <6a3c26bc6e25d883686287883528dbde30725922.1566975410.git.rahul.tanwar@linux.intel.com>
 <20190902222015.11360-1-martin.blumenstingl@googlemail.com>
 <d9e96dab-96be-0c14-b7af-e1f2dc07ebd2@linux.intel.com>
 <CAFBinCARQJ7q9q3r6c6Yr2SD0Oo_Drah-kxss3Obs-g=B1M28A@mail.gmail.com>
 <b7920723-1df2-62df-61c7-98c3a1665aa1@linux.intel.com>
 <CAFBinCA+J-HnXfRnquqviXvX0Jo84hoLC9=_uHbyWKZycwyAFw@mail.gmail.com>
From:   "Kim, Cheol Yong" <cheol.yong.kim@linux.intel.com>
Message-ID: <4e1ddc50-7ae3-3ba9-7e41-80a834fa2dbf@linux.intel.com>
Date:   Mon, 9 Sep 2019 22:16:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFBinCA+J-HnXfRnquqviXvX0Jo84hoLC9=_uHbyWKZycwyAFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2019 4:47 AM, Martin Blumenstingl wrote:
> Hi Rahul,
>
> On Wed, Sep 4, 2019 at 10:04 AM Tanwar, Rahul
> <rahul.tanwar@linux.intel.com> wrote:
>>
>> Hi Martin,
>>
>> On 4/9/2019 2:53 AM, Martin Blumenstingl wrote:
>>>> My understanding is that if we do not use syscon, then there is no
>>>> point in using regmap because this driver uses simple 32 bit register
>>>> access. Can directly read/write registers using readl() & writel().
>>>>
>>>> Would you agree ?
>>> if there was only the LGM SoC then I would say: drop regmap
>>>
>>> however, last year a driver for the GRX350/GRX550 SoCs was proposed: [0]
>>> this was never updated but it seems to use the same "framework" as the
>>> LGM driver
>>> with this in mind I am for keeping regmap support because.
>>> I think it will be easier to add support for old SoCs like
>>> GRX350/GRX550 (but also VRX200), because the PLL sub-driver (I am
>>> assuming that it is similar on all SoCs) or some other helpers can be
>>> re-used across various SoCs instead of "duplicating" code (where one
>>> variant would use regmap and the other readl/writel).
>>
>> Earlier, we had discussed about it in our team.  There are no plans to
>> upstream mips based platform code, past up-streaming efforts for mips
>> platforms were also dropped. GRX350/GRX550/VRX200 are all mips
>> based platforms. Plan is to upstream only x86 based platforms. In-fact,
>> i had removed GRX & other older SoCs support from this driver before
>> sending for review. So we can consider only x86 based LGM family of
>> SoCs for this driver & all of them will be reusing same IP.
> this is very sad news
> as far as I can tell many IP cores are similar/identical on
> GRX350/GRX550, LGM and even VRX200
>
> I already know that VRX200 is a legacy product and you won't be supporting it
> once LGM support lands upstream you could add support for
> GRX350/GRX550 with small to medium effort
> that is a big win (in my opinion) because it means happier end-users
> (see XWAY and VRX200 support in OpenWrt for example: while support
> from Intel/Lantiq has died long ago these devices can still run a
> recent LTS kernel and get security updates. without OpenWrt these
> devices would probably end up as electronic waste)

I'm sorry to say that we don't plan to support legacy SOCs. As you might 
know, we tried to upstream some of drivers last year but found a lot of 
problems to support both legacy SOCs and LGM.

It was a real pain to support all of them with limited resources/time 
and we couldn't make it. Our new plan was to reattempt to upstream LGM 
drivers only. This can be more realistic target for us.

>
> maybe implementing a re-usable regmap clock driver (for mux, gate and
> divider) means less effort (compared to converting everything to
> standard clock ops) for you.
> (we did the switch from standard clock ops to regmap for the Amlogic
> Meson clock drivers when we discovered that there were some non-clock
> registers that belong to other IP blocks in it and it was a lot of
> effort)
> this will allow you to add support for GRX350/GRX550 in the future if
> demand for upstream drivers rises.

I've discussed internally the amount of efforts to create a reusable 
regmap clock driver which might be reused by other companies too.

It seems it requires significant efforts for implementation/tests. As we 
don't plan to support our old SOCs for now, I'm not sure if we need to 
put such a big efforts.

Stephan,

It seems you don't like both meson/qcom regmap clock implementation.

What is your opinion for our current CGU clock driver implementation?


>
> Martin
>
