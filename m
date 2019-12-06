Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B07C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9677521835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 12:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLFMx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 07:53:26 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53940 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726160AbfLFMx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 07:53:26 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6ClbV6064006
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 07:53:25 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq55tfmrn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 07:53:24 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 6 Dec 2019 12:53:22 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 12:53:20 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6CrJSh61407486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 12:53:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90BBB11C052;
        Fri,  6 Dec 2019 12:53:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F11FA11C050;
        Fri,  6 Dec 2019 12:53:17 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri,  6 Dec 2019 12:53:17 +0000 (GMT)
Date:   Fri, 6 Dec 2019 18:23:17 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: Optimize select_idle_core
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191205172316.8198-1-srikar@linux.vnet.ibm.com>
 <6242deaa-e570-3384-0737-e49abb0599dd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <6242deaa-e570-3384-0737-e49abb0599dd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19120612-4275-0000-0000-0000038C63DA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120612-4276-0000-0000-000038A00C9D
Message-Id: <20191206125317.GC22330@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_03:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912060110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Valentin,

> Say you have a 4-core SMT2 system with the usual numbering scheme:
> 
> {0, 4}  {1, 5}  {2, 6}  {3, 7}
> CORE0   CORE1   CORE2   CORE3
> 
> 
> Say 'target' is the prev_cpu, in that case let's pick 5. Because we do a
> for_each_cpu_wrap(), our iteration for 'core' would start with 
> 
>   5, 6, 7, ...
> 
> So say CORE2 is entirely idle and CORE1 isn't, we would go through the
> inner loop on CORE1 (with 'core' == 5), then go through CORE2 (with
> 'core' == 6) and return 'core'. I find it a bit unusual that we wouldn't
> return the first CPU in the SMT mask, usually we try to fill sched_groups
> in cpumask order.
> 
> 
> If we could have 'cpus' start with only primary CPUs, that would simplify
> things methinks:
> 

Its probably something to think over. I probably don't have an answer on why
we are not choosing the starting cpu to be primary CPU.  Would we have to
think of the case where the Primary CPUs are online / offline etc? I mean
with target cpu, we know the CPU is online for sure.

>   for_each_cpu_wrap(core, cpus, target) {
> 	  bool idle = true;
> 
> 	  for_each_cpu(cpu, cpu_smt_mask(core)) {
> 		  if (!available_idle_cpu(cpu)) {
> 			  idle = false;
> 			  break;
> 		  }
> 
> 	  __cpumask_clear_cpu(core, cpus);
> 
> 	  if (idle)
> 		  return core;
> 
> 
> Food for thought; your change itself looks fine as it is.
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 

Thanks for the review.

-- 
Thanks and Regards
Srikar Dronamraju

