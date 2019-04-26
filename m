Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD176C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BDE9206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 02:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpMip/Lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfDZCWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 22:22:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46549 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfDZCWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 22:22:53 -0400
Received: by mail-io1-f68.google.com with SMTP id p23so1683868iol.13;
        Thu, 25 Apr 2019 19:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+vvGO8Y1oAVkJD0txdttFXV5YwE9AsR5LLh/8nosKG4=;
        b=NpMip/Lc5XDzTbTYjMDa9RalrduOPnDPwy33A8yoJ9Z9HWkxKYMZ1fG11Y9a5waHWB
         1fhR7NKRaboZAo8mMUUGTAOQ/p6/ek/i+kPJq9WopCOSK8wZ7IEvsTN+8D3RqBzDZyLt
         zn8aYAi961IjJuua3Lz5d90aTLYbcIebKTRX+en0ItYKDRiduoS8ISocA3hp3NA27CUD
         YWig25acitecTp01IyjbSqmQSq3RAvjRm43iAkGsAJvQ40VuFm+FZZv/B0YXFczMdOrP
         GiMPjYxuSJK0/bT5Qm1L4SKWms6NR7ioEJcLmaiqGg+7/OsxaFgjhh6Zv5eV1ySo9z51
         KJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vvGO8Y1oAVkJD0txdttFXV5YwE9AsR5LLh/8nosKG4=;
        b=fN4gmx4F0MYqQVAWxYEaKmShMYa8YUTUXrb1FCmGxfjIb7lddktWNHoid0qUYzj16J
         Fhr0AkPXC+yiPqLc+4uXPxw/P3COfBq/QsqazNV2T/X24hOcShALURnU1e2cjQ198oOi
         mjmPLP6F5NR8wjAS1Izo5++hbv0NgKBJLPeJJ6feM6C+1Y1N+SoythXoQLbbHgmsU1Tw
         em75I63/91Zjh9Ffe+KLrdlr/LuNFQv+L/ksfC+yfPQVdbnhPhp2gyR+jD2nkZvYlEHK
         eefcW8Ejb1XE7lvp306KdGj6wD2I0/2AH6YUmLBpS9dSxow7KROJNqjjtzBZPk8N2EF2
         i71Q==
X-Gm-Message-State: APjAAAUt4wlMlEaAsX07rg7klS8vsxinDFOG2OPjyxx27b1EBKbnf5eF
        fPWJK/7YzG1HSuPGvqqKnGR5QBMS
X-Google-Smtp-Source: APXvYqymEOFMT8EjaM2P1wcooc6qvyrGufmrTjTM8uyyer0O/Rqkeb58gwfQKqJSmF3p3+oECcatZQ==
X-Received: by 2002:a6b:6e01:: with SMTP id d1mr20940339ioh.28.1556245371854;
        Thu, 25 Apr 2019 19:22:51 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id m9sm3608498ioc.73.2019.04.25.19.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 19:22:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/4] clk: tegra20/30: Add custom EMC clock
 implementation
To:     Stephen Boyd <sboyd@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190414202009.31268-1-digetx@gmail.com>
 <20190414202009.31268-2-digetx@gmail.com>
 <155621927685.15276.16453873579880842057@swboyd.mtv.corp.google.com>
 <2b4f56cd-caf9-e6b5-6344-a045e08a9c91@gmail.com>
 <155623110849.15276.13181079281286430446@swboyd.mtv.corp.google.com>
 <1497cbbe-9748-87f1-2edc-daa54dbf6360@gmail.com>
 <155623927513.15276.3011897763001027401@swboyd.mtv.corp.google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f81bdfb0-40d6-f9fc-44da-618551963387@gmail.com>
