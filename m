Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F69C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 776022184E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="lEsCIYTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfC1UxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:53:06 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43140 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfC1UxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:53:05 -0400
Received: from zn.tnic (p200300EC2F098000329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:8000:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 241181EC0985;
        Thu, 28 Mar 2019 21:53:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553806383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=smEX/KW7hecQPFiuL1QnBeS5MYgty/UWrmLWl/eibXQ=;
        b=lEsCIYTRpI5Pmdu9B8EmlmRn6kUzKD4kwyimMovp32V8a3kzR8ObiTAOpisaOD9nGAJZIz
        5uHBk0igL2ynQeqMPCqJpdC1Druh15a2ePgu/X8aFO5W9DNJT+PjNE1FKMbsTyYgn/CHj/
        UxzjrVlLujN0SDqOdY82CA68mzjcFWg=
Date:   Thu, 28 Mar 2019 21:53:05 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Phillips, Kim" <kim.phillips@amd.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Natarajan, Janakarajan" <Janakarajan.Natarajan@amd.com>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Pu Wen <puwen@hygon.cn>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/events: add event map for AMD Family 17h
Message-ID: <20190328205305.GR22720@zn.tnic>
References: <20190321211515.20756-1-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190321211515.20756-1-kim.phillips@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:15:22PM +0000, Phillips, Kim wrote:
> From: Kim Phillips <kim.phillips@amd.com>
> 
> Family 17h differs from prior families by:
>  - not supporting an L2 cache miss event
>  - having re-enumerated PMC counters for:
>    - L2 cache references
>    - front & back end stalled cycles
> 
> So we add a new amd_f17h_perfmon_event_map so that the generic
> perf event names will resolve to the correct h/w events on
> family 17h and above processors.
> 
> Reference sections 2.1.13.3.3 (stalls) and 2.1.13.3.6 (L2):
> https://www.amd.com/system/files/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
> 
> Fixes: e40ed1542dd7 ("perf/x86: Add perf support for AMD family-17h processors")
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>
> Cc: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
> Cc: Martin Liška <mliska@suse.cz>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/events/amd/core.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 7d2d7c801dba..764d181afa18 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -127,8 +127,25 @@ static const u64 amd_perfmon_event_map[PERF_COUNT_HW_MAX] =
>    [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x00d1, /* "Dispatch stalls" event */
>  };
>  
> +/*
> + * AMD Performance Monitor Family 17h
> + */
> +static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
> +{
> +  [PERF_COUNT_HW_CPU_CYCLES]			= 0x0076,
> +  [PERF_COUNT_HW_INSTRUCTIONS]			= 0x00c0,
> +  [PERF_COUNT_HW_CACHE_REFERENCES]		= 0xff60,
> +  [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]		= 0x00c2,
> +  [PERF_COUNT_HW_BRANCH_MISSES]			= 0x00c3,
> +  [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]	= 0x0287,
> +  [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]	= 0x0187,
> +};
> +
>  static u64 amd_pmu_event_map(int hw_event)
>  {
> +	if (boot_cpu_data.x86 >= 0x17)
> +		return amd_f17h_perfmon_event_map[hw_event];
> +
>  	return amd_perfmon_event_map[hw_event];
>  }
>  
> --

Your patch has some style problems, see below. Please run it through
checkpatch before submitting.

And yeah, that amd_perfmon_event_map in that file has some wrong
formatting too - preceding whitespace instead of tabs - so you can
submit a cleanup patch ontop to fix that up too.

Thx.

---
ERROR: that open brace { should be on the previous line
#70: FILE: arch/x86/events/amd/core.c:134:
+static const u64 amd_f17h_perfmon_event_map[PERF_COUNT_HW_MAX] =
+{

WARNING: please, no spaces at the start of a line
#71: FILE: arch/x86/events/amd/core.c:135:
+  [PERF_COUNT_HW_CPU_CYCLES]^I^I^I= 0x0076,$

WARNING: please, no spaces at the start of a line
#72: FILE: arch/x86/events/amd/core.c:136:
+  [PERF_COUNT_HW_INSTRUCTIONS]^I^I^I= 0x00c0,$

WARNING: please, no spaces at the start of a line
#73: FILE: arch/x86/events/amd/core.c:137:
+  [PERF_COUNT_HW_CACHE_REFERENCES]^I^I= 0xff60,$

WARNING: please, no spaces at the start of a line
#74: FILE: arch/x86/events/amd/core.c:138:
+  [PERF_COUNT_HW_BRANCH_INSTRUCTIONS]^I^I= 0x00c2,$

WARNING: please, no spaces at the start of a line
#75: FILE: arch/x86/events/amd/core.c:139:
+  [PERF_COUNT_HW_BRANCH_MISSES]^I^I^I= 0x00c3,$

WARNING: please, no spaces at the start of a line
#76: FILE: arch/x86/events/amd/core.c:140:
+  [PERF_COUNT_HW_STALLED_CYCLES_FRONTEND]^I= 0x0287,$

WARNING: please, no spaces at the start of a line
#77: FILE: arch/x86/events/amd/core.c:141:
+  [PERF_COUNT_HW_STALLED_CYCLES_BACKEND]^I= 0x0187,$

total: 1 errors, 8 warnings, 25 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

Your patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
