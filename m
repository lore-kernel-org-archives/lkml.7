Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947DAC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 23:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DC702084A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 23:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfEJXHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 19:07:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59692 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726944AbfEJXHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 19:07:49 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4AMqNZC103375
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 19:07:48 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sdfhqee62-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 19:07:47 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 11 May 2019 00:07:47 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 11 May 2019 00:07:42 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4AN7fbf11075730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 May 2019 23:07:41 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 856C6B205F;
        Fri, 10 May 2019 23:07:41 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58551B2065;
        Fri, 10 May 2019 23:07:41 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 May 2019 23:07:41 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1C70116C3968; Fri, 10 May 2019 16:07:42 -0700 (PDT)
Date:   Fri, 10 May 2019 16:07:42 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        andrea.parri@amarulasolutions.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>, joelaf@google.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question about sched_setaffinity()
Reply-To: paulmck@linux.ibm.com
References: <20190430100318.GP2623@hirez.programming.kicks-ass.net>
 <20190430105129.GA3923@linux.ibm.com>
 <20190430115551.GT2623@hirez.programming.kicks-ass.net>
 <20190501191213.GX3923@linux.ibm.com>
 <20190501151655.51469a4c@gandalf.local.home>
 <20190501202713.GY3923@linux.ibm.com>
 <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509193625.GA12455@linux.ibm.com>
 <20190510120819.GR2589@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510120819.GR2589@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19051023-2213-0000-0000-0000038BE1E7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011083; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01201504; UDB=6.00630509; IPR=6.00982400;
 MB=3.00026837; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-10 23:07:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051023-2214-0000-0000-00005E62CD58
Message-Id: <20190510230742.GY3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-10_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905100145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 02:08:19PM +0200, Peter Zijlstra wrote:
> On Thu, May 09, 2019 at 12:36:25PM -0700, Paul E. McKenney wrote:
> > I forward-ported the relevant patches from -rcu and placed them on -rcu
> > branch peterz.2019.05.09a, and this is what produced the output above.
> > 
> > Any other debugging thoughts?
> > 
> > Or, if you wish, you can reproduce by running the following:
> > 
> > nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop" --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y"
> > 
> > This gets me the following summary output:
> > 
> >  --- Thu May  9 12:08:31 PDT 2019 Test summary:
> >  Results directory: /home/git/linux-2.6-tip/tools/testing/selftests/rcutorture/res/2019.05.09-12:08:31
> >  tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs TRIVIAL --bootargs trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop --kconfig CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y
> >  TRIVIAL ------- 2177 GPs (18.1417/s) [trivial: g0 f0x0 ]
> >  :CONFIG_HOTPLUG_CPU: improperly set
> >  WARNING: BAD SEQ 2176:2176 last:2177 version 4
> >      /home/git/linux-2.6-tip/tools/testing/selftests/rcutorture/res/2019.05.09-12:08:31/TRIVIAL/console.log
> >      WARNING: Assertion failure in /home/git/linux-2.6-tip/tools/testing/selftests/rcutorture/res/2019.05.09-12:08:31/TRIVIAL/console.log
> >      WARNING: Summary: Warnings: 1 Bugs: 1 Call Traces: 5 Stalls: 8
> 
> So I could reproduce...
> 
> I must first complain about your scripts; it does "make mrproper" on the
> source tree every time you run it, this is not appreciated. For one, it
> deletes my 'tags' file.

This is because it builds in a different directory, and "make O=/path"
complains if you don't have the source directory pristine.

But there really is no longer any reason to build in a different
directory, I suppose.  This is a largish change, but working on it.

> Getting it to not rebuild the whole kernel every time wasn't easy
> either.

You trust "make" far more than I do!  I am thinking of adding a
"--trust-make" argument that suppresses the "make clean".  Maybe if
I grow to trust "make" in the fulness of time, I can remove the "make
clean" entirely.  But given ccache, and given the duration of the typical
rcutorture run, and given that there are multiple rcutorture scenarios
each with a different .config, this hasn't been a priority.  The build
step is already omitted for repeated runs.

> Aside from that it seems to 'work'.
> 
> The below trace explain the issue. Some Paul person did it, see below.
> It's broken per construction :-)

*facepalm*  Hence the very strange ->cpus_allowed mask.  I really
should have figured that one out.

The fix is straightforward.  I just added "rcutorture.shuffle_interval=0"
to the TRIVIAL.boot file, which stops rcutorture from shuffling its
kthreads around.

Please accept my apologies for the hassle, and thank you for tracking
this down!!!

							Thanx, Paul

