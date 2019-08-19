Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B64C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B2D20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 02:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHSCPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 22:15:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726314AbfHSCPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 22:15:11 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7J2CGDT010786;
        Sun, 18 Aug 2019 22:14:56 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufdc1ruqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Aug 2019 22:14:56 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7J2Dxo9013943;
        Sun, 18 Aug 2019 22:14:55 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufdc1ruq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 18 Aug 2019 22:14:55 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7J2AB2H008413;
        Mon, 19 Aug 2019 02:14:54 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma05wdc.us.ibm.com with ESMTP id 2ue975s4ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 02:14:54 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7J2ErS650528616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 02:14:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A03B2064;
        Mon, 19 Aug 2019 02:14:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2422FB205F;
        Mon, 19 Aug 2019 02:14:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 02:14:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CFD0F16C1AFD; Sun, 18 Aug 2019 19:14:55 -0700 (PDT)
Date:   Sun, 18 Aug 2019 19:14:55 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        peterz@infradead.org, joel@joelfernandes.org
Subject: Re: How to turn scheduler tick on for current nohz_full CPU?
Message-ID: <20190819021455.GA23663@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190724115331.GA29059@linux.ibm.com>
 <20190724132257.GA1029@lenoir>
 <20190724135219.GY14271@linux.ibm.com>
 <20190724143012.GB1029@lenoir>
 <20190725011243.GZ14271@linux.ibm.com>
 <20190729223238.GF14271@linux.ibm.com>
 <20190730164309.GA962@lenoir>
 <20190730173637.GG14271@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190730173637.GG14271@linux.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=918 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 10:36:37AM -0700, Paul E. McKenney wrote:
> On Tue, Jul 30, 2019 at 06:43:10PM +0200, Frederic Weisbecker wrote:
> > On Mon, Jul 29, 2019 at 03:32:38PM -0700, Paul E. McKenney wrote:
> > > On Wed, Jul 24, 2019 at 06:12:43PM -0700, Paul E. McKenney wrote:
> > > 
> > > The patch below (which includes your patch) does help considerably.
> > > However, it does have some shortcomings:
> > > 
> > > 1.	Adds an atomic operation (albeit a cache-local one) to
> > > 	the scheduler fastpath.  One approach would be to have
> > > 	a way of testing this bit and clearing it only if set.
> > > 
> > > 	Another approach would be to instead clear it on the
> > > 	transition to nohz_full userspace or to idle.
> > 
> > Well, the latter would be costly as it is going to restart the tick on every
> > user -> kernel transitions.
> 
> You lost me on this one.  I would be turning off RCU's request to
> maintain the tick on transition to nohz_full userspace or to idle.
> Why would the tick get turned on by a later user->kernel transition?
> 
> > > 2.	There are a lot of other places in the kernel that are in
> > > 	need of this bit being set.  I am therefore considering making
> > > 	multi_cpu_stop() or its callers set this bit on all CPUs upon
> > > 	entry and clear it upon exit.  While in this state, it is
> > > 	likely necessary to disable clearing this bit.  Or it would
> > > 	be necessary to make multi_cpu_stop() repeat clearing the bit
> > > 	every so often.
> > > 
> > > 	As it stands, I have CPU hotplug removal operations taking
> > > 	more than 400 seconds.
> > > 
> > > 3.	It was tempting to ask for this bit to be tracked on a per-task
> > > 	basis, but from what I can see that adds at least as much
> > > 	complexity as it removes.
> > 
> > Yeah I forgot to answer, you can use tick_dep_set_task() for that.
> 
> Ah, good, that would remove my need to clear things on the scheduler
> fastpaths.  My guess is that I use both the per-CPU and the per-task
> variant in different places, but testing will tell!  ;-)

And after a few bug fixes (one key fix for an embarrassing bug from Joel),
this now passes 14-hour rcutorture on the scenario that used to get RCU
CPU stall warnings once or twice per hour.  Though still not material for
the upcoming merge window.

Thank you, everyone!

							Thanx, Paul
