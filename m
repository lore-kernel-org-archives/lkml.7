Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BBDC3A5A2
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C013E21897
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 03:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfIDDgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 23:36:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28206 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727701AbfIDDgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 23:36:21 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x843Wrur016805
        for <linux-kernel@vger.kernel.org>; Tue, 3 Sep 2019 23:36:20 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ut51arqte-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:36:19 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Wed, 4 Sep 2019 04:36:17 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 4 Sep 2019 04:36:11 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x843aA2W52232316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Sep 2019 03:36:11 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB8B3A4059;
        Wed,  4 Sep 2019 03:36:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 426EBA404D;
        Wed,  4 Sep 2019 03:36:10 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Sep 2019 03:36:10 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D619DA0147;
        Wed,  4 Sep 2019 13:36:08 +1000 (AEST)
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Allison Randal <allison@lohutok.net>
Date:   Wed, 04 Sep 2019 13:36:08 +1000
In-Reply-To: <20190903160415.GA9749@gate.crashing.org>
References: <20190903052407.16638-1-alastair@au1.ibm.com>
         <20190903052407.16638-4-alastair@au1.ibm.com>
         <20190903130430.GC31406@gate.crashing.org>
         <d268ee78-607e-5eb3-ed89-d5c07f672046@c-s.fr>
         <20190903160415.GA9749@gate.crashing.org>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19090403-0012-0000-0000-0000034663F2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090403-0013-0000-0000-00002180B434
Message-Id: <b9f8b21afc0f86e9757daf3de2794144ce2565e6.camel@au1.ibm.com>
Subject: RE: [PATCH v2 3/6] powerpc: Convert flush_icache_range & friends to C
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-03_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909040036
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-03 at 11:04 -0500, Segher Boessenkool wrote:
> On Tue, Sep 03, 2019 at 04:28:09PM +0200, Christophe Leroy wrote:
> > Le 03/09/2019 à 15:04, Segher Boessenkool a écrit :
> > > On Tue, Sep 03, 2019 at 03:23:57PM +1000, Alastair D'Silva wrote:
> > > > +	asm volatile(
> > > > +		"   mtctr %2;"
> > > > +		"   mtmsr %3;"
> > > > +		"   isync;"
> > > > +		"0: dcbst   0, %0;"
> > > > +		"   addi    %0, %0, %4;"
> > > > +		"   bdnz    0b;"
> > > > +		"   sync;"
> > > > +		"   mtctr %2;"
> > > > +		"1: icbi    0, %1;"
> > > > +		"   addi    %1, %1, %4;"
> > > > +		"   bdnz    1b;"
> > > > +		"   sync;"
> > > > +		"   mtmsr %5;"
> > > > +		"   isync;"
> > > > +		: "+r" (loop1), "+r" (loop2)
> > > > +		: "r" (nb), "r" (msr), "i" (bytes), "r" (msr0)
> > > > +		: "ctr", "memory");
> > > 
> > > This outputs as one huge assembler statement, all on one
> > > line.  That's
> > > going to be fun to read or debug.
> > 
> > Do you mean \n has to be added after the ; ?
> 
> Something like that.  There is no really satisfying way for doing
> huge
> inline asm, and maybe that is a good thing ;-)
> 
> Often people write \n\t at the end of each line of inline asm.  This
> works
> pretty well (but then there are labels, oh joy).
> 
> > > loop1 and/or loop2 can be assigned the same register as msr0 or
> > > nb.  They
> > > need to be made earlyclobbers.  (msr is fine, all of its reads
> > > are before
> > > any writes to loop1 or loop2; and bytes is fine, it's not a
> > > register).
> > 
> > Can you explicit please ? Doesn't '+r' means that they are input
> > and 
> > output at the same time ?
> 
> That is what + means, yes -- that this output is an input as
> well.  It is
> the same to write
> 
>   asm("mov %1,%0 ; mov %0,42" : "+r"(x), "=r"(y));
> or to write
>   asm("mov %1,%0 ; mov %0,42" : "=r"(x), "=r"(y) : "0"(x));
> 
> (So not "at the same time" as in "in the same machine instruction",
> but
> more loosely, as in "in the same inline asm statement").
> 
> > "to be made earlyclobbers", what does this means exactly ? How to
> > do that ?
> 
> You write &, like "+&r" in this case.  It means the machine code
> writes
> to this register before it has consumed all asm inputs (remember, GCC
> does not understand (or even parse!) the assembler string).
> 
> So just
> 
> 		: "+&r" (loop1), "+&r" (loop2)
> 
> will do.  (Why are they separate though?  It could just be one loop
> var).
> 
> 

Thanks, I've updated these.

-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

