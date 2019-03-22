Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8399FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD17218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 09:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfCVJDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 05:03:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:55028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725981AbfCVJDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 05:03:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1ECEAB00B;
        Fri, 22 Mar 2019 09:03:33 +0000 (UTC)
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Borislav Petkov <bp@suse.de>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1605148.8jT99SsvVP@aspire.rjw.lan>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <0754bf38-319e-f1a7-1ae6-fe2de548b882@suse.de>
Date:   Fri, 22 Mar 2019 10:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1605148.8jT99SsvVP@aspire.rjw.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/19 11:18 PM, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The current handling of MSR_IA32_ENERGY_PERF_BIAS in the kernel is
> problematic, because it may cause changes made by user space to that
> MSR (with the help of the x86_energy_perf_policy tool, for example)
> to be lost every time a CPU goes offline and then back online as well
> as during system-wide power management transitions into sleep states
> and back into the working state.
> 
> The first problem is that if the current EPB value for a CPU going
> online is 0 ('performance'), the kernel will change it to 6 ('normal')
> regardless of whether or not this is the first bring-up of that CPU.
> That also happens during system-wide resume from sleep states
> (including, but not limited to, hibernation).  However, the EPB may
> have been adjusted by user space this way and the kernel should not
> blindly override that setting.
> 
> The second problem is that if the platform firmware resets the EPB
> values for any CPUs during system-wide resume from a sleep state,
> the kernel will not restore their previous EPB values that may
> have been set by user space before the preceding system-wide
> suspend transition.  Again, that behavior may at least be confusing
> from the user space perspective.
> 
> In order to address these issues, rework the handling of
> MSR_IA32_ENERGY_PERF_BIAS so that the EPB value is saved on CPU
> offline and restored on CPU online as well as (for the boot CPU)
> during the syscore stages of system-wide suspend and resume
> transitions, respectively.
> 
> However, retain the policy by which the EPB is set to 6 ('normal')
> on the first bring-up of each CPU if its initial value is 0, based
> on the observation that 0 may mean 'not initialized' just as well as
> 'performance' in that case.
> 
> While at it, move the MSR_IA32_ENERGY_PERF_BIAS handling code into
> a separate file and document it in Documentation/admin-guide.
> 
> Fixes: abe48b108247 (x86, intel, power: Initialize MSR_IA32_ENERGY_PERF_BIAS)
> Fixes: b51ef52df71c (x86/cpu: Restore MSR_IA32_ENERGY_PERF_BIAS after resume)
> Reported-by: Thomas Renninger <trenn@suse.de>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
