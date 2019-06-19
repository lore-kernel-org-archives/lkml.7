Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3620C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12E020665
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbfFSRPK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:15:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbfFSRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:15:09 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5JHC3uU172612
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:15:08 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t7r2p3xhk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 13:15:08 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 19 Jun 2019 18:15:06 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 18:15:03 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5JHF2qf45809886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 17:15:02 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 541C452059;
        Wed, 19 Jun 2019 17:15:02 +0000 (GMT)
Received: from localhost (unknown [9.85.70.229])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id F01395204F;
        Wed, 19 Jun 2019 17:15:01 +0000 (GMT)
Date:   Wed, 19 Jun 2019 22:44:56 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 4/7] powerpc/ftrace: Additionally nop out the preceding
 mflr with -mprofile-kernel
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <72492bc769cd6f40a536e689fc3195570d07fd5c.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <877e9idum7.fsf@concordia.ellerman.id.au>
        <1560927184.kqsg9x9bd1.astroid@bobo.none>
        <1560935530.70niyxru6o.naveen@linux.ibm.com>
        <1560939496.ovo51ph4i4.astroid@bobo.none>
In-Reply-To: <1560939496.ovo51ph4i4.astroid@bobo.none>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19061917-0016-0000-0000-0000028A95A4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061917-0017-0000-0000-000032E7EDD6
Message-Id: <1560961996.5xzl76c7fj.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin wrote:
> Naveen N. Rao's on June 19, 2019 7:53 pm:
>> Nicholas Piggin wrote:
>>> Michael Ellerman's on June 19, 2019 3:14 pm:
>>>> 
>>>> I'm also not convinced the ordering between the two patches is
>>>> guaranteed by the ISA, given that there's possibly no isync on the other
>>>> CPU.
>>> 
>>> Will they go through a context synchronizing event?
>>> 
>>> synchronize_rcu_tasks() should ensure a thread is scheduled away, but
>>> I'm not actually sure it guarantees CSI if it's kernel->kernel. Could
>>> do a smp_call_function to do the isync on each CPU to be sure.
>> 
>> Good point. Per 
>> Documentation/RCU/Design/Requirements/Requirements.html#Tasks RCU:
>> "The solution, in the form of Tasks RCU, is to have implicit read-side 
>> critical sections that are delimited by voluntary context switches, that 
>> is, calls to schedule(), cond_resched(), and synchronize_rcu_tasks(). In 
>> addition, transitions to and from userspace execution also delimit 
>> tasks-RCU read-side critical sections."
>> 
>> I suppose transitions to/from userspace, as well as calls to schedule() 
>> result in context synchronizing instruction being executed. But, if some 
>> tasks call cond_resched() and synchronize_rcu_tasks(), we probably won't 
>> have a CSI executed.
>> 
>> Also:
>> "In CONFIG_PREEMPT=n kernels, trampolines cannot be preempted, so these 
>> APIs map to call_rcu(), synchronize_rcu(), and rcu_barrier(), 
>> respectively."
>> 
>> In this scenario as well, I think we won't have a CSI executed in case 
>> of cond_resched().
>> 
>> Should we enhance patch_instruction() to handle that?
> 
> Well, not sure. Do we have many post-boot callers of it? Should
> they take care of their own synchronization requirements?

Kprobes and ftrace are the two users (along with anything else that may 
use jump labels).

Looking at this from the CMODX perspective: the main example quoted of 
an erratic behavior is when any variant of the patched instruction 
causes an exception.

With ftrace, I think we are ok since we only ever patch a 'nop' or a 
'bl' (and the 'mflr' now), none of which should cause an exception. As 
such, the existing patch_instruction() should suffice.

However, with kprobes, we patch a 'trap' (or a branch in case of 
optprobes) on most instructions. I wonder if we should be issuing an 
'isync' on all cpus in this case. Or, even if that is sufficient or 
necessary.


Thanks,
Naveen


