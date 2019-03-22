Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0273C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7BB20883
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dp9Vj9kb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfCVOqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:46:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40226 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728893AbfCVOqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:46:42 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 676391EC00FF;
        Fri, 22 Mar 2019 15:46:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553266000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tmxLRF1Y9/DbOv0CBMVmJCNfE0FVRQ95SjbrO328xWE=;
        b=dp9Vj9kb1oiRDMDHL9n9Ez0W+8xfN9TYjWLBQUig7xuqQJd/aDd8U7J05hyWX5LvwzZxHz
        6G1j6MSppcxGMZ56kFCxrSIVU3zCVMemvW7E9yo4wkna2CjDUS+7a6t3PS0h5YeabZZzV+
        veyDszSFIy6zslrRyXvYRLMAZgdEJ18=
Date:   Fri, 22 Mar 2019 15:46:43 +0100
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
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
 interface
Message-ID: <20190322144629.GC12472@zn.tnic>
References: <1637073.gl2OfxWTjI@aspire.rjw.lan>
 <1762575.ER2xjzr9E1@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1762575.ER2xjzr9E1@aspire.rjw.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, thanks a lot for doing that!

This is a good example for how we should convert all the /dev/msr
accessing tools.

Nitpicks below.

On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The Performance and Energy Bias Hint (EPB) is expected to be set by
> user space through the generic MSR interface, but that interface is
> not particularly nice and there are security concerns regarding it,
> so it is not always available.
> 
> For this reason, add a sysfs interface for reading and updating the
> EPB, in the form of a new attribute, energy_perf_bias, located
> under /sys/devices/system/cpu/cpu#/power/ for online CPUs that
> support the EPB feature.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-system-cpu |   18 ++++
>  Documentation/admin-guide/pm/intel_epb.rst         |   27 ++++++
>  arch/x86/kernel/cpu/intel_epb.c                    |   93 ++++++++++++++++++++-
>  3 files changed, 134 insertions(+), 4 deletions(-)

...

> +static ssize_t energy_perf_bias_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	unsigned int cpu = dev->id;
> +	u64 epb;
> +	int ret;
> +
> +	ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);

That's an IPI and an MSR read each time. You could dump saved_epb
instead, no?

> +	if (ret < 0)
> +		return ret;
> +
> +	return sprintf(buf, "%llu\n", epb);
> +}
> +
> +static ssize_t energy_perf_bias_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	unsigned int cpu = dev->id;
> +	u64 epb, val;
> +	int ret;
> +
> +	ret = __sysfs_match_string(energy_perf_strings,
> +				   ARRAY_SIZE(energy_perf_strings), buf);
> +	if (ret >= 0)
> +		val = energ_perf_values[ret];
> +	else if (kstrtou64(buf, 0, &val) || val > MAX_EPB)

Range is 0 - 15 but u64? Maybe make it an u8? :)

> +		return -EINVAL;
> +
> +	ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
> +			    (epb & ~EPB_MASK) | val);
> +	if (ret < 0)
> +		return ret;
> +
> +	return count;
> +}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
