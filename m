Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A020BCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8E321D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 06:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405364AbfJYGni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 02:43:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733071AbfJYGnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 02:43:37 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P6bKT0100021
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:43:36 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vutkftd50-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 02:43:36 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 25 Oct 2019 07:43:34 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 07:43:31 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9P6hU4p54591684
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 06:43:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E89FFA4051;
        Fri, 25 Oct 2019 06:43:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60FE3A4053;
        Fri, 25 Oct 2019 06:43:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.242])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 06:43:28 +0000 (GMT)
Subject: Re: [PATCH] sched/fair: Make sched-idle cpu selection consistent
 throughout
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org
References: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 25 Oct 2019 12:13:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102506-0028-0000-0000-000003AF3F33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102506-0029-0000-0000-0000247173F4
Message-Id: <7d3a1549-a99c-ae42-6074-8ed2ecd7074f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 10/24/19 12:15 PM, Viresh Kumar wrote:
> There are instances where we keep searching for an idle CPU despite
> having a sched-idle cpu already (in find_idlest_group_cpu(),
> select_idle_smt() and select_idle_cpu() and then there are places where
> we don't necessarily do that and return a sched-idle cpu as soon as we
> find one (in select_idle_sibling()). This looks a bit inconsistent and
> it may be worth having the same policy everywhere.
> 
> On the other hand, choosing a sched-idle cpu over a idle one shall be
> beneficial from performance point of view as well, as we don't need to
> get the cpu online from a deep idle state which is quite a time
> consuming process and delays the scheduling of the newly wakeup task.
> 
> This patch tries to simplify code around sched-idle cpu selection and
> make it consistent throughout.
> 
> FWIW, tests were done with the help of rt-app (8 SCHED_OTHER and 5
> SCHED_IDLE tasks, not bound to any cpu) on ARM platform (octa-core), and
> no significant difference in scheduling latency of SCHED_OTHER tasks was
> found.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

[...]

> @@ -5755,13 +5749,11 @@ static int select_idle_smt(struct task_struct *p, int target)
>  	for_each_cpu(cpu, cpu_smt_mask(target)) {
>  		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>  			continue;
> -		if (available_idle_cpu(cpu))
> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>  			return cpu;

I guess this is a correct approach, but just wondering what if we still
keep searching for a sched_idle CPU even though we have found an
available_idle CPU?

[...]


Thanks,
Parth

