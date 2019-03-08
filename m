Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C77AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAEE02133F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbfCHNRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:17:32 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59192 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfCHNRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 08:17:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8DDF80D;
        Fri,  8 Mar 2019 05:17:31 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E84E33F71D;
        Fri,  8 Mar 2019 05:17:29 -0800 (PST)
Date:   Fri, 8 Mar 2019 13:17:23 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Message-ID: <20190308131723.GA30600@e107981-ln.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com>
 <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
 <20190306181519.GA3355@e107981-ln.cambridge.arm.com>
 <CAPDyKFrbu4rFyohv+YJkG7O03_r3+3gn1vib_FJUW0t-4REgTw@mail.gmail.com>
 <20190308114943.GA27731@e107981-ln.cambridge.arm.com>
 <CAPDyKFry_ZQXA-bj6gA8npdqkMmg8AUOZ+Kr4mnOaS8=xZ+MwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFry_ZQXA-bj6gA8npdqkMmg8AUOZ+Kr4mnOaS8=xZ+MwA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 08, 2019 at 02:07:51PM +0100, Ulf Hansson wrote:
> On Fri, 8 Mar 2019 at 12:49, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> >
> > On Fri, Mar 08, 2019 at 11:36:49AM +0100, Ulf Hansson wrote:
> >
> > [...]
> >
> > > Instead, my suggestion is according to what I propose in patch 4 and
> > > $subject patch, which means minor adjustments to be able to pass the
> > > struct cpuidle_driver * to the init functions. This, I need it for
> > > next steps, but already at this point it improves things as it avoids
> > > some of the OF parsing, and that's good, isn't it?
> >
> > I will take the patches Mark ACKed and send them for v5.2 as
> > early as it gets in v5.1-rc* cycle.
> 
> Actually, may I suggest we funnel these through Rafael's tree, unless
> you are expecting other PSCI changes for v.5.2, which could cause
> conflicts?
> 
> The reason is, other PM core changes, to genpd for example, needs to
> go via Rafael's tree. Those would then potentially block us for
> applying any other changes to your tree (arm-soc?) for PSCI (as there
> is dependency) until v5.3.
> 
> How about if you provides your explicit acks for those PSCI changes
> your are happy with, then Rafael can pick them?

It is fine we can do that, I would have not sent the patches Mark
has ACKed to arm-soc till -{rc2/rc3} anyway.

Thanks,
Lorenzo

> > For this one maybe you can post the changes on top and see what's
> > the best way forward ?
> >
> > I agree that duplicating idle state parsing code across back-ends
> > is silly - we just want to keep PSCI and kernel data structure
> > decoupled.
> 
> Right. Let's continue this discussion later on and move forward here.
> Make sense.
> 
> >
> > Post the code on top and we will find a way forward, OK ?
> 
> Sure, let me do that.
> 
> Thanks and kind regards
> Uffe
