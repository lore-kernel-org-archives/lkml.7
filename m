Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81BEC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 05:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 992DF2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 05:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfHQFVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 01:21:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725562AbfHQFVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 01:21:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7H5GZnR060951;
        Sat, 17 Aug 2019 01:20:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ue66yyb57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Aug 2019 01:20:26 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7H5IEQV064707;
        Sat, 17 Aug 2019 01:20:26 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ue66yyb4u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Aug 2019 01:20:26 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7H5JorH025899;
        Sat, 17 Aug 2019 05:20:25 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma03dal.us.ibm.com with ESMTP id 2ue9760kgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Aug 2019 05:20:25 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7H5KO5Q49545482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 05:20:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C204B2066;
        Sat, 17 Aug 2019 05:20:24 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2769EB205F;
        Sat, 17 Aug 2019 05:20:24 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 17 Aug 2019 05:20:24 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0561D16C1EB3; Fri, 16 Aug 2019 22:20:24 -0700 (PDT)
Date:   Fri, 16 Aug 2019 22:20:23 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        kernel-team <kernel-team@lge.com>,
        Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <max.byungchul.park@gmail.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20190817052023.GA28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190816164330.GA8320@linux.ibm.com>
 <20190816174429.GE10481@google.com>
 <20190816191629.GW28441@linux.ibm.com>
 <CAEXW_YTSJaKzWGC5nTbOuoQ6dxO4_uYW6=ttTJY6FWGb5rcB6Q@mail.gmail.com>
 <20190817035637.GY28441@linux.ibm.com>
 <20190817043024.GA137383@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817043024.GA137383@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-17_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908170057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 12:30:24AM -0400, Joel Fernandes wrote:
> On Fri, Aug 16, 2019 at 08:56:37PM -0700, Paul E. McKenney wrote:
> > On Fri, Aug 16, 2019 at 09:32:23PM -0400, Joel Fernandes wrote:
> > > Hi Paul,
> > > 
> > > On Fri, Aug 16, 2019 at 3:16 PM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
> > > > > > Hello, Joel,
> > > > > >
> > > > > > I reworked the commit log as follows, but was then unsuccessful in
> > > > > > working out which -rcu commit to apply it to.  Could you please
> > > > > > tell me what commit to apply this to?  (Once applied, git cherry-pick
> > > > > > is usually pretty good about handling minor conflicts.)
> > > > >
> > > > > It was originally based on v5.3-rc2
> > > > >
> > > > > I was able to apply it just now to the rcu -dev branch and I pushed it here:
> > > > > https://github.com/joelagnel/linux-kernel.git (branch paul-dev)
> > > > >
> > > > > Let me know if any other issues, thanks for the change log rework!
> > > >
> > > > Pulled and cherry-picked, thank you!
> > > >
> > > > Just for grins, I also  pushed out a from-joel.2019.08.16a showing the
> > > > results of the pull.  If you pull that branch, then run something like
> > > > "gitk v5.3-rc2..", and then do the same with branch "dev", comparing the
> > > > two might illustrate some of the reasons for the current restrictions
> > > > on pull requests and trees subject to rebase.
> > > 
> > > Right, I did the compare and see what you mean. I guess sending any
> > > future pull requests against Linux -next would be the best option?
> > 
> > Hmmm...  You really want to send some pull requests, don't you?  ;-)
> 
> I would be lying if I said I don't have the itch to ;-)
> 
> > Suppose you had sent that pull request against Linux -next or v5.2
> > or wherever.  What would happen next, given the high probability of a
> > conflict with someone else's patch?  What would the result look like?
> 
> One hopes that the tools are able to automatically resolve the resolution,
> however adequate re-inspection of the resulting code and testing it would be
> needed in either case, to ensure the conflict resolution (whether manual or
> automatic) happened correctly.

I didn't ask you to hope.  I instead asked you what tell me what would
actually happen.  ;-)

You could actually try this by randomly grouping the patches in -rcu
(say, placing every third patch into one of three groups), generating
separate pull requests, and then merging the pull requests together.
Then you wouldn't have to hope.  You could instead look at it in (say)
gitk after the pieces were put together.

And there are more questions.  For example, how would this affect testing
given issues involving both RCU and other pieces of the kernel?

> IIUC, this usually depends on the maintainer's preference on which branch to
> send patches against.
> 
> Are you saying -rcu's dev branch is still the best option to send patches
> against, even though it is rebased often?

Sounds like we might need to discuss this face to face.

							Thanx, Paul
