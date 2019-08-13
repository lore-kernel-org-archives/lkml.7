Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8801AC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C851205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 15:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730101AbfHMPmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 11:42:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727697AbfHMPmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 11:42:31 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7DFYBgX035146;
        Tue, 13 Aug 2019 11:41:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubwnsyfk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 11:41:53 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7DFYcga036076;
        Tue, 13 Aug 2019 11:41:52 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ubwnsyfgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 11:41:51 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7DFUFVk023546;
        Tue, 13 Aug 2019 15:41:46 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02dal.us.ibm.com with ESMTP id 2u9nj63gvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Aug 2019 15:41:46 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7DFfjEA51577192
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Aug 2019 15:41:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4CE0CB2064;
        Tue, 13 Aug 2019 15:41:45 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D07CEB205F;
        Tue, 13 Aug 2019 15:41:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 13 Aug 2019 15:41:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B618D16C12A4; Tue, 13 Aug 2019 08:41:45 -0700 (PDT)
Date:   Tue, 13 Aug 2019 08:41:45 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Rao Shoaib <rao.shoaib@oracle.com>, kernel-team@android.com,
        kernel-team <kernel-team@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 1/2] rcu/tree: Add basic support for kfree_rcu
 batching
Message-ID: <20190813154145.GE28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190808095232.GA30401@X58A-UD3R>
 <20190808125607.GB261256@google.com>
 <CANrsvRPU_u6oKpjZ1368Evto+1hGboNYeOuMdbdzaOfXhSO=5g@mail.gmail.com>
 <20190808180916.GP28441@linux.ibm.com>
 <20190811083626.GA9486@X58A-UD3R>
 <20190811084950.GB9486@X58A-UD3R>
 <20190811234939.GC28441@linux.ibm.com>
 <20190812101052.GA10478@X58A-UD3R>
 <20190812131234.GC27552@google.com>
 <20190813052954.GA18373@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190813052954.GA18373@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-13_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908130159
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 02:29:54PM +0900, Byungchul Park wrote:
> On Mon, Aug 12, 2019 at 09:12:34AM -0400, Joel Fernandes wrote:
> > On Mon, Aug 12, 2019 at 07:10:52PM +0900, Byungchul Park wrote:
> > > On Sun, Aug 11, 2019 at 04:49:39PM -0700, Paul E. McKenney wrote:
> > > > Maybe.  Note well that I said "potential issue".  When I checked a few
> > > > years ago, none of the uses of rcu_barrier() cared about kfree_rcu().
> > > > They cared instead about call_rcu() callbacks that accessed code or data
> > > > that was going to disappear soon, for example, due to module unload or
> > > > filesystem unmount.
> > > > 
> > > > So it -might- be that rcu_barrier() can stay as it is, but with changes
> > > > as needed to documentation.
> > 
> > Right, we should update the docs. Byungchul, do you mind sending a patch that
> > documents the rcu_barrier() behavior?
> 
> Are you trying to give me the chance? I feel thankful. It doens't matter
> to try it at the moment though, I can't follow-up until September. I'd
> better do that in Septamber or give it up this time.

Which reminds me...  I recall your asking if the kfree_rcu() patch
might be sensitive to the exact hardware, but I cannot locate that
email right off-hand.  This is an excellent question!  When faced with
floods of kfree_rcu() calls, I would expect some hardware, compiler,
and kernel-configuration sensitivity.  Which is why it will likely be
necessary to do a few more improvements over time -- for but one example,
accumulating callbacks into vectors in order to reduce the number of
kfree()-time cache misses.

							Thanx, Paul

> Thanks,
> Byungchul
> 
> > > > It also -might- be, maybe now or maybe some time in the future, that
> > > > there will need to be a kfree_rcu_barrier() or some such.  But if so,
> > > > let's not create it until it is needed.  For one thing, it is reasonably
> > > > likely that something other than a kfree_rcu_barrier() would really
> > > > be what was needed.  After all, the main point would be to make sure
> > > > that the old memory really was freed before allocating new memory.
> > > 
> > > Now I fully understand what you meant thanks to you. Thank you for
> > > explaining it in detail.
> > > 
> > > > But if the system had ample memory, why wait?  In that case you don't
> > > > really need to wait for all the old memory to be freed, but rather for
> > > > sufficient memory to be available for allocation.
> > > 
> > > Agree. Totally make sense.
> > 
> > Agreed, all makes sense.
> > 
> > thanks,
> > 
> >  - Joel
> > 
> > [snip]
> 
