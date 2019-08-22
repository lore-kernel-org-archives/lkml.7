Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E0AC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4F9233A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 10:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387542AbfHVKWP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 06:22:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22654 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbfHVKWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 06:22:15 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7MAImaV067976
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:22:13 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uhnug7g7k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 06:22:13 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 22 Aug 2019 11:22:11 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 22 Aug 2019 11:22:07 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7MAM6KX48169076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Aug 2019 10:22:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2920A404D;
        Thu, 22 Aug 2019 10:22:06 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D12CA4040;
        Thu, 22 Aug 2019 10:22:06 +0000 (GMT)
Received: from localhost (unknown [9.199.32.226])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Aug 2019 10:22:06 +0000 (GMT)
Date:   Thu, 22 Aug 2019 15:52:05 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] arm64: implement KPROBES_ON_FTRACE
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20190822113421.52920377@xhacker.debian>
        <1566456155.27ojwy97ss.naveen@linux.ibm.com>
        <20190822173558.63de3fc4@xhacker.debian>
In-Reply-To: <20190822173558.63de3fc4@xhacker.debian>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19082210-0016-0000-0000-000002A16D6B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082210-0017-0000-0000-00003301A5EE
Message-Id: <1566468150.x8u1577wgh.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=699 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908220111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jisheng Zhang wrote:
> Hi,
> 
> On Thu, 22 Aug 2019 12:23:58 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
>> Jisheng Zhang wrote:
...
>> > +/* Ftrace callback handler for kprobes -- called under preepmt 
>> > disabed */
>> > +void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>> > +                        struct ftrace_ops *ops, struct pt_regs *regs)
>> > +{
>> > +     struct kprobe *p;
>> > +     struct kprobe_ctlblk *kcb;
>> > +
>> > +     /* Preempt is disabled by ftrace */
>> > +     p = get_kprobe((kprobe_opcode_t *)ip);
>> > +     if (unlikely(!p) || kprobe_disabled(p))
>> > +             return;
>> > +
>> > +     kcb = get_kprobe_ctlblk();
>> > +     if (kprobe_running()) {
>> > +             kprobes_inc_nmissed_count(p);
>> > +     } else {
>> > +             unsigned long orig_ip = instruction_pointer(regs);
>> > +             /* Kprobe handler expects regs->pc = pc + 4 as breakpoint hit */
>> > +             instruction_pointer_set(regs, ip + sizeof(kprobe_opcode_t));  
>> 
>> Just want to make sure that you've confirmed that this is what happens
>> with a regular trap/brk based kprobe on ARM64. The reason for setting
>> the instruction pointer here is to ensure that it is set to the same
>> value as would be set if there was a trap/brk instruction at the ftrace
>> location. This ensures that the kprobe pre handler sees the same value
>> regardless.
> 
> Due to the arm64's DYNAMIC_FTRACE_WITH_REGS implementation, the code itself
> is correct. But this doesn't look like "there was a trap instruction at
> the ftrace location".
> 
> W/O KPROBE_ON_FTRACE:
> 
> foo:
> 00	insA
> 04	insB
> 08	insC
> 
> kprobe's pre_handler() will see pc points to 00.

In this case, the probe will be placed at foo+0x00, so pre_handler() 
seeing that address in pt_regs is correct behavior - as long as arm64 
'brk' instruction causes an exception with the instruction pointer set 
*to* the 'brk' instruction. This is similar to how powerpc 'trap' works.  
However, x86 'int3' causes an exception *after* execution of the 
instruction.

> 
> W/ KPROBE_ON_FTRACE:
> 
> foo:
> 00	lr saver
> 04	nop     // will be modified to ftrace call ins when KPROBE is armed
> 08	insA
> 0c	insB

In this case, if user asks for a probe to be placed at 'foo', we will 
choose foo+0x04 and from that point on, the behavior should reflect that 
a kprobe was placed at foo+0x04. In particular, the pre_handler() should 
see foo+0x04 in pt_regs. The post_handler() would then see foo+0x08.

> 
> later, kprobe_ftrace_handler() will see pc points to 04, so pc + 4 will
> point to 08 the same as the one w/o KPROBE_ON_FTRACE.

I didn't mean to compare regular trap/brk based kprobes with 
KPROBES_ON_FTRACE. The only important aspect is that the handlers see 
consistent pt_regs in both cases, depending on where the kprobe was 
placed. Choosing a different address/offset to place a kprobe during its 
registration is an orthogonal aspect.

> 
> It seems I need to fix the comment.

Given your explanation above, I think you can simply drop the first 
adjustment to the instruction pointer before the pre handler invocation.  
The rest of the code looks fine.


- Naveen

