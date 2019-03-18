Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82FBC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853BE20854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfCRLkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:40:46 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:37075 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbfCRLkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:40:46 -0400
X-Originating-IP: 109.213.80.250
Received: from localhost (alyon-652-1-57-250.w109-213.abo.wanadoo.fr [109.213.80.250])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id E4646240006;
        Mon, 18 Mar 2019 11:40:39 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc:     Christian Neubert <christian.neubert.86@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: mvebu: armada-37xx-periph: Fix initialization for cpu clocks
In-Reply-To: <20190318112844.GA1708@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com> <20190314121541.GB19385@apalos> <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com> <20190314134428.GA24768@apalos> <874l85v8p6.fsf@FE-laptop> <20190318112844.GA1708@apalos>
Date:   Mon, 18 Mar 2019 12:40:38 +0100
Message-ID: <87h8c0s955.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilias,
 
 On lun., mars 18 2019, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> Hi Gregory, 
>> Hi Ilias,
>>  
>>  On jeu., mars 14 2019, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
>> 
>> > Hello Christian,
>> >> Hi,
>> >> 
>> >> I assume you use the 1000 MHz firmware. This does also not work on my Rev 7
>> >> board. But I'm pretty sure this is not a problem of the patches, because if
>> >> I take a newer kernel (4.19.20/27) without the patches it also does not
>> >> work. A kernel 4.19.17 does work for me. My opinion on that is that this is
>> >> another problem which does just occure now because now the cpu frequency
>> >> scaling is working with the right frequencies.
>> > I am not sure which firmware i am running, i did all my tests on 5.0.0 and
>> > changing between governors worked fine without the patches
>> 
>> Curently my espressobin is broken so I tested the patches on the Armada
>> 3700 DB and I didn't observe the issue you had.
>> 
>> The 3700 DB I used is configured to run at 800MHz.
>> 
>> Could you apply the following patch and sent me the boot log?
>> 
>> diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
>> index 26ed3c18a239..f814ade5cd80 100644
>> --- a/drivers/clk/mvebu/armada-37xx-periph.c
>> +++ b/drivers/clk/mvebu/armada-37xx-periph.c
>> @@ -452,14 +452,17 @@ static int clk_pm_cpu_set_parent(struct clk_hw *hw, u8 index)
>>  
>>         /* Set the parent clock for all the load level */
>>         for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
>> -               unsigned int reg, mask,  val,
>> +               unsigned int reg, mask,  val, old,
>>                         offset = ARMADA_37XX_NB_TBG_SEL_OFF;
>>  
>>                 armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
>>  
>>                 val = index << offset;
>>                 mask = ARMADA_37XX_NB_TBG_SEL_MASK << offset;
>> +               regmap_read(base, reg, &old);
>>                 regmap_update_bits(base, reg, mask, val);
>> +               pr_err("%s old=%X -> val=0x%X load_level=%d\n",
>> +                      __func__, old,  val, load_level);
>>         }
>>         return 0;
>>  }
>> 
>> 
>> 
> [   14.909524] clk_pm_cpu_set_parent old=28004840 -> val=0x6000000 load_level=0
> [   14.916424] clk_pm_cpu_set_parent old=2E004840 -> val=0x600 load_level=1
> [   14.923315] clk_pm_cpu_set_parent old=8880A8C0 -> val=0x6000000 load_level=2
> [   14.930572] clk_pm_cpu_set_parent old=8E80A8C0 -> val=0x600 load_level=3
>
>
> Let me know if you need anything else

Could you show me the output of "cat /sys/kernel/debug/clk/clk_summary"

Also, during this week-end, Christian suggested that the issue might
come from the AVS support.

Could you disable it and check you still have the issue?

For this, you just have to remove the avs node in
arch/arm64/boot/dts/marvell/armada-37xx.dtsi and rebuild the dtb.

Thanks,

Gregory

>
> Regards
> /Ilias

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
