Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9910C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E7C206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553508081;
	bh=e57cBwNVhCgPqAuRAEZbgEhNU0b8epobT2WJnce8xBU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RYUOKX3cqLvu/VsdzxU/puMGWHfwraGHGG7LB6MTJTeTC3trZAE0va8CzZkVd/xsW
	 zw+BlLC9Dbvb49SoJAtxRd27D6z+J9NxBXgmp2Naepl50dYiZiR+EoHOg9iJr5LqwO
	 0H2Y6aF0tLF5l/OtWMKMeumRlhr8uvSO1b9H0LXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbfCYKBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:01:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39358 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729912AbfCYKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:01:19 -0400
Received: by mail-ot1-f67.google.com with SMTP id f10so7444750otb.6;
        Mon, 25 Mar 2019 03:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3mZCdUMQ/EmpArie8AgSdBX+Pv8ZoaXYZbo9SgN/d8c=;
        b=FD0qOWIraQzp18uUKRlRfxUmWw4htKceKuvx7pYGzIbToxWdNoLB11gm0P68RN0Er2
         x6B6cCgbac2IIhch3erg2BUKLU+z+hOlLv1Pi2wDheuJjacMBg4oyS+vueSNB2yxuulE
         DaWobUx8RvtH6Uu9cBZ4OIuKvIaPNTbfbbbpdXyV1FHzyvjpfTd8J3PNVZSPcuWyi9TU
         W9ReuaAK24cpzA7ASRVMjE6Q3uYddx6enz3KnRNmBWOUjyCs8gFjv+7roxapd2Yt4R1C
         xIrRPXNQTupxQNMINlco6MyF2YkLe3UQLFxt/cCJ+zeJ1e4YumGMXjdOIWpkFLGdFo0r
         4C9w==
X-Gm-Message-State: APjAAAUuZqEvCBdQO8kRPoCMhrKTsFetZT9Mnch+nB+nDCt9stplbR1q
        bTafkTOoCs+Fd9fbbv2doVqwy/W9PGucyTuD37k=
X-Google-Smtp-Source: APXvYqykbUAQycL4J2KrCkI3meP39CZXXlE7zDksjkpwSu8UmKp75Xgu5SSBLoa/3aLh6eCqIrXvHV7CiwRqFVzrgZ4=
X-Received: by 2002:a9d:36a:: with SMTP id 97mr16259753otv.124.1553508079246;
 Mon, 25 Mar 2019 03:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <1637073.gl2OfxWTjI@aspire.rjw.lan> <1762575.ER2xjzr9E1@aspire.rjw.lan>
 <20190322144629.GC12472@zn.tnic>
In-Reply-To: <20190322144629.GC12472@zn.tnic>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Mar 2019 11:01:08 +0100
Message-ID: <CAJZ5v0iML0dvzLszSnZjBPKc=2fWp4aUxEjAYWjJnz41Kz8w1g@mail.gmail.com>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs interface
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Laura Abbott <labbott@fedoraproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Simon Schricker <sschricker@suse.de>,
        Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 3:46 PM Borislav Petkov <bp@alien8.de> wrote:
>
> First of all, thanks a lot for doing that!
>
> This is a good example for how we should convert all the /dev/msr
> accessing tools.
>
> Nitpicks below.
>
> On Thu, Mar 21, 2019 at 11:20:17PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The Performance and Energy Bias Hint (EPB) is expected to be set by
> > user space through the generic MSR interface, but that interface is
> > not particularly nice and there are security concerns regarding it,
> > so it is not always available.
> >
> > For this reason, add a sysfs interface for reading and updating the
> > EPB, in the form of a new attribute, energy_perf_bias, located
> > under /sys/devices/system/cpu/cpu#/power/ for online CPUs that
> > support the EPB feature.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/ABI/testing/sysfs-devices-system-cpu |   18 ++++
> >  Documentation/admin-guide/pm/intel_epb.rst         |   27 ++++++
> >  arch/x86/kernel/cpu/intel_epb.c                    |   93 ++++++++++++++++++++-
> >  3 files changed, 134 insertions(+), 4 deletions(-)
>
> ...
>
> > +static ssize_t energy_perf_bias_show(struct device *dev,
> > +                                  struct device_attribute *attr,
> > +                                  char *buf)
> > +{
> > +     unsigned int cpu = dev->id;
> > +     u64 epb;
> > +     int ret;
> > +
> > +     ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
>
> That's an IPI and an MSR read each time. You could dump saved_epb
> instead, no?

No, because the MSR can change in ways beyond control of this code sometimes.

Generally, saved_epb only is the right value at the CPU online time.

> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return sprintf(buf, "%llu\n", epb);
> > +}
> > +
> > +static ssize_t energy_perf_bias_store(struct device *dev,
> > +                                   struct device_attribute *attr,
> > +                                   const char *buf, size_t count)
> > +{
> > +     unsigned int cpu = dev->id;
> > +     u64 epb, val;
> > +     int ret;
> > +
> > +     ret = __sysfs_match_string(energy_perf_strings,
> > +                                ARRAY_SIZE(energy_perf_strings), buf);
> > +     if (ret >= 0)
> > +             val = energ_perf_values[ret];
> > +     else if (kstrtou64(buf, 0, &val) || val > MAX_EPB)
>
> Range is 0 - 15 but u64? Maybe make it an u8? :)

At the cost of an extra conversion below, right?

> > +             return -EINVAL;
> > +
> > +     ret = rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     ret = wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
> > +                         (epb & ~EPB_MASK) | val);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return count;
> > +}
>
> --
