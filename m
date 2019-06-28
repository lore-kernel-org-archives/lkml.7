Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4101EC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB7D2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 11:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbfF1Lyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 07:54:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16674 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726564AbfF1Lyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 07:54:54 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SBqcYR048949
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:54:53 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tdgnvm8nj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 07:54:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 28 Jun 2019 12:54:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 12:54:45 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SBsiUv41812068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 11:54:44 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 994BFAE053;
        Fri, 28 Jun 2019 11:54:44 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60B62AE045;
        Fri, 28 Jun 2019 11:54:42 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 28 Jun 2019 11:54:42 +0000 (GMT)
Date:   Fri, 28 Jun 2019 11:54:41 +0000
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     subhra mazumdar <subhra.mazumdar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        tim.c.chen@linux.intel.com, mgorman@techsingularity.net
Subject: Re: [PATCH v3 3/7] sched: rotate the cpu search window for better
 spread
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-4-subhra.mazumdar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190627012919.4341-4-subhra.mazumdar@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19062811-0016-0000-0000-0000028D5718
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062811-0017-0000-0000-000032EADA7F
Message-Id: <20190628115441.GA30685@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280143
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* subhra mazumdar <subhra.mazumdar@oracle.com> [2019-06-26 18:29:15]:

> Rotate the cpu search window for better spread of threads. This will ensure
> an idle cpu will quickly be found if one exists.

While rotating the cpu search window is good, not sure if this can find a
idle cpu quickly. The probability of finding an idle cpu still should remain
the same. No?

> 
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  kernel/sched/fair.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> @@ -6219,9 +6219,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  		}
>  	}
>  
> +	if (per_cpu(next_cpu, target) != -1)
> +		target_tmp = per_cpu(next_cpu, target);
> +	else
> +		target_tmp = target;
> +
>  	time = local_clock();
>  
> -	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
> +	for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
> +		per_cpu(next_cpu, target) = cpu;

Shouldn't this assignment be outside the for loop.
With the current code,
1. We keep reassigning multiple times.
2. The last assignment happes for idle_cpu and sometimes the
assignment is for non-idle cpu.

>  		if (!--nr)
>  			return -1;
>  		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> -- 
> 2.9.3
> 

-- 
Thanks and Regards
Srikar Dronamraju

