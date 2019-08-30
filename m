Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC180C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50A92189D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567127393;
	bh=oWlAAeXGfXGwCw0QfcNYJJRiM5WqZQi0J2j06byTLd0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZXQDw2rTIOWTCYteTHqWTiwvDfyCIeMRFlF7bCwiqnJCzIavk5CrOpqa/vKs9MxYX
	 m/UdcK/jc/8VcBO8IXV+fJYYUs6QWba4ow1ek8gMDxV77MPceEWC2rewz6awHA/YN0
	 wi3064KCPr9Yc1rLqeJ9ThIJAIdu67264OFp1en8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfH3BJw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:09:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbfH3BJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:09:49 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7U184vH045570;
        Thu, 29 Aug 2019 21:09:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upp2demqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 21:09:09 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7U1970K048213;
        Thu, 29 Aug 2019 21:09:08 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2upp2demqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Aug 2019 21:09:08 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7U17NHZ005547;
        Fri, 30 Aug 2019 01:09:07 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 2ujvv7fu61-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 01:09:06 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7U195ZN36438402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 01:09:05 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DEA6B2065;
        Fri, 30 Aug 2019 01:09:05 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 579D3B206E;
        Fri, 30 Aug 2019 01:09:05 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.80.201.94])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 30 Aug 2019 01:09:05 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6530216C1310; Thu, 29 Aug 2019 17:48:18 -0700 (PDT)
Date:   Thu, 29 Aug 2019 17:48:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Android Kernel Team <kernel-team@android.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC v1 2/2] rcu/tree: Remove dynticks_nmi_nesting counter
Message-ID: <20190830004818.GX4125@linux.ibm.com>
Reply-To: paulmck@kernel.org
References: <20190828220108.GC26530@linux.ibm.com>
 <20190828221444.GA100789@google.com>
 <20190828231247.GE26530@linux.ibm.com>
 <20190829015155.GB100789@google.com>
 <20190829034336.GD4125@linux.ibm.com>
 <20190829144355.GE63638@google.com>
 <20190829160946.GP4125@linux.ibm.com>
 <CALCETrWNPOOdTrFabTDd=H7+wc6xJ9rJceg6OL1S0rTV5pfSsA@mail.gmail.com>
 <20190829165407.GT4125@linux.ibm.com>
 <20190829190046.GB115245@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829190046.GB115245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=965 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908300009
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 03:00:46PM -0400, Joel Fernandes wrote:
> Hi Paul,
> 
> On Thu, Aug 29, 2019 at 09:54:07AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 29, 2019 at 09:21:46AM -0700, Andy Lutomirski wrote:
> > > On Thu, Aug 29, 2019 at 9:10 AM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Thu, Aug 29, 2019 at 10:43:55AM -0400, Joel Fernandes wrote:
> > > >
> > > > [ . . . ]
> > > >
> > > > > Paul, do we also nuke rcu_eqs_special_set()?  Currently I don't see anyone
> > > > > using it. And also remove the bottom most bit of dynticks?
> > > > >
> > > > > Also what happens if a TLB flush broadcast is needed? Do we IPI nohz or idle
> > > > > CPUs are the moment?
> > > > >
> > > > > All of this was introduced in:
> > > > > b8c17e6664c4 ("rcu: Maintain special bits at bottom of ->dynticks counter")
> > > >
> > > > Adding Andy Lutomirski on CC.
> > > >
> > > > Andy, is this going to be used in the near term, or should we just get
> > > > rid of it?
> > > 
> > > Let's get rid of it.  I'm not actually convinced it *can* be used as designed.
> > > 
> > > For those who forgot the history or weren't cc'd on all of it: I had
> > > this clever idea about how we could reduce TLB flushes.  I implemented
> > > some of it (but not the part that would have used this RCU feature),
> > > and it exploded in nasty and subtle ways.  This caused me to learn
> > > that speculative TLB fills were a problem that I had entirely failed
> > > to account for.  Then PTI happened and thoroughly muddied the water.
> > 
> > Yeah, PTI was quite annoying.  Still is, from what I can see.  :-/
> > 
> > > So I think we should just drop this :(
> > 
> > OK, thank you!  I will put a tag into -rcu marking its removal in case
> > it should prove useful whenever for whatever.
> > 
> > Joel, would you like to remove this, or would you rather that I did?
> > It is in code you are working with right now, so if I do it, I need to
> > wait until yours is finalized.  Which wouldn't be a problem.
> 
> I can remove it in my series, made a note to do so.

Sounds good!

							Thanx, Paul
