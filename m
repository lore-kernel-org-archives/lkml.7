Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C036FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99BB42075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbfC0JQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:16:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726257AbfC0JQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:16:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2R95Omt152533
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 05:16:21 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rg3ymdp98-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 05:16:20 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <schwidefsky@de.ibm.com>;
        Wed, 27 Mar 2019 09:16:18 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 09:16:13 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2R9GCjZ36962526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 09:16:12 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22B34A4060;
        Wed, 27 Mar 2019 09:16:12 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DADB7A405C;
        Wed, 27 Mar 2019 09:16:10 +0000 (GMT)
Received: from mschwideX1 (unknown [9.145.35.252])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 Mar 2019 09:16:10 +0000 (GMT)
Date:   Wed, 27 Mar 2019 10:16:08 +0100
From:   Martin Schwidefsky <schwidefsky@de.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Carlos O'Donell" <codonell@redhat.com>,
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
In-Reply-To: <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
        <20190212194253.1951-2-mathieu.desnoyers@efficios.com>
        <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
        <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19032709-0012-0000-0000-00000307A146
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032709-0013-0000-0000-0000213ECD18
Message-Id: <20190327101608.77b0de6f@mschwideX1>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=740 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 11:54:32 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> >> +++ b/sysdeps/unix/sysv/linux/s390/bits/rseq.h  
> [...]
> >> +
> >> +/* Signature required before each abort handler code.  */
> >> +#define RSEQ_SIG 0x53053053  
> > 
> > Why not a s390 specific value here?  
> 
> s390 also has the abort handler in a __rseq_failure section:
> 
> #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)             \
>                 ".pushsection __rseq_failure, \"ax\"\n\t"               \
>                 ".long " __rseq_str(RSEQ_SIG) "\n\t"                    \
>                 __rseq_str(label) ":\n\t"                               \
>                 teardown                                                \
>                 "j %l[" __rseq_str(abort_label) "]\n\t"                 \
>                 ".popsection\n\t"
> 
> Same question applies as powerpc: since disassemblers will try to decode
> that instruction, would it be better to define it as a valid one ?
> 
> [...]

A 4-byte sequence starting with 0x53 is decoded as a "diebr" instruction.
And please replace that "j %l[...]" with a "jg %l[...]", the branch target
range of the "j" instruction is 64K, not enough for the general case.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.

