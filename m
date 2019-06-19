Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD41C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 427A720B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 09:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfFSJxh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 05:53:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56006 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbfFSJxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 05:53:37 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5J9lkKL023815
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:53:36 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t7gbhfw13-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 05:53:36 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 19 Jun 2019 10:53:33 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 19 Jun 2019 10:53:30 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5J9rTFH47251624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 09:53:29 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A40804C046;
        Wed, 19 Jun 2019 09:53:29 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 528D84C040;
        Wed, 19 Jun 2019 09:53:29 +0000 (GMT)
Received: from localhost (unknown [9.124.35.165])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 19 Jun 2019 09:53:29 +0000 (GMT)
Date:   Wed, 19 Jun 2019 15:23:26 +0530
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
In-Reply-To: <1560927184.kqsg9x9bd1.astroid@bobo.none>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19061909-0008-0000-0000-000002F51480
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061909-0009-0000-0000-000022622F79
Message-Id: <1560935530.70niyxru6o.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906190081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Piggin wrote:
> Michael Ellerman's on June 19, 2019 3:14 pm:
>> Hi Naveen,
>> 
>> Sorry I meant to reply to this earlier .. :/

No problem. Thanks for the questions.

>> 
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
>>> With -mprofile-kernel, gcc emits 'mflr r0', followed by 'bl _mcount' to
>>> enable function tracing and profiling. So far, with dynamic ftrace, we
>>> used to only patch out the branch to _mcount(). However, mflr is
>>> executed by the branch unit that can only execute one per cycle on
>>> POWER9 and shared with branches, so it would be nice to avoid it where
>>> possible.
>>>
>>> We cannot simply nop out the mflr either. When enabling function
>>> tracing, there can be a race if tracing is enabled when some thread was
>>> interrupted after executing a nop'ed out mflr. In this case, the thread
>>> would execute the now-patched-in branch to _mcount() without having
>>> executed the preceding mflr.
>>>
>>> To solve this, we now enable function tracing in 2 steps: patch in the
>>> mflr instruction, use synchronize_rcu_tasks() to ensure all existing
>>> threads make progress, and then patch in the branch to _mcount(). We
>>> override ftrace_replace_code() with a powerpc64 variant for this
>>> purpose.
>> 
>> According to the ISA we're not allowed to patch mflr at runtime. See the
>> section on "CMODX".
> 
> According to "quasi patch class" engineering note, we can patch
> anything with a preferred nop. But that's written as an optional
> facility, which we don't have a feature to test for.
> 

Hmm... I wonder what the implications are. We've been patching in a 
'trap' for kprobes for a long time now, along with having to patch back 
the original instruction (which can be anything), when the probe is 
removed.

>> 
>> I'm also not convinced the ordering between the two patches is
>> guaranteed by the ISA, given that there's possibly no isync on the other
>> CPU.
> 
> Will they go through a context synchronizing event?
> 
> synchronize_rcu_tasks() should ensure a thread is scheduled away, but
> I'm not actually sure it guarantees CSI if it's kernel->kernel. Could
> do a smp_call_function to do the isync on each CPU to be sure.

Good point. Per 
Documentation/RCU/Design/Requirements/Requirements.html#Tasks RCU:
"The solution, in the form of Tasks RCU, is to have implicit read-side 
critical sections that are delimited by voluntary context switches, that 
is, calls to schedule(), cond_resched(), and synchronize_rcu_tasks(). In 
addition, transitions to and from userspace execution also delimit 
tasks-RCU read-side critical sections."

I suppose transitions to/from userspace, as well as calls to schedule() 
result in context synchronizing instruction being executed. But, if some 
tasks call cond_resched() and synchronize_rcu_tasks(), we probably won't 
have a CSI executed.

Also:
"In CONFIG_PREEMPT=n kernels, trampolines cannot be preempted, so these 
APIs map to call_rcu(), synchronize_rcu(), and rcu_barrier(), 
respectively."

In this scenario as well, I think we won't have a CSI executed in case 
of cond_resched().

Should we enhance patch_instruction() to handle that?


- Naveen

