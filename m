Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2562CC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E48251F7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfE3IjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:39:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55768 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbfE3IjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:39:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4U8bas4138555
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:38:59 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sta87mtnc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 04:38:59 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 30 May 2019 09:38:56 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 30 May 2019 09:38:51 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4U8covW52690944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 08:38:50 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 206FD4C044;
        Thu, 30 May 2019 08:38:50 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 277EC4C050;
        Thu, 30 May 2019 08:38:47 +0000 (GMT)
Received: from [9.124.31.34] (unknown [9.124.31.34])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 May 2019 08:38:46 +0000 (GMT)
Subject: Re: [PATCH] perf: Fix oops when kthread execs user process
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Young Xiao <92siuyang@gmail.com>, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, x86@kernel.org, kan.liang@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ravi.bangoria@linux.vnet.ibm.com, mpe@ellerman.id.au,
        acme@redhat.com, eranian@google.com, fweisbec@gmail.com,
        jolsa@redhat.com, ravi.bangoria@linux.ibm.com
References: <1559046689-24091-1-git-send-email-92siuyang@gmail.com>
 <20190528140103.GT2623@hirez.programming.kicks-ass.net>
 <20190528153224.GE20758@fuggles.cambridge.arm.com>
 <20190528173228.GW2623@hirez.programming.kicks-ass.net>
 <20190529091733.GA4485@fuggles.cambridge.arm.com>
 <20190529101042.GN2623@hirez.programming.kicks-ass.net>
 <20190529102022.GC4485@fuggles.cambridge.arm.com>
 <20190529125557.GU2623@hirez.programming.kicks-ass.net>
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Date:   Thu, 30 May 2019 14:08:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529125557.GU2623@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19053008-0016-0000-0000-00000280EC8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19053008-0017-0000-0000-000032DE01CA
Message-Id: <efcd5cf4-3501-f3b6-bf47-145a9ef19a53@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300066
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/19 6:25 PM, Peter Zijlstra wrote:
> On Wed, May 29, 2019 at 11:20:22AM +0100, Will Deacon wrote:
>> Anyway, you can add my ack to your patch, but I bet we can remove that mm
>> check :D
> 
> I've ended up with the below. Ravi, can you test if that does indeed
> obsolete your PPC patch?

Checking.

> 
> ---
> Subject: perf: Fix perf_sample_regs_user()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Wed May 29 14:37:24 CEST 2019
> 
> perf_sample_regs_user() uses 'current->mm' to test for the presence of
> userspace, but this is insufficient, consider use_mm().
> 
> A better test is: '!(current->flags & PF_KTHREAD)', exec() clears
> PF_KTHREAD after it sets the new ->mm but before it drops to userspace
> for the first time.

This looks correct. I'll give it a try.

> 
> Possibly obsoletes: bf05fc25f268 ("powerpc/perf: Fix oops when kthread execs user process")
> 
> Reported-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Reported-by: Young Xiao <92siuyang@gmail.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Fixes: 4018994f3d87 ("perf: Add ability to attach user level registers dump to sample")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -5923,7 +5923,7 @@ static void perf_sample_regs_user(struct
>  	if (user_mode(regs)) {
>  		regs_user->abi = perf_reg_abi(current);
>  		regs_user->regs = regs;
> -	} else if (current->mm) {
> +	} else if (!(current->flags & PF_KTHREAD)) {
>  		perf_get_regs_user(regs_user, regs, regs_user_copy);
>  	} else {
>  		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
> 

