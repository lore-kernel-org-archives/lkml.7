Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA14AC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B2BB20855
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 02:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHC1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 22:27:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbfDHC1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 22:27:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x382OFxE062582
        for <linux-kernel@vger.kernel.org>; Sun, 7 Apr 2019 22:27:35 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rqvh5t8aj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2019 22:27:35 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 8 Apr 2019 03:27:34 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Apr 2019 03:27:28 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x382RReN17039474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Apr 2019 02:27:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F16BFB2065;
        Mon,  8 Apr 2019 02:27:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8200B206A;
        Mon,  8 Apr 2019 02:27:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.136.16])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  8 Apr 2019 02:27:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6DE4316C36AE; Sun,  7 Apr 2019 19:27:28 -0700 (PDT)
Date:   Sun, 7 Apr 2019 19:27:28 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
References: <20190402142816.GA13084@linux.ibm.com>
 <20190403162039.GA14111@linux.ibm.com>
 <20190405232835.GA24702@linux.ibm.com>
 <20190406230613.GA187766@google.com>
 <20190407133941.GC14111@linux.ibm.com>
 <20190407135937.GA30053@linux.ibm.com>
 <134026717.535.1554665176677.JavaMail.zimbra@efficios.com>
 <20190407193202.GA30934@localhost>
 <1632568795.549.1554669696728.JavaMail.zimbra@efficios.com>
 <20190407210718.GA6656@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190407210718.GA6656@localhost>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040802-0072-0000-0000-00000416CB2D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010887; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01185901; UDB=6.00621059; IPR=6.00966656;
 MB=3.00026334; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-08 02:27:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040802-0073-0000-0000-00004BBF0E0A
Message-Id: <20190408022728.GF14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=629 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904080020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2019 at 09:07:18PM +0000, Joel Fernandes wrote:
> On Sun, Apr 07, 2019 at 04:41:36PM -0400, Mathieu Desnoyers wrote:
> > 
> > ----- On Apr 7, 2019, at 3:32 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> > 
> > > On Sun, Apr 07, 2019 at 03:26:16PM -0400, Mathieu Desnoyers wrote:
> > >> ----- On Apr 7, 2019, at 9:59 AM, paulmck paulmck@linux.ibm.com wrote:
> > >> 
> > >> > On Sun, Apr 07, 2019 at 06:39:41AM -0700, Paul E. McKenney wrote:
> > >> >> On Sat, Apr 06, 2019 at 07:06:13PM -0400, Joel Fernandes wrote:
> > >> > 
> > >> > [ . . . ]
> > >> > 
> > >> >> > > diff --git a/include/asm-generic/vmlinux.lds.h
> > >> >> > > b/include/asm-generic/vmlinux.lds.h
> > >> >> > > index f8f6f04c4453..c2d919a1566e 100644
> > >> >> > > --- a/include/asm-generic/vmlinux.lds.h
> > >> >> > > +++ b/include/asm-generic/vmlinux.lds.h
> > >> >> > > @@ -338,6 +338,10 @@
> > >> >> > >  		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
> > >> >> > >  		__stop___tracepoints_ptrs = .;				\
> > >> >> > >  		*(__tracepoints_strings)/* Tracepoints: strings */	\
> > >> >> > > +		. = ALIGN(8);						\
> > >> >> > > +		__start___srcu_struct = .;				\
> > >> >> > > +		*(___srcu_struct_ptrs)					\
> > >> >> > > +		__end___srcu_struct = .;				\
> > >> >> > >  	}								\
> > >> >> > 
> > >> >> > This vmlinux linker modification is not needed. I tested without it and srcu
> > >> >> > torture works fine with rcutorture built as a module. Putting further prints
> > >> >> > in kernel/module.c verified that the kernel is able to find the srcu structs
> > >> >> > just fine. You could squash the below patch into this one or apply it on top
> > >> >> > of the dev branch.
> > >> >> 
> > >> >> Good point, given that otherwise FORTRAN named common blocks would not
> > >> >> work.
> > >> >> 
> > >> >> But isn't one advantage of leaving that stuff in the RO_DATA_SECTION()
> > >> >> macro that it can be mapped read-only?  Or am I suffering from excessive
> > >> >> optimism?
> > >> > 
> > >> > And to answer the other question, in the case where I am suffering from
> > >> > excessive optimism, it should be a separate commit.  Please see below
> > >> > for the updated original commit thus far.
> > >> > 
> > >> > And may I have your Tested-by?
> > >> 
> > >> Just to confirm: does the cleanup performed in the modules going
> > >> notifier end up acting as a barrier first before freeing the memory ?
> > >> If not, is it explicitly stated that a barrier must be issued before
> > >> module unload ?
> > >> 
> > > 
> > > You mean rcu_barrier? It is mentioned in the documentation that this is the
> > > responsibility of the module writer to prevent delays for all modules.
> > 
> > It's a srcu barrier yes. Considering it would be a barrier specific to the
> > srcu domain within that module, I don't see how it would cause delays for
> > "all" modules if we implicitly issue the barrier on module unload. What
> > am I missing ?
> 
> Yes you are right. I thought of this after I just sent my email. I think it
> makes sense for srcu case to do and could avoid a class of bugs.

If there are call_srcu() callbacks outstanding, the module writer still
needs the srcu_barrier() because otherwise callbacks arrive after
the module text has gone, which will be disappoint the CPU when it
tries fetching instructions that are no longer mapped.  If there are
no call_srcu() callbacks from that module, then there is no need for
srcu_barrier() either way.

So if an srcu_barrier() is needed, the module developer needs to
supply it.

							Thanx, Paul

