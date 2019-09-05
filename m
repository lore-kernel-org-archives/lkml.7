Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A30EC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABC5E21D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbfIENCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:02:42 -0400
Received: from foss.arm.com ([217.140.110.172]:44682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfIENCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:02:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29EBD28;
        Thu,  5 Sep 2019 06:02:41 -0700 (PDT)
Received: from [10.1.196.133] (e112269-lin.cambridge.arm.com [10.1.196.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1163F718;
        Thu,  5 Sep 2019 06:02:40 -0700 (PDT)
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Mark Brown <broonie@kernel.org>
Cc:     David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190904123032.23263-1-broonie@kernel.org>
 <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
 <feaf7338-9aa1-5065-7a83-028aeadd5578@arm.com>
 <20190905124014.GA4053@sirena.co.uk>
From:   Steven Price <steven.price@arm.com>
Message-ID: <93b8910d-fc01-4c16-fd7e-86abfc3cc617@arm.com>
Date:   Thu, 5 Sep 2019 14:02:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905124014.GA4053@sirena.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2019 13:40, Mark Brown wrote:
> On Thu, Sep 05, 2019 at 10:37:53AM +0100, Steven Price wrote:
> 
>> Ah, I didn't realise that regulator_get() will return a dummy regulator
>> if none is provided in the DT. In theory that seems like a nicer
>> solution to my two commits. However there's still a problem - the dummy
>> regulator returned from regulator_get() reports errors when
>> regulator_set_voltage() is called. So I get errors like this:
> 
>> [  299.861165] panfrost e82c0000.mali: Cannot set voltage 1100000 uV
>> [  299.867294] devfreq devfreq0: dvfs failed with (-22) error
> 
>> (And therefore the frequency isn't being changed)
> 
>> Ideally we want a dummy regulator that will silently ignore any
>> regulator_set_voltage() calls.
> 
> Is that safe?  You can't rely on being able to change voltages even if
> there's a physical regulator available, system constraints or the
> results of sharing the regulator with other users may prevent changes.

Perhaps I didn't express myself clearly. I mean that in the case of the
Hikey960 it would be convenient to have a "dummy regulator" that simply
accepted any change because ultimately Linux doesn't have direct control
of the voltages but simply requests a particular operating frequency via
the mailbox.

> I guess at the minute the code is assuming that if you can't vary the
> regulator it's fixed at the maximum voltage and that it's safe to run at
> a lower clock with a higher voltage (some devices don't like doing that).

No - at the moment if the regulator reports an error then the function
bails out and doesn't change the frequency.

> If the device always starts up at full speed I guess that's OK.  It's
> certainly in general a bad idea to do this in general, we can't tell how
> important it is to the consumer that they actually get the voltage that
> they asked for - for some applications like this it's just adding to the
> power saving it's likely fine but for others it might break things.

Agreed.

> If you're happy to change the frequency without the ability to vary the
> voltage you can query what's supported through the API (the simplest
> interface is regulator_is_supported_voltage()).  You should do the
> regulator API queries at initialization time since they can be a bit
> expensive, the usual pattern would be to go through your OPP table and
> disable states where you can't support the voltage but you *could* also
> flag states where you just don't set the voltage.  That seems especially
> reasonable if no voltages in the range the device supports can be set.
> 
> I do note that the current code requires exactly specified voltages with
> no variation which doesn't match the behaviour you say you're OK with
> here, what you're describing sounds like the driver should be specifying
> a voltage range from the hardware specified maximum down to whatever the
> minimum the OPP supports rather than exactly the OPP voltage.  As things
> are you might also run into voltages that can't be hit exactly (eg, in
> the Exynos 5433 case in mainline a regulator that only offers steps of
> 2mV will error out trying to set several of the OPPs).

Perhaps there's a better way of doing devfreq? Panfrost itself doesn't
really care must about this - we just need to be able to scaling up/down
the operating point depending on load.

On many platforms to set the frequency it's necessary to do the dance to
set an appropriate voltage before/afterwards, but on the Hikey960
because this is handled via a mailbox we don't actually have a regulator
to set the voltage on. My commit[1] supports this by simply not listing
the regulator in the DT and assuming that nothing is needed when
switching frequency. I'm happy for some other way of handling this if
there's a better method.

At the moment your change from devm_regulator_get_optional() to
devm_regulator_get() is a regression on this platform because it means
there is now a dummy regulator which will always fail the
regulator_set_voltage() calls preventing frequency changes. And I can't
see anything I can do in the DT to fix that.

Steve

[1] e21dd290881b drm/panfrost: Enable devfreq to work without regulator
(plus bug fix in 52282163dfa6)
