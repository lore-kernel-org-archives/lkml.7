Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19D4C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B69B62072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 09:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgAHJLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 04:11:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727112AbgAHJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 04:11:50 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008989uI070324;
        Wed, 8 Jan 2020 04:11:43 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb8p19ub5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 04:11:42 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0089AIpU007690;
        Wed, 8 Jan 2020 09:11:41 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2xajb6ug33-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jan 2020 09:11:41 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0089BedX51511678
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jan 2020 09:11:40 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4881112061;
        Wed,  8 Jan 2020 09:11:40 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4203112063;
        Wed,  8 Jan 2020 09:11:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.48.19])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jan 2020 09:11:36 +0000 (GMT)
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events incase of overlapping events
To:     "Jin, Yao" <yao.jin@linux.intel.com>, acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20200108065844.4030-1-kjain@linux.ibm.com>
 <e866c12a-7328-8524-fd0e-668301da6875@linux.intel.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <822bcb9d-4c08-39c5-e6e7-9c3e20d77852@linux.ibm.com>
Date:   Wed, 8 Jan 2020 14:41:35 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e866c12a-7328-8524-fd0e-668301da6875@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_01:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/20 12:55 PM, Jin, Yao wrote:
>
>
> On 1/8/2020 2:58 PM, Kajol Jain wrote:
>> Commit f01642e4912b ("perf metricgroup: Support multiple
>> events for metricgroup") introduced support for multiple events
>> in a metric group. But with the current upstream, metric events
>> names are not printed properly incase we try to run multiple
>> metric groups with overlapping event.
>>
>> With current upstream version, incase of overlapping metric events
>> issue is, we always start our comparision logic from start.
>> So, the events which already matched with some metric group also
>> take part in comparision logic. Because of that when we have overlapping
>> events, we end up matching current metric group event with already 
>> matched
>> one.
>>
>> For example, in skylake machine we have metric event CoreIPC and
>> Instructions. Both of them need 'inst_retired.any' event value.
>> As events in Instructions is subset of events in CoreIPC, they
>> endup in pointing to same 'inst_retired.any' value.
>>
>> In skylake platform:
>>
>> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
>>
>>   Performance counter stats for 'CPU(s) 0':
>>
>>       1,254,992,790      inst_retired.any          # 1254992790.0
>>                             Instructions
>>                                                    #      1.3 CoreIPC
>>         977,172,805      cycles
>>       1,254,992,756      inst_retired.any
>>
>>         1.000802596 seconds time elapsed
>>
>> command:# sudo ./perf stat -M UPI,IPC sleep 1
>>
>>     Performance counter stats for 'sleep 1':
>>
>>             948,650      uops_retired.retire_slots
>>             866,182      inst_retired.any          #      0.7 IPC
>>             866,182      inst_retired.any
>>           1,175,671      cpu_clk_unhalted.thread
>>
>> Patch fixes the issue by adding a static variable 'iterator_perf_evlist'
>> to keep track of events which already matched with some group. It points
>> to event in perf_evlist from where next match should start. Because we
>> need to make sure, we match correct set of events belongs to
>> corresponding metric group.
>>
>> With this patch:
>> In skylake platform:
>>
>> command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1
>>
>>   Performance counter stats for 'CPU(s) 0':
>>
>>         149,481,533      inst_retired.any          #      0.8 CoreIPC
>>         186,244,218      cycles
>>         149,479,362      inst_retired.any          # 149479362.0
>>                             Instructions
>>
>>         1.001655885 seconds time elapsed
>>
>> command:# ./perf stat -M UPI,IPC sleep 1
>>   Performance counter stats for 'CPU(s) 0':
>>
>>          16,858,849      uops_retired.retire_slots #      1.3 UPI
>>          12,529,178      inst_retired.any
>>          12,529,558      inst_retired.any          #      0.3 IPC
>>          39,936,071      cpu_clk_unhalted.thread
>>
>>         1.001413978 seconds time elapsed
>>
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Andi Kleen <ak@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@kernel.org>
>> Cc: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Jin Yao <yao.jin@linux.intel.com>
>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> ---
>>   tools/perf/util/metricgroup.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c 
>> b/tools/perf/util/metricgroup.c
>> index 35e151b8359b..58889b0496fb 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -90,16 +90,21 @@ struct egroup {
>>       const char *metric_unit;
>>   };
>>   +static int iterator_perf_evlist;
>> +
>>   static struct evsel *find_evsel_group(struct evlist *perf_evlist,
>>                         const char **ids,
>>                         int idnum,
>>                         struct evsel **metric_events)
>>   {
>>       struct evsel *ev;
>> -    int i = 0;
>> +    int i = 0, j = 0;
>>       bool leader_found;
>>         evlist__for_each_entry (perf_evlist, ev) {
>> +        j++;
>> +        if (j <= iterator_perf_evlist)
>> +            continue;
>>           if (!strcmp(ev->name, ids[i])) {
>>               if (!metric_events[i])
>>                   metric_events[i] = ev;
>> @@ -146,6 +151,7 @@ static struct evsel *find_evsel_group(struct 
>> evlist *perf_evlist,
>>               }
>>           }
>>       }
>> +    iterator_perf_evlist = j;
>>         return metric_events[0];
>>   }
>>
>
> Thanks for reporting and fixing this issue.
>
> I just have one question, do we really need a *static variable* to 
> track the matched events? Perhaps using an input parameter?

Hi Jin,

The other way I come up with to solve this issue is, making change in 
perf_evlist itself by adding some flag in event name, to keep track of 
matched events.

As if we change event name itself, next time when we compare it won't 
matched. But in that case we need to remove those flag later. Which will 
increase the

complexity. If you have any suggestions, please let me know.

Thanks,

Kajol

>
> Thanks
> Jin Yao
>
