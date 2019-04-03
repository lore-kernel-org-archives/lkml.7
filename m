Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B324C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A032147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfDCNT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:19:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725959AbfDCNT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:19:27 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DEEQq124954
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 09:19:27 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rmvx1t8u1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:19:26 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 3 Apr 2019 14:19:26 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 14:19:19 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33DJIC916515084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 13:19:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEC5CB2065;
        Wed,  3 Apr 2019 13:19:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79337B2066;
        Wed,  3 Apr 2019 13:19:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.202.55])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 13:19:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2344016C0EB6; Wed,  3 Apr 2019 06:19:18 -0700 (PDT)
Date:   Wed, 3 Apr 2019 06:19:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
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
        linux-nvdimm@lists.01.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Reply-To: paulmck@linux.ibm.com
References: <20190402142816.GA13084@linux.ibm.com>
 <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
 <20190402152334.GC4102@linux.ibm.com>
 <20190402184054.GA18150@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190402184054.GA18150@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040313-2213-0000-0000-0000036FE736
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010867; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183738; UDB=6.00619751; IPR=6.00964489;
 MB=3.00026276; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 13:19:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040313-2214-0000-0000-00005DE35D65
Message-Id: <20190403131918.GD4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030091
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 02:40:54PM -0400, Joel Fernandes wrote:
> On Tue, Apr 02, 2019 at 08:23:34AM -0700, Paul E. McKenney wrote:
> > On Tue, Apr 02, 2019 at 11:14:40AM -0400, Mathieu Desnoyers wrote:
> > > ----- On Apr 2, 2019, at 10:28 AM, paulmck paulmck@linux.ibm.com wrote:
> > > 
> > > > Hello!
> > > > 
> > > > This series prohibits use of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
> > > > by loadable modules.  The reason for this prohibition is the fact
> > > > that using these two macros within modules requires that the size of
> > > > the reserved region be increased, which is not something we want to
> > > > be doing all that often.  Instead, loadable modules should define an
> > > > srcu_struct and invoke init_srcu_struct() from their module_init function
> > > > and cleanup_srcu_struct() from their module_exit function.  Note that
> > > > modules using call_srcu() will also need to invoke srcu_barrier() from
> > > > their module_exit function.
> > > 
> > > This arbitrary API limitation seems weird.
> > > 
> > > Isn't there a way to allow modules to use DEFINE_SRCU and DEFINE_STATIC_SRCU
> > > while implementing them with dynamic allocation under the hood ?
> > 
> > Although call_srcu() already has initialization hooks, some would
> > also be required in srcu_read_lock(), and I am concerned about adding
> > memory allocation at that point, especially given the possibility
> > of memory-allocation failure.  And the possibility that the first
> > srcu_read_lock() happens in an interrupt handler or similar.
> > 
> > Or am I missing a trick here?
> 
> Hi Paul,
> 
> Which 'reserved region' are you referring to? Isn't this region also
> used for non-module cases in which case the same problem applies to
> non-modules?

The percpu/module reservation discussed in this thread:

https://lore.kernel.org/lkml/c72402f2-967e-cd56-99d8-9139c9e7f267@google.com/T/#mbcacf60ddc0b3fd6e831a3ea71efc90da359a3bf

For non-modules, global per-CPU variables are statically allocated.
For modules, they must be dynamically allocated at modprobe time, and
their size is set by PERCPU_MODULE_RESERVE.

							Thanx, Paul

