Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F12C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2355520830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbfDJKgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:36:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51604 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfDJKgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:36:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E26A15AB;
        Wed, 10 Apr 2019 03:36:53 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D73893F59C;
        Wed, 10 Apr 2019 03:36:50 -0700 (PDT)
Date:   Wed, 10 Apr 2019 11:36:45 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com,
        catalin.marinas@arm.com, daniel.lezcano@linaro.org,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] thermal: cpu_cooling: Migrate to using the EM
 framework
Message-ID: <20190410103642.gopsoixrpc4nfuxz@queper01-lin>
References: <20190328101352.25657-1-quentin.perret@arm.com>
 <20190328101352.25657-4-quentin.perret@arm.com>
 <20190410054449.zwmemg7vza557gue@vireshk-i7>
 <20190410085702.nll6spd565oio3ds@queper01-lin>
 <20190410101423.3pl6yfhv2wnxuwgw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410101423.3pl6yfhv2wnxuwgw@vireshk-i7>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Apr 2019 at 15:44:23 (+0530), Viresh Kumar wrote:
> On 10-04-19, 09:57, Quentin Perret wrote:
> > Hmm, indeed... I thought cpufreq_table_validate_and_sort() was actively
> > sorting the table but it seems I was wrong.
> > 
> > But I _think_ in practice the freq table actually happens to be sorted
> > for the upstream cpufreq drivers with the CPUFREQ_IS_COOLING_DEV flag
> > set. Most of them use dev_pm_opp_init_cpufreq_table() which guarantees
> > the table is sorted and qoriq-cpufreq explicitly sorts the table. But
> > I'm not sure about qcom-cpufreq-hw ...
> > 
> > So, if the above is true, perhaps I could simply add a check to mandate
> > that policy->freq_table_sorted != CPUFREQ_TABLE_SORTED_UNSORTED for
> > cpu_cooling ? That shouldn't harm the existing users.
> 
> Right, I think most of the platforms will have it sorted anyway right now, but
> you never know if one or two of them don't. Maybe just add the above conditional
> and put out an error or WARN or something, so people know that something broke.

Right, WARN + bail out should do it. I'll do the change in v2.

Thanks !
Quentin
