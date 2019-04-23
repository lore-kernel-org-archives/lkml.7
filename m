Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1F6C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB4020645
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 13:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfDWNVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 09:21:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727500AbfDWNVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 09:21:25 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3NDG6LD085940
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:21:24 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s2154xnyv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 09:21:24 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 23 Apr 2019 14:21:22 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 23 Apr 2019 14:21:18 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3NDLHVU20643988
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Apr 2019 13:21:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 455F1B205F;
        Tue, 23 Apr 2019 13:21:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02CF0B2064;
        Tue, 23 Apr 2019 13:21:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.207.109])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 23 Apr 2019 13:21:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 95F3816C2A15; Tue, 23 Apr 2019 06:21:16 -0700 (PDT)
Date:   Tue, 23 Apr 2019 06:21:16 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        Luc Maranget <luc.maranget@inria.fr>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] Documentation: atomic_t.txt: Explain ordering provided
 by smp_mb__{before,after}_atomic()
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1904191312200.1406-100000@iolanthe.rowland.org>
 <20190419180017.GP4038@hirez.programming.kicks-ass.net>
 <20190419182620.GF14111@linux.ibm.com>
 <1555719429.t9n8gkf70y.astroid@bobo.none>
 <20190420085440.GK14111@linux.ibm.com>
 <20190423121715.GQ4038@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190423121715.GQ4038@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19042313-0040-0000-0000-000004E48207
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010981; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01193231; UDB=6.00625502; IPR=6.00974052;
 MB=3.00026557; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 13:21:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042313-0041-0000-0000-000008EF90D8
Message-Id: <20190423132116.GJ3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-23_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904230091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 02:17:15PM +0200, Peter Zijlstra wrote:
> On Sat, Apr 20, 2019 at 01:54:40AM -0700, Paul E. McKenney wrote:
> > 3.	Make non-value-returning atomics provide full ordering.
> > 	This would of course need some benchmarking, but would be a
> > 	simple change to make and would eliminate a large class of
> > 	potential bugs.  My guess is that the loss in performance
> > 	would be non-negligible, but who knows?
> 
> Well, only for the architectures that have
> smp_mb__{before,after}_atomic() as barrier(), which are: ia64, mips,
> s390, sparc, x86 and xtense.

The weakly ordered architectures would need to add the equivalent of
smp_mb() before and after, right?  This might result in a more noticeable
loss of performance.

							Thanx, Paul

> $ ./compare.sh defconfig-build defconfig-build1 vmlinux
> do_profile_hits                                           275        278   +3,+0
> freezer_apply_state                                        86         98   +12,+0
> perf_event_alloc                                         2232       2261   +29,+0
> _free_event                                               631        660   +29,+0
> shmem_add_to_page_cache                                   712        722   +10,+0
> _enable_swap_info                                         333        337   +4,+0
> do_mmu_notifier_register                                  303        311   +8,+0
> __nfs_commit_inode                                        356        359   +3,+0
> tcp_try_coalesce                                          246        250   +4,+0
> i915_gem_free_object                                       90         97   +7,+0
> mce_intel_hcpu_update                                      39         47   +8,+0
> __ia32_sys_swapoff                                       1177       1181   +4,+0
> pci_enable_ats                                            124        131   +7,+0
> __x64_sys_swapoff                                        1178       1182   +4,+0
> i915_gem_madvise_ioctl                                    447        443   -4,+0
> calc_global_load_tick                                      75         82   +7,+0
> i915_gem_object_set_tiling                                712        708   -4,+0
> 					     total   11374236   11374367   +131,+0
> Which doesn't look too bad.
> 
> ---
> diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
> index ea3d95275b43..115127c7ad28 100644
> --- a/arch/x86/include/asm/atomic.h
> +++ b/arch/x86/include/asm/atomic.h
> @@ -54,7 +54,7 @@ static __always_inline void arch_atomic_add(int i, atomic_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "addl %1,%0"
>  		     : "+m" (v->counter)
> -		     : "ir" (i));
> +		     : "ir" (i) : "memory");
>  }
>  
>  /**
> @@ -68,7 +68,7 @@ static __always_inline void arch_atomic_sub(int i, atomic_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "subl %1,%0"
>  		     : "+m" (v->counter)
> -		     : "ir" (i));
> +		     : "ir" (i) : "memory");
>  }
>  
>  /**
> @@ -95,7 +95,7 @@ static __always_inline bool arch_atomic_sub_and_test(int i, atomic_t *v)
>  static __always_inline void arch_atomic_inc(atomic_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "incl %0"
> -		     : "+m" (v->counter));
> +		     : "+m" (v->counter) :: "memory");
>  }
>  #define arch_atomic_inc arch_atomic_inc
>  
> @@ -108,7 +108,7 @@ static __always_inline void arch_atomic_inc(atomic_t *v)
>  static __always_inline void arch_atomic_dec(atomic_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "decl %0"
> -		     : "+m" (v->counter));
> +		     : "+m" (v->counter) :: "memory");
>  }
>  #define arch_atomic_dec arch_atomic_dec
>  
> diff --git a/arch/x86/include/asm/atomic64_64.h b/arch/x86/include/asm/atomic64_64.h
> index dadc20adba21..5e86c0d68ac1 100644
> --- a/arch/x86/include/asm/atomic64_64.h
> +++ b/arch/x86/include/asm/atomic64_64.h
> @@ -45,7 +45,7 @@ static __always_inline void arch_atomic64_add(long i, atomic64_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "addq %1,%0"
>  		     : "=m" (v->counter)
> -		     : "er" (i), "m" (v->counter));
> +		     : "er" (i), "m" (v->counter) : "memory");
>  }
>  
>  /**
> @@ -59,7 +59,7 @@ static inline void arch_atomic64_sub(long i, atomic64_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "subq %1,%0"
>  		     : "=m" (v->counter)
> -		     : "er" (i), "m" (v->counter));
> +		     : "er" (i), "m" (v->counter) : "memory");
>  }
>  
>  /**
> @@ -87,7 +87,7 @@ static __always_inline void arch_atomic64_inc(atomic64_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "incq %0"
>  		     : "=m" (v->counter)
> -		     : "m" (v->counter));
> +		     : "m" (v->counter) : "memory");
>  }
>  #define arch_atomic64_inc arch_atomic64_inc
>  
> @@ -101,7 +101,7 @@ static __always_inline void arch_atomic64_dec(atomic64_t *v)
>  {
>  	asm volatile(LOCK_PREFIX "decq %0"
>  		     : "=m" (v->counter)
> -		     : "m" (v->counter));
> +		     : "m" (v->counter) : "memory");
>  }
>  #define arch_atomic64_dec arch_atomic64_dec
>  
> 

