Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D32C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A325824654
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfLLFzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:55:23 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbfLLFzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:55:23 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC5gsOP016049;
        Thu, 12 Dec 2019 00:54:14 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsu3rr2t0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 00:54:13 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id xBC5l3Uv027382;
        Thu, 12 Dec 2019 00:54:13 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsu3rr2sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 00:54:13 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xBC5rIlv005465;
        Thu, 12 Dec 2019 05:54:12 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 2wtdq7edre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 05:54:12 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBC5sBcw51905002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 05:54:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34326B2068;
        Thu, 12 Dec 2019 05:54:11 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C0DB2065;
        Thu, 12 Dec 2019 05:54:07 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.241])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 05:54:06 +0000 (GMT)
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
References: <20191120084059.24458-1-kjain@linux.ibm.com>
 <ed80bcc2-a507-bcf8-9084-181b18b6a95f@linux.ibm.com>
 <20191211134528.GC15181@kernel.org>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <a32e131e-1ade-b770-724d-63270b0fbe7e@linux.ibm.com>
Date:   Thu, 12 Dec 2019 11:24:05 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191211134528.GC15181@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/19 7:15 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Dec 04, 2019 at 12:25:22PM +0530, Ravi Bangoria escreveu:
>>
>> On 11/20/19 2:10 PM, Kajol Jain wrote:
>>> Commit f01642e4912b ("perf metricgroup: Support multiple
>>> events for metricgroup") introduced support for multiple events
>>> in a metric group. But with the current upstream, metric events
>>> names are not printed properly
>>>
>>> In power9 platform:
>>> command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
>>>        1.000208486
>>>        2.000368863
>>>        2.001400558
>>>
>>> Similarly in skylake platform:
>>> command:./perf stat --metric-only -M Power -I 1000
>>>        1.000579994
>>>        2.002189493
>>>
>>> With current upstream version, issue is with event name comparison
>>> logic in find_evsel_group(). Current logic is to compare events
>>> belonging to a metric group to the events in perf_evlist.
>>> Since the break statement is missing in the loop used for comparison
>>> between metric group and perf_evlist events, the loop continues to
>>> execute even after getting a pattern match, and end up in discarding
>>> the matches.
>>> Incase of single metric event belongs to metric group, its working fine,
>>> because in case of single event once it compare all events it reaches to
>>> end of perf_evlist.
>>>
>>> Example for single metric event in power9 platform
>>> command:# ./perf stat --metric-only  -M branches_per_inst -I 1000 sleep 1
>>>        1.000094653                  0.2
>>>        1.001337059                  0.0
>>>
>>> Patch fixes the issue by making sure once we found all events
>>> belongs to that metric event matched in find_evsel_group(), we
>>> successfully break from that loop by adding corresponding condition.
>>>
>>> With this patch:
>>> In power9 platform:
>>>
>>> command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
>>> result:#           time derat_4k_miss_rate_percent  derat_4k_miss_ratio
>>>        derat_miss_ratio derat_64k_miss_rate_percent derat_64k_miss_ratio
>>>            dslb_miss_rate_percent islb_miss_rate_percent
>>>        1.000135672                         0.0                  0.3
>>>                     1.0                          0.0                  0.2
>>>                    0.0                     0.0
>>>        2.000380617                         0.0                  0.0
>>>                                                 0.0                  0.0
>>>                   0.0                     0.0
>>>
>>> command:# ./perf stat --metric-only -M Power -I 1000
>>>
>>> Similarly in skylake platform:
>>> result:#           time    Turbo_Utilization    C3_Core_Residency
>>>               C6_Core_Residency    C7_Core_Residency     C2_Pkg_Residency
>>>                C3_Pkg_Residency     C6_Pkg_Residency     C7_Pkg_Residency
>>>        1.000563580                  0.3                  0.0
>>>                     2.6                44.2                 21.9
>>>                     0.0                  0.0                  0.0
>>>        2.002235027                  0.4                  0.0
>>>                     2.7           43.0                 20.7
>>>                     0.0                  0.0               0.0
>>>
>>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>> Cc: Andi Kleen <ak@linux.intel.com>
>>> Cc: Jiri Olsa <jolsa@kernel.org>
>>> Cc: Kan Liang <kan.liang@linux.intel.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Jin Yao <yao.jin@linux.intel.com>
>>> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
>>> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
>> Fixes: f01642e4912b ("perf metricgroup: Support multiple events for metricgroup")
>> Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Tested on a Skylake machine and applied.
>
>> But while looking at the patch, I found that, commit f01642e4912b
>> has (again) screwed up logic for metric with overlapping events.
> Is someone looking into this?


Hi Arnaldo,

             I am looking  into this issue and will post the fix soon.

Kajol

>   
>>    $ sudo ./perf stat -M UPI,IPC sleep 1
>>
>>     Performance counter stats for 'sleep 1':
>>
>>             948,650      uops_retired.retire_slots
>>             866,182      inst_retired.any          #      0.7 IPC
>>             866,182      inst_retired.any
>>           1,175,671      cpu_clk_unhalted.thread
>>
>> This also needs to be fixed.
>>
>> Ravi

