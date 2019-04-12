Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926DFC10F13
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA0F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 02:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfDLCfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 22:35:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726694AbfDLCfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 22:35:50 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3C2YqVM009185
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 22:35:49 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtgvhtbht-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 22:35:49 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 12 Apr 2019 03:35:48 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 03:35:43 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3C2Zg0b30343260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 02:35:42 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52FB6B2066;
        Fri, 12 Apr 2019 02:35:42 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 321E0B205F;
        Fri, 12 Apr 2019 02:35:42 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.226.95])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 02:35:42 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1526816C5EEB; Thu, 11 Apr 2019 19:35:42 -0700 (PDT)
Date:   Thu, 11 Apr 2019 19:35:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        rcu@vger.kernel.org, kernel-hardening@lists.openwall.com,
        kernel-team@android.com, Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] module: Make srcu_struct ptr array as read-only
Reply-To: paulmck@linux.ibm.com
References: <20190411202421.131779-1-joel@joelfernandes.org>
 <20190411213155.GD14111@linux.ibm.com>
 <20190412021422.GA208673@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412021422.GA208673@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041202-0060-0000-0000-0000032BDE16
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010912; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187806; UDB=6.00622212; IPR=6.00968572;
 MB=3.00026402; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-12 02:35:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041202-0061-0000-0000-000048EB7C43
Message-Id: <20190412023542.GF14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120017
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 11, 2019 at 10:14:22PM -0400, Joel Fernandes wrote:
> On Thu, Apr 11, 2019 at 02:31:55PM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 11, 2019 at 04:24:21PM -0400, Joel Fernandes (Google) wrote:
> > > Since commit title ("srcu: Allocate per-CPU data for DEFINE_SRCU() in
> > > modules"), modules that call DEFINE_{STATIC,}SRCU will have a new array
> > > of srcu_struct pointers, which is used by srcu code to initialize and
> > > clean up these structures and save valuable per-cpu reserved space.
> > > 
> > > There is no reason for this array of pointers to be writable, and can
> > > cause security or other hidden bugs. Mark these are read-only after the
> > > module init has completed.
> > > 
> > > Tested with the following diff to ensure array not writable:
> > > 
> > > (diff is a bit reduced to avoid patch command getting confused)
> > >  a/kernel/module.c
> > >  b/kernel/module.c
> > >   -3506,6 +3506,14  static noinline int do_init_module [snip]
> > >  	rcu_assign_pointer(mod->kallsyms, &mod->core_kallsyms);
> > >  #endif
> > >  	module_enable_ro(mod, true);
> > > +
> > > +	if (mod->srcu_struct_ptrs) {
> > > +		// Check if srcu_struct_ptrs access is possible
> > > +		char x = *(char *)mod->srcu_struct_ptrs;
> > > +		*(char *)mod->srcu_struct_ptrs = 0;
> > > +		*(char *)mod->srcu_struct_ptrs = x;
> > > +	}
> > > +
> > >  	mod_tree_remove_init(mod);
> > >  	disable_ro_nx(&mod->init_layout);
> > >  	module_arch_freeing_init(mod);
> > > 
> > > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Cc: paulmck@linux.vnet.ibm.com
> > > Cc: rostedt@goodmis.org
> > > Cc: mathieu.desnoyers@efficios.com
> > > Cc: rcu@vger.kernel.org
> > > Cc: kernel-hardening@lists.openwall.com
> > > Cc: kernel-team@android.com
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Queued for testing and further review, thank you, Joel!
> 
> Thanks a lot! I also just saw you added the rcutorture module to be built as
> a part kselftests which is really cool ;-)

Just a smoke test, really, but it will be interesting to see how
it goes.  ;-)

							Thanx, Paul

