Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E647DCA9EB7
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C656B20663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 09:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbfJWJHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 05:07:24 -0400
Received: from [217.140.110.172] ([217.140.110.172]:45300 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S2390394AbfJWJHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 05:07:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A1D9332;
        Wed, 23 Oct 2019 02:06:54 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97BBD3F718;
        Wed, 23 Oct 2019 02:06:53 -0700 (PDT)
Date:   Wed, 23 Oct 2019 10:06:47 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH] cpufreq: mark duplicate frequencies as invalid and
 continue as normal
Message-ID: <20191023090647.GA29654@bogus>
References: <20191022173215.13350-1-sudeep.holla@arm.com>
 <20191023032608.v7lgqirvpbwgsyz4@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023032608.v7lgqirvpbwgsyz4@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 08:56:08AM +0530, Viresh Kumar wrote:
> On 22-10-19, 18:32, Sudeep Holla wrote:
> > Currently if we encounter duplicate frequency table entries, we abort
> > the validation and return error immediately. Instead of failing, we
> > can mark the entry as invalid and continue to function normal.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/freq_table.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > Hi Viresh,
> >
> > Since commit da0c6dc00c69 ("cpufreq: Handle sorted frequency tables more
> > efficiently"), I seem to have modified the firmware entry on my TC2 to
> > drop 500MHz and had not seen the issue with duplicate entries and had
> > totally forgotten about it.
> >
> > Recently I reverted back to original setting as I corrupted it and
> > started seeing this issues. I don't know the background for raising
> > duplicates as fatal error but we did allow it when we add arm_big_little.c
> > and hence this RFC. If there are known issues with this approach, I can
> > continue with changed firmware config.
> >
> > With switcher, we have:
> > (little cluster)
> > Virt: 175 MHz, 200 MHz, 250 MHz, 300 MHz, 350 MHz, 400 MHz, 450 MHz, 500 MHz
> > Actu: 350 MHz, 400 MHz, 500 MHz, 600 MHz, 700 MHz, 800 MHz, 900 MHz, 1000 MHz
> > (big cluster)
> > 500 MHz, 600 MHz, 700 MHz, 800 MHz, 900 MHz, 1000 MHz, 1.10 GHz, 1.20 GHz
> >
> > with 500 MHz duplicate in merged table.
> >
> > Regards,
> > Sudeep
> >
> > diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
> > index ded427e0a488..e9bf287846d6 100644
> > --- a/drivers/cpufreq/freq_table.c
> > +++ b/drivers/cpufreq/freq_table.c
> > @@ -305,9 +305,10 @@ static int set_freq_table_sorted(struct cpufreq_policy *policy)
> >  		}
> >
> >  		if (pos->frequency == prev->frequency) {
> > -			pr_warn("Duplicate freq-table entries: %u\n",
> > +			pr_warn("Duplicate freq-table entries: %u marking it invalid\n,",
> >  				pos->frequency);
> > -			return -EINVAL;
> > +			pos->frequency = CPUFREQ_ENTRY_INVALID;
> > +			continue;
> >  		}
> >
> >  		/* Frequency increased from prev to pos */
>
> Of course we can do this, but I don't see why we shouldn't force
> people to fix the freq-tables instead.

Agreed. We still have warning :)

> What's the point of allowing people to have duplicate entries instead ?

I agree, we shouldn't. But this is in IKS which is built in the merged
table by the driver. We can fix that, but found this easier and simple.
And since it was allowed when the driver was merged, just thought of
checking the details with you.

> This shouldn't happen with OPP tables as we check for duplicate entries
> there as well.
>

Yes, but OPPs are per cpu cluster and they don't have duplicates in this
case.

--
Regards,
Sudeep
