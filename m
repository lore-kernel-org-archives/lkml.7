Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C31C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7CB20700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 07:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfDEH2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 03:28:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:2350 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbfDEH2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 03:28:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 00:28:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,310,1549958400"; 
   d="scan'208";a="137790181"
Received: from raj-desk2.iind.intel.com ([10.223.107.30])
  by fmsmga008.fm.intel.com with ESMTP; 05 Apr 2019 00:28:16 -0700
Date:   Fri, 5 Apr 2019 12:44:55 +0530
From:   Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To:     Evan Green <evgreen@chromium.org>
Cc:     Rajat Jain <rajatja@google.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Report slp_s0 residency
 range
Message-ID: <20190405071455.GA30194@raj-desk2.iind.intel.com>
References: <20190401180505.6621-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401180505.6621-1-evgreen@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 11:05:04AM -0700, Evan Green wrote:
> The PMC driver performs a 32-bit read on the sleep s0 residency counter,
> followed by a hard-coded multiplication to convert into microseconds.
> The maximum value this counter could have would be 0xffffffff*0x64
> microseconds, which by my calculations is about 4.9 days. This is well
> within a reasonable time period to observe an overflow.
> 
> Usermode consumers watching slp_s0_residency_usec need to be aware of
> overflows, but have no idea what the maximum value of this counter is,
> given the hardcoded multiply of a 32-bit value by
> SPT_PMC_SLP_S0_RES_COUNTER_STEP.

This register is a 32 bit register untill ICL generation and a recent patch
from Rajat fixed the overflow https://patchwork.kernel.org/patch/10816103/
already so i am not sure how this will help userspace. I think the userspace
can still take care of any overflow concerns based on the information
available about this register in EDS so i feel exposing a new debugfs entry
just for the sake of knowing range is probably not needed.

> 
> Expose a slp_s0_residency_usec_range to usermode as well, which returns
> the maximum value this counter could have. Consumers can use this to
> manage rollovers.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> 
> ---
> 
> Note: I also looked at a similar bit of functionality in
> intel_pmc_s0ix_counter_read(), but noticed it's doing a 64-bit register
> access. Is the counter being read here in pmc_core_dev_state_get()
> (weird name btw) actually 64-bits long? If so, we can abandon this change
> and just create a fix to return the full extended value.
> 
> ---
>  drivers/platform/x86/intel_pmc_core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index f2c621b55f49..bec54be9be93 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -396,6 +396,14 @@ static int pmc_core_dev_state_get(void *data, u64 *val)
>  
>  DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_dev_state, pmc_core_dev_state_get, NULL, "%llu\n");
>  
> +static int pmc_core_slp_s0_range_get(void *data, u64 *val)
> +{
> +	*val = pmc_core_adjust_slp_s0_step(0xffffffff);
> +	return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(pmc_core_slp_s0_range, pmc_core_slp_s0_range_get, NULL, "%llu\n");
> +
>  static int pmc_core_check_read_lock_bit(void)
>  {
>  	struct pmc_dev *pmcdev = &pmc;
> @@ -764,6 +772,9 @@ static int pmc_core_dbgfs_register(struct pmc_dev *pmcdev)
>  	debugfs_create_file("slp_s0_residency_usec", 0444, dir, pmcdev,
>  			    &pmc_core_dev_state);
>  
> +	debugfs_create_file("slp_s0_residency_usec_range", 0444, dir, pmcdev,
> +			    &pmc_core_slp_s0_range);
> +
>  	debugfs_create_file("pch_ip_power_gating_status", 0444, dir, pmcdev,
>  			    &pmc_core_ppfear_fops);
>  
> -- 
> 2.20.1
> 

-- 
Best Regards,
Rajneesh
