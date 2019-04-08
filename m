Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB4FC282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F059120855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfDHC2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:28:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfDHC2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:28:19 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x382OHd3075066
        for <linux-kernel@vger.kernel.org>; Sun, 7 Apr 2019 22:28:18 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rqqt8kfyu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:28:17 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 8 Apr 2019 03:28:16 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Apr 2019 03:28:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x382SAOq20906164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Apr 2019 02:28:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D7C8B2065;
        Mon,  8 Apr 2019 02:28:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49037B2067;
        Mon,  8 Apr 2019 02:28:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.136.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  8 Apr 2019 02:28:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 06BF816C36AE; Sun,  7 Apr 2019 19:28:12 -0700 (PDT)
Date:   Sun, 7 Apr 2019 19:28:12 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        dipankar <dipankar@in.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        fweisbec <fweisbec@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Reply-To: paulmck@linux.ibm.com
References: <20190403133243.GE4102@linux.ibm.com>
 <1028306587.504.1554301662374.JavaMail.zimbra@efficios.com>
 <20190403162039.GA14111@linux.ibm.com>
 <20190405232835.GA24702@linux.ibm.com>
 <20190406230613.GA187766@google.com>
 <20190407133941.GC14111@linux.ibm.com>
 <20190407135937.GA30053@linux.ibm.com>
 <20190407154613.GA2770@localhost>
 <20190407170514.GE14111@linux.ibm.com>
 <20190408003646.GA135726@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408003646.GA135726@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040802-0060-0000-0000-00000329C783
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010887; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01185902; UDB=6.00621059; IPR=6.00966656;
 MB=3.00026334; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-08 02:28:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040802-0061-0000-0000-000048DF01D1
Message-Id: <20190408022811.GG14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 08:36:46PM -0400, Joel Fernandes wrote:
> On Sun, Apr 07, 2019 at 10:05:14AM -0700, Paul E. McKenney wrote:
> > On Sun, Apr 07, 2019 at 03:46:13PM +0000, Joel Fernandes wrote:
> > > On Sun, Apr 07, 2019 at 06:59:37AM -0700, Paul E. McKenney wrote:
> > > > On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
> > > > > On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> > > > 
> > > > [ . . . ]
> > > > 
> > > > > > > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > > > > > > index f8f6f04c4453..c2d919a1566e 100644
> > > > > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > > > > @@ -338,6 +338,10 @@
> > > > > > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> > > > > > >  		__stop___tracepoints_ptrs = .;				\
> > > > > > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> > > > > > > +		. = ALIGN(8);						\
> > > > > > > +		__start___srcu_struct = .;				\
> > > > > > > +		*(___srcu_struct_ptrs)					\
> > > > > > > +		__end___srcu_struct = .;				\
> > > > > > >  	}								\
> > > > > > 
> > > > > > This vmlinux linker modification is not needed. I tested without it and srcu
> > > > > > torture works fine with rcutorture built as a module. Putting further prints
> > > > > > in kernel/module.c verified that the kernel is able to find the srcu structs
> > > > > > just fine. You could squash the below patch into this one or apply it on top
> > > > > > of the dev branch.
> > > > > 
> > > > > Good point, given that otherwise FORTRAN named common blocks would not
> > > > > work.
> > > > > 
> > > > > But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
> > > > > macro that it can be mapped read-only?  Or am I suffering from excessive
> > > > > optimism?
> > > > 
> > > > And to answer the other question, in the case where I am suffering from
> > > > excessive optimism, it should be a separate commit.  Please see below
> > > > for the updated original commit thus far.
> > > 
> > > Actually the vmlinux.lds.h file is unused for module building. For ex, if you
> > > delete include/asm-generic/vmlinux.lds.h , then you can still build
> > > rcutorture.ko. Did I miss something obvious? In that case the vmlinux.lds.h
> > > are not needed since the __section annotations automatically place the srcu
> > > structs in a separate section.
> > 
> > Hard to argue given that I just deleted include/asm-generic/vmlinux.lds.h,
> > touched kernel/rcu/rcutorture.c, and rebuilt the corresponding .ko
> > without errors.  ;-)
> > 
> > Hmmm...  Is there some way to place a section into a read-only page,
> > for example, tagged onto the text section for that module?  That would
> > get rid of a class of bugs, if nothing else.
> 
> Strictly speaking, the array of pointers in the new srcu section are fixed up
> at runtime because the srcu_struct(s) they point to can be loaded at a
> dynamic location in memory. The srcu_struct(s) are themselves in the .bss
> section of the module and their locations depend on where the .bss section of
> the module is loaded in memory at load time.
> 
> I agree that after such relocation fixups are done, there is no reason to keep
> the array-of-pointers section readable but unfortunately I couldn't figure a
> way out to make them read-only post the relocations.
> 
> I copied Jessica Yu who maintains module loading for any input. Jessica, as a
> summary, we are trying to create a custom ELF section of srcu_struct pointers
> in kernels modules, and then make the module loader do SRCU initialization
> from structs pointed to by this section.  The srcu_struct themselves are defined
> on the .bss section. Is there any way we can make this pointer array section
> read-only *after* the relocation fixups of the array are completed?
> 
> > > Let me know if you would like me to send a patch separately, or if the
> > > appended patch for the same in my previous email suffices.
> > 
> > Please do resend as a formal patch with the above in the commit log.
> > I doubt that I am the only one needing a bit of module-build education!
> > And thank you for providing that education, by the way!
> 
> Sounds great, I will go ahead and send out a patch in the morning for this
> part.

Sounds good on both counts!

							Thanx, Paul

> > > > And may I have your Tested-by?
> > > 
> > > Absolutely, please do and thanks!
> > 
> > Done, and thank you for giving it a go!
> 
> You're very welcome. thanks,
> 
>  - Joel
> 

