Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F34C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA70E218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfJJRVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:21:02 -0400
Received: from foss.arm.com ([217.140.110.172]:36516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfJJRVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:21:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E859828;
        Thu, 10 Oct 2019 10:21:01 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF9F93F71A;
        Thu, 10 Oct 2019 10:21:00 -0700 (PDT)
Date:   Thu, 10 Oct 2019 18:20:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     will@kernel.org, maz@kernel.org, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/4] arm64: add support for the AMU extension v1
Message-ID: <20191010172058.GD40923@arrakis.emea.arm.com>
References: <20190917134228.5369-1-ionela.voinescu@arm.com>
 <20190917134228.5369-2-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917134228.5369-2-ionela.voinescu@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ionela,

On Tue, Sep 17, 2019 at 02:42:25PM +0100, Ionela Voinescu wrote:
> +#ifdef CONFIG_ARM64_AMU_EXTN
> +
> +/*
> + * This per cpu variable only signals that the CPU implementation supports the
> + * AMU but does not provide information regarding all the events that it
> + * supports.
> + * When this amu_feat per CPU variable is true, the user of this feature can
> + * only rely on the presence of the 4 fixed counters. But this does not
> + * guarantee that the counters are enabled or access to these counters is
> + * provided by code executed at higher exception levels.
> + */
> +DEFINE_PER_CPU(bool, amu_feat) = false;
> +
> +static void cpu_amu_enable(struct arm64_cpu_capabilities const *cap)
> +{
> +	if (has_cpuid_feature(cap, SCOPE_LOCAL_CPU)) {
> +		pr_info("detected CPU%d: Activity Monitors extension\n",
> +			smp_processor_id());
> +		this_cpu_write(amu_feat, true);
> +	}
> +}

Sorry if I missed anything as I just skimmed through this series. I
can't see the amu_feat used anywhere in these patches, so on its own it
doesn't make much sense.

I also can't see the advantage of allowing mismatched CPU
implementations for this feature. What's the intended use-case?

Thanks.

-- 
Catalin
