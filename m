Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F95A2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfC1QW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:22:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbfC1QW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:22:29 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2SGK2bE054103
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:22:27 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rh1ndr7kj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:22:27 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 28 Mar 2019 16:22:26 -0000
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 28 Mar 2019 16:22:22 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2SGML6B22347934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Mar 2019 16:22:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C1FCB206A;
        Thu, 28 Mar 2019 16:22:21 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FAB8B2067;
        Thu, 28 Mar 2019 16:22:21 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 28 Mar 2019 16:22:21 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3445C16C3799; Thu, 28 Mar 2019 09:22:22 -0700 (PDT)
Date:   Thu, 28 Mar 2019 09:22:22 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>
Subject: Re: Potentially missing "memory" clobbers in bitops.h for x86
Reply-To: paulmck@linux.ibm.com
References: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032816-0068-0000-0000-000003AC737E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010829; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01180951; UDB=6.00618066; IPR=6.00961669;
 MB=3.00026196; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-28 16:22:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032816-0069-0000-0000-000047F700C3
Message-Id: <20190328162222.GO4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903280110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 03:14:12PM +0100, Alexander Potapenko wrote:
> Hello,
> 
> arch/x86/include/asm/bitops.h defines clear_bit(nr, addr) for
> non-constant |nr| values as follows:
> 
> void clear_bit(long nr, volatile unsigned long *addr) {
>   asm volatile("lock; btr %1,%0"
>     : "+m"(*(volatile long *)addr)
>     : "Ir" (nr));
>   }
> (https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/bitops.h#L111)
> 
> According to the comments in the file, |nr| may be arbitrarily large.
> However the assembly constraints only imply that the first unsigned
> long value at |addr| is written to.
> This may result in the compiler ignoring the effect of the asm directive.
> 
> Consider the following example (https://godbolt.org/z/naTmjn):
> 
>   #include <stdio.h>
>   void clear_bit(long nr, volatile unsigned long *addr) {
>     asm volatile("lock; btr %1,%0"
>       : "+m"(*(volatile long *)addr)
>       : "Ir" (nr));
>   }
> 
>   unsigned long foo() {
>     unsigned long addr[2] = {1, 2};
>     clear_bit(65, addr);
>     return addr[0] + addr[1];
>   }
> 
>   int main() {
>     printf("foo: %lu\n", foo());
>   }
> 
> Depending on the optimization level, the program may print either 1
> (for -O0 and -O1) or 3 (for -O2 and -O3).
> This is because on higher optimization levels GCC assumes that addr[1]
> is unchanged and directly propagates the constant to the result.
> 
> I suspect the definitions of clear_bit() and similar functions are
> lacking the "memory" clobber.
> But the whole file tends to be very picky about whether this clobber
> needs to be applied in each case, so in the case of a performance
> penalty we may need to consider alternative approaches to fixing this
> code.

Is there a way of indicating a clobber only on the specific location
affected?  I suppose that one approach would be to calculate in C code
a pointer to the specific element of the addr[] array, which would
put the specific clobbered memory location onto the outputs list.
Or keep the current calculation, but also add "addr[nr / sizeof(long)]"
to the output list, thus telling the compiler exactly what is being
clobbered.  Assuming that actually works...

Of course, this would force the compiler to actually compute the
offset, which would slow things down.  I have no idea whether this
would be better or worse than just using the "memory" clobber.

							Thanx, Paul

