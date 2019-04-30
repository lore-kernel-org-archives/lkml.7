Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E675DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD10820675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfD3Kvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:51:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726294AbfD3Kvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:51:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3UAhJgk144190;
        Tue, 30 Apr 2019 06:51:31 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s6hj3gyye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 06:51:31 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x3U4s422004003;
        Tue, 30 Apr 2019 04:55:23 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma01dal.us.ibm.com with ESMTP id 2s4eq3sdkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 04:55:23 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3UApTok25624786
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Apr 2019 10:51:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A09F7B2066;
        Tue, 30 Apr 2019 10:51:29 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80792B2065;
        Tue, 30 Apr 2019 10:51:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.213.184])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 30 Apr 2019 10:51:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0707016C0A0D; Tue, 30 Apr 2019 03:51:30 -0700 (PDT)
Date:   Tue, 30 Apr 2019 03:51:30 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, andrea.parri@amarulasolutions.com
Subject: Re: Question about sched_setaffinity()
Message-ID: <20190430105129.GA3923@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190427180246.GA15502@linux.ibm.com>
 <20190430100318.GP2623@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190430100318.GP2623@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-30_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904300070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 12:03:18PM +0200, Peter Zijlstra wrote:
> On Sat, Apr 27, 2019 at 11:02:46AM -0700, Paul E. McKenney wrote:
> 
> > This actually passes rcutorture.  But, as Andrea noted, not klitmus.
> > After some investigation, it turned out that klitmus was creating kthreads
> > with PF_NO_SETAFFINITY, hence the failures.  But that prompted me to
> > put checks into my code: After all, rcutorture can be fooled.
> > 
> > 	void synchronize_rcu(void)
> > 	{
> > 		int cpu;
> > 
> > 		for_each_online_cpu(cpu) {
> > 			sched_setaffinity(current->pid, cpumask_of(cpu));
> > 			WARN_ON_ONCE(raw_smp_processor_id() != cpu);
> > 		}
> > 	}
> > 
> > This triggers fairly quickly, usually in less than a minute of rcutorture
> > testing.
> >
> > And further investigation shows that sched_setaffinity()
> > always returned 0. 
> 
> > Is this expected behavior?  Is there some configuration or setup that I
> > might be missing?
> 
> ISTR there is hotplug involved in RCU torture? In that case, it can be
> sched_setaffinity() succeeds to place us on a CPU, which CPU hotplug
> then takes away. So when we run the WARN thingy, we'll be running on a
> different CPU than expected.

There can be CPU hotplug involved in rcutorture, but it was disabled
during this run.

> If OTOH, your loop is written like (as it really should be):
> 
> 	void synchronize_rcu(void)
> 	{
> 		int cpu;
> 
> 		cpus_read_lock();
> 		for_each_online_cpu(cpu) {
> 			sched_setaffinity(current->pid, cpumask_of(cpu));
> 			WARN_ON_ONCE(raw_smp_processor_id() != cpu);
> 		}
> 		cpus_read_unlock();
> 	}
> 
> Then I'm not entirely sure how we can return 0 and not run on the
> expected CPU. If we look at __set_cpus_allowed_ptr(), the only paths out
> to 0 are:
> 
>  - if the mask didn't change
>  - if we already run inside the new mask
>  - if we migrated ourself with the stop-task
>  - if we're not in fact running
> 
> That last case should never trigger in your circumstances, since @p ==
> current and current is obviously running. But for completeness, the
> wakeup of @p would do the task placement in that case.

Are there some diagnostics I could add that would help track this down,
be it my bug or yours?

							Thanx, Paul
