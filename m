Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B920C31E5C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471A22084A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfkYfsJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbfFQPAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:00:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55358 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfFQPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:00:46 -0400
Received: by mail-wm1-f68.google.com with SMTP id a15so9638815wmj.5;
        Mon, 17 Jun 2019 08:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ymEXm01lQbZ5JsOJLEyNUJ2oidzFEFtqzRRB3b8GyvI=;
        b=hfkYfsJX5SFaiJ58VyVBXlCQV7k150u9NSGLP8qmAGhNoT7pnx/Ay5GDcSJvUlssqC
         14f8ziBEcsNiXKpR6VZwFn1D52ZUCllxuplqU1E/zR+TT2TwyCUIzzkpJ39heL8JTLJU
         q8WTbphSR4+oqyGZe7rEls2QP/YKqrRZQ3KxRNgzW1ppF4CPIssBd1qo/NLid7Inx0Jq
         w+kc9bS7Is1p2RS/Mci53zy5O59H41Y1XP0HaTGGuQJoAsGbmbmweLVmg98n888Ouch1
         mNzJvak2JCGp3tAXuBWVdLlqvaUGb1vpAKeLmSC8MDNgBHKphTHEdJW5ZqSilu76ntgu
         q3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ymEXm01lQbZ5JsOJLEyNUJ2oidzFEFtqzRRB3b8GyvI=;
        b=hJ5BBddERAQMoPBe/C7VuLABYWuCyr30CAhy/BL592ErIlB0c83zL+zL+Xnow87SSA
         dz1DXiYh/7FhFJd0z0zT2KFIGbC0Zoo/xjcAvvDIX3LrjBEZZIMb2H/CqnX2jKVy/EmC
         ItS+5MzkWPweGYBU4oSvUJsiZG1oeLpJYtzusu98FbYvGbF4Vz/FTW6vU2uZPaS1atNt
         Ap00dVhGu5TCVgHrfC5K2HWCoD0IWdSf0lVPFGmt2dL7OLQ+ZLDlxlcuNo7CX8mkSeOL
         fU7H1M9AF+uUsaka2ZelN23RYo6coiEipYfKu44na4Qwm9Eum2ZclydGCFYdqe+2XZF8
         MZVg==
X-Gm-Message-State: APjAAAXcUuCz1En0pbHiTSn9q5R2RMBu9/p8WTNqmGC9aT9+JeZS3l80
        7iCHn6BmNr7/ulE9fTu3TCXIEmsC
X-Google-Smtp-Source: APXvYqwJyWZZq7dWw9wPc2GM/qpPpTih7lBmjvkoujngYX5TSub1leBer4k1StC1ijZSFNPpBWhy+Q==
X-Received: by 2002:a1c:9dc5:: with SMTP id g188mr19836239wme.93.1560783644169;
        Mon, 17 Jun 2019 08:00:44 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.googlemail.com with ESMTPSA id x6sm13697447wru.0.2019.06.17.08.00.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:00:43 -0700 (PDT)
Subject: Re: [PATCH v4 01/10] clk: tegra20/30: Add custom EMC clock
 implementation
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190616233551.6838-1-digetx@gmail.com>
 <20190616233551.6838-2-digetx@gmail.com> <20190617093555.GB508@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <596703d3-ce13-ff69-e685-7eb8cf7eb0d4@gmail.com>
