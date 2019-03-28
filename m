Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABCEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AFC20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfC1Rmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:42:49 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49278 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbfC1Rmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:42:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B00B380D;
        Thu, 28 Mar 2019 10:42:48 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AD313F557;
        Thu, 28 Mar 2019 10:42:46 -0700 (PDT)
Date:   Thu, 28 Mar 2019 17:42:36 +0000
From:   Quentin Perret <quentin.perret@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] arm64: defconfig: Enable CONFIG_ENERGY_MODEL
Message-ID: <20190328174233.jthsdzxrzmzpjnqd@queper01-lin>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-2-quentin.perret@arm.com>
 <20190328102206.doqj5fykqlld7jkd@queper01-lin>
 <f5c699d6-f8f8-ab53-2835-329ae2bd8202@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5c699d6-f8f8-ab53-2835-329ae2bd8202@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thursday 28 Mar 2019 at 18:27:49 (+0100), Daniel Lezcano wrote:
> On 28/03/2019 11:22, Quentin Perret wrote:
> >> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> >> index 2d9c39033c1a..3c09bdaaefd3 100644
> >> --- a/arch/arm64/configs/defconfig
> >> +++ b/arch/arm64/configs/defconfig
> >> @@ -97,6 +97,7 @@ CONFIG_XEN=y
> >>  CONFIG_COMPAT=y
> >>  CONFIG_HIBERNATION=y
> >>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=y
> >> +CONFIG_ENERGY_MODEL=n
> > 
> > Hmm, sorry I turned this to '=n' for testing and forgot to update the
> > patch. This obviously should be '=y' ...
> 
> I did a test without the ENERGY_MODEL config option set, dhrystone and
> the power_allocator policy on the hikey. The board did not mitigate well
> and ended up rebooting.

OK ... And is the same thing happening if you just run mainline w/o the
dynamic-power-coefficient binding set for example ? The result _should_
be the same. If not, then perhaps I missed something. I'll try to
reproduce on my end. Just to be sure, when you say hikey, you mean
hikey960 ? Or 620 ? In any case, thanks for testing :-)

> May be the cpu cooling Kconfig option should add
> a SELECT or a DEPENDS on ENERGY_MODEL ?

Right, I've been wondering the same thing. I'm not a big fan of 'select'
because enabling ENERGY_MODEL automatically for the thermal stuff will
also happen to enable other things (EAS) without the user knowing. So
I'd rather keep the ENERGY_MODEL option explicit.

But perhaps having THERMAL_GOV_POWER_ALLOCATOR 'depend on ENERGY_MODEL'
could work. It's just that there is no _strong_ dependency, the IPA code
isn't supposed to crash even if there is no EM ...

Thanks,
Quentin
