Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67229C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0DD2082C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 10:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbfIFKA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 06:00:57 -0400
Received: from foss.arm.com ([217.140.110.172]:53834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732476AbfIFKA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 06:00:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CCB21570;
        Fri,  6 Sep 2019 03:00:56 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38B333F59C;
        Fri,  6 Sep 2019 03:00:55 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Mark Brown <broonie@kernel.org>
Cc:     David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
References: <20190904123032.23263-1-broonie@kernel.org>
 <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
 <feaf7338-9aa1-5065-7a83-028aeadd5578@arm.com>
 <20190905124014.GA4053@sirena.co.uk>
 <93b8910d-fc01-4c16-fd7e-86abfc3cc617@arm.com>
 <20190905163420.GD4053@sirena.co.uk>
From:   Steven Price <steven.price@arm.com>
Message-ID: <58594735-c079-74e5-26c8-4911f073d4df@arm.com>
Date:   Fri, 6 Sep 2019 11:00:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905163420.GD4053@sirena.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+CC Rob - I'm not sure why he was dropped)

On 05/09/2019 17:34, Mark Brown wrote:
> On Thu, Sep 05, 2019 at 02:02:38PM +0100, Steven Price wrote:
>> On 05/09/2019 13:40, Mark Brown wrote:
> 
>>> Is that safe?  You can't rely on being able to change voltages even if
>>> there's a physical regulator available, system constraints or the
>>> results of sharing the regulator with other users may prevent changes.
> 
>> Perhaps I didn't express myself clearly. I mean that in the case of the
>> Hikey960 it would be convenient to have a "dummy regulator" that simply
>> accepted any change because ultimately Linux doesn't have direct control
>> of the voltages but simply requests a particular operating frequency via
>> the mailbox.
> 
> There's more platforms than just HiKey supported here though, I'm pretty
> sure some of them don't have the regulator under firmware control (and
> HiKey doesn't seem to have this device enabled upstream at all?).

Yes there are platforms that have a regulator under Linux's control. On
those devm_regulator_get(_optional) will of course return that regulator
and the panfrost driver will use regulator_set_voltage() to set the
voltage as appropriate.

You are also correct that HiKey does not (yet) have this enabled
upstream - hence my questions about whether there is a better way of
representing this in device tree than just omitting the regulator.

>>> I guess at the minute the code is assuming that if you can't vary the
>>> regulator it's fixed at the maximum voltage and that it's safe to run at
>>> a lower clock with a higher voltage (some devices don't like doing that).
> 
>> No - at the moment if the regulator reports an error then the function
>> bails out and doesn't change the frequency.
> 
> I'm talking about the case where you didn't get a regulator at all where
> it won't even try to set anything (ie, current behaviour).

Ok, the current code in drm-misc will indeed not try to set anything if
there's no regulator.

>>> I do note that the current code requires exactly specified voltages with
>>> no variation which doesn't match the behaviour you say you're OK with
>>> here, what you're describing sounds like the driver should be specifying
>>> a voltage range from the hardware specified maximum down to whatever the
>>> minimum the OPP supports rather than exactly the OPP voltage.  As things
>>> are you might also run into voltages that can't be hit exactly (eg, in
>>> the Exynos 5433 case in mainline a regulator that only offers steps of
>>> 2mV will error out trying to set several of the OPPs).
> 
>> Perhaps there's a better way of doing devfreq? Panfrost itself doesn't
>> really care must about this - we just need to be able to scaling up/down
>> the operating point depending on load.
> 
> The idiomatic thing for this sort of usage would be to set the voltage
> to a range between the minimum voltage the OPP can support and the
> maximum the hardware can support.  That's basically saying "try to set
> the voltage to the lowest thing between this minimum and maximum" which
> seems to be about what you're asking for here.

It's not my present concern - but it may be worth changing the calls to
regulator_set_voltage to specify a range as you suggest.

>> On many platforms to set the frequency it's necessary to do the dance to
>> set an appropriate voltage before/afterwards, but on the Hikey960
>> because this is handled via a mailbox we don't actually have a regulator
>> to set the voltage on. My commit[1] supports this by simply not listing
>> the regulator in the DT and assuming that nothing is needed when
>> switching frequency. I'm happy for some other way of handling this if
>> there's a better method.
> 
>> At the moment your change from devm_regulator_get_optional() to
>> devm_regulator_get() is a regression on this platform because it means
>> there is now a dummy regulator which will always fail the
>> regulator_set_voltage() calls preventing frequency changes. And I can't
>> see anything I can do in the DT to fix that.
> 
> Like I say that system doesn't have any enablement at all for thse
> devices upstream that I can see, the only thing with any OPPs is the
> Exynos 5433 which does have a regulator.
> 
> The simplest thing to do what you're trying to do inside the driver is
> the approach I suggested in my previous mail with checking to see what
> voltages are actually supported on the system and do something with
> that information, I'd recommend eliminating individual OPPs if some are
> supported or just never doing any regulator configuration if none can be
> set.

The problem on the Hikey960 is that the voltage control is not done by
Linux. At the moment I have a DT with a set of operating-points:

	operating-points = <
		/* <frequency> <voltage>*/
		178000  650000
		400000	700000
		533000	800000
		807000	900000
		960000	1000000
		1037000 1100000
	>;

But while Linux can set the frequency (via the mailbox interface) the
voltages are not set by Linux but are implicit by choosing a frequency.
At the moment my DT has a clock but no regulator and with the code in
drm-next this works.

Your change swapping devm_regulator_get_optional() to
devm_regulator_get() breaks this because that will return a dummy
regulator which will reject any regulator_set_voltage() calls.

I don't currently see how I can write a DT configuration for the
Hikey960 which would work with the devm_regulator_get() call.

> However you're probably better off hiding all this stuff with the
> generic OPP code rather than open coding it - this already has much
> better handling for this, it supports voltage ranges rather than single
> voltages and optional regulators already.  I'm not 100% clear why this
> is open coded TBH but I might be missing something, if there's some
> restriction preventing the generic code being used it seems like those
> sohuld be fixed.

To be honest I've no idea how to use the generic OPP code to do this. I
suspect the original open coding was cargo-culted from another driver:
the comments in the function look like they were lifted from
drivers/devfreq/rk3399_dmc.c. Any help tidying this up would be appreciated.

> In the short term I'd also strongly suggest adding documentation to the
> code so it's clear that there's some intentionality to this, at the
> minute it does not appear at all intentional.

Good point - although if it's possible to switch to generic OPP code
that would be even better.

Thanks,

Steve
