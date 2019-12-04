Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41041C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E302073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 06:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfLDGzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 01:55:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbfLDGzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 01:55:35 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB46q7Xg084182
        for <linux-kernel@vger.kernel.org>; Wed, 4 Dec 2019 01:55:34 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wn3peqw5p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 01:55:34 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Wed, 4 Dec 2019 06:55:30 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Dec 2019 06:55:27 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB46tPpS45678648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Dec 2019 06:55:25 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 718FB42045;
        Wed,  4 Dec 2019 06:55:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64EF342042;
        Wed,  4 Dec 2019 06:55:23 +0000 (GMT)
Received: from [9.124.31.177] (unknown [9.124.31.177])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Dec 2019 06:55:23 +0000 (GMT)
Subject: Re: [PATCH] tools/perf/metricgroup: Fix printing event names of
 metric group with multiple events
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191120084059.24458-1-kjain@linux.ibm.com>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Wed, 4 Dec 2019 12:25:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191120084059.24458-1-kjain@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120406-4275-0000-0000-0000038AEC68
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120406-4276-0000-0000-0000389E8CB1
Message-Id: <ed80bcc2-a507-bcf8-9084-181b18b6a95f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-04_01:2019-12-04,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912040050
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/19 2:10 PM, Kajol Jain wrote:
> Commit f01642e4912b ("perf metricgroup: Support multiple
> events for metricgroup") introduced support for multiple events
> in a metric group. But with the current upstream, metric events
> names are not printed properly
> 
> In power9 platform:
> command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
>       1.000208486
>       2.000368863
>       2.001400558
> 
> Similarly in skylake platform:
> command:./perf stat --metric-only -M Power -I 1000
>       1.000579994
>       2.002189493
> 
> With current upstream version, issue is with event name comparison
> logic in find_evsel_group(). Current logic is to compare events
> belonging to a metric group to the events in perf_evlist.
> Since the break statement is missing in the loop used for comparison
> between metric group and perf_evlist events, the loop continues to
> execute even after getting a pattern match, and end up in discarding
> the matches.
> Incase of single metric event belongs to metric group, its working fine,
> because in case of single event once it compare all events it reaches to
> end of perf_evlist.
> 
> Example for single metric event in power9 platform
> command:# ./perf stat --metric-only  -M branches_per_inst -I 1000 sleep 1
>       1.000094653                  0.2
>       1.001337059                  0.0
> 
> Patch fixes the issue by making sure once we found all events
> belongs to that metric event matched in find_evsel_group(), we
> successfully break from that loop by adding corresponding condition.
> 
> With this patch:
> In power9 platform:
> 
> command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
> result:#           time derat_4k_miss_rate_percent  derat_4k_miss_ratio
>       derat_miss_ratio derat_64k_miss_rate_percent derat_64k_miss_ratio
>           dslb_miss_rate_percent islb_miss_rate_percent
>       1.000135672                         0.0                  0.3
>                    1.0                          0.0                  0.2
>                   0.0                     0.0
>       2.000380617                         0.0                  0.0
>                                                0.0                  0.0
>                  0.0                     0.0
> 
> command:# ./perf stat --metric-only -M Power -I 1000
> 
> Similarly in skylake platform:
> result:#           time    Turbo_Utilization    C3_Core_Residency
>              C6_Core_Residency    C7_Core_Residency     C2_Pkg_Residency
>               C3_Pkg_Residency     C6_Pkg_Residency     C7_Pkg_Residency
>       1.000563580                  0.3                  0.0
>                    2.6                44.2                 21.9
>                    0.0                  0.0                  0.0
>       2.002235027                  0.4                  0.0
>                    2.7           43.0                 20.7
>                    0.0                  0.0               0.0
> 
> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Fixes: f01642e4912b ("perf metricgroup: Support multiple events for metricgroup")
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

But while looking at the patch, I found that, commit f01642e4912b
has (again) screwed up logic for metric with overlapping events.

   $ sudo ./perf stat -M UPI,IPC sleep 1

    Performance counter stats for 'sleep 1':

            948,650      uops_retired.retire_slots
            866,182      inst_retired.any          #      0.7 IPC
            866,182      inst_retired.any
          1,175,671      cpu_clk_unhalted.thread

This also needs to be fixed.

Ravi

