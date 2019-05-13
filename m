Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2A7C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A992084F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfEMPx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:53:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50992 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728291AbfEMPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:53:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4DFpjN9144462
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:53:55 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sfaxgsxr1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:53:55 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 13 May 2019 16:53:54 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 May 2019 16:53:51 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4DFrokY25165966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 May 2019 15:53:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A75D1B205F;
        Mon, 13 May 2019 15:53:50 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92FFCB2066;
        Mon, 13 May 2019 15:53:50 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.216])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 13 May 2019 15:53:50 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E1DBF16C33C8; Mon, 13 May 2019 08:53:52 -0700 (PDT)
Date:   Mon, 13 May 2019 08:53:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Question about sched_setaffinity()
Reply-To: paulmck@linux.ibm.com
References: <20190507221613.GA11057@linux.ibm.com>
 <20190509173654.GA23530@linux.ibm.com>
 <20190509193625.GA12455@linux.ibm.com>
 <20190510120819.GR2589@hirez.programming.kicks-ass.net>
 <20190510230742.GY3923@linux.ibm.com>
 <20190511214520.GA3251@andrea>
 <20190512003915.GD3923@linux.ibm.com>
 <20190512010539.GA8167@andrea>
 <20190513122043.GJ3923@linux.ibm.com>
 <20190513153714.GA40957@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513153714.GA40957@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19051315-0052-0000-0000-000003BE8F8A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011093; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01202778; UDB=6.00631285; IPR=6.00983694;
 MB=3.00026868; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-13 15:53:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051315-0053-0000-0000-000060E1A50C
Message-Id: <20190513155352.GL3923@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905130109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:37:14AM -0400, Joel Fernandes wrote:
> On Mon, May 13, 2019 at 05:20:43AM -0700, Paul E. McKenney wrote:
> > On Sun, May 12, 2019 at 03:05:39AM +0200, Andrea Parri wrote:
> > > > > > The fix is straightforward.  I just added "rcutorture.shuffle_interval=0"
> > > > > > to the TRIVIAL.boot file, which stops rcutorture from shuffling its
> > > > > > kthreads around.
> > > > > 
> > > > > I added the option to the file and I didn't reproduce the issue.
> > > > 
> > > > Thank you!  May I add your Tested-by?
> > > 
> > > Please feel free to do so.  But it may be worth to squash "the commits"
> > > (and adjust the changelogs accordingly).  And you might want to remove
> > > some of those debug checks/prints?
> > 
> > Revert/remove a number of the commits, but yes.  ;-)
> > 
> > And remove the extra loop, but leave the single WARN_ON() complaining
> > about being on the wrong CPU.
> 
> The other "toy" implementation I noticed is based on reader/writer locking.
> 
> Would you see value in having that as an additional rcu torture type?

Interesting question!

My kneejerk reaction is "no" because the fact that reader-writer locking
primitives pass locktorture imply that they have the needed semantics
to be a toy RCU implementation.  (Things like NMI handlers prevent them
from operating correctly within the Linux kernel, and even things like
interrupt handlers would require disabling interrupts for Linux-kernel
use, but from a toy/textbook perspective, they qualify.)

We do have a large number of toy RCU implementations in perfbook, though,
and I believe reader-writer locking is one of them.

But the current "trivial" version would actually work in the Linux
kernel as it is, give or take more esoteric things like CPU hotplug
and respecting user-level uses of sched_setaffinity().  Which could be
"fixed", but at the expense of making it quite a bit less trivial.
(See early-2000s LKML traffic for some proposals along these lines.)

							Thanx, Paul

