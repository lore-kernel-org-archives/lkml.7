Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36B5F22CE9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 16:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbfHSQRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 12:17:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24690 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727868AbfHSQRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 12:17:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JGHhqM108288
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:17:43 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufwgx4fh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2019 12:17:43 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 19 Aug 2019 17:17:36 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 19 Aug 2019 17:17:33 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7JGHW8w46334368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Aug 2019 16:17:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F9F1B2067;
        Mon, 19 Aug 2019 16:17:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B5C3B2070;
        Mon, 19 Aug 2019 16:17:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 19 Aug 2019 16:17:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 777ED16C124D; Mon, 19 Aug 2019 09:17:36 -0700 (PDT)
Date:   Mon, 19 Aug 2019 09:17:36 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH -rcu dev 3/3] RFC: rcu/tree: Read dynticks_nmi_nesting in
 advance
Reply-To: paulmck@linux.ibm.com
References: <20190816025311.241257-1-joel@joelfernandes.org>
 <20190816025311.241257-3-joel@joelfernandes.org>
 <20190816162404.GB10481@google.com>
 <20190816165242.GS28441@linux.ibm.com>
 <20190819125907.GD27088@lenoir>
 <20190819142208.GA117378@google.com>
 <20190819144107.GV28441@linux.ibm.com>
 <20190819154636.GC117548@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819154636.GC117548@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081916-0052-0000-0000-000003EC5342
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011618; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249125; UDB=6.00659386; IPR=6.01030659;
 MB=3.00028236; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 16:17:35
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081916-0053-0000-0000-0000622668DC
Message-Id: <20190819161736.GZ28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:46:36AM -0400, Joel Fernandes wrote:
> On Mon, Aug 19, 2019 at 07:41:08AM -0700, Paul E. McKenney wrote:
> > On Mon, Aug 19, 2019 at 10:22:08AM -0400, Joel Fernandes wrote:
> > > On Mon, Aug 19, 2019 at 02:59:08PM +0200, Frederic Weisbecker wrote:
> > > > On Fri, Aug 16, 2019 at 09:52:42AM -0700, Paul E. McKenney wrote:
> > > > > On Fri, Aug 16, 2019 at 12:24:04PM -0400, Joel Fernandes wrote:
> > > > > > On Thu, Aug 15, 2019 at 10:53:11PM -0400, Joel Fernandes (Google) wrote:
> > > > > > > I really cannot explain this patch, but without it, the "else if" block
> > > > > > > just doesn't execute thus causing the tick's dep mask to not be set and
> > > > > > > causes the tick to be turned off.
> > > > > > > 
> > > > > > > I tried various _ONCE() macros but the only thing that works is this
> > > > > > > patch.
> > > > > > > 
> > > > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > > > > ---
> > > > > > >  kernel/rcu/tree.c | 3 ++-
> > > > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > index 856d3c9f1955..ac6bcf7614d7 100644
> > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > @@ -802,6 +802,7 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
> > > > > > >  {
> > > > > > >  	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
> > > > > > >  	long incby = 2;
> > > > > > > +	int dnn = rdp->dynticks_nmi_nesting;
> > > > > > 
> > > > > > I believe the accidental sign extension / conversion from long to int was
> > > > > > giving me an illusion since things started working well. Changing the 'int
> > > > > > dnn' to 'long dnn' gives similar behavior as without this patch! At least I
> > > > > > know now. Please feel free to ignore this particular RFC patch while I debug
> > > > > > this more (over the weekend or early next week). The first 2 patches are
> > > > > > good, just ignore this one.
> > > > > 
> > > > > Ah, good point on the type!  So you were ending up with zero due to the
> > > > > low-order 32 bits of DYNTICK_IRQ_NONIDLE being zero, correct?  If so,
> > > > > the "!rdp->dynticks_nmi_nesting" instead needs to be something like
> > > > > "rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE", which sounds like
> > > > > it is actually worse then the earlier comparison against the constant 2.
> > > > > 
> > > > > Sounds like I should revert the -rcu commit 805a16eaefc3 ("rcu: Force
> > > > > nohz_full tick on upon irq enter instead of exit").
> > > > 
> > > > I can't find that patch so all I can say so far is that its title doesn't
> > > > inspire me much. Do you still need that change for some reason?
> > > 
> > > No we don't need it. Paul's dev branch fixed it by checking DYNTICK_IRQ_NONIDLE:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?h=dev&id=227482fd4f3ede0502b586da28a59971dfbac0b0
> > 
> > Ah, so you have tested reverting this?  If so, thank you very much!
> 
> Just tried reverting, and found a bug if done in the reverted way. Sent you
> email with a proposed change which is essentially the top of tree:
> https://github.com/joelagnel/linux-kernel/commits/rcu/nohz-test-3
> 
> Also for Frederick, I wanted to mention why my pure hack above (dnn variable)
> seemed to work. The reason was because of long to int conversion of
> rdp->dynticks_nmi_nesting which I surprisingly did not get a compiler warning
> for. dynticks_nmi_nesting getting converted to int was truncating the
> DYNTICK_IRQ_NONIDLE bit (in fact I believe this was due to the cltq
> instruction in x86). This caused the "else if" condition to always evaluate
> to true and turn off the tick.
> 
> Paul, I wanted to see if I can create a repeatable test case for this issue.
> Not a full blown RCU torture test, but something that one could run and get a
> PASS or FAIL. Do you think this could be useful? And what is the best place
> for such a test?
> Essentially the test would be:
> 1. Run a test and dump some traces.
> 2. Parse the traces and see if things are sane (such as the tick not turning
>    off for this issue).
> 3. Report pass or fail.
> 
> The other way instead of parsing traces could be, a kernel module that does
> trace_probe_register on various tracepoints and tries to see if the tick
> indeed could stay turned on. Then report pass/fail at the end of the module's
> execution.

Or you could increment a per-CPU counter in rcu_sched_clock_irq() and use
that to verify the tick.  Maybe you could use the existing ->ticks_this_gp,
though that does get zeroed at the beginning of each grace period, which
would make sampling it a bit trickier.

							Thanx, Paul

