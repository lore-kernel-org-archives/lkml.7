Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A324DC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8326C21A4C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbfJALhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:37:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbfJALhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:37:09 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91BWRV5072775
        for <linux-kernel@vger.kernel.org>; Tue, 1 Oct 2019 07:37:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vc5kxrx9f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 07:37:07 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Tue, 1 Oct 2019 12:37:05 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 1 Oct 2019 12:37:01 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x91Bb0Qe57082092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 11:37:00 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FFCA11C054;
        Tue,  1 Oct 2019 11:37:00 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CFE711C04A;
        Tue,  1 Oct 2019 11:36:57 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.122.211.122])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  1 Oct 2019 11:36:57 +0000 (GMT)
Date:   Tue, 1 Oct 2019 17:06:56 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        bigeasy@linutronix.de, tglx@linutronix.de, thgarnie@google.com,
        tytso@mit.edu, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, mingo@redhat.com, will@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Subject: Re: [PATCH] sched: Avoid spurious lock dependencies
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1568392064-3052-1-git-send-email-cai@lca.pw>
 <20190925093153.GC4553@hirez.programming.kicks-ass.net>
 <1569424727.5576.221.camel@lca.pw>
 <20190925164527.GG4553@hirez.programming.kicks-ass.net>
 <1569500974.5576.234.camel@lca.pw>
 <20191001091837.GK4536@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-TM-AS-GCONF: 00
x-cbid: 19100111-0008-0000-0000-0000031CBD92
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100111-0009-0000-0000-00004A3B677A
Message-Id: <20191001113513.GB32306@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=27 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: sched: Avoid spurious lock dependencies
> 
> While seemingly harmless, __sched_fork() does hrtimer_init(), which,
> when DEBUG_OBJETS, can end up doing allocations.
> 

NIT: s/DEBUG_OBJETS/DEBUG_OBJECTS

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7880f4f64d0e..1832fc0fbec5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6039,10 +6039,11 @@ void init_idle(struct task_struct *idle, int cpu)
>  	struct rq *rq = cpu_rq(cpu);
>  	unsigned long flags;
>  
> +	__sched_fork(0, idle);
> +
>  	raw_spin_lock_irqsave(&idle->pi_lock, flags);
>  	raw_spin_lock(&rq->lock);
>  
> -	__sched_fork(0, idle);
>  	idle->state = TASK_RUNNING;
>  	idle->se.exec_start = sched_clock();
>  	idle->flags |= PF_IDLE;
> 

Given that there is a comment just after this which says
"init_task() gets called multiple times on a task",
should we add a check if rq->idle is present and bail out?

if (rq->idle) {
    raw_spin_unlock(&rq->lock);
    raw_spin_unlock_irqrestore(&idle->pi_lock, flags);
    return;
}

Also can we also move the above 3 statements before the lock?


-- 
Thanks and Regards
Srikar Dronamraju

