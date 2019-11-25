Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD91AC43141
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19B92082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbfKYNu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:50:58 -0500
Received: from ns.iliad.fr ([212.27.33.1]:37026 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727462AbfKYNu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 08:50:58 -0500
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id 1E11720C37;
        Mon, 25 Nov 2019 14:50:57 +0100 (CET)
Received: from [192.168.108.51] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id 0767C20609;
        Mon, 25 Nov 2019 14:50:57 +0100 (CET)
Subject: Re: [PATCH v1] clk: Add devm_clk_{prepare,enable,prepare_enable}
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1d7a1b3b-e9bf-1d80-609d-a9c0c932b15a@free.fr>
 <20190715214647.GY7234@tuxbook-pro>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <c4d6c458-3cdf-fbfa-5615-5ab4441d3f60@free.fr>
Date:   Mon, 25 Nov 2019 14:50:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190715214647.GY7234@tuxbook-pro>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Nov 25 14:50:57 2019 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doh! Your reply never made it to my inbox, and I never thought to check
the mailing list...

On 15/07/2019 23:46, Bjorn Andersson wrote:

> On Mon 15 Jul 08:34 PDT 2019, Marc Gonzalez wrote:
> 
> [..]
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index c0990703ce54..5e85548357c0 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -914,6 +914,18 @@ int clk_prepare(struct clk *clk)
>>  }
>>  EXPORT_SYMBOL_GPL(clk_prepare);
>>  
>> +static void unprepare(void *clk)
> 
> This deserves a less generic name.

Fair enough. Though it's only because of C's function pointer idiosyncrasies
that a function wrapper is even needed.


> clk_enable() is used in code that can't sleep, in what scenario do you
> envision it being useful to enable a clock from such region until devres
> cleans up the associated device?

The use-case I had in mind was
"Device drivers that call
1) clk_prepare_enable from probe()
2) clk_disable_unprepare() in remove()"

(Russell King has pointed out the short-comings of such an approach
in a different sub-thread.)


>> +int devm_clk_prepare(struct device *dev, struct clk *clk);
>> +int devm_clk_enable(struct device *dev, struct clk *clk);
>> +static inline int devm_clk_prepare_enable(struct device *dev, struct clk *clk)
> 
> devm_clk_prepare_enable() sounds very useful, devm_clk_prepare() might
> be useful, so keep those and drop devm_clk_enable().

Oooh, I think I understand what you mean...

I saw clk_prepare_enable() defined as clk_prepare() + clk_enable(),
and figured I'd define devm_clk_prepare_enable() as
devm_clk_prepare() + devm_clk_enable() without realizing that
devm_clk_enable() made no sense.

Solution: drop devm_clk_enable() from include/linux/clk.h
Consequence devm_clk_prepare_enable() cannot be static inline,
but that may not be a big deal...

Regards.
