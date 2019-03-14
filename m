Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35E2C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDA621852
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbfCNOUn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:20:43 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:34735 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfCNOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:20:43 -0400
Received: from localhost (alyon-652-1-66-9.w109-213.abo.wanadoo.fr [109.213.209.9])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E685010000E;
        Thu, 14 Mar 2019 14:20:37 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Christian Neubert <christian.neubert.86@gmail.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
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
In-Reply-To: <20190314134428.GA24768@apalos>
References: <20190313163558.6705-1-gregory.clement@bootlin.com> <20190314121541.GB19385@apalos> <CAC5LXJcCs4nr-qFOWzUJpUBAJ9ngG-cgeTCVCFBKFc1SPzHMuQ@mail.gmail.com> <20190314134428.GA24768@apalos>
Date:   Thu, 14 Mar 2019 15:20:37 +0100
Message-ID: <874l85v8p6.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilias,
 
 On jeu., mars 14 2019, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:

> Hello Christian,
>> Hi,
>> 
>> I assume you use the 1000 MHz firmware. This does also not work on my Rev 7
>> board. But I'm pretty sure this is not a problem of the patches, because if
>> I take a newer kernel (4.19.20/27) without the patches it also does not
>> work. A kernel 4.19.17 does work for me. My opinion on that is that this is
>> another problem which does just occure now because now the cpu frequency
>> scaling is working with the right frequencies.
> I am not sure which firmware i am running, i did all my tests on 5.0.0 and
> changing between governors worked fine without the patches

Curently my espressobin is broken so I tested the patches on the Armada
3700 DB and I didn't observe the issue you had.

The 3700 DB I used is configured to run at 800MHz.

Could you apply the following patch and sent me the boot log?

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 26ed3c18a239..f814ade5cd80 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -452,14 +452,17 @@ static int clk_pm_cpu_set_parent(struct clk_hw *hw, u8 index)
 
        /* Set the parent clock for all the load level */
        for (load_level = 0; load_level < LOAD_LEVEL_NR; load_level++) {
-               unsigned int reg, mask,  val,
+               unsigned int reg, mask,  val, old,
                        offset = ARMADA_37XX_NB_TBG_SEL_OFF;
 
                armada_3700_pm_dvfs_update_regs(load_level, &reg, &offset);
 
                val = index << offset;
                mask = ARMADA_37XX_NB_TBG_SEL_MASK << offset;
+               regmap_read(base, reg, &old);
                regmap_update_bits(base, reg, mask, val);
+               pr_err("%s old=%X -> val=0x%X load_level=%d\n",
+                      __func__, old,  val, load_level);
        }
        return 0;
 }



>
> Regards
> /Ilias
>> 
>> Ilias Apalodimas <ilias.apalodimas@linaro.org> schrieb am Do., 14. März
>> 2019, 13:15:
>> 
>> > Hi Gregory,
>> > > The clock parenting was not setup properly when DVFS was enabled. It was
>> > > expected that the same clock source was used with and without DVFS which
>> > > was not the case.
>> > >
>> > > This patch fixes this issue, allowing to make the cpufreq support work
>> > > when the CPU clocks source are not the default ones.
>> > >
>> > > Fixes: 92ce45fb875d ("cpufreq: Add DVFS support for Armada 37xx")
>> > > Cc: <stable@vger.kernel.org>
>> > > Reported-by: Christian Neubert <christian.neubert.86@gmail.com>
>> > > Reported-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> > > Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
>> > > ---
>> > >  drivers/clk/mvebu/armada-37xx-periph.c | 11 +++++++++++
>> > >  1 file changed, 11 insertions(+)
>> > >
>> > > diff --git a/drivers/clk/mvebu/armada-37xx-periph.c
>> > b/drivers/clk/mvebu/armada-37xx-periph.c
>> > > index 1f1cff428d78..26ed3c18a239 100644
>> > > --- a/drivers/clk/mvebu/armada-37xx-periph.c
>> > > +++ b/drivers/clk/mvebu/armada-37xx-periph.c
>> > > @@ -671,6 +671,17 @@ static int armada_3700_add_composite_clk(const
>> > struct clk_periph_data *data,
>> > >               map = syscon_regmap_lookup_by_compatible(
>> > >                               "marvell,armada-3700-nb-pm");
>> > >               pmcpu_clk->nb_pm_base = map;
>> > > +
>> > > +             /*
>> > > +              * Use the same parent when DVFS is enabled that the
>> > > +              * default parent received at boot time. When this
>> > > +              * function is called, DVFS is not enabled yet, so we
>> > > +              * get the default parent and we can set the parent
>> > > +              * for DVFS.
>> > > +              */
>> > > +             if (clk_pm_cpu_set_parent(muxrate_hw,
>> > > +
>> >  clk_pm_cpu_get_parent(muxrate_hw)))
>> > > +                     dev_warn(dev, "Failed to setup default parent
>> > clock for DVFS\n");
>> > >       }
>> > >
>> > >       *hw = clk_hw_register_composite(dev, data->name,
>> > data->parent_names,
>> > > --
>> > > 2.20.1
>> > >
>> > Applied this and selected only
>> >
>> > CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
>> > CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>> > CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>> >
>> > After changing the governor from 'powersave' to 'performance' the board
>> > completely froze (i even lost access to the serial port)
>> >
>> > Cheers
>> > /Ilias
>> >

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
