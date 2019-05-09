Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C432C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15624208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 22:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfEIWRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 18:17:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727224AbfEIWRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 18:17:39 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x49MGWhT071376
        for <linux-kernel@vger.kernel.org>; Thu, 9 May 2019 18:17:38 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2scsufxmyn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2019 18:17:37 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 9 May 2019 23:17:35 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 9 May 2019 23:17:31 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x49MHUlD37224552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 May 2019 22:17:31 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE4D6B2072;
        Thu,  9 May 2019 22:17:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80192B205F;
        Thu,  9 May 2019 22:17:30 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  9 May 2019 22:17:30 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DC87A16C5DD8; Thu,  9 May 2019 15:17:30 -0700 (PDT)
Date:   Thu, 9 May 2019 15:17:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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
 <20190509214025.GA5385@andrea>
 <20190509215505.GB5820@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509215505.GB5820@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19050922-0060-0000-0000-0000033E2C24
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011079; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01201013; UDB=6.00630211; IPR=6.00981904;
 MB=3.00026819; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-09 22:17:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050922-0061-0000-0000-00004949E7B9
Message-Id: <20190509221730.GM3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-09_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905090127
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 11:56:35PM +0200, Andrea Parri wrote:
> On Thu, May 09, 2019 at 11:40:25PM +0200, Andrea Parri wrote:
> > On Thu, May 09, 2019 at 10:36:54AM -0700, Paul E. McKenney wrote:
> > > On Tue, May 07, 2019 at 03:16:13PM -0700, Paul E. McKenney wrote:
> > > > On Wed, May 01, 2019 at 01:27:13PM -0700, Paul E. McKenney wrote:
> > > > > On Wed, May 01, 2019 at 03:16:55PM -0400, Steven Rostedt wrote:
> > > > > > On Wed, 1 May 2019 12:12:13 -0700
> > > > > > "Paul E. McKenney" <paulmck@linux.ibm.com> wrote:
> > > > > > 
> > > > > > 
> > > > > > > OK, what I did was to apply the patch at the end of this email to -rcu
> > > > > > > branch dev, then run rcutorture as follows:
> > > > > > > 
> > > > > > > nohup tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 8 --duration 2 --configs "TRIVIAL" --bootargs "trace_event=sched:sched_switch,sched:sched_wakeup ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop"
> > > > > > > 
> > > > > > > This resulted in the console output that I placed here:
> > > > > > > 
> > > > > > > http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > > > > > > 
> > > > > > > But I don't see calls to sched_setaffinity() or migration_cpu_stop().
> > > > > > > Steve, is something else needed on the kernel command line in addition to
> > > > > > > the following?
> > > > > > > 
> > > > > > > ftrace=function_graph ftrace_graph_filter=sched_setaffinity,migration_cpu_stop
> > > > > > 
> > > > > > Do you have function graph enabled in the config?
> > > > > > 
> > > > > > [    2.098303] ftrace bootup tracer 'function_graph' not registered.
> > > > > 
> > > > > I guess I don't!  Thank you, will fix.
> > > > > 
> > > > > Let's see...
> > > > > 
> > > > > My .config has CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y.  It looks like I
> > > > > need CONFIG_FUNCTION_GRAPH_TRACER=y, which I don't have.  And it looks
> > > > > like that needs CONFIG_FUNCTION_TRACER=y, which I also don't have.
> > > > > But I do have CONFIG_HAVE_FUNCTION_TRACER=y.  So I should add this
> > > > > to my rcutorture command line:
> > > > > 
> > > > > --kconfig "CONFIG_FUNCTION_TRACER=y CONFIG_FUNCTION_GRAPH_TRACER=y".
> > > > > 
> > > > > I fired this up.  Here is hoping!  ;-)
> > > > > 
> > > > > And it does have sched_setaffinity(), woo-hoo!!!  I overwrote the old file:
> > > > > 
> > > > > 	http://www2.rdrop.com/~paulmck/submission/console.log.gz
> > > > 
> > > > And I reran after adding a trace_printk(), which shows up as follows:
> > > > 
> > > > [  211.409565]  6)               |  /* On unexpected CPU 6, expected 4!!! */
> > > > 
> > > > I placed the console log here:
> > > > 
> > > > 	http://www2.rdrop.com/~paulmck/submission/console.tpk.log.gz
> > > > 
> > > > Just in case the earlier log proves useful.
> > > > 
> > > > And it is acting as if the destination CPU proved to be offline.  Except
> > > > that this rcutorture scenario doesn't offline anything, and I don't see
> > > > any CPU-hotplug removal messages.  So I added another trace_printk() to
> > > > print out cpu_online_mask.  This gets me the following:
> > > > 
> > > > [   31.565605]  0)               |  /* On unexpected CPU 0, expected 1!!! */
> > > > [   31.565605]  0)               |  /* Online CPUs: 0-7 */
> > > > 
> > > > So we didn't make it to CPU 1 despite its being online.  I placed the
> > > > console log here:
> > > > 
> > > > 	http://www2.rdrop.com/~paulmck/submission/console.tpkol.log.gz
> > > > 
> > > > Thoughts?
> > 
> > And I can finally see/reproduce it!!
> > 
> > Frankly, no idea how this is happening (I have been staring at these
> > traces/functions for hours/days now...  ;-/ )
> > 
> > Adding some "sched" folks in Cc: hopefully, they can shed some light
> > about this.
> 
> +Thomas, +Sebastian
> 
> Thread starts here:
> 
> http://lkml.kernel.org/r/20190427180246.GA15502@linux.ibm.com

Peter Zijlstra kindly volunteered over IRC to look at this more closely
tomorrow (well, today, his time).  It is quite strange, though!  ;-)

							Thanx, Paul

>   Andrea
> 
> 
> > 
> > And yes, my only suggestion/approach would be to keep bisecting this
> > code with printk*..., 'fun' ;-/
> > 
> >   Andrea
> 

