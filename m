Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F63C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29CC206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfHPBoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:44:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725983AbfHPBoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:44:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7G1gK68013469
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 21:44:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2udfc8f6qv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 21:44:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <alastair@au1.ibm.com>;
        Fri, 16 Aug 2019 02:44:34 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 16 Aug 2019 02:44:30 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7G1i9oR32244136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Aug 2019 01:44:09 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B5A9A4055;
        Fri, 16 Aug 2019 01:44:29 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 888AAA404D;
        Fri, 16 Aug 2019 01:44:28 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 16 Aug 2019 01:44:28 +0000 (GMT)
Received: from adsilva.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 251A5A01EB;
        Fri, 16 Aug 2019 11:44:27 +1000 (AEST)
Subject: Re: [PATCH 3/6] powerpc: Convert flush_icache_range & friends to C
From:   "Alastair D'Silva" <alastair@au1.ibm.com>
To:     christophe leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>, Qian Cai <cai@lca.pw>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 16 Aug 2019 11:44:27 +1000
In-Reply-To: <8a86bccf-ae4d-6d2c-72b1-db136cec9d10@c-s.fr>
References: <20190815041057.13627-1-alastair@au1.ibm.com>
         <20190815041057.13627-4-alastair@au1.ibm.com>
         <8a86bccf-ae4d-6d2c-72b1-db136cec9d10@c-s.fr>
