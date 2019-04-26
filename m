Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796EAC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DE120878
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgjOsf7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfDZADT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:03:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36351 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbfDZADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:03:17 -0400
Received: by mail-lf1-f68.google.com with SMTP id u17so1104483lfi.3;
        Thu, 25 Apr 2019 17:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ywgRsIltAEi4f/aNSNy0lYmgAH/opfcQXhNSDU0Kbk8=;
        b=UgjOsf7aPSJwdmlKAHc2FTPKGbDE9nMeIsErC172xaIWuzc/Hpe8aeDPIwd4Imk/cr
         PfBUx4DtzNT1lA2YEIHm4jclyvlQjbvYHb69HFfCup4DJyjm4cTbDsCe5SjfYC9tYztn
         MuNssR6oSCEIeuhEU8Wao9HeIOpkNfsA7Sf3fTQ7M0te8iRMo09ovbTyH7Pv3MtPp3Lj
         buxNnMtWsOZZKBIlkB9zjPeP3tqSeu2DMfmRTnQcI+5aiWlUfsy5kCLCIQacckZdIKmG
         Kct5xXaLQkM/+XlJCJyeuwO5z9ZrXmc+21Art2YQO3TgnfpKtBfKETPPD0jQ6Hsk56bh
         23WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ywgRsIltAEi4f/aNSNy0lYmgAH/opfcQXhNSDU0Kbk8=;
        b=cG2+eaYcu7SrSyDU/LKB7K/5HtMTpWxN588TnAKY9MGjDCZzpbV2W0yaUD2LL0ELak
         L52eGEHyunY7E8DTnFDEPLfkqmP73//5nF1MAKP8Amt6SiREor99CwK62+uUdhpTp2Gn
         RhCzk2bHa1OaMYyXbpySAspa1F+CkJiOHsQWwuKDXrtlpCxORmx2Vrf5qTxfM6IS8zpc
         H0vGy8mlly3YjA7AsFTrS8wDrvf3r2IVomWku+xuqHW/Wz4r63Gdw+NqDtlHnT/3EQEZ
         JgBwD+ygxN6AUjlWwD7H+v3Q0Ik/29nGPu9xy7z10Tc0jbWCW/L+4X1aw70KROof1dyJ
         XxNQ==
X-Gm-Message-State: APjAAAU2ulLW6x2dxx531qySgPE/wMqbfjGtPjiiKbB87/oPpWJJQzS9
        JDWZ0Mz4HNrlEjxZ/UHmxXEhSjyw
X-Google-Smtp-Source: APXvYqyj6qjY/K9YWtO+oQqv3T2oI3WrBRiL1l8PKr9uTNBAMn8bZ0/Mc0o+C512M0KLpzcKgNgL0w==
X-Received: by 2002:a19:48c9:: with SMTP id v192mr22203606lfa.136.1556236993610;
        Thu, 25 Apr 2019 17:03:13 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id q12sm5226896lfa.37.2019.04.25.17.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 17:03:12 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <1497cbbe-9748-87f1-2edc-daa54dbf6360@gmail.com>
Date:   Fri, 26 Apr 2019 03:03:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155623110849.15276.13181079281286430446@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

26.04.2019 1:25, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2019-04-25 14:42:19)
>> 25.04.2019 22:07, Stephen Boyd пишет:
>>> Quoting Dmitry Osipenko (2019-04-14 13:20:06)
>>>> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
>>>> new file mode 100644
>>>> index 000000000000..35b67a9989c8
>>>> --- /dev/null
>>>> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
>>>> @@ -0,0 +1,307 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +#include <linux/bits.h>
>>>> +#include <linux/clk/tegra.h>
>>>
>>> Include clk-provider.h as this is a clk provider driver.
>>
>> Okay, although clk-provider.h is also included by clk.h below.
> 
> We prefer explicit includes instead of implicit ones. Failing to do that
> leads to changes like the one I'm making now to push out linux/io.h to
> all the users who are relying on clk-provider.h to provide it for them.

Ok.

