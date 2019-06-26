Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EEADC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4700F20B7C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfFZJkG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:40:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbfFZJkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:40:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5Q9cd6m050406
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:40:04 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tc5g1t1a3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 05:40:04 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Wed, 26 Jun 2019 10:40:02 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 26 Jun 2019 10:39:58 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5Q9dm2T15729130
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 09:39:48 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC53F4C046;
        Wed, 26 Jun 2019 09:39:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AD584C044;
        Wed, 26 Jun 2019 09:39:57 +0000 (GMT)
Received: from localhost (unknown [9.124.35.28])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jun 2019 09:39:57 +0000 (GMT)
Date:   Wed, 26 Jun 2019 15:09:56 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 7/7] powerpc/kprobes: Allow probing on any ftrace address
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <cover.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <d26f5467577ff0aeecea55e7035ea64e303bdf17.1560868106.git.naveen.n.rao@linux.vnet.ibm.com>
        <20190621235034.acc00fc3e2b2c7e89caa1fd5@kernel.org>
In-Reply-To: <20190621235034.acc00fc3e2b2c7e89caa1fd5@kernel.org>
User-Agent: astroid/0.14.0 (https://github.com/astroidmail/astroid)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
x-cbid: 19062609-0020-0000-0000-0000034D817E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062609-0021-0000-0000-000021A0F5C4
Message-Id: <1561541820.15ifr1qex2.naveen@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-26_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=688 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu wrote:
> On Tue, 18 Jun 2019 20:17:06 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
>> With KPROBES_ON_FTRACE, kprobe is allowed to be inserted on instructions
>> that branch to _mcount (referred to as ftrace location). With
>> -mprofile-kernel, we now include the preceding 'mflr r0' as being part
>> of the ftrace location.
>> 
>> However, by default, probing on an instruction that is not actually the
>> branch to _mcount() is prohibited, as that is considered to not be at an
>> instruction boundary. This is not the case on powerpc, so allow the same
>> by overriding arch_check_ftrace_location()
>> 
>> In addition, we update kprobe_ftrace_handler() to detect this scenarios
>> and to pass the proper nip to the pre and post probe handlers.
>> 
>> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/kprobes-ftrace.c | 30 ++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
>> index 972cb28174b2..6a0bd3c16cb6 100644
>> --- a/arch/powerpc/kernel/kprobes-ftrace.c
>> +++ b/arch/powerpc/kernel/kprobes-ftrace.c
>> @@ -12,14 +12,34 @@
>>  #include <linux/preempt.h>
>>  #include <linux/ftrace.h>
>>  
>> +/*
>> + * With -mprofile-kernel, we patch two instructions -- the branch to _mcount
>> + * as well as the preceding 'mflr r0'. Both these instructions are claimed
>> + * by ftrace and we should allow probing on either instruction.
>> + */
>> +int arch_check_ftrace_location(struct kprobe *p)
>> +{
>> +	if (ftrace_location((unsigned long)p->addr))
>> +		p->flags |= KPROBE_FLAG_FTRACE;
>> +	return 0;
>> +}
>> +
>>  /* Ftrace callback handler for kprobes */
>>  void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
>>  			   struct ftrace_ops *ops, struct pt_regs *regs)
>>  {
>>  	struct kprobe *p;
>> +	int mflr_kprobe = 0;
>>  	struct kprobe_ctlblk *kcb;
>>  
>>  	p = get_kprobe((kprobe_opcode_t *)nip);
>> +	if (unlikely(!p)) {
> 
> Hmm, is this really unlikely? If we put a kprobe on the second instruction address,
> we will see p == NULL always.
> 
>> +		p = get_kprobe((kprobe_opcode_t *)(nip - MCOUNT_INSN_SIZE));
>> +		if (!p)
> 
> Here will be unlikely, because we can not find kprobe at both of nip and
> nip - MCOUNT_INSN_SIZE.
> 
>> +			return;
>> +		mflr_kprobe = 1;
>> +	}
>> +
>>  	if (unlikely(!p) || kprobe_disabled(p))
> 
> "unlikely(!p)" is not needed here.

...

Joe Perches wrote:
> On Fri, 2019-06-21 at 23:50 +0900, Masami Hiramatsu wrote:
>> On Tue, 18 Jun 2019 20:17:06 +0530
>> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> trivia:
> 
>> > diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
> []
>> > @@ -57,6 +82,11 @@ NOKPROBE_SYMBOL(kprobe_ftrace_handler);
>> >  
>> >  int arch_prepare_kprobe_ftrace(struct kprobe *p)
>> >  {
>> > +	if ((unsigned long)p->addr & 0x03) {
>> > +		printk("Attempt to register kprobe at an unaligned address\n");
> 
> Please use the appropriate KERN_<LEVEL> or pr_<level>
> 

All good points. Thanks for the review.


- Naveen


