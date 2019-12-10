Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B6C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25A420652
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 19:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh3VqzZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfLJTsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:48:31 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37345 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfLJTsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 14:48:31 -0500
Received: by mail-ua1-f66.google.com with SMTP id f9so7467161ual.4;
        Tue, 10 Dec 2019 11:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5XRylTtRIq8nOcASUwg/qS7RkYYZwrC39wLzCcxTSfw=;
        b=Xh3VqzZqAq49b2QNXj4Ebde2x1/jSp8Rqr37SQd+s/dSAc5AWvgxFydtIWtPRK8cHQ
         QsPO2i7p5gTOWDgXUaNzFBF6/wsEdcyLAgMDnJe2iha1V36/1nrTnBlyg80lOoEUJBIO
         GemsH8MiJgSxhNvT6Fu1Q6U5kp9LYK17iUG1EocW7+1olKIMIygnm8HdZj8JDtkSnuAB
         3+wXdS4ahrKQ8Tz14PWaJRShRh9bVnO3Uu5A+AVkrC9U1NViVyk/PJ/+mLfr65GggHob
         Z5w9FcTDZejqGiaMUrCkaOfoeBcpM8jHC042E3QY40h/RtQpnFkGGDv2A/V4u744GdKq
         oZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5XRylTtRIq8nOcASUwg/qS7RkYYZwrC39wLzCcxTSfw=;
        b=NB4Nzrsrh01z7rgIn/9KwqiXJPeW1aiBVRgH0sqtMpgTrzbzBn7yIApe6Tbd85HuPS
         zBVg0DF90qI1fY+dHH/Su5tqfi1QGQZhcPJFgsyA50Er9WEpEXbMX1xveVVoGVsU2l0n
         jFf1TMtBm5NpavAH3qooy4Q/9mVr81vn6eyfyJqmERBxtoyk2f/jfvsG59nawVo0ZIxt
         HX+do7SYdpx634T4kGtJMQULHQKzCC8QCWV1qftlzEjidf+OSW5tsyo7p/aAJbAh0qmu
         c1oE9eCIgos1drdu5vT3PmK+4hnEqJVaveBaoBnvPVKZwo+vCncbaLcDRgb7aI8Ov2Xs
         Wzvg==
X-Gm-Message-State: APjAAAUrqw9o5PPnjpP38raMBGZu49ic7NpsnD3gce1Qx778bKisxhTr
        Rhitj0LjfrIR6ydUxlvS5So=
X-Google-Smtp-Source: APXvYqy2XSHPpXravAXhLPLytQ/TF5/83WcXqCP8QQ4gbbQyG0Zn7odP3sHPkIdfItib7GFToo6wSg==
X-Received: by 2002:ab0:1c6:: with SMTP id 64mr31120938ual.13.1576007310173;
        Tue, 10 Dec 2019 11:48:30 -0800 (PST)
Received: from quaco.ghostprotocols.net (179-240-167-103.3g.claro.net.br. [179.240.167.103])
        by smtp.gmail.com with ESMTPSA id w3sm2610335vsl.4.2019.12.10.11.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 11:48:29 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CBA0140352; Tue, 10 Dec 2019 16:48:25 -0300 (-03)
Date:   Tue, 10 Dec 2019 16:48:25 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        mark.rutland@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: perf top for arm64?
Message-ID: <20191210194825.GC13965@kernel.org>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210163655.GG14123@krava>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Dec 10, 2019 at 05:36:55PM +0100, Jiri Olsa escreveu:
> On Tue, Dec 10, 2019 at 04:13:49PM +0000, John Garry wrote:
> > Hi all,
> > 
> > I find to my surprise that "perf top" does not work for arm64:
> > 
> > root@ubuntu:/home/john/linux# tools/perf/perf top
> > Couldn't read the cpuid for this machine: No such file or directory
> 
> there was recent change that check on cpuid and quits:
>   608127f73779 perf top: Initialize perf_env->cpuid, needed by the per arch annotation init routine
> 
> Arnaldo,
> maybe this should be just a warning/info, because it seems to be related
> to annotations only..?

Right, my bad, I'll look into making this just a debug message and then
check in the annotation code when this is really needed to show an
error/popup window :-\

- Arnaldo
 
