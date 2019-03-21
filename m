Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B656CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C47B2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfCUNZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:25:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728157AbfCUNZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:25:20 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2LDOYdM062566
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:25:18 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rc96yep4k-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 09:25:18 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 21 Mar 2019 13:25:15 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 21 Mar 2019 13:25:11 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2LDPCWR25034776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Mar 2019 13:25:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F33AB2064;
        Thu, 21 Mar 2019 13:25:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 815ABB205F;
        Thu, 21 Mar 2019 13:25:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 21 Mar 2019 13:25:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 056D016C1ED4; Thu, 21 Mar 2019 06:26:04 -0700 (PDT)
Date:   Thu, 21 Mar 2019 06:26:03 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, tglx@linutronix.de,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v3] rcu: Allow to eliminate softirq processing from
 rcutree
Reply-To: paulmck@linux.ibm.com
References: <20190320160547.s5lbeahr2y4jlzwt@linutronix.de>
 <20190320161500.GK4102@linux.ibm.com>
 <20190320163532.mr32oi53iaueuizw@linutronix.de>
 <20190320173001.GM4102@linux.ibm.com>
 <20190320175952.yh6yfy64vaiurszw@linutronix.de>
 <20190320181210.GO4102@linux.ibm.com>
 <20190320181435.x3qyutwqllmq5zbk@linutronix.de>
 <20190320211333.eq7pwxnte7la67ph@linutronix.de>
 <20190320234601.GQ4102@linux.ibm.com>
 <20190321082737.t5jhdyuartimamu2@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321082737.t5jhdyuartimamu2@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032113-0064-0000-0000-000003BE26F2
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010789; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01177557; UDB=6.00616015; IPR=6.00958253;
 MB=3.00026091; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-21 13:25:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032113-0065-0000-0000-00003CCADC3E
Message-Id: <20190321132603.GS4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-21_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903210096
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 09:27:37AM +0100, Sebastian Andrzej Siewior wrote:
> On 2019-03-20 16:46:01 [-0700], Paul E. McKenney wrote:
> > Thank you!  I reverted v2 and applied this one with the same sort of
> > update.  Testing is going well thus far aside from my failing to add
> > the required "=0" after the rcutree.use_softirq.  I will probably not
> > be the only one who will run afoul of this, so I updated the commit log
> > and the documentation accordingly, as shown below.
> 
> perfect, thank you.
> 
> > 							Thanx, Paul
> > 
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index f46b4af96ab9..b807204ffd83 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -629,7 +609,10 @@ static void rcu_read_unlock_special(struct task_struct *t)
> >  		/* Need to defer quiescent state until everything is enabled. */
> >  		if (irqs_were_disabled) {
> >  			/* Enabling irqs does not reschedule, so... */
> > -			raise_softirq_irqoff(RCU_SOFTIRQ);
> > +			if (!use_softirq)
> 
> that exclamation mark needs to go :/

That might explain some of the failures in TREE01, TREE02, TREE03, and
TREE09.  TREE01 got a NULL pointer dereference, but in __do_softirq().
So I suspect that this was related.  Ditto for TREE02, TREE03, and TREE09.
These also all have CONFIG_PREEMPT=y, and are the only ones run by default
that are set up this way.  (Well, so do SRCU-P, TASKS01, and TASKS03, but
they are torturing other forms of RCU.)

Anyway, I applied your fix above and will rerun.  The failures happened
within a few seconds in all cases, so a short run should cover this.

Once I get good rcutorture runs, I will ask you to run a heavy-duty run.
Once that passes, I will look at your changes in more detail.

							Thanx, Paul

> > +				raise_softirq_irqoff(RCU_SOFTIRQ);
> > +			else
> > +				invoke_rcu_core();
> >  		} else {
> >  			/* Enabling BH or preempt does reschedule, so... */
> >  			set_tsk_need_resched(current);
> 
> Sebastian
> 

