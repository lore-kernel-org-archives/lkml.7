Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450DEC10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB042075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfC0Txf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:53:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:37745 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbfC0Txf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:53:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Mar 2019 12:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,277,1549958400"; 
   d="scan'208";a="145777334"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2019 12:53:33 -0700
Received: from [10.254.82.239] (kliang2-mobl.ccr.corp.intel.com [10.254.82.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E5D1458011C;
        Wed, 27 Mar 2019 12:53:32 -0700 (PDT)
Subject: Re: [PATCH] perf pmu: Fix parser error for uncore event alias
To:     acme@kernel.org
Cc:     Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        Thomas Richter <tmricht@linux.ibm.com>, stable@vger.kernel.org
References: <1552672814-156173-1-git-send-email-kan.liang@linux.intel.com>
 <20190318085322.GD5200@krava>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <ff0cc658-7c71-3829-f54b-a786b35c5b79@linux.intel.com>
Date:   Wed, 27 Mar 2019 15:53:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190318085322.GD5200@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/18/2019 4:53 AM, Jiri Olsa wrote:
> On Fri, Mar 15, 2019 at 11:00:14AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Perf fails to parse uncore event alias, for example:
>>
>>    #perf stat -e unc_m_clockticks -a --no-merge sleep 1
>>    event syntax error: 'unc_m_clockticks'
>>                         \___ parser error
>>
>> Current code assumes that the event alias is from one specific PMU.
>> To find the PMU, perf strcmp the pmu name of event alias with the
>> real pmu name on the system.
>> However, the uncore event alias may be from multiple PMUs with common
>> prefix. The pmu name of uncore event alias is the common prefix.
>> For example, UNC_M_CLOCKTICKS is clock event for iMC, which include
>> 6 PMUs with the same prefix "uncore_imc" on a skylake server.
>> The real pmu names on the system for iMC are uncore_imc_0 ...
>> uncore_imc_5.
>> The strncmp is used to only check the common prefix for uncore
>> event alias.
>>
>> With the patch,
>>    #perf stat -e unc_m_clockticks -a --no-merge sleep 1
>>    Performance counter stats for 'system wide':
>>
>>         723,594,722      unc_m_clockticks [uncore_imc_5]
>>         724,001,954      unc_m_clockticks [uncore_imc_3]
>>         724,042,655      unc_m_clockticks [uncore_imc_1]
>>         724,161,001      unc_m_clockticks [uncore_imc_4]
>>         724,293,713      unc_m_clockticks [uncore_imc_2]
>>         724,340,901      unc_m_clockticks [uncore_imc_0]
>>
>>         1.002090060 seconds time elapsed
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Thomas Richter <tmricht@linux.ibm.com>
>> Cc: stable@vger.kernel.org
>> Fixes: ea1fa48c055f ("perf stat: Handle different PMU names with common prefix")
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
>

Hi Arnaldo,

Could you please apply the fix?

Thanks,
Kan



> thanks,
> jirka
> 
>> ---
>>   tools/perf/util/pmu.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
>> index 51d437f..395308f 100644
>> --- a/tools/perf/util/pmu.c
>> +++ b/tools/perf/util/pmu.c
>> @@ -732,10 +732,20 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
>>   
>>   		if (!is_arm_pmu_core(name)) {
>>   			pname = pe->pmu ? pe->pmu : "cpu";
>> +
>> +			/*
>> +			 * uncore alias may be from different PMU
>> +			 * with common prefix
>> +			 */
>> +			if (pmu_is_uncore(name) &&
>> +			    !strncmp(pname, name, strlen(pname)))
>> +				goto new_alias;
>> +
>>   			if (strcmp(pname, name))
>>   				continue;
>>   		}
>>   
>> +new_alias:
>>   		/* need type casts to override 'const' */
>>   		__perf_pmu__new_alias(head, NULL, (char *)pe->name,
>>   				(char *)pe->desc, (char *)pe->event,
>> -- 
>> 2.7.4
>>
