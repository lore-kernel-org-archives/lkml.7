Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3A8C5B577
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB17214DA
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 19:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfF2TQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 15:16:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726882AbfF2TQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 15:16:15 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5TJBY58091299;
        Sat, 29 Jun 2019 15:15:16 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tec55ja4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jun 2019 15:15:16 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5TJCLFP092599;
        Sat, 29 Jun 2019 15:15:16 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tec55ja42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jun 2019 15:15:16 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5TJEaUv015307;
        Sat, 29 Jun 2019 19:15:15 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma03dal.us.ibm.com with ESMTP id 2tdym6c4fg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Jun 2019 19:15:15 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5TJFExA49676550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 29 Jun 2019 19:15:14 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B4A44B205F;
        Sat, 29 Jun 2019 19:15:14 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92E05B2065;
        Sat, 29 Jun 2019 19:15:14 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.128.230])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 29 Jun 2019 19:15:14 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6BC4A16C1BB1; Sat, 29 Jun 2019 12:15:15 -0700 (PDT)
Date:   Sat, 29 Jun 2019 12:15:15 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Andrea Parri <andrea.parri@amarulasolutions.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Message-ID: <20190629191515.GM26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628073138.GB13650@X58A-UD3R>
 <20190628104045.GA8394@X58A-UD3R>
 <20190628114411.5d9ab351@gandalf.local.home>
 <20190629151236.GA7862@andrea>
 <20190629165533.GA3112@linux.ibm.com>
 <20190629180910.GA3399@andrea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190629180910.GA3399@andrea>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-29_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906290240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 29, 2019 at 08:09:10PM +0200, Andrea Parri wrote:
> On Sat, Jun 29, 2019 at 09:55:33AM -0700, Paul E. McKenney wrote:
> > On Sat, Jun 29, 2019 at 05:12:36PM +0200, Andrea Parri wrote:
> > > Hi Steve,
> > > 
> > > > As Paul stated, interrupts are synchronization points. Archs can only
> > > > play games with ordering when dealing with entities outside the CPU
> > > > (devices and other CPUs). But if you have assembly that has two stores,
> > > > and an interrupt comes in, the arch must guarantee that the stores are
> > > > done in that order as the interrupt sees it.
> > > 
> > > Hopefully I'm not derailing the conversation too much with my questions
> > > ... but I was wondering if we had any documentation (or inline comments)
> > > elaborating on this "interrupts are synchronization points"?
> > 
> > I don't know of any, but I would suggest instead looking at something
> > like the Hennessey and Patterson computer-architecture textbook.
> > 
> > Please keep in mind that the rather detailed documentation on RCU is a
> > bit of an outlier due to the fact that there are not so many textbooks
> > that cover RCU.  If we tried to replicate all of the relevant textbooks
> > in the Documentation directory, it would be quite a large mess.  ;-)
> 
> You know some developers considered it worth to develop formal specs in
> order to better understand concepts such as "synchronization" and "IRQs
> (processing)"! ...  ;-)  I still think that adding a few paragraphs (if
> only in informal prose) to explain that "interrupts are synchronization
> points" wouln't hurt.  And you're right, I guess we may well start from
> a reference to H&P...
> 
> Remark: we do have code which (while acknowledging that "interrupts are
> synchronization points") doesn't quite seem to "believe it", c.f., e.g.,
> kernel/sched/membarrier.c:ipi_mb().  So, I guess the follow-up question
> would be "Would we better be (more) paranoid? ..."

As Steve said that I said, they are synchronization points from the
viewpoint of code within the interrupted CPU.  Unless the architecture
code does as smp_mb() on interrupt entry and exit (which perhaps some
do, for all I know, maybe all of them do by now), memory accesses could
still be reordered across the interrupt from the perspective of other
CPUs and devices on the system.

							Thanx, Paul
