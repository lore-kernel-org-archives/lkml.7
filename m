Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A87C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9738A25F41
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 18:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfE3SQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 14:16:01 -0400
Received: from mga11.intel.com ([192.55.52.93]:32247 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfE3SQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 14:16:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 11:16:00 -0700
X-ExtLoop1: 1
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.123]) ([10.24.14.123])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2019 11:16:00 -0700
Subject: Re: [PATCH] x86/resctrl: Don't stop walking closids when a locksetup
 group is found
To:     James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Avin <hpa@zytor.com>
References: <20190530155742.84547-1-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <3859c54e-65fb-5760-5092-509b4a4fb6ff@intel.com>
Date:   Thu, 30 May 2019 11:16:00 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190530155742.84547-1-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 5/30/2019 8:57 AM, James Morse wrote:
> When a new control group is created __init_one_rdt_domain() walks all
> the other closids to calculate the sets of used and unused bits.
> 
> If it discovers a pseudo_locksetup group, it breaks out of the loop.
> This means any later closid doesn't get its used bits added to used_b.
> These bits will then get set in unused_b, and added to the new
> control group's configuration, even if they were marked as exclusive
> for a later closid.
> 
> When encountering a pseudo_locksetup group, we should continue. This
> is because "a resource group enters 'pseudo-locked' mode after the
> schemata is written while the resource group is in 'pseudo-locksetup'
> mode." When we find a pseudo_locksetup group, its configuration is
> expected to be overwritten, we can skip it.
> 
> Fixes: dfe9674b04ff6 ("x86/intel_rdt: Enable entering of pseudo-locksetup mode")
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 333c177a2471..049ccb709957 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2541,8 +2541,15 @@ static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
>  	for (i = 0; i < closids_supported(); i++, ctrl++) {
>  		if (closid_allocated(i) && i != closid) {
>  			mode = rdtgroup_mode_by_closid(i);
> -			if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
> -				break;
> +			if (mode == RDT_MODE_PSEUDO_LOCKSETUP) {
> +				/*
> +				 * ctrl values for locksetup aren't relevant
> +				 * until the schemata is written, and the mode
> +				 * becomes RDT_MODE_PSEUDO_LOCKED.
> +				 */
> +				continue;
> +			}
> +
>  			/*
>  			 * If CDP is active include peer domain's
>  			 * usage to ensure there is no overlap
> 

Thank you very much for catching this. The only possible quibbles that
will be guided by the maintainer's style preference are the unnecessary
braces and extra empty line, but this fix is needed. Also, could "Cc:
stable@vger.kernel.org" please be added to the sign-off area?

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette
