Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84360C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9512075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDCNcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:32:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725959AbfDCNcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:32:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DUk0Y113515
        for <linux-kernel@vger.kernel.org>; Wed, 3 Apr 2019 09:32:52 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rmvh847hh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 09:32:51 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 3 Apr 2019 14:32:50 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 3 Apr 2019 14:32:44 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x33DWhGs18808998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Apr 2019 13:32:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C56FFB205F;
        Wed,  3 Apr 2019 13:32:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73268B2064;
        Wed,  3 Apr 2019 13:32:43 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.202.55])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Apr 2019 13:32:43 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0CFAE16C0FB0; Wed,  3 Apr 2019 06:32:43 -0700 (PDT)
Date:   Wed, 3 Apr 2019 06:32:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rcu <rcu@vger.kernel.org>,
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
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Reply-To: paulmck@linux.ibm.com
References: <20190402142816.GA13084@linux.ibm.com>
 <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
 <20190402152334.GC4102@linux.ibm.com>
 <161156422.1435.1554219247444.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161156422.1435.1554219247444.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040313-0072-0000-0000-00000414E860
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010867; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183742; UDB=6.00619754; IPR=6.00964494;
 MB=3.00026276; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-03 13:32:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040313-0073-0000-0000-00004BB26799
Message-Id: <20190403133243.GE4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=790 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904030093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 11:34:07AM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 2, 2019, at 11:23 AM, paulmck paulmck@linux.ibm.com wrote:
> 
> > On Tue, Apr 02, 2019 at 11:14:40AM -0400, Mathieu Desnoyers wrote:
> >> ----- On Apr 2, 2019, at 10:28 AM, paulmck paulmck@linux.ibm.com wrote:
> >> 
> >> > Hello!
> >> > 
> >> > This series prohibits use of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
> >> > by loadable modules.  The reason for this prohibition is the fact
> >> > that using these two macros within modules requires that the size of
> >> > the reserved region be increased, which is not something we want to
> >> > be doing all that often.  Instead, loadable modules should define an
> >> > srcu_struct and invoke init_srcu_struct() from their module_init function
> >> > and cleanup_srcu_struct() from their module_exit function.  Note that
> >> > modules using call_srcu() will also need to invoke srcu_barrier() from
> >> > their module_exit function.
> >> 
> >> This arbitrary API limitation seems weird.
> >> 
> >> Isn't there a way to allow modules to use DEFINE_SRCU and DEFINE_STATIC_SRCU
> >> while implementing them with dynamic allocation under the hood ?
> > 
> > Although call_srcu() already has initialization hooks, some would
> > also be required in srcu_read_lock(), and I am concerned about adding
> > memory allocation at that point, especially given the possibility
> > of memory-allocation failure.  And the possibility that the first
> > srcu_read_lock() happens in an interrupt handler or similar.
> > 
> > Or am I missing a trick here?
> 
> I was more thinking that under #ifdef MODULE, both DEFINE_SRCU and
> DEFINE_STATIC_SRCU could append data in a dedicated section. module.c
> would additionally lookup that section on module load, and deal with
> those statically defined SRCU entries as if they were dynamically
> allocated ones. It would of course cleanup those resources on module
> unload.
> 
> Am I missing some subtlety there ?

If I understand you correctly, that is actually what is already done.  The
size of this dedicated section is currently set by PERCPU_MODULE_RESERVE,
and the additions of DEFINE{_STATIC}_SRCU() in modules was requiring that
this to be increased frequently.  That led to a request that something
be done, in turn leading to this patch series.

I don't see a way around this short of changing module loading to do
alloc_percpu() and then updating the relocation based on this result.
Which would admittedly be far more convenient.  I was assuming that
this would be difficult due to varying CPU offsets or the like.

But if it can be done reasonably, it would be quite a bit nicer than
forcing dynamic allocation in cases where it is not otherwise needed.

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> >							Thanx, Paul
> > 
> >> Thanks,
> >> 
> >> Mathieu
> >> 
> >> 
> >> > 
> >> > This series consist of the following:
> >> > 
> >> > 1.	Dynamically allocate dax_srcu.
> >> > 
> >> > 2.	Dynamically allocate drm_unplug_srcu.
> >> > 
> >> > 3.	Dynamically allocate kfd_processes_srcu.
> >> > 
> >> > These build and have been subjected to 0day testing, but might also need
> >> > testing by someone having the requisite hardware.
> >> > 
> >> >							Thanx, Paul
> >> > 
> >> > ------------------------------------------------------------------------
> >> > 
> >> > drivers/dax/super.c                        |   10 +++++-
> >> > drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |    5 +++
> >> > drivers/gpu/drm/amd/amdkfd/kfd_process.c   |    2 -
> >> > drivers/gpu/drm/drm_drv.c                  |    8 ++++
> >> > include/linux/srcutree.h                   |   19 +++++++++--
> >> > kernel/rcu/rcuperf.c                       |   40 +++++++++++++++++++-----
> >> > kernel/rcu/rcutorture.c                    |   48 +++++++++++++++++++++--------
> >> >  7 files changed, 105 insertions(+), 27 deletions(-)
> >> 
> >> --
> >> Mathieu Desnoyers
> >> EfficiOS Inc.
> >> http://www.efficios.com
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

