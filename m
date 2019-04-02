Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361BDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F403C2084C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 08:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfDBIlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 04:41:00 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58013 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbfDBIlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 04:41:00 -0400
Received: from 79.184.254.219.ipv4.supernova.orange.pl (79.184.254.219) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 3138d2579266a92a; Tue, 2 Apr 2019 10:40:57 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Erwan Velu <e.velu@criteo.com>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq/intel_pstate: Load only on Intel hardware
Date:   Tue, 02 Apr 2019 10:38:52 +0200
Message-ID: <1751498.6LRAoAyAK1@aspire.rjw.lan>
In-Reply-To: <20190401150345.GJ28264@zn.tnic>
References: <20190330100225.14744-1-bp@alien8.de> <20190401083902.GC28264@zn.tnic> <20190401150345.GJ28264@zn.tnic>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, April 1, 2019 5:03:45 PM CEST Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> This driver is Intel-only so loading on anything which is not Intel is
> pointless. Prevent it from doing so.
> 
> While at it, correct the "not supported" print statement to say CPU
> "model" which is what that test does.
> 
> Suggested-by: Erwan Velu <e.velu@criteo.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/intel_pstate.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index b599c7318aab..2986119dd31f 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2596,6 +2596,9 @@ static int __init intel_pstate_init(void)
>  	const struct x86_cpu_id *id;
>  	int rc;
>  
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +		return -ENODEV;
> +
>  	if (no_load)
>  		return -ENODEV;
>  
> @@ -2611,7 +2614,7 @@ static int __init intel_pstate_init(void)
>  	} else {
>  		id = x86_match_cpu(intel_pstate_cpu_ids);
>  		if (!id) {
> -			pr_info("CPU ID not supported\n");
> +			pr_info("CPU model not supported\n");
>  			return -ENODEV;
>  		}
>  
> 

Applied, thanks!

