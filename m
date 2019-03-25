Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6BD2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="imDCoyYX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbfCYLcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:32:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39086 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730941AbfCYLcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:32:13 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6B8631EC0987;
        Mon, 25 Mar 2019 12:32:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553513531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=icjgNOxhSK7v2Qt5wjRjWd2TnLg47U6UOFug1LLmZLs=;
        b=imDCoyYXxeRKemi6HbwA7yC1YTf2ARER1dDiOf7pz+yidXPFvRfoNFkAsdg73m1HLs6lP9
        VfYLQ3APczUURTo79q7YRLaP4K5QwIkDL0wrxB9X1HB89aXDHL7K9SmsCNhRoRR01Fg1qm
        RexQoUbjpXj/yxZ1ORuhpR0vZ292I7M=
Date:   Mon, 25 Mar 2019 12:32:18 +0100
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
        Borislav Petkov <bp@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 2/2] PM / arch: x86: MSR_IA32_ENERGY_PERF_BIAS sysfs
 interface
Message-ID: <20190325113218.GG12016@zn.tnic>
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

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