Date:   Fri, 26 Apr 2019 05:22:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155623927513.15276.3011897763001027401@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.04.2019 3:41, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2019-04-25 17:03:11)
>> 26.04.2019 1:25, Stephen Boyd пишет:
>>> Quoting Dmitry Osipenko (2019-04-25 14:42:19)
>>>> 25.04.2019 22:07, Stephen Boyd пишет:
>>>>> Quoting Dmitry Osipenko (2019-04-14 13:20:06)
>>>>>> +{
>>>>>> +       struct clk *clk = __clk_lookup("emc");
>>>>>> +       struct tegra_clk_emc *emc;
>>>>>> +       struct clk_hw *hw;
>>>>>> +
>>>>>> +       if (clk) {
>>>>>> +               hw = __clk_get_hw(clk);
>>>>>> +               emc = to_tegra_clk_emc(hw);
>>>>>> +
>>>>>> +               emc->round_cb = round_cb;
>>>>>> +               emc->arg_cb = arg_cb;
>>>>>> +       }
>>>>>> +}
>>>>>> +
>>>>>> +bool tegra20_clk_emc_driver_available(void)
>>>>>> +{
>>>>>> +       struct clk *clk = __clk_lookup("emc");
>>>>>
>>>>> Can we avoid using __clk_lookup()? Maybe by having the clk_hw pointer in
>>>>> this driver somehow?
>>>>
>>>> tegra20_clk_emc_driver_available() is a private function of the Tegra's
>>>> clk-core. Please note that prototype of this function is added to the
>>>> local "drivers/clk/tegra/clk.h" file.
>>>>
>>>> It is indeed possible to use clk pointer instead of __clk_lookup() and
>>>> I'll change that in v3 since it's causing some confusion.
>>>
>>> Can you use a clk_hw pointer directly? I'd like to see clk provider
>>> drivers only use struct clk_hw, and clk consumers only use struct clk.
>>
>> The clk_hw pointers are not stored directly anywhere in the Tegra's
>> clk-driver, it will be a quite massive change to make the clk driver's
>> code to use clk_hw pointers instead of struct clk.
> 
> Well they must be stored in the clk driver somewhere because that's how
> the whole clk framework works.

AFAIK, Tegra stores them only in a form of clk->core->hw.

>>
>> I can add a global variable for the tegra_clk_emc pointer, but it is
>> not really necessary since there is __clk_get_hw.
>>
>> Could you please explain what's the problem with __clk_get_hw?
> 
> If it's a large invasive change then no worries. The thin that's wrong
> with __clk_get_hw() is that it's using a struct clk, meaing that most
> likely this is a clk consumer driver doing something weird.
> 
>>
>>>>
>>>>>> +       struct tegra_clk_emc *emc; +       struct clk_hw *hw; + +
>>>>>> if (clk) { +               hw = __clk_get_hw(clk);
>>>>>
>>>>> This gets further to the point, we don't prefer to see drivers use
>>>>> __clk_get_hw() unless they absolutely need to. Maybe I don't
>>>>> understand the driver structure, but it seems like maybe the
>>>>> driver that's providing the callbacks could be the same driver
>>>>> that's registering these clks, and thus everything could be inside
>>>>> one file so that we don't have to pass around callbacks and clk_hw
>>>>> pointers? Commit text says "this is how it's been" but that's not
>>>>> a reason to keep doing it.
>>>>
>>>> Again, tegra20_clk_emc_driver_available() is for the Terga's
>>>> clk-core and not for the EMC (External Memory Controller) driver.
>>>> This function is used to determine whether EMC driver is ready to
>>>> handle clock-rate changes (PRE/POST rate-change notifications), clk
>>>> users can't get EMC clock until driver is ready (i.e. the "round"
>>>> callback is registered by the driver).
>>>
>>> Who are the other users of the EMC clk? Why does the EMC driver and
>>> the clk driver need to be in sync in such a way that requires us to
>>> check if some code in the EMC driver is ready before we can hand out
>>> clks from this clk provider? It looks like some tight coupling
>>> between these two pieces of code on the clk_get() path which is
>>> setting off alarms for me.
>>
>> The other EMC clk user is the devfreq driver. We don't want the
>> devfreq driver to get and use the EMC clock if memory timing can't be
>> programmed.
> 
> Alright, got it!
> 
>> That is correct.
>>
>>> Is there some other entity that's needing to be deferred while the
>>> EMC and clk drivers tell each other that they're probed and ready so
>>> that these notifiers all work? Is that entity using clks directly
>>> instead of going through the EMC to change frequencies? If so, why
>>> can't we funnel that logic through EMC which then goes to the clk
>>> driver? That way it's clearly "thing that changes frequency" -> EMC
>>> -> clk controller call chain. It might even allow us to get rid of
>>> the rate notifiers?
>>>
>>
>> That entity is the devfreq driver which uses EMC clk directly right
>> now.
>>
>>         https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/devfreq/tegra-devfreq.c#n484
>>
>> I think we can funnel all the rate-changing logic through the EMC
>> drivers using the PM memory bandwidth QoS API, which is currently
>> unsupported by the drivers. And then indeed the rate notifiers won't
>> be needed.
> 
> Why does PM QoS matter here? I'm mostly asking for the chain to be
> stacked and the devfreq driver to be the same as the EMC driver and then
> have the EMC/devfreq combo driver use clk APIs to set rates and do
> things before and after.

It could be implemented either way, the result will be the same. The
final decision probably will be made after wiring up the PM QoS support
and doing some more testing. Also note that EMC and devfreq are actually
separate hardware blocks that are integrated.

So it all could look like this (current variant that in works):

 +-------+   PM QoS   +-+
 |DEVICE1+----------->+E|    CLK API
 +-------+   PM QoS   |M+<----------+   +-+
             +------->+C|           +--->C|
             |        +-+               |L|
 +-------+   |                       +-->K|
 |DEVICE2+---+    +-------+  CLK API |  +-+
 +-------+        |DEVFREQ+<---------+
                  +-------+

And like this:

+-------+ PM QoS  +-+
|DEVICE1+---------+ |
+-------+         | |       +-+
+-------+ PM QoS  |E|  CLK  |C|
|DEVICE2+-------->+M+<----->+L|
+-------+         |C|  API  |K|
+-------+ PM QoS  | |       +++
|DEVFREQ+---------+ |        |
+---+---+         +-+        |
    ^                        |
    +------------------------+
             CLK API

Or like this:

+-------+ PM QoS  +-+
|DEVICE1+---------+ |
+-------+         | |       +-+
+-------+ PM QoS  |E|  CLK  |C|
|DEVICE2+-------->+M+<----->+L|
+-------+         |C|  API  |K|
+-------+ PM QoS  | |       +-+
|DEVFREQ+---------+ |
+---+---+         +++
    ^              |
    +--------------+
         PM QoS

As you can see there will be other drivers that will demand memory
bandwidth too. For example the display controller performs isochronous
memory transfers and hence may require higher bandwidth than devfreq
suggests because devfreq judges the bandwidth demand by taking average
of bandwidth consumption over a period of time.

The other thing is that drivers should be abstracted from the knowledge
about the EMC because:

  a) memory/device hardware units do not know about each other

  b) it is common to express memory bandwidth in Mbs and not in a clock rate

It's only the devfreq driver that is a bit special because devfreq
hardware is actually integrated with the EMC.

>>
>>         https://github.com/grate-driver/linux/commit/2aa2390dd0cb8bca98e4cea6a29d7bda64a51bb3
>>
>> Actually it will be the next step to wire up the PM QoS support to all
>> relevant drivers that I'm going to implement after the current
>> CLK/EMC/DEVFREQ patch sets will land, it's just not realistic to do
>> everything in a single hop.
> 
> Ok. It doesn't make me feel great but I suppose if you don't disappear
> after this code is merged things will work out in the end.
> 

Correct.
