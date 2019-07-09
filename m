Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B133CC73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C372073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 20:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfGIUJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 16:09:37 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:49280 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726679AbfGIUJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 16:09:37 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x69K5sfM007998;
        Tue, 9 Jul 2019 20:09:17 GMT
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 2tn15w86pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jul 2019 20:09:17 +0000
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2354.austin.hpe.com (Postfix) with ESMTP id 3E52481;
        Tue,  9 Jul 2019 20:09:16 +0000 (UTC)
Received: from hpe.com (ben.americas.hpqcorp.net [10.33.153.7])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id A84F739;
        Tue,  9 Jul 2019 20:09:14 +0000 (UTC)
Date:   Tue, 9 Jul 2019 15:09:14 -0500
From:   Russ Anderson <rja@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Mike Travis <mike.travis@hpe.com>,
        Hedi Berriche <hedi.berriche@hpe.com>
Subject: Re: [PATCH v2 8/9] x86/mm/tlb: Remove UV special case
Message-ID: <20190709200914.fjvi3cy3qfc6fmis@hpe.com>
Reply-To: Russ Anderson <rja@hpe.com>
References: <20190702235151.4377-1-namit@vmware.com>
 <20190702235151.4377-9-namit@vmware.com>
 <alpine.DEB.2.21.1907092146570.1758@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907092146570.1758@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907090239
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 09, 2019 at 09:50:27PM +0200, Thomas Gleixner wrote:
> On Tue, 2 Jul 2019, Nadav Amit wrote:
> 
> > SGI UV support is outdated and not maintained, and it is not clear how
> > it performs relatively to non-UV. Remove the code to simplify the code.
> 
> You should at least Cc the SGI/HP folks on that. They are still
> around. Done so.

Thanks Thomas.  The SGI UV is now HPE Superdome Flex and is
very much still supported.

Thanks.

> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Dave Hansen <dave.hansen@intel.com>
> > Suggested-by: Andy Lutomirski <luto@kernel.org>
> > Signed-off-by: Nadav Amit <namit@vmware.com>
> > ---
> >  arch/x86/mm/tlb.c | 25 -------------------------
> >  1 file changed, 25 deletions(-)
> > 
> > diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> > index b47a71820f35..64afe1215495 100644
> > --- a/arch/x86/mm/tlb.c
> > +++ b/arch/x86/mm/tlb.c
> > @@ -689,31 +689,6 @@ void native_flush_tlb_multi(const struct cpumask *cpumask,
> >  		trace_tlb_flush(TLB_REMOTE_SEND_IPI,
> >  				(info->end - info->start) >> PAGE_SHIFT);
> >  
> > -	if (is_uv_system()) {
> > -		/*
> > -		 * This whole special case is confused.  UV has a "Broadcast
> > -		 * Assist Unit", which seems to be a fancy way to send IPIs.
> > -		 * Back when x86 used an explicit TLB flush IPI, UV was
> > -		 * optimized to use its own mechanism.  These days, x86 uses
> > -		 * smp_call_function_many(), but UV still uses a manual IPI,
> > -		 * and that IPI's action is out of date -- it does a manual
> > -		 * flush instead of calling flush_tlb_func_remote().  This
> > -		 * means that the percpu tlb_gen variables won't be updated
> > -		 * and we'll do pointless flushes on future context switches.
> > -		 *
> > -		 * Rather than hooking native_flush_tlb_multi() here, I think
> > -		 * that UV should be updated so that smp_call_function_many(),
> > -		 * etc, are optimal on UV.
> > -		 */
> > -		flush_tlb_func_local(info);
> > -
> > -		cpumask = uv_flush_tlb_others(cpumask, info);
> > -		if (cpumask)
> > -			smp_call_function_many(cpumask, flush_tlb_func_remote,
> > -					       (void *)info, 1);
> > -		return;
> > -	}
> > -
> >  	/*
> >  	 * If no page tables were freed, we can skip sending IPIs to
> >  	 * CPUs in lazy TLB mode. They will flush the CPU themselves
> > -- 
> > 2.17.1
> > 
> > 

-- 
Russ Anderson,  SuperDome Flex Linux Kernel Group Manager
HPE - Hewlett Packard Enterprise (formerly SGI)  rja@hpe.com
