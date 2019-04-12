Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593D7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B072084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfDLLa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:30:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726327AbfDLLaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:30:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3CBQD73129056
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:30:25 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rtsrhr8gr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 07:30:24 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 12 Apr 2019 12:30:23 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Apr 2019 12:30:19 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3CBUIS734078942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Apr 2019 11:30:18 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78B7BB2070;
        Fri, 12 Apr 2019 11:30:18 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E79FB2066;
        Fri, 12 Apr 2019 11:30:18 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.226.95])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 12 Apr 2019 11:30:18 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D4D6A16C36C6; Fri, 12 Apr 2019 04:30:18 -0700 (PDT)
Date:   Fri, 12 Apr 2019 04:30:18 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/4] Allow CPU0 to be nohz full
Reply-To: paulmck@linux.ibm.com
References: <20190404120704.18479-1-npiggin@gmail.com>
 <alpine.DEB.2.21.1904041635190.1685@nanos.tec.linutronix.de>
 <1554393113.wbjxx9ccdx.astroid@bobo.none>
 <alpine.DEB.2.21.1904051952160.1802@nanos.tec.linutronix.de>
 <1554800737.v126tflazd.astroid@bobo.none>
 <20190411154239.GA29448@linux.ibm.com>
 <1555037352.52b4w2o4bf.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1555037352.52b4w2o4bf.astroid@bobo.none>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041211-0060-0000-0000-0000032C05FB
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010914; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187982; UDB=6.00622319; IPR=6.00968750;
 MB=3.00026410; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-12 11:30:22
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041211-0061-0000-0000-000048ECA284
Message-Id: <20190412113018.GG14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-12_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=637 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904120075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 01:16:01PM +1000, Nicholas Piggin wrote:
> Paul E. McKenney's on April 12, 2019 1:42 am:
> > On Tue, Apr 09, 2019 at 07:21:54PM +1000, Nicholas Piggin wrote:
> >> Thomas Gleixner's on April 6, 2019 3:54 am:
> >> > On Fri, 5 Apr 2019, Nicholas Piggin wrote:
> >> >> Thomas Gleixner's on April 5, 2019 12:36 am:
> >> >> > On Thu, 4 Apr 2019, Nicholas Piggin wrote:
> >> >> > 
> >> >> >> I've been looking at ways to fix suspend breakage with CPU0 as a
> >> >> >> nohz CPU. I started looking at various things like allowing CPU0
> >> >> >> to take over do_timer again temporarily or allowing nohz full
> >> >> >> to be stopped at runtime (that is quite a significant change for
> >> >> >> little real benefit). The problem then was having the housekeeping
> >> >> >> CPU go offline.
> >> >> >> 
> >> >> >> So I decided to try just allowing the freeze to occur on non-zero
> >> >> >> CPU. This seems to be a lot simpler to get working, but I guess
> >> >> >> some archs won't be able to deal with this? Would it be okay to
> >> >> >> make it opt-in per arch?
> >> >> > 
> >> >> > It needs to be opt in. x86 will fall on its nose with that.
> >> >> 
> >> >> Okay I can add that.
> >> >> 
> >> >> > Now the real interesting question is WHY do we need that at all?
> >> >> 
> >> >> Why full nohz for CPU0? Basically this is how their job system was
> >> >> written and used, testing nohz full was a change that came much later 
> >> >> as an optimisation.
> >> >> 
> >> >> I don't think there is a fundamental reason an equivalent system
> >> >> could not be made that uses a different CPU for housekeeping, but I
> >> >> was assured the change would be quite difficult for them.
> >> >> 
> >> >> If we can support it, it seems nice if you can take a particular
> >> >> configuration and just apply nohz_full to your application processors
> >> >> without any other changes.
> >> > 
> >> > This wants an explanation in the patches.
> >> 
> >> Okay.
> >> 
> >> > And patch 4 has in the changelog:
> >> > 
> >> >    nohz_full has been successful at significantly reducing jitter for a
> >> >    large supercomputer customer, but their job control system requires CPU0
> >> >    to be for housekeeping.
> >> > 
> >> > which just makes me dazed and confused :)
> >> > 
> >> > Other than some coherent explanation and making it opt in, I don't think
> >> > there is a fundamental issue with that.
> >> 
> >> I will try to make the changelogs less jibberish then :)
> > 
> > Maybe this is all taken care of now, but do the various clocks stay
> > synchronized with wall-clock time if all CPUs are in nohz_full mode?
> > At one time, at least one CPU needed to keep its scheduler-clock
> > interrupt going in order to keep things in sync.
> 
> Ah, may not have been clear in the changelog -- the series still 
> requires at least one CPU present at boot time to be a housekeeper 
> that keeps things running. So conceptually this doesn't change 
> anything about runtime behaviour, the main change is the boot-time
> handoff from CPU0.

I did miss that, thank you for the update.

> > The ppc timebase register might make it possible to do this without any
> > scheduler-clock interrupts, but figured I should check.  ;-)
> 
> I dont know all this code too well, but if we really wanted to push 
> things, I think nohz-full could be more aggressive in shutting down 
> the tick and possibly even avoiding a housekeeping CPU completely, but 
> you would have to do that work on user->kernel switch too. Likely the 
> complexity and overhead is not worthwhile.

There was some RCU functionality that detected when all the
non-housekeeping CPUs went idle, but it went unused for some years, so
I reverted it.  This revert commit is at tag sysidle.2017.05.11a in my
-rcu tree.  If it is actually going to be used, I could of course add
it back.  ;-)

> Other thing is you might be able to avoid the jiffies tick completely
> and change jiffies to read from timebase register. Lot of interesting
> things we could try.

Or make userspace use the timebase register to avoid the need for
in-kernel time adjustments, though the connection to NTP and similar
would still need to be maintained.  I supposed that the jiffies
counter could be fixed up on entry to the kernel?

							Thanx, Paul

