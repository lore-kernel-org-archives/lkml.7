Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA678C06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC08E20881
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 12:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfGAMXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 08:23:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39584 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727820AbfGAMXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 08:23:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x61CIYfv145254
        for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2019 08:23:07 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tfhnmt0kw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 08:23:07 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Jul 2019 13:23:07 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 13:23:03 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x61CN2YM13304396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 12:23:02 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F104B2064;
        Mon,  1 Jul 2019 12:23:02 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DD10B205F;
        Mon,  1 Jul 2019 12:23:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.128.230])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 12:23:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E411A16C5D9E; Mon,  1 Jul 2019 05:23:05 -0700 (PDT)
Date:   Mon, 1 Jul 2019 05:23:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Scott Wood <swood@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC] Deadlock via recursive wakeup via RCU with threadirqs
Reply-To: paulmck@linux.ibm.com
References: <20190627181638.GA209455@google.com>
 <20190627184107.GA26519@linux.ibm.com>
 <13761fee4b71cc004ad0d6709875ce917ff28fce.camel@redhat.com>
 <20190627203612.GD26519@linux.ibm.com>
 <20190628141522.GF3402@hirez.programming.kicks-ass.net>
 <20190628155404.GV26519@linux.ibm.com>
 <20190628160408.GH32547@worktop.programming.kicks-ass.net>
 <20190628172056.GW26519@linux.ibm.com>
 <20190701094215.GR3402@hirez.programming.kicks-ass.net>
 <20190701102442.35grdpcsbrwyyaco@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190701102442.35grdpcsbrwyyaco@linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070112-0072-0000-0000-000004430B4F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011359; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01225887; UDB=6.00645332; IPR=6.01007099;
 MB=3.00027534; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-01 12:23:06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070112-0073-0000-0000-00004CB34210
Message-Id: <20190701122305.GB26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=833 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 12:24:42PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-07-01 11:42:15 [+0200], Peter Zijlstra wrote:
> > I'm not sure if smp_send_reschedule() can be used as self-IPI, some
> > hardware doesn't particularly like that IIRC. That is, hardware might
> > only have interfaces to IPI _other_ CPUs, but not self.
> > 
> > The normal scheduler code takes care to not call smp_send_reschedule()
> > to self.
> 
> and irq_work:
>   471ba0e686cb1 ("irq_work: Do not raise an IPI when queueing work on the local CPU")

OK, so it looks like I will need to use something else.  But thank you
for calling my attention to this commit.

							Thanx, Paul

