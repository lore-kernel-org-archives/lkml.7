Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BFBC76186
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA6CF21855
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 01:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbfGYBMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 21:12:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726115AbfGYBMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 21:12:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6P18K3J113058
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 21:12:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2txxrxqna5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 21:12:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 25 Jul 2019 02:12:42 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 02:12:39 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6P1CcmU16253938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 01:12:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 536CDB2068;
        Thu, 25 Jul 2019 01:12:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31145B2066;
        Thu, 25 Jul 2019 01:12:38 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.189.166])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 01:12:38 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5437A16C34F8; Wed, 24 Jul 2019 18:12:43 -0700 (PDT)
Date:   Wed, 24 Jul 2019 18:12:43 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        peterz@infradead.org
Subject: Re: How to turn scheduler tick on for current nohz_full CPU?
Reply-To: paulmck@linux.ibm.com
References: <20190724115331.GA29059@linux.ibm.com>
 <20190724132257.GA1029@lenoir>
 <20190724135219.GY14271@linux.ibm.com>
 <20190724143012.GB1029@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724143012.GB1029@lenoir>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19072501-0060-0000-0000-00000365276F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011490; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01237008; UDB=6.00652024; IPR=6.01018375;
 MB=3.00027878; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-25 01:12:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072501-0061-0000-0000-00004A47F81F
Message-Id: <20190725011243.GZ14271@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 04:30:13PM +0200, Frederic Weisbecker wrote:
> On Wed, Jul 24, 2019 at 06:52:19AM -0700, Paul E. McKenney wrote:
> > On Wed, Jul 24, 2019 at 03:22:59PM +0200, Frederic Weisbecker wrote:
> > > On Wed, Jul 24, 2019 at 04:53:31AM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > One of the callback-invocation forward-progress issues turns out to
> > > > be nohz_full CPUs not turning their scheduling-clock interrupt back on
> > > > when running in kernel mode.  Given that callback floods can cause RCU's
> > > > callback-invocation loop to run for some time, it would be good for this
> > > > loop to re-enable this interrupt.  Of course, this problem applies to
> > > > pretty much any kernel code that might loop for an extended time period,
> > > > not just RCU.
> > > > 
> > > > I took a quick look at kernel/time/tick-sched.c and the closest thing
> > > > I found was tick_nohz_full_kick_cpu(), except that (1) it isn't clear
> > > > that this does much when invoked on the current CPU and (2) it doesn't
> > > > help in rcutorture TREE04.  In contrast, disabling NO_HZ_FULL and using
> > > > RCU_NOCB_CPU instead works quite well.
> > > > 
> > > > So what should I be calling instead of tick_nohz_full_kick_cpu() to
> > > > re-enable the current CPU's scheduling-clock interrupt?
> > > 
> > > Indeed, kernel code is assumed to be quick enough (between two extended grace
> > > periods) to avoid running the tick for RCU. But some long lasting kernel code
> > > may require to tick temporarily.
> > > 
> > > You can use tick_nohz_dep_set_cpu(cpu, TICK_DEP_MASK_RCU) with the
> > > following:
> > > 
> > > diff --git a/include/linux/tick.h b/include/linux/tick.h
> > > index f92a10b5e112..3f476e2a4bf7 100644
> > > --- a/include/linux/tick.h
> > > +++ b/include/linux/tick.h
> > > @@ -108,7 +108,8 @@ enum tick_dep_bits {
> > >  	TICK_DEP_BIT_POSIX_TIMER	= 0,
> > >  	TICK_DEP_BIT_PERF_EVENTS	= 1,
> > >  	TICK_DEP_BIT_SCHED		= 2,
> > > -	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3
> > > +	TICK_DEP_BIT_CLOCK_UNSTABLE	= 3,
> > > +	TICK_DEP_BIT_RCU		= 4
> > >  };
> > >  
> > >  #define TICK_DEP_MASK_NONE		0
> > > @@ -116,6 +117,7 @@ enum tick_dep_bits {
> > >  #define TICK_DEP_MASK_PERF_EVENTS	(1 << TICK_DEP_BIT_PERF_EVENTS)
> > >  #define TICK_DEP_MASK_SCHED		(1 << TICK_DEP_BIT_SCHED)
> > >  #define TICK_DEP_MASK_CLOCK_UNSTABLE	(1 << TICK_DEP_BIT_CLOCK_UNSTABLE)
> > > +#define TICK_DEP_MASK_RCU		(1 << TICK_DEP_BIT_RCU)
> > >  
> > >  #ifdef CONFIG_NO_HZ_COMMON
> > >  extern bool tick_nohz_enabled;
> > 
> > I will give this a try, thank you!  (Testing will take a few days.)
> 
> Sure!
> 
> For the background: expect a self-IPI to fire which then restart the tick on IRQ exit.
> Once you're later done with the work, don't forget to remove the tick dependency:
> 
>      tick_nohz_dep_clear_cpu(cpu, TICK_DEP_MASK_RCU);

Does this get cleared automatically if preempted, or should I clear
this is one of RCU's scheduler hooks?  (My guess is the latter, but
I figured I should ask.)

							Thanx, Paul

