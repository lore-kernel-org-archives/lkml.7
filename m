Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEDDC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D10D20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbfDBPXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:23:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbfDBPXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:23:38 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32FKqjx072704
        for <linux-kernel@vger.kernel.org>; Tue, 2 Apr 2019 11:23:37 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rm9jsjtb3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 11:23:36 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 2 Apr 2019 16:23:35 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Apr 2019 16:23:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x32FNTTq13435078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Apr 2019 15:23:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60219B2066;
        Tue,  2 Apr 2019 15:23:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A7B6B2067;
        Tue,  2 Apr 2019 15:23:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Apr 2019 15:23:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7174016C2A40; Tue,  2 Apr 2019 08:23:34 -0700 (PDT)
Date:   Tue, 2 Apr 2019 08:23:34 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rcu@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
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
        linux-nvdimm@lists.01.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH RFC tip/core/rcu 0/4] Forbid static SRCU use in modules
Reply-To: paulmck@linux.ibm.com
References: <20190402142816.GA13084@linux.ibm.com>
 <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <886051277.1395.1554218080591.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040215-0068-0000-0000-000003AF7936
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010862; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01183302; UDB=6.00619488; IPR=6.00964050;
 MB=3.00026261; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-02 15:23:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040215-0069-0000-0000-000048049FEC
Message-Id: <20190402152334.GC4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=718 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904020103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 11:14:40AM -0400, Mathieu Desnoyers wrote:
> ----- On Apr 2, 2019, at 10:28 AM, paulmck paulmck@linux.ibm.com wrote:
> 
> > Hello!
> > 
> > This series prohibits use of DEFINE_SRCU() and DEFINE_STATIC_SRCU()
> > by loadable modules.  The reason for this prohibition is the fact
> > that using these two macros within modules requires that the size of
> > the reserved region be increased, which is not something we want to
> > be doing all that often.  Instead, loadable modules should define an
> > srcu_struct and invoke init_srcu_struct() from their module_init function
> > and cleanup_srcu_struct() from their module_exit function.  Note that
> > modules using call_srcu() will also need to invoke srcu_barrier() from
> > their module_exit function.
> 
> This arbitrary API limitation seems weird.
> 
> Isn't there a way to allow modules to use DEFINE_SRCU and DEFINE_STATIC_SRCU
> while implementing them with dynamic allocation under the hood ?

Although call_srcu() already has initialization hooks, some would
also be required in srcu_read_lock(), and I am concerned about adding
memory allocation at that point, especially given the possibility
of memory-allocation failure.  And the possibility that the first
srcu_read_lock() happens in an interrupt handler or similar.

Or am I missing a trick here?

							Thanx, Paul

> Thanks,
> 
> Mathieu
> 
> 
> > 
> > This series consist of the following:
> > 
> > 1.	Dynamically allocate dax_srcu.
> > 
> > 2.	Dynamically allocate drm_unplug_srcu.
> > 
> > 3.	Dynamically allocate kfd_processes_srcu.
> > 
> > These build and have been subjected to 0day testing, but might also need
> > testing by someone having the requisite hardware.
> > 
> >							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > drivers/dax/super.c                        |   10 +++++-
> > drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |    5 +++
> > drivers/gpu/drm/amd/amdkfd/kfd_process.c   |    2 -
> > drivers/gpu/drm/drm_drv.c                  |    8 ++++
> > include/linux/srcutree.h                   |   19 +++++++++--
> > kernel/rcu/rcuperf.c                       |   40 +++++++++++++++++++-----
> > kernel/rcu/rcutorture.c                    |   48 +++++++++++++++++++++--------
> >  7 files changed, 105 insertions(+), 27 deletions(-)
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
> 