>>
>>>> +{
>>>> +       struct clk *clk = __clk_lookup("emc");
>>>> +       struct tegra_clk_emc *emc;
>>>> +       struct clk_hw *hw;
>>>> +
>>>> +       if (clk) {
>>>> +               hw = __clk_get_hw(clk);
>>>> +               emc = to_tegra_clk_emc(hw);
>>>> +
>>>> +               emc->round_cb = round_cb;
>>>> +               emc->arg_cb = arg_cb;
>>>> +       }
>>>> +}
>>>> +
>>>> +bool tegra20_clk_emc_driver_available(void)
>>>> +{
>>>> +       struct clk *clk = __clk_lookup("emc");
>>>
>>> Can we avoid using __clk_lookup()? Maybe by having the clk_hw pointer in
>>> this driver somehow?
>>
>> tegra20_clk_emc_driver_available() is a private function of the Tegra's
>> clk-core. Please note that prototype of this function is added to the
>> local "drivers/clk/tegra/clk.h" file.
>>
>> It is indeed possible to use clk pointer instead of __clk_lookup() and
>> I'll change that in v3 since it's causing some confusion.
> 
> Can you use a clk_hw pointer directly? I'd like to see clk provider
> drivers only use struct clk_hw, and clk consumers only use struct clk.

The clk_hw pointers are not stored directly anywhere in the Tegra's
clk-driver, it will be a quite massive change to make the clk driver's
code to use clk_hw pointers instead of struct clk.

I can add a global variable for the tegra_clk_emc pointer, but it is not
really necessary since there is __clk_get_hw.

Could you please explain what's the problem with __clk_get_hw?

>>
>>>> +       struct tegra_clk_emc *emc;
>>>> +       struct clk_hw *hw;
>>>> +
>>>> +       if (clk) {
>>>> +               hw = __clk_get_hw(clk);
>>>
>>> This gets further to the point, we don't prefer to see drivers use
>>> __clk_get_hw() unless they absolutely need to. Maybe I don't understand
>>> the driver structure, but it seems like maybe the driver that's
>>> providing the callbacks could be the same driver that's registering
>>> these clks, and thus everything could be inside one file so that we
>>> don't have to pass around callbacks and clk_hw pointers? Commit text
>>> says "this is how it's been" but that's not a reason to keep doing it.
>>
>> Again, tegra20_clk_emc_driver_available() is for the Terga's clk-core
>> and not for the EMC (External Memory Controller) driver. This function
>> is used to determine whether EMC driver is ready to handle clock-rate
>> changes (PRE/POST rate-change notifications), clk users can't get EMC
>> clock until driver is ready (i.e. the "round" callback is registered by
>> the driver).
> 
> Who are the other users of the EMC clk? Why does the EMC driver and the
> clk driver need to be in sync in such a way that requires us to check if
> some code in the EMC driver is ready before we can hand out clks from
> this clk provider? It looks like some tight coupling between these two
> pieces of code on the clk_get() path which is setting off alarms for me.

The other EMC clk user is the devfreq driver. We don't want the devfreq
driver to get and use the EMC clock if memory timing can't be programmed.

>>
>> Please see tegra20_clk_src_onecell_get() changes in this patch and
>> drivers/memory/tegra/tegra20-emc.c for clarity.
>>
>> It is not possible to register clk from the EMC driver without having
>> some custom integration with the clk-core because CLK and EMC are
>> different hardware units and hence EMC driver doesn't have direct access
>> to the CLK registers. I think it is better to keep CLK and memory-timing
>> programming logically separated simply for consistency, although I'm
>> open to suggestions.
> 
> Sorry, I'm really confused and it's probably because I'm not taking the
> time to read all the Tegra code right now. I'm trying to understand the
> overall memory controller frequency logic.

No problems, sorry for the confusion.

> I understand that there's a memory controller, and a clk controller, and
> they're different hardware blocks. Presumably the clk controller can't
> change frequencies without informing the memory controller that it's
> going to change something so the memory controller can fix timings in
> the EMC register space.

That is correct.

> Is there some other entity that's needing to be deferred while the EMC
> and clk drivers tell each other that they're probed and ready so that
> these notifiers all work? Is that entity using clks directly instead of
> going through the EMC to change frequencies? If so, why can't we funnel
> that logic through EMC which then goes to the clk driver? That way it's
> clearly "thing that changes frequency" -> EMC -> clk controller call
> chain. It might even allow us to get rid of the rate notifiers?
> 

That entity is the devfreq driver which uses EMC clk directly right now.

	https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/devfreq/tegra-devfreq.c#n484

I think we can funnel all the rate-changing logic through the EMC
drivers using the PM memory bandwidth QoS API, which is currently
unsupported by the drivers. And then indeed the rate notifiers won't be
needed.

	https://github.com/grate-driver/linux/commit/2aa2390dd0cb8bca98e4cea6a29d7bda64a51bb3

Actually it will be the next step to wire up the PM QoS support to all
relevant drivers that I'm going to implement after the current
CLK/EMC/DEVFREQ patch sets will land, it's just not realistic to do
everything in a single hop.
