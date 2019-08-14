Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8E2C32753
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DE12063F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 16:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbfHNQ7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 12:59:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728253AbfHNQ7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 12:59:33 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EGsKgG095660
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 12:59:31 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ucn5ejv3w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 12:59:31 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 14 Aug 2019 17:59:30 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 14 Aug 2019 17:59:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7EGxPTa53084526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Aug 2019 16:59:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AE31B2064;
        Wed, 14 Aug 2019 16:59:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BD83B205F;
        Wed, 14 Aug 2019 16:59:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 14 Aug 2019 16:59:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1546416C0FD4; Wed, 14 Aug 2019 09:59:27 -0700 (PDT)
Date:   Wed, 14 Aug 2019 09:59:27 -0700
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
Reply-To: paulmck@linux.ibm.com
References: <20190811083626.GA9486@X58A-UD3R>
 <20190811084950.GB9486@X58A-UD3R>
 <20190811234939.GC28441@linux.ibm.com>
 <20190812101052.GA10478@X58A-UD3R>
 <20190812131234.GC27552@google.com>
 <20190813052954.GA18373@X58A-UD3R>
 <20190813154145.GE28441@linux.ibm.com>
 <20190814001103.GA31884@X58A-UD3R>
 <20190814025349.GM28441@linux.ibm.com>
 <20190814034310.GA31272@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814034310.GA31272@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081416-0052-0000-0000-000003EAD90F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011590; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01246775; UDB=6.00657962; IPR=6.01028282;
 MB=3.00028173; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-14 16:59:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081416-0053-0000-0000-00006217D9A1
Message-Id: <20190814165927.GT28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:43:10PM +0900, Byungchul Park wrote:
> On Tue, Aug 13, 2019 at 07:53:49PM -0700, Paul E. McKenney wrote:
> > On Wed, Aug 14, 2019 at 09:11:03AM +0900, Byungchul Park wrote:
> > > On Tue, Aug 13, 2019 at 08:41:45AM -0700, Paul E. McKenney wrote:
> > > > On Tue, Aug 13, 2019 at 02:29:54PM +0900, Byungchul Park wrote:
> > > > > On Mon, Aug 12, 2019 at 09:12:34AM -0400, Joel Fernandes wrote:
> > > > > > On Mon, Aug 12, 2019 at 07:10:52PM +0900, Byungchul Park wrote:
> > > > > > > On Sun, Aug 11, 2019 at 04:49:39PM -0700, Paul E. McKenney wrote:
> > > > > > > > Maybe.  Note well that I said "potential issue".  When I checked a few
> > > > > > > > years ago, none of the uses of rcu_barrier() cared about kfree_rcu().
> > > > > > > > They cared instead about call_rcu() callbacks that accessed code or data
> > > > > > > > that was going to disappear soon, for example, due to module unload or
> > > > > > > > filesystem unmount.
> > > > > > > > 
> > > > > > > > So it -might- be that rcu_barrier() can stay as it is, but with changes
> > > > > > > > as needed to documentation.
> > > > > > 
> > > > > > Right, we should update the docs. Byungchul, do you mind sending a patch that
> > > > > > documents the rcu_barrier() behavior?
> > > > > 
> > > > > Are you trying to give me the chance? I feel thankful. It doens't matter
> > > > > to try it at the moment though, I can't follow-up until September. I'd
> > > > > better do that in Septamber or give it up this time.
> > > > 
> > > > Which reminds me...  I recall your asking if the kfree_rcu() patch
> > > > might be sensitive to the exact hardware, but I cannot locate that
> > > > email right off-hand.  This is an excellent question!  When faced with
> > > > floods of kfree_rcu() calls, I would expect some hardware, compiler,
> > > > and kernel-configuration sensitivity.  Which is why it will likely be
> > > 
> > > Yes.
> > > 
> > > > necessary to do a few more improvements over time -- for but one example,
> > > > accumulating callbacks into vectors in order to reduce the number of
> > > > kfree()-time cache misses.
> > > 
> > > Yes. That would be a pretty good way to mitigate the problem. I hope
> > > the simple way we've done works well enough so it would never happen
> > > though.
> > > 
> > > Or I would check the condition of all system resourses e.g. CPU and
> > > memory and control the bandwith of them, of course only if that actually
> > > happens.
> > > 
> > > Thanks a lot for sharing your opinion on it!
> > 
> > Didn't you say earlier that you were getting OOM on your system even
> > with the patches?  Or did I miss the resolution of that issue?
> 
> I said I saw OOM with a *larger* value of KFREE_DRAIN_JIFFIES. It was
> fine with the patch itself.

Got it, thank you!

> Anyway I'm sorry I expressed it in a confusing way.

But what is life without a little confusion?  ;-)

							Thanx, Paul

