Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F671C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCE82085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BD/yLuGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfCYLbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:31:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38842 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbfCYLbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:31:21 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F05941EC0987;
        Mon, 25 Mar 2019 12:31:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553513480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zPNHNJzzrCYQq1d7EtTW+RAp59xLlj7afJzzPP5UHlo=;
        b=BD/yLuGIu/jeF711f70oitT8LxEsLIwixeWvWeaRTRLZLH62qaj0wnaWcAVrN2rCIG1Aot
        T5Yr5OaHm3HpiwD4xVcjKPmzsuxbkdFZk1hXgRLHXfj/6fgQp9slHis0CKwcbh38SkL79d
        Iv+mwcDf/B3sXoMypAGz6YSdJ5Fi7T4=
Date:   Mon, 25 Mar 2019 12:31:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/2] PM / arch: x86: Rework the MSR_IA32_ENERGY_PERF_BIAS
 handling
Message-ID: <20190325113123.GF12016@zn.tnic>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1605148.8jT99SsvVP@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1605148.8jT99SsvVP@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 11:18:01PM +0100, Rafael J. Wysocki wrote:
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

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
