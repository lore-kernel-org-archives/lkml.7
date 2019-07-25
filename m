Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D851AC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A564321951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbfGYRf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:35:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729029AbfGYRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:35:27 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PFvFM0097485
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 13:35:26 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tyer2wvry-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 13:35:26 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Thu, 25 Jul 2019 18:35:24 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 18:35:20 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6PHZJOf56951024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:35:19 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 535D35204F;
        Thu, 25 Jul 2019 17:35:19 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 6D34E5204E;
        Thu, 25 Jul 2019 17:35:17 +0000 (GMT)
Date:   Thu, 25 Jul 2019 23:05:16 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@redhat.com>,
        Mel Gorman <mgorman@suse.de>, jhladky@redhat.com,
        lvenanci@redhat.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] autonuma: Fix scan period updating
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20190725080124.494-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190725080124.494-1-ying.huang@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19072517-0012-0000-0000-00000336397E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072517-0013-0000-0000-0000216FD20C
Message-Id: <20190725173516.GA16399@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Huang, Ying <ying.huang@intel.com> [2019-07-25 16:01:24]:

> From: Huang Ying <ying.huang@intel.com>
> 
> From the commit log and comments of commit 37ec97deb3a8 ("sched/numa:
> Slow down scan rate if shared faults dominate"), the autonuma scan
> period should be increased (scanning is slowed down) if the majority
> of the page accesses are shared with other processes.  But in current
> code, the scan period will be decreased (scanning is speeded up) in
> that situation.
> 
> The commit log and comments make more sense.  So this patch fixes the
> code to make it match the commit log and comments.  And this has been
> verified via tracing the scan period changing and /proc/vmstat
> numa_pte_updates counter when running a multi-threaded memory
> accessing program (most memory areas are accessed by multiple
> threads).
> 

Lets split into 4 modes.
More Local and Private Page Accesses:
We definitely want to scan slowly i.e increase the scan window.

More Local and Shared Page Accesses:
We still want to scan slowly because we have consolidated and there is no
point in scanning faster. So scan slowly + increase the scan window.
(Do remember access on any active node counts as local!!!)

More Remote + Private page Accesses:
Most likely the Private accesses are going to be local accesses.

In the unlikely event of the private accesses not being local, we should
scan faster so that the memory and task consolidates.

More Remote + Shared page Accesses: This means the workload has not
consolidated and needs to scan faster. So we need to scan faster.

So I would think we should go back to before 37ec97deb3a8.

i.e 

	int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;

	if (!slot)
		slot = 1;
	diff = slot * period_slot;


No?

> Fixes: 37ec97deb3a8 ("sched/numa: Slow down scan rate if shared faults dominate")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Rik van Riel <riel@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: jhladky@redhat.com
> Cc: lvenanci@redhat.com
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  kernel/sched/fair.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 036be95a87e9..468a1c5038b2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1940,7 +1940,7 @@ static void update_task_scan_period(struct task_struct *p,
>  			unsigned long shared, unsigned long private)
>  {
>  	unsigned int period_slot;
> -	int lr_ratio, ps_ratio;
> +	int lr_ratio, sp_ratio;
>  	int diff;
>  
>  	unsigned long remote = p->numa_faults_locality[0];
> @@ -1971,22 +1971,22 @@ static void update_task_scan_period(struct task_struct *p,
>  	 */
>  	period_slot = DIV_ROUND_UP(p->numa_scan_period, NUMA_PERIOD_SLOTS);
>  	lr_ratio = (local * NUMA_PERIOD_SLOTS) / (local + remote);
> -	ps_ratio = (private * NUMA_PERIOD_SLOTS) / (private + shared);
> +	sp_ratio = (shared * NUMA_PERIOD_SLOTS) / (private + shared);
>  
> -	if (ps_ratio >= NUMA_PERIOD_THRESHOLD) {
> +	if (sp_ratio >= NUMA_PERIOD_THRESHOLD) {
>  		/*
> -		 * Most memory accesses are local. There is no need to
> -		 * do fast NUMA scanning, since memory is already local.
> +		 * Most memory accesses are shared with other tasks.
> +		 * There is no point in continuing fast NUMA scanning,
> +		 * since other tasks may just move the memory elsewhere.

With this change, I would expect that with Shared page accesses,
consolidation to take a hit.

>  		 */
> -		int slot = ps_ratio - NUMA_PERIOD_THRESHOLD;
> +		int slot = sp_ratio - NUMA_PERIOD_THRESHOLD;
>  		if (!slot)
>  			slot = 1;
>  		diff = slot * period_slot;
>  	} else if (lr_ratio >= NUMA_PERIOD_THRESHOLD) {
>  		/*
> -		 * Most memory accesses are shared with other tasks.
> -		 * There is no point in continuing fast NUMA scanning,
> -		 * since other tasks may just move the memory elsewhere.
> +		 * Most memory accesses are local. There is no need to
> +		 * do fast NUMA scanning, since memory is already local.

Comment wise this make sense.

>  		 */
>  		int slot = lr_ratio - NUMA_PERIOD_THRESHOLD;
>  		if (!slot)
> @@ -1998,7 +1998,7 @@ static void update_task_scan_period(struct task_struct *p,
>  		 * yet they are not on the local NUMA node. Speed up
>  		 * NUMA scanning to get the memory moved over.
>  		 */
> -		int ratio = max(lr_ratio, ps_ratio);
> +		int ratio = max(lr_ratio, sp_ratio);
>  		diff = -(NUMA_PERIOD_THRESHOLD - ratio) * period_slot;
>  	}
>  
> -- 
> 2.20.1
> 

-- 
Thanks and Regards
Srikar Dronamraju

