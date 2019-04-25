Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29698C4321B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC312064A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPATN+U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbfDYVmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:42:25 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45635 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388072AbfDYVmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:42:25 -0400
Received: by mail-lf1-f65.google.com with SMTP id t11so751643lfl.12;
        Thu, 25 Apr 2019 14:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gG6aQ8ZO8ZoycQskXBs1LzAsPS+UPyLGX3n406xO94A=;
        b=dPATN+U/MUZDx8zJgyAti4jOXkDgjUyfU/AjDa+HjmcCoI/slT+TgBRffm5D1K5DKc
         +JKHfPA0Xi2pwOTT8vK4BpQd+ed2d/H2tBmeAGX/AC5VijlSlPzXkIk2KxgU2+li106u
         9hw7HwR14/br4QxZbQKVf/E1ToEcCvkHa703M0Fp9zfAAB3JFBKxn8w8WbG/7keEAJ0l
         k1URPbSgxeezXQY4MbYB9Lqb53L+xG6Ra6dZta8PN/0BuBfdAiCW2hs4g7vT2sJdjoLq
         iGcOLLIg6Du1aryat5Uaaf2n30MzfiMnMpfHWcpM7r6CPbYU3Bw9CNemlgbSvTBWCcjA
         cUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gG6aQ8ZO8ZoycQskXBs1LzAsPS+UPyLGX3n406xO94A=;
        b=BtO9AJRxBq3NGNJZFz9YYFkZxFh7c5gI8/JxfqtUtiKykYf2bCW43L5fTOcBX8hGIy
         OMZxM0iAg9BdvKqV/JggCBcPyBsJepvkRzUlR/DRxeLqyOtJpl5JeeiHAOc5UTwts0DR
         nuD/HQs9525ZdlaUfWsibG3sevKFnJhuCaFNUj/cFj6S1hrqpwSFwsgw8TzGVFoU2a45
         jVAZwxR4SALaAL4LihUWRG0pAlXNcAnDzsK3iNBOTsMElY8QPo7l4/IzGtG9RHD2K2Oi
         sf9RzGwN5CFvODmnRSSdE9JTE43DjT5czWtEwDDnjVCpd5LxX7s6NAxjUdlwk283E/gd
         6erw==
X-Gm-Message-State: APjAAAVH2m6cbTwe29nQFpAWXLNWKfseKoUJ2xPXXCkfiwJ2Z5+wwT5I
        XQAaBz381SC9P3PFerN5Vp4gah6k
X-Google-Smtp-Source: APXvYqzmvaTbqKZSELuS5ejM3X1moRZrqVE2UJNHEq3q/d1epIc0TI1/JGqaBt2yjSfuVKf+G1fyIQ==
X-Received: by 2002:a19:f81a:: with SMTP id a26mr22565850lff.63.1556228541572;
        Thu, 25 Apr 2019 14:42:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.googlemail.com with ESMTPSA id q29sm4851088ljc.8.2019.04.25.14.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 14:42:20 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2b4f56cd-caf9-e6b5-6344-a045e08a9c91@gmail.com>
Date:   Fri, 26 Apr 2019 00:42:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <155621927685.15276.16453873579880842057@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.04.2019 22:07, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2019-04-14 13:20:06)
>> diff --git a/drivers/clk/tegra/clk-tegra20-emc.c b/drivers/clk/tegra/clk-tegra20-emc.c
>> new file mode 100644
>> index 000000000000..35b67a9989c8
>> --- /dev/null
>> +++ b/drivers/clk/tegra/clk-tegra20-emc.c
>> @@ -0,0 +1,307 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include <linux/bits.h>
>> +#include <linux/clk/tegra.h>
> 
> Include clk-provider.h as this is a clk provider driver.

Okay, although clk-provider.h is also included by clk.h below.

>> +#include <linux/err.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +
>> +#include "clk.h"
>> +
>> +#define CLK_SOURCE_EMC_2X_CLK_DIVISOR_MASK     GENMASK(7, 0)
>> +#define CLK_SOURCE_EMC_2X_CLK_SRC_MASK         GENMASK(31, 30)
> [...]
>> +
>> +static const struct clk_ops tegra_clk_emc_ops = {
>> +       .recalc_rate = emc_recalc_rate,
>> +       .get_parent = emc_get_parent,
>> +       .set_parent = emc_set_parent,
>> +       .set_rate = emc_set_rate,
>> +       .set_rate_and_parent = emc_set_rate_and_parent,
>> +       .determine_rate = emc_determine_rate,
>> +};
>> +
>> +void tegra20_clk_set_emc_round_callback(void *round_cb, void *arg_cb)
> 
> Why can't we have type safety on these function pointers?

It is probably not really necessary since it's a platform-specific API.
But I'll add an explicit type in v3 for consistency, thanks.

>> +{
>> +       struct clk *clk = __clk_lookup("emc");
>> +       struct tegra_clk_emc *emc;
>> +       struct clk_hw *hw;
>> +
>> +       if (clk) {
>> +               hw = __clk_get_hw(clk);
>> +               emc = to_tegra_clk_emc(hw);
>> +
>> +               emc->round_cb = round_cb;
>> +               emc->arg_cb = arg_cb;
>> +       }
>> +}
>> +
>> +bool tegra20_clk_emc_driver_available(void)
>> +{
>> +       struct clk *clk = __clk_lookup("emc");
> 
> Can we avoid using __clk_lookup()? Maybe by having the clk_hw pointer in
> this driver somehow?

tegra20_clk_emc_driver_available() is a private function of the Tegra's
clk-core. Please note that prototype of this function is added to the
local "drivers/clk/tegra/clk.h" file.

It is indeed possible to use clk pointer instead of __clk_lookup() and
I'll change that in v3 since it's causing some confusion.

>> +       struct tegra_clk_emc *emc;
>> +       struct clk_hw *hw;
>> +
>> +       if (clk) {
>> +               hw = __clk_get_hw(clk);
> 
> This gets further to the point, we don't prefer to see drivers use
> __clk_get_hw() unless they absolutely need to. Maybe I don't understand
> the driver structure, but it seems like maybe the driver that's
> providing the callbacks could be the same driver that's registering
> these clks, and thus everything could be inside one file so that we
> don't have to pass around callbacks and clk_hw pointers? Commit text
> says "this is how it's been" but that's not a reason to keep doing it.

Again, tegra20_clk_emc_driver_available() is for the Terga's clk-core
and not for the EMC (External Memory Controller) driver. This function
is used to determine whether EMC driver is ready to handle clock-rate
changes (PRE/POST rate-change notifications), clk users can't get EMC
clock until driver is ready (i.e. the "round" callback is registered by
the driver).

Please see tegra20_clk_src_onecell_get() changes in this patch and
drivers/memory/tegra/tegra20-emc.c for clarity.

It is not possible to register clk from the EMC driver without having
some custom integration with the clk-core because CLK and EMC are
different hardware units and hence EMC driver doesn't have direct access
to the CLK registers. I think it is better to keep CLK and memory-timing
programming logically separated simply for consistency, although I'm
open to suggestions.
