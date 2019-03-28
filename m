Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FBC7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94882173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 07:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbfC1HuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 03:50:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbfC1HuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 03:50:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2S7nvBO048834
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:50:06 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rgq2wqjp7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 03:50:05 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Thu, 28 Mar 2019 07:49:59 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 07:49:51 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2S7noY654722630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 07:49:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB9BA4203F;
        Thu, 28 Mar 2019 07:49:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAF6942041;
        Thu, 28 Mar 2019 07:49:49 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.176.227])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 07:49:49 +0000 (GMT)
Date:   Thu, 28 Mar 2019 08:49:48 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     "Carlos O'Donell" <codonell@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        carlos <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup
 and thread creation (v7)
In-Reply-To: <4021516e-6a1e-166d-a4f6-e961e6f94cc4@redhat.com>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
        <20190212194253.1951-2-mathieu.desnoyers@efficios.com>
        <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
        <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
        <20190327101608.77b0de6f@mschwideX1>
        <4021516e-6a1e-166d-a4f6-e961e6f94cc4@redhat.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032807-4275-0000-0000-000003205DBC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032807-4276-0000-0000-0000382EFA53
Message-Id: <20190328084948.6486fa67@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2019 16:38:32 -0400
"Carlos O'Donell" <codonell@redhat.com> wrote:

> On 3/27/19 5:16 AM, Martin Schwidefsky wrote:
> > On Mon, 25 Mar 2019 11:54:32 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >>>> +++ b/sysdeps/unix/sysv/linux/s390/bits/rseq.h  
> >> [...]  
> >>>> +
> >>>> +/* Signature required before each abort handler code.  */
> >>>> +#define RSEQ_SIG 0x53053053  
> >>>
> >>> Why not a s390 specific value here?  
> >>
> >> s390 also has the abort handler in a __rseq_failure section:
> >>
> >> #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)             \
> >>                  ".pushsection __rseq_failure, \"ax\"\n\t"               \
> >>                  ".long " __rseq_str(RSEQ_SIG) "\n\t"                    \
> >>                  __rseq_str(label) ":\n\t"                               \
> >>                  teardown                                                \
> >>                  "j %l[" __rseq_str(abort_label) "]\n\t"                 \
> >>                  ".popsection\n\t"
> >>
> >> Same question applies as powerpc: since disassemblers will try to decode
> >> that instruction, would it be better to define it as a valid one ?
> >>
> >> [...]  
> > 
> > A 4-byte sequence starting with 0x53 is decoded as a "diebr" instruction.
> > And please replace that "j %l[...]" with a "jg %l[...]", the branch target
> > range of the "j" instruction is 64K, not enough for the general case.  
> 
> Why was this particular operated selected?
>   
> So on s390 the RSEQ_SIG will show up as an unexpected "divide to integer"
> instruction that can't be reached by any control flow?
> 
> Can we use a NOP with a unique value in an immediate operand?
> 
> The goal being to have something that won't confuse during a debug
> session, or that the debugger can ignore (like constant pools on Arm)

I was looking at the wrong table in regard to opcode 0x53. The pattern
0x53...... is not a known instruction as far as the disassembler is
concerned. As Mathieu pointed out "diebr" is actually 0xb353....
Sorry about the confusion.

But why do we need this value in the first place if it can not be reached?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

