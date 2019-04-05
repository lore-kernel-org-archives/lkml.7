Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B69C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C40B217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730724AbfDEKK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:10:28 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45220 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730283AbfDEKK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:10:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA171168F;
        Fri,  5 Apr 2019 03:10:27 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 815FA3F721;
        Fri,  5 Apr 2019 03:10:25 -0700 (PDT)
Date:   Fri, 5 Apr 2019 11:10:22 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <marc.zyngier@arm.com>, <suzuki.poulose@arm.com>,
        <Dave.Martin@arm.com>, <shankerd@codeaurora.org>,
        <julien.thierry@arm.com>, <mlangsdo@redhat.com>,
        <stefan.wahren@i2e.com>, <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v6 09/10] arm64: add sysfs vulnerability show for
 speculative store bypass
Message-ID: <20190405111022.6ef0b7bb@donnerap.cambridge.arm.com>
In-Reply-To: <20190403165005.GA17500@fuggles.cambridge.arm.com>
References: <20190321230557.45107-1-jeremy.linton@arm.com>
        <20190321230557.45107-10-jeremy.linton@arm.com>
        <20190403165005.GA17500@fuggles.cambridge.arm.com>
Organization: ARM
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019 17:50:05 +0100
Will Deacon <will.deacon@arm.com> wrote:

> Hi Jeremy,
> 
> On Thu, Mar 21, 2019 at 06:05:56PM -0500, Jeremy Linton wrote:
> > Return status based on ssbd_state and the arm64 SSBS feature. If
> > the mitigation is disabled, or the firmware isn't responding then
> > return the expected machine state based on a new blacklist of known
> > vulnerable cores.
> > 
> > Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> > Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >  arch/arm64/kernel/cpu_errata.c | 44 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> > index 6958dcdabf7d..172ffbabd597 100644
> > --- a/arch/arm64/kernel/cpu_errata.c
> > +++ b/arch/arm64/kernel/cpu_errata.c
> > @@ -278,6 +278,7 @@ static int detect_harden_bp_fw(void)
> >  DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
> >  
> >  int ssbd_state __read_mostly = ARM64_SSBD_KERNEL;
> > +static bool __ssb_safe = true;
> >  
> >  static const struct ssbd_options {
> >  	const char	*str;
> > @@ -386,6 +387,9 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
> >  
> >  	WARN_ON(scope != SCOPE_LOCAL_CPU || preemptible());
> >  
> > +	if (is_midr_in_range_list(read_cpuid_id(), entry->midr_range_list))
> > +		__ssb_safe = false;
> > +  
> 
> Does this mean that we assume that CPUs not present in our table are not
> affected by speculative store bypass?

No, not affected are only those where we either have SSBS or the firmware
explicitly returns SMCCC_RET_NOT_REQUIRED. This is governed by ssbd_state.
So this doesn't affect correctness.

__ssb_safe is an additional state just used for the sysfs output. But
indeed it looks like this is wrong if the CPU is both not listed and the
system doesn't provide the firmware interface: AFAICS we would report "Not
affected" in this case.

> I don't think that's a good
> assumption, because we don't necessary have knowledge about partner or
> future CPU implementations, so I think any CPU lists really have to be
> whitelists like they are for the other vulnerabilities.

I think the idea was to cover all those "legacy" systems which have
older cores (no SSBS), but didn't get an firmware update. So your old Seattle
would truthfully report "Vulnerable", but any random A53 device would
report "Not affected", even with ancient firmware.

Cheers,
Andre.

> >  	if (this_cpu_has_cap(ARM64_SSBS)) {
> >  		required = false;
> >  		goto out_printmsg;
> > @@ -419,12 +423,14 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
> >  		ssbd_state = ARM64_SSBD_UNKNOWN;
> >  		return false;
> >  
> > +	/* machines with mixed mitigation requirements must not return this */
> >  	case SMCCC_RET_NOT_REQUIRED:
> >  		pr_info_once("%s mitigation not required\n", entry->desc);
> >  		ssbd_state = ARM64_SSBD_MITIGATED;
> >  		return false;
> >  
> >  	case SMCCC_RET_SUCCESS:
> > +		__ssb_safe = false;
> >  		required = true;
> >  		break;
> >  
> > @@ -474,6 +480,16 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
> >  	return required;
> >  }
> >  
> > +/* known vulnerable cores */
> > +static const struct midr_range arm64_ssb_cpus[] = {
> > +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A57),
> > +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A72),
> > +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A73),
> > +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A75),
> > +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
> > +	{},
> > +};
> > +
> >  static void __maybe_unused
> >  cpu_enable_cache_maint_trap(const struct arm64_cpu_capabilities *__unused)
> >  {
> > @@ -769,6 +785,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
> >  		.capability = ARM64_SSBD,
> >  		.type = ARM64_CPUCAP_LOCAL_CPU_ERRATUM,
> >  		.matches = has_ssbd_mitigation,
> > +		.midr_range_list = arm64_ssb_cpus,
> >  	},
> >  #ifdef CONFIG_ARM64_ERRATUM_1188873
> >  	{
> > @@ -807,3 +824,30 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr,
> >  
> >  	return sprintf(buf, "Vulnerable\n");
> >  }
> > +
> > +ssize_t cpu_show_spec_store_bypass(struct device *dev,
> > +		struct device_attribute *attr, char *buf)
> > +{
> > +	/*
> > +	 *  Two assumptions: First, ssbd_state reflects the worse case
> > +	 *  for heterogeneous machines, and that if SSBS is supported its
> > +	 *  supported by all cores.
> > +	 */
> > +	switch (ssbd_state) {
> > +	case ARM64_SSBD_MITIGATED:
> > +		return sprintf(buf, "Not affected\n");
> > +
> > +	case ARM64_SSBD_KERNEL:
> > +	case ARM64_SSBD_FORCE_ENABLE:
> > +		if (cpus_have_cap(ARM64_SSBS))
> > +			return sprintf(buf, "Not affected\n");
> > +		if (IS_ENABLED(CONFIG_ARM64_SSBD))
> > +			return sprintf(buf,
> > +			    "Mitigation: Speculative Store Bypass disabled\n");  
> 
> x86 has a message about the prctl(), which we also support.
> 
> Will