Organization: IBM Australia
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.2 (3.32.2-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19081601-4275-0000-0000-000003599AD1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081601-4276-0000-0000-0000386BB1AE
Message-Id: <9dd9b36169a04009ad08b26a899bdac0775104a7.camel@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-15_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-15 at 09:29 +0200, christophe leroy wrote:
> 
> Le 15/08/2019 à 06:10, Alastair D'Silva a écrit :
> > From: Alastair D'Silva <alastair@d-silva.org>
> > 
> > Similar to commit 22e9c88d486a
> > ("powerpc/64: reuse PPC32 static inline flush_dcache_range()")
> > this patch converts flush_icache_range() to C, and reimplements the
> > following functions as wrappers around it:
> > __flush_dcache_icache
> > __flush_dcache_icache_phys
> 
> Not sure you can do that for __flush_dcache_icache_phys(), see
> detailed 
> comments below
> 
> > This was done as we discovered a long-standing bug where the length
> > of the
> > range was truncated due to using a 32 bit shift instead of a 64 bit
> > one.
> > 
> > By converting these functions to C, it becomes easier to maintain.
> > 
> > Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> > ---
> >   arch/powerpc/include/asm/cache.h      |  26 +++---
> >   arch/powerpc/include/asm/cacheflush.h |  32 ++++---
> >   arch/powerpc/kernel/misc_32.S         | 117 -------------------
> > -------
> >   arch/powerpc/kernel/misc_64.S         |  97 ---------------------
> >   arch/powerpc/mm/mem.c                 |  71 +++++++++++++++-
> >   5 files changed, 102 insertions(+), 241 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/cache.h
> > b/arch/powerpc/include/asm/cache.h
> > index f852d5cd746c..728f154204db 100644
> > --- a/arch/powerpc/include/asm/cache.h
> > +++ b/arch/powerpc/include/asm/cache.h
> > @@ -98,20 +98,7 @@ static inline u32 l1_icache_bytes(void)
> >   #endif
> >   #endif /* ! __ASSEMBLY__ */
> >   
> > -#if defined(__ASSEMBLY__)
> > -/*
> > - * For a snooping icache, we still need a dummy icbi to purge all
> > the
> > - * prefetched instructions from the ifetch buffers. We also need a
> > sync
> > - * before the icbi to order the the actual stores to memory that
> > might
> > - * have modified instructions with the icbi.
> > - */
> > -#define PURGE_PREFETCHED_INS	\
> > -	sync;			\
> > -	icbi	0,r3;		\
> > -	sync;			\
> > -	isync
> 
> Is this still used anywhere now ?
No, this patch removes all users of it.

> > -
> > -#else
> > +#if !defined(__ASSEMBLY__)
> >   #define __read_mostly
> > __attribute__((__section__(".data..read_mostly")))
> >   
> >   #ifdef CONFIG_PPC_BOOK3S_32
> > @@ -145,6 +132,17 @@ static inline void dcbst(void *addr)
> >   {
> >   	__asm__ __volatile__ ("dcbst %y0" : : "Z"(*(u8 *)addr) :
> > "memory");
> >   }
> > +
> > +static inline void icbi(void *addr)
> > +{
> > +	__asm__ __volatile__ ("icbi 0, %0" : : "r"(addr) : "memory");
> > +}
> > +
> > +static inline void iccci(void)
> > +{
> > +	__asm__ __volatile__ ("iccci 0, r0");
> 
> I think you need the "memory" clobber too here.
> 
Thanks, I'll add that.

> > +}
> > +
> >   #endif /* !__ASSEMBLY__ */
> >   #endif /* __KERNEL__ */
> >   #endif /* _ASM_POWERPC_CACHE_H */
> > diff --git a/arch/powerpc/include/asm/cacheflush.h
> > b/arch/powerpc/include/asm/cacheflush.h
> > index ed57843ef452..4c3377aff8ed 100644
> > --- a/arch/powerpc/include/asm/cacheflush.h
> > +++ b/arch/powerpc/include/asm/cacheflush.h
> > @@ -42,24 +42,18 @@ extern void flush_dcache_page(struct page
> > *page);
> >   #define flush_dcache_mmap_lock(mapping)		do { } while
> > (0)
> >   #define flush_dcache_mmap_unlock(mapping)	do { } while (0)
> >   
> > -extern void flush_icache_range(unsigned long, unsigned long);
> > +void flush_icache_range(unsigned long start, unsigned long stop);
> >   extern void flush_icache_user_range(struct vm_area_struct *vma,
> >   				    struct page *page, unsigned long
> > addr,
> >   				    int len);
> > -extern void __flush_dcache_icache(void *page_va);
> >   extern void flush_dcache_icache_page(struct page *page);
> > -#if defined(CONFIG_PPC32) && !defined(CONFIG_BOOKE)
> > -extern void __flush_dcache_icache_phys(unsigned long physaddr);
> > -#else
> > -static inline void __flush_dcache_icache_phys(unsigned long
> > physaddr)
> > -{
> > -	BUG();
> > -}
> > -#endif
> >   
> > -/*
> > - * Write any modified data cache blocks out to memory and
> > invalidate them.
> > +/**
> > + * flush_dcache_range(): Write any modified data cache blocks out
> > to memory and invalidate them.
> >    * Does not invalidate the corresponding instruction cache
> > blocks.
> > + *
> > + * @start: the start address
> > + * @stop: the stop address (exclusive)
> >    */
> >   static inline void flush_dcache_range(unsigned long start,
> > unsigned long stop)
> >   {
> > @@ -82,6 +76,20 @@ static inline void flush_dcache_range(unsigned
> > long start, unsigned long stop)
> >   		isync();
> >   }
> >   
> > +/**
> > + * __flush_dcache_icache(): Flush a particular page from the data
> > cache to RAM.
> > + * Note: this is necessary because the instruction cache does
> > *not*
> > + * snoop from the data cache.
> > + *
> > + * @page: the address of the page to flush
> > + */
> > +static inline void __flush_dcache_icache(void *page)
> > +{
> > +	unsigned long page_addr = (unsigned long)page;
> 
> The function is small enough to call this addr instead of page_addr 
> without ambiguity.
Ok

> 
> > +
> > +	flush_icache_range(page_addr, page_addr + PAGE_SIZE);
> 
> Finally, I think that's not so simple. For the 44x, if
> MMU_FTR_TYPE_44x 
> is set, that's just a clean_dcache_range().
> If that feature is not set, it looks like a standard 
> flush_icache_range() but without the special CONFIG_4xx handling
> with 
> iccci we have in flush_icache_range()
> 
Hmm, I'll have to hack at this a bit more.

<snip>
-- 
Alastair D'Silva
Open Source Developer
Linux Technology Centre, IBM Australia
mob: 0423 762 819

