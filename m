Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B82C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7850208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbfLKOqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:46:48 -0500
Received: from foss.arm.com ([217.140.110.172]:60634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727457AbfLKOqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:46:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 592621FB;
        Wed, 11 Dec 2019 06:46:47 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C72223F67D;
        Wed, 11 Dec 2019 06:46:45 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:46:43 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>, linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES] Fix 'perf top' breakage on architectures not providing
 get_cpuid() Re: perf top for arm64?
Message-ID: <20191211144643.GC35097@lakrids.cambridge.arm.com>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
 <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
 <20191210195113.GD13965@kernel.org>
 <20191211133319.GA15181@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211133319.GA15181@kernel.org>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:33:19AM -0300, Arnaldo Carvalho de Melo wrote:
> So can you take a look at the two patches below and provide me Acked-by
> and/or Reviewed-by and/or Tested-by?

I just gave this a spin. With vanilla v5.5-rc1 perf top behaves as John
reported, and with these applied atop perf works as expected:

Tested-by: Mark Rutland <mark.rutland@arm.com>

From scaning the code, the only other user of get_cpuid() that ends up
giving up is perf kvm, but AFAICT that never supported arm64, so that
looks sound to me:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> From 53c6cde6a71a1a9283763bd2e938b229b50c2cd5 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Wed, 11 Dec 2019 10:09:24 -0300
> Subject: [PATCH 1/2] perf arch: Make the default get_cpuid() return compatible
>  error
> 
> Some of the functions calling get_cpuid() propagate back the error it
> returns, and all are using errno (positive) values, make the weak
> default get_cpuid() function return ENOSYS to be consistent and to allow
> checking if this is an arch not providing this function or if a provided
> one is having trouble getting the cpuid, to decide if the warning should
> be provided to the user or just a debug message should be emitted.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index becc2d109423..4d39a75551a0 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -850,7 +850,7 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
>   */
>  int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
>  {
> -	return -1;
> +	return ENOSYS; /* Not implemented */
>  }
>  
>  static int write_cpuid(struct feat_fd *ff,
> -- 
> 2.21.0
> 
> From c6c6a3e2eb6982e37294abcac389effd298cf730 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Wed, 11 Dec 2019 10:21:59 -0300
> Subject: [PATCH 2/2] perf top: Do not bail out when perf_env__read_cpuid()
>  returns ENOSYS
> 
> 'perf top' stopped working on hw architectures that do not provide a
> get_cpuid() implementation and thus fallback to the weak get_cpuid()
> default function.
> 
> This is done because at annotation time we may need it in the arch
> specific annotation init routine, but that is only being used by arches
> that do provide a get_cpuid() implementation:
> 
>   $ find tools/  -name "*.[ch]" | xargs grep 'evlist->env'
>   tools/perf/builtin-top.c:	top.evlist->env = &perf_env;
>   tools/perf/util/evsel.c:		return evsel->evlist->env;
>   tools/perf/util/s390-cpumsf.c:	sf->machine_type = s390_cpumsf_get_type(session->evlist->env->cpuid);
>   tools/perf/util/header.c:	session->evlist->env = &header->env;
>   tools/perf/util/sample-raw.c:	const char *arch_pf = perf_env__arch(evlist->env);
>   $
> 
>   $ find tools/perf/arch  -name "*.[ch]" | xargs grep -w get_cpuid
>   tools/perf/arch/x86/util/auxtrace.c:	ret = get_cpuid(buffer, sizeof(buffer));
>   tools/perf/arch/x86/util/header.c:get_cpuid(char *buffer, size_t sz)
>   tools/perf/arch/powerpc/util/header.c:get_cpuid(char *buffer, size_t sz)
>   tools/perf/arch/s390/util/header.c: * Implementation of get_cpuid().
>   tools/perf/arch/s390/util/header.c:int get_cpuid(char *buffer, size_t sz)
>   tools/perf/arch/s390/util/header.c:	if (buf && get_cpuid(buf, 128))
>   $
> 
> For 'report' or 'script', i.e. tools working on perf.data files, that is
> setup while reading the header, its just top that needs to explicitely
> read it at tool start.
> 
> Reported-by: John Garry <john.garry@huawei.com>
> Analysed-by: Jiri Olsa <jolsa@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-top.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index dc80044bc46f..795e353de095 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1568,9 +1568,13 @@ int cmd_top(int argc, const char **argv)
>  	 */
>  	status = perf_env__read_cpuid(&perf_env);
>  	if (status) {
> -		pr_err("Couldn't read the cpuid for this machine: %s\n",
> -		       str_error_r(errno, errbuf, sizeof(errbuf)));
> -		goto out_delete_evlist;
> +		/*
> +		 * Some arches do not provide a get_cpuid(), so just use pr_debug, otherwise
> +		 * warn the user explicitely.
> +		 */
> +		eprintf(status == ENOSYS ? 1 : 0, verbose,
> +			"Couldn't read the cpuid for this machine: %s\n",
> +			str_error_r(errno, errbuf, sizeof(errbuf)));
>  	}
>  	top.evlist->env = &perf_env;
>  
> -- 
> 2.21.0
> 