Date:   Mon, 17 Jun 2019 18:00:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190617093555.GB508@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2019 12:35, Thierry Reding пишет:
> On Mon, Jun 17, 2019 at 02:35:42AM +0300, Dmitry Osipenko wrote:
>> A proper External Memory Controller clock rounding and parent selection
>> functionality is required by the EMC drivers. It is not available using
>> the generic clock implementation, hence add a custom one. The clock rate
>> rounding shall be done by the EMC drivers because they have information
>> about available memory timings, so the drivers will have to register a
>> callback that will round the requested rate. EMC clock users won't be able
>> to request EMC clock by getting -EPROBE_DEFER until EMC driver is probed
>> and the callback is set up. The functionality is somewhat similar to the
>> clk-emc.c which serves Tegra124+ SoC's, the later HW generations support
>> more parent clock sources and the HW configuration and integration with
>> the EMC drivers differs a tad from the older gens, hence it's not really
>> worth to try to squash everything into a single source file.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/clk/tegra/Makefile          |   2 +
>>  drivers/clk/tegra/clk-tegra20-emc.c | 305 ++++++++++++++++++++++++++++
>>  drivers/clk/tegra/clk-tegra20.c     |  55 ++---
>>  drivers/clk/tegra/clk-tegra30.c     |  38 +++-
>>  drivers/clk/tegra/clk.h             |   6 +
>>  include/linux/clk/tegra.h           |  14 ++
>>  6 files changed, 368 insertions(+), 52 deletions(-)
>>  create mode 100644 drivers/clk/tegra/clk-tegra20-emc.c
>>
>> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
>> index 4812e45c2214..df966ca06788 100644
>> --- a/drivers/clk/tegra/Makefile
>> +++ b/drivers/clk/tegra/Makefile
>> @@ -17,7 +17,9 @@ obj-y					+= clk-tegra-fixed.o
>>  obj-y					+= clk-tegra-super-gen4.o
>>  obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
>> +obj-$(CONFIG_ARCH_TEGRA_2x_SOC)		+= clk-tegra20-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_3x_SOC)         += clk-tegra30.o
>> +obj-$(CONFIG_ARCH_TEGRA_3x_SOC)		+= clk-tegra20-emc.o
>>  obj-$(CONFIG_ARCH_TEGRA_114_SOC)	+= clk-tegra114.o
>>  obj-$(CONFIG_ARCH_TEGRA_124_SOC)	+= clk-tegra124.o
>>  obj-$(CONFIG_TEGRA_CLK_DFLL)		+= clk-tegra124-dfll-fcpu.o
>> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
>> new file mode 100644
>> index 000000000000..b7f64ad5c04c
>> --- /dev/null
>> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
>> @@ -0,0 +1,305 @@
>> +// SPDX-License-Identifier: GPL-2.0
> 
> Perhaps you want to add copyright information here? Part of this is
> copied from other drivers, so keep that copyright intact. But there's
> also quite a bit of new code here, so also make sure to add yourself.

Okay! And it's true that I initially used clk-emc as a template.

[snip]

>> +void tegra30_clk_set_emc_round_callback(tegra30_clk_emc_round_cb *round_cb,
>> +					void *cb_arg)
>> +{
>> +	tegra20_clk_set_emc_round_callback(round_cb, cb_arg);
>> +}
>> +
>> +bool tegra30_clk_emc_driver_available(struct clk_hw *emc_hw)
>> +{
>> +	return tegra20_clk_emc_driver_available(emc_hw);
>> +}
> 
> Do we really need to make this distinction? Do you have any work in
> progress patches that would need to override these Tegra30 specific bits
> by code that's not the same as the Tegra20 variant? I don't see why you
> would want to duplicate this if there's no use to it. Or perhaps I'm
> missing something?

There are no other patches planned for this code. The primary reason for the
distinction is that I don't like to have T20 functions mixed with T30 because this
leads to inconsistency and confusion.

[snip]

> Again, I don't see any advantage in quirky things like this. It seems to
> me like the only reason why this exists is so that Tegra30 code doesn't
> have to call functions that start with a tegra20_ prefix. However, we
> already have code that does similar things elsewhere, so I think this
> can be considered "common" practice. No need for this duplication.

Oh, well. But this is not a very good practice in my opinion. I'll adhere to yours
comment in v5.

> Again, if I'm missing something please let me know. Might be worth
> noting why this is done in a code comment or the commit message.

You got everything right.
