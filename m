Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF1AC04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951B5208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfFFU4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:56:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:14942 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727606AbfFFU4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:56:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 13:56:22 -0700
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 06 Jun 2019 13:56:22 -0700
Received: from [10.251.1.101] (kliang2-mobl.ccr.corp.intel.com [10.251.1.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id ADA56580416;
        Thu,  6 Jun 2019 13:56:21 -0700 (PDT)
Subject: Re: [PATCH V3 2/5] perf header: Add die information in CPU topology
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     jolsa@kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
References: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
 <1559688644-106558-2-git-send-email-kan.liang@linux.intel.com>
 <20190606191210.GG21245@kernel.org> <20190606200826.GI21245@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <5afed22a-f7c4-63da-5603-8732b02ee2ab@linux.intel.com>
Date:   Thu, 6 Jun 2019 16:56:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606200826.GI21245@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/6/2019 4:08 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 06, 2019 at 04:12:10PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Tue, Jun 04, 2019 at 03:50:41PM -0700, kan.liang@linux.intel.com escreveu:
>>> From: Kan Liang <kan.liang@linux.intel.com>
>>>
>>> With the new CPUID.1F, a new level type of CPU topology, 'die', is
>>> introduced. The 'die' information in CPU topology should be added in
>>> perf header.
>>>
>>> To be compatible with old perf.data, the patch checks the section size
>>> before reading the die information. The new info is added at the end of
>>> the cpu_topology section, the old perf tool ignores the extra data.
>>> It never reads data crossing the section boundary.
>>>
>>> The new perf tool with the patch can be used on legacy kernel. Add a
>>> new function has_die_topology() to check if die topology information is
>>> supported by kernel. The function only check X86 and CPU 0. Assuming
>>> other CPUs have same topology.
>>
>> You're changing the header, how would a new tool handle an old perf.data
>> where this 'die_id' is not present? What about an old tool dealing with
>> a perf.data with this die_id?
>>
>> I couldn't see any provision for that, am I missing something?
>>
>> /me goes to read tools/perf/util/cputopo.c ...
>>
>> Yeah, its just the description on the perf.data doc file that confused
>> me, I'll clarify that after finishing reviewing/applying this patchkit.
> 
> So I have this on top, please check.
>

It looks good to me.

Thanks,
Kan

> - Arnaldo
> 
> commit a9396a70fc7101c108e1c91fa1771557bbbb57a1
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Thu Jun 6 17:03:18 2019 -0300
> 
>      perf data: Fix perf.data documentation for HEADER_CPU_TOPOLOGY
>      
>      The 'die' info isn't in the same array as core and socket ids, and we
>      missed the 'dies' string list, that comes right after the 'core' +
>      'socket' id variable length array, followed by the VLA for the dies.
>      
>      Cc: Adrian Hunter <adrian.hunter@intel.com>
>      Cc: Andi Kleen <ak@linux.intel.com>
>      Cc: Jiri Olsa <jolsa@kernel.org>
>      Cc: Kan Liang <kan.liang@linux.intel.com>
>      Cc: Namhyung Kim <namhyung@kernel.org>
>      Cc: Peter Zijlstra <peterz@infradead.org>
>      Fixes: c9cb12c5ba08 ("perf header: Add die information in CPU topology")
>      Link: https://lkml.kernel.org/n/tip-nubi6mxp2n8ofvlx7ph6k3h6@git.kernel.org
>      Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
> index de78183f6881..5f54feb19977 100644
> --- a/tools/perf/Documentation/perf.data-file-format.txt
> +++ b/tools/perf/Documentation/perf.data-file-format.txt
> @@ -151,20 +151,35 @@ struct {
>   
>   	HEADER_CPU_TOPOLOGY = 13,
>   
> -String lists defining the core and CPU threads topology.
> -The string lists are followed by a variable length array
> -which contains core_id, die_id (for x86) and socket_id of each cpu.
> -The number of entries can be determined by the size of the
> -section minus the sizes of both string lists.
> -
>   struct {
> +	/*
> +	 * First revision of HEADER_CPU_TOPOLOGY
> +	 *
> +	 * See 'struct perf_header_string_list' definition earlier
> +	 * in this file.
> +	 */
> +
>          struct perf_header_string_list cores; /* Variable length */
>          struct perf_header_string_list threads; /* Variable length */
> +
> +       /*
> +        * Second revision of HEADER_CPU_TOPOLOGY, older tools
> +        * will not consider what comes next
> +        */
> +
>          struct {
>   	      uint32_t core_id;
> -	      uint32_t die_id;
>   	      uint32_t socket_id;
>          } cpus[nr]; /* Variable length records */
> +       /* 'nr' comes from previously processed HEADER_NRCPUS's nr_cpu_avail */
> +
> +        /*
> +	 * Third revision of HEADER_CPU_TOPOLOGY, older tools
> +	 * will not consider what comes next
> +	 */
> +
> +	struct perf_header_string_list dies; /* Variable length */
> +	uint32_t die_id[nr_cpus_avail]; /* from previously processed HEADER_NR_CPUS, VLA */
>   };
>   
>   Example:
> 
