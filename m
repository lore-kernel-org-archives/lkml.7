Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AA6C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20FA2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbfHNSoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:44:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5878 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728265AbfHNSof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:44:35 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EIfajM098672
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:44:35 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ucp3vkuxn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:44:34 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 14 Aug 2019 19:44:33 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Aug 2019 19:44:28 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7EIiRlf49873240
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 18:44:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8864DB205F;
        Wed, 14 Aug 2019 18:44:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68424B2065;
        Wed, 14 Aug 2019 18:44:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Aug 2019 18:44:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 446FE16C1049; Wed, 14 Aug 2019 11:44:29 -0700 (PDT)
Date:   Wed, 14 Aug 2019 11:44:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Rao Shoaib <rao.shoaib@oracle.com>,
        max.byungchul.park@gmail.com, byungchul.park@lge.com,
        kernel-team@android.com, kernel-team@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3 1/2] rcu/tree: Add basic support for kfree_rcu batching
Reply-To: paulmck@linux.ibm.com
References: <20190813170046.81707-1-joel@joelfernandes.org>
 <20190813190738.GH28441@linux.ibm.com>
 <20190814143817.GA253999@google.com>
 <20190814172233.GA68498@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814172233.GA68498@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081418-0064-0000-0000-000004089D35
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011590; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01246810; UDB=6.00657983; IPR=6.01028317;
 MB=3.00028174; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-14 18:44:33
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081418-0065-0000-0000-00003EAB4496
Message-Id: <20190814184429.GV28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:22:33PM -0400, Joel Fernandes wrote:
> On Wed, Aug 14, 2019 at 10:38:17AM -0400, Joel Fernandes wrote:
> > On Tue, Aug 13, 2019 at 12:07:38PM -0700, Paul E. McKenney wrote:
>  [snip]
> > > > - * Queue an RCU callback for lazy invocation after a grace period.
> > > > - * This will likely be later named something like "call_rcu_lazy()",
> > > > - * but this change will require some way of tagging the lazy RCU
> > > > - * callbacks in the list of pending callbacks. Until then, this
> > > > - * function may only be called from __kfree_rcu().
> > > > + * Maximum number of kfree(s) to batch, if this limit is hit then the batch of
> > > > + * kfree(s) is queued for freeing after a grace period, right away.
> > > >   */
> > > > -void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > > +struct kfree_rcu_cpu {
> > > > +	/* The rcu_work node for queuing work with queue_rcu_work(). The work
> > > > +	 * is done after a grace period.
> > > > +	 */
> > > > +	struct rcu_work rcu_work;
> > > > +
> > > > +	/* The list of objects being queued in a batch but are not yet
> > > > +	 * scheduled to be freed.
> > > > +	 */
> > > > +	struct rcu_head *head;
> > > > +
> > > > +	/* The list of objects that have now left ->head and are queued for
> > > > +	 * freeing after a grace period.
> > > > +	 */
> > > > +	struct rcu_head *head_free;
> > > 
> > > So this is not yet the one that does multiple batches concurrently
> > > awaiting grace periods, correct?  Or am I missing something subtle?
> > 
> > Yes, it is not. I honestly, still did not understand that idea. Or how it
> > would improve things. May be we can discuss at LPC on pen and paper? But I
> > think that can also be a follow-up optimization.
> 
> I got it now. Basically we can benefit a bit more by having another list
> (that is have multiple kfree_rcu batches in flight). I will think more about
> it - but hopefully we don't need to gate this patch by that.

I am willing to take this as a later optimization.

> It'll be interesting to see what rcuperf says about such an improvement :)

Indeed, no guarantees either way.  The reason for hope assumes a busy
system where each grace period is immediately followed by another
grace period.  On such a system, the current setup allows each CPU to
make use only of every second grace period for its kfree_rcu() work.
The hope would therefore be that this would reduce the memory footprint
substantially with no increase in overhead.

But no way to know without trying it!  ;-)

							Thanx, Paul

