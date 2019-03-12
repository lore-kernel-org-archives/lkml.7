Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF3CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFF02087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 14:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfCLOJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 10:09:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726192AbfCLOJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 10:09:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CE9UcJ037546
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:09:32 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r6d2yn9wn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:09:31 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 12 Mar 2019 14:09:25 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 12 Mar 2019 14:09:21 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2CE9K8516842772
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 14:09:20 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85287B2065;
        Tue, 12 Mar 2019 14:09:20 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6768DB2064;
        Tue, 12 Mar 2019 14:09:20 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 12 Mar 2019 14:09:20 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3296B16C6A7D; Tue, 12 Mar 2019 07:09:23 -0700 (PDT)
Date:   Tue, 12 Mar 2019 07:09:23 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Neeraj Upadhyay <neeraju@codeaurora.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: Fix self wakeups for grace period kthread
Reply-To: paulmck@linux.ibm.com
References: <1552038378-11166-1-git-send-email-neeraju@codeaurora.org>
 <20190311215027.2f3458a1@oasis.local.home>
 <579cd03a-17a7-5729-46b3-ffcc4afee0e5@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <579cd03a-17a7-5729-46b3-ffcc4afee0e5@codeaurora.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19031214-0060-0000-0000-0000031AD6F7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010745; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000281; SDB=6.01173312; UDB=6.00613445; IPR=6.00953972;
 MB=3.00025946; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-12 14:09:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031214-0061-0000-0000-00004895912B
Message-Id: <20190312140923.GU13351@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903120100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 05:25:28PM +0530, Neeraj Upadhyay wrote:
> On 3/12/19 7:20 AM, Steven Rostedt wrote:
> >On Fri,  8 Mar 2019 15:16:18 +0530
> >Neeraj Upadhyay <neeraju@codeaurora.org> wrote:
> >
> >>Update the code to match the comment that self wakeup of
> >>grace period kthread is allowed from interrupt handler, and
> >>softirq handler, running in the grace period kthread's
> >>context. Present code allows self wakeups from all
> >>interrupt contexts - nmi, softirq and hardirq contexts.
> >
> >That's not actually the issue. But it appears that we return if we
> >simply have BH disabled, which I don't think we want, and we don't care
> >about NMI as NMI should never call this code.
> >
> >I think your patch is correct, but the change log is not.

How about this?

	The current rcu_gp_kthread_wake() function uses in_interrupt()
	and thus does a self-wakeup from all interrupt contexts,
	including the pointless case where the GP kthread happens to be
	running with bottom halves disabled, along with the impossible
	case where the GP kthread is running within an NMI handler (you
	are not supposed to invoke rcu_gp_kthread_wake() from within an
	NMI handler.  This commit therefore replaces the in_interrupt()
	with in_irq(), so that the self-wakeups happen only from handlers
	for hardware interrupts and softirqs.  This also makes the code
	match the comment.

							Thanx, Paul

> >-- Steve
> >
> 
> Hi Steve, sorry, I don't understand fully, why we want to not return
> in BH disabled case. From the commit logs and lkml discussion, there
> is a case where GP kthread is interrupted in the wait event path and
> rcu_gp_kthread_wake() is called in softirq handler (I am not sure
> about interrupt handler case; how rcu_gp_kthread_wake() is called
> from that path).
> 
> https://github.com/torvalds/linux/commit/1d1f898df6586c5ea9aeaf349f13089c6fa37903
> 
> Thanks
> Neeraj
> >
> >>
> >>Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
> >>---
> >>  kernel/rcu/tree.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >>index acd6ccf..57cac6d 100644
> >>--- a/kernel/rcu/tree.c
> >>+++ b/kernel/rcu/tree.c
> >>@@ -1585,7 +1585,7 @@ static bool rcu_future_gp_cleanup(struct rcu_node *rnp)
> >>  static void rcu_gp_kthread_wake(void)
> >>  {
> >>  	if ((current == rcu_state.gp_kthread &&
> >>-	     !in_interrupt() && !in_serving_softirq()) ||
> >>+	     !in_irq() && !in_serving_softirq()) ||
> >>  	    !READ_ONCE(rcu_state.gp_flags) ||
> >>  	    !rcu_state.gp_kthread)
> >>  		return;
> >
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
> 

