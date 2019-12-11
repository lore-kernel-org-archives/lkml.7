Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E60BC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A41E208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 14:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfLKOuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 09:50:09 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2180 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726242AbfLKOuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 09:50:08 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id C7EB851606058E11F8C7;
        Wed, 11 Dec 2019 14:50:06 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Dec 2019 14:50:06 +0000
Received: from [127.0.0.1] (10.202.226.46) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 11 Dec
 2019 14:50:06 +0000
Subject: Re: [PATCHES] Fix 'perf top' breakage on architectures not providing
 get_cpuid() Re: perf top for arm64?
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
References: <1573045254-39833-1-git-send-email-john.garry@huawei.com>
 <20191106140036.GA6259@kernel.org>
 <418023e7-a50d-cb6f-989f-2e6d114ce5d8@huawei.com>
 <20191210163655.GG14123@krava>
 <952dc484-2739-ee65-f41c-f0198850ab10@huawei.com>
 <20191210170841.GA23357@krava>
 <9a31536b-f266-e305-1107-2f745d0a33e3@huawei.com>
 <20191210195113.GD13965@kernel.org> <20191211133319.GA15181@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dec45157-5358-62ee-c22c-ba11b13bc407@huawei.com>
Date:   Wed, 11 Dec 2019 14:50:05 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191211133319.GA15181@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.46]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> 
>> Right, I need to make that just a pr_debug() message and then check in
>> the annotation code when that is needed to see if it is set, if not,
>> then show a popup error message and refuse to do whatever annotation
>> feature requires that.
> 
>> Anyway, your patch should make sense and provide info that the ARM64
>> annotation may use now or in the future.
> 
> So can you take a look at the two patches below and provide me Acked-by
> and/or Reviewed-by and/or Tested-by?
> 
> 

>>From 53c6cde6a71a1a9283763bd2e938b229b50c2cd5 Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Wed, 11 Dec 2019 10:09:24 -0300
> Subject: [PATCH 1/2] perf arch: Make the default get_cpuid() return compatible
>   error
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

For both patches:
Tested-by: John Garry <john.garry@huawei.com> #arm64

I'll still look to get the arm64 version of get_cpuid() patch sent.

> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Link: https://lkml.kernel.org/n/tip-lxwjr0cd2eggzx04a780ffrv@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>   tools/perf/util/header.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index becc2d109423..4d39a75551a0 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -850,7 +850,7 @@ int __weak strcmp_cpuid_str(const char *mapcpuid, const char *cpuid)
>    */
>   int __weak get_cpuid(char *buffer __maybe_unused, size_t sz __maybe_unused)
>   {
> -	return -1;
> +	return ENOSYS; /* Not implemented */
>   }
>   
>   static int write_cpuid(struct feat_fd *ff,
> 