> get_cpuid is defined only for s390/x86/powerpc, so I guess it won't work
> on the rest as well
> 
> jirka
> 
> > 
> > That's v5.5-rc1 release.
> > 
> > It seems that we are just missing an arm64 version of get_cpuid() - with the
> > patch below, I now get as hoped:
> > 
> >    PerfTop:   32857 irqs/sec  kernel:85.0%  exact:  0.0% lost: 0/0 drop: 0/0
> > [4000Hz cycles],  (all, 64 CPUs)
> > -------------------------------------------------------------------------------
> > 
> >      8.99%  [kernel]          [k] arm_smmu_cmdq_issue_cmdlist
> >      5.80%  [kernel]          [k] __softirqentry_text_start
> >      4.49%  [kernel]          [k] _raw_spin_unlock_irqrestore
> >      3.48%  [kernel]          [k] el0_svc_common.constprop.2
> >      3.37%  [kernel]          [k] _raw_write_lock_irqsave
> >      3.28%  [kernel]          [k] __local_bh_enable_ip
> >      3.05%  [kernel]          [k] __blk_complete_request
> >      2.07%  [kernel]          [k] queued_spin_lock_slowpath
> >      1.93%  [vdso]            [.] 0x0000000000000484
> > 
> > 
> > Was this just missed? Or is there a good reason to omit?
> > 
> > Thanks,
> > John
> > 
> > --->8---
> > 
> > Subject: [PATCH] perf: Add perf top support for arm64
> > 
> > Copied from get_cpuid_str() essentially...
> > 
> > Signed-off-by: John Garry <john.garry@huawei.com>
> > 
> > diff --git a/tools/perf/arch/arm64/util/header.c
> > b/tools/perf/arch/arm64/util/header.c
> > index a32e4b72a98f..ecd1f86e29cc 100644
> > --- a/tools/perf/arch/arm64/util/header.c
> > +++ b/tools/perf/arch/arm64/util/header.c
> > @@ -1,10 +1,12 @@
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <perf/cpumap.h>
> > +#include <util/cpumap.h>
> >  #include <internal/cpumap.h>
> >  #include <api/fs/fs.h>
> >  #include "debug.h"
> >  #include "header.h"
> > +#include <errno.h>
> > 
> >  #define MIDR "/regs/identification/midr_el1"
> >  #define MIDR_SIZE 19
> > @@ -12,6 +14,59 @@
> >  #define MIDR_VARIANT_SHIFT      20
> >  #define MIDR_VARIANT_MASK       (0xf << MIDR_VARIANT_SHIFT)
> > 
> > +int
> > +get_cpuid(char *buffer, size_t sz)
> > +{
> > +	char *buf = NULL;
> > +	char path[PATH_MAX];
> > +	const char *sysfs = sysfs__mountpoint();
> > +	int cpu;
> > +	u64 midr = 0;
> > +	FILE *file;
> > +
> > +	if (!sysfs)
> > +		return EINVAL;
> > +
> > +	buf = malloc(MIDR_SIZE);
> > +	if (!buf)
> > +		return EINVAL;
> > +
> > +	/* read midr from list of cpus mapped to this pmu */
> > +	for (cpu = 0; cpu < cpu__max_present_cpu(); cpu++) {
> > +		scnprintf(path, sz, "%s/devices/system/cpu/cpu%d"MIDR,
> > +				sysfs, cpu);
> > +
> > +		file = fopen(path, "r");
> > +		if (!file) {
> > +			pr_debug("fopen failed for file %s\n", path);
> > +			continue;
> > +		}
> > +
> > +		if (!fgets(buf, MIDR_SIZE, file)) {
> > +			fclose(file);
> > +			continue;
> > +		}
> > +		fclose(file);
> > +
> > +		/* Ignore/clear Variant[23:20] and
> > +		 * Revision[3:0] of MIDR
> > +		 */
> > +		midr = strtoul(buf, NULL, 16);
> > +		midr &= (~(MIDR_VARIANT_MASK | MIDR_REVISION_MASK));
> > +		scnprintf(buffer, MIDR_SIZE, "0x%016lx", midr);
> > +		/* got midr break loop */
> > +		break;
> > +	}
> > +
> > +	if (!midr) {
> > +		pr_err("failed to get cpuid string\n");
> > +		free(buf);
> > +		return EINVAL;
> > +	}
> > +	return 0;
> > +}
> > +
> > 

-- 

- Arnaldo
