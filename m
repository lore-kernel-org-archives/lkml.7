Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B32C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF432184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 10:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563530548;
	bh=KvPLM1GNe5tFVjsJpLtAS+Cc5JSEL3ozQZTgGhM2Zj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cisfm9ExuzRRPwrmc9k3+2R8ZcV3hK6hf2czwUbN18ndJAWn2F8uwUS9HgPJ56hYo
	 ZMvRCH6kzJjgJNBGZGjiTLKJckb5V4CEdbeaJFUKNHjx20FS8zdvMBQ92HjfQOqLtu
	 9pxPD2mo+HS5aNdDD3Wpmutu1QbzLnxLdYhh2nOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfGSKC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 06:02:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbfGSKC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 06:02:26 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF302173B;
        Fri, 19 Jul 2019 10:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563530545;
        bh=KvPLM1GNe5tFVjsJpLtAS+Cc5JSEL3ozQZTgGhM2Zj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ngDBnyyvbzeDdeqaWe1yYZ14j969anbfifz4sULg2Y/9mfJfcN2ruBIKYgfHGrwXv
         RK6jQPeP2tF0RC6ZW5ZWHe7piD8IkfoGr1N8FVpUiEllxkKqG6jvPfz5Eo+0qxU4FW
         pwk+O2cge3NeLPhjy9rKqiqtFbFtbFxsxPikY1Nw=
Date:   Fri, 19 Jul 2019 11:02:20 +0100
From:   Will Deacon <will@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        Frank Li <frank.li@nxp.com>, dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Subject: Re: [PATCH] perf tool: arch: arm64: change the way for
 get_cpuid_str() function
Message-ID: <20190719100219.b3bbrv4t4qcv2gid@willie-the-truck>
References: <20190718061853.10403-1-qiangqing.zhang@nxp.com>
 <20190719075450.xcm4i4a5sfaxlfap@willie-the-truck>
 <DB7PR04MB4618EE69C2D8A664660C19C4E6CB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB7PR04MB4618EE69C2D8A664660C19C4E6CB0@DB7PR04MB4618.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 08:29:12AM +0000, Joakim Zhang wrote:
> > On Thu, Jul 18, 2019 at 06:21:30AM +0000, Joakim Zhang wrote:
> > > Now the get_cpuid__str function returns the MIDR string of the first
> > > online cpu from the range of cpus asscociated with the PMU CORE device.
> > >
> > > It can work when pass a perf_pmu entity to get_cpuid_str. However, it
> > > will pass NULL via perf_pmu__find_map from metricgroup.c if we want to
> > > add metric group for arm64. When pass NULL to get_cpuid_str, it can't
> > > return the MIDR string.
> > 
> > Why is this code passing a NULL PMU? What information does it actually need?
> > Other functions, such as print_pmu_events(), iterate over all PMUs.
> 
> tools/perf/utils/metricgroup.c:
> metricgroup__add_metric()/metricgroup__has_metric()/metricgroup__print()---->perf_pmu__find_map(NULL)------>perf_pmu__getcpuid(NULL)----->get_cpuid_str(NULL)
> So, it will eventually pass NULL to get_cpuid_str() function for arm64, and now get_cpuid_str() for arm64 need *struct perf_pmu* entity to return MIDR string.
> 
> And the declaration for get_cpuid_str() is char *get_cpuid_str(struct perf_pmu *pmu __maybe_unused) in tools/perf/utils/header.h file.
> So, it can return MIDR string without passing *struct perf_pmu* entity. Arch PowerPC/x86/s390 which implement metricgroup all add __maybe_unused.
> 
> > > There are three methods from userspace getting MIDR string for arm64:
> > > 1. parse
> > > sysfs(/sys/devices/system/cpu/cpu?/regs/identification/midr_el1)
> > > 2. parse procfs(/proc/cpuinfo)
> > > 3. read the hwcaps(MIDR register) with getauxval(AT_HWCAP)
> > >
> > > Perfer to select #3 as it is more simple and direct.
> > 
> > That's probably terminally broken for heterogeneous systems, so I'm not at all
> > happy with this patch.
> 
> The implement of get_cpuid_str() for arm64 now only can return the MIDR
> string of the first online cpu. I think it is also broken for
> heterogeneous systems.

I disagree: the current code returns the MIDR string for the first online
CPU *corresponding to the PMU* (e.g. pmu->cpus) and therefore handles
heterogeneous systems like that.

> Will, do you know how to fix this issue more reasonable?

I still don't know what the metricgroup coce is trying to achieve, but my
previous suggestion about looking at print_pmu_events() is probably still a
good place to start.

Will
