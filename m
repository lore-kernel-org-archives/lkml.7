Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2F1C5B576
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 19:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB7920881
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 19:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbfF3TjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 15:39:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14792 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726674AbfF3TjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 15:39:15 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5UJacsk133648;
        Sun, 30 Jun 2019 15:38:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tenkn31ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Jun 2019 15:38:34 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5UJcX7P137109;
        Sun, 30 Jun 2019 15:38:33 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tenkn31y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Jun 2019 15:38:33 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5UJYSZ6014453;
        Sun, 30 Jun 2019 19:38:33 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01wdc.us.ibm.com with ESMTP id 2tdym6a59s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Jun 2019 19:38:33 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5UJcWU554133076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 30 Jun 2019 19:38:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E435B2064;
        Sun, 30 Jun 2019 19:38:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB83B205F;
        Sun, 30 Jun 2019 19:38:32 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.128.230])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 30 Jun 2019 19:38:32 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CEDF416C1F1D; Sun, 30 Jun 2019 12:38:34 -0700 (PDT)
Date:   Sun, 30 Jun 2019 12:38:34 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Byungchul Park <byungchul.park@lge.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: Re: [PATCH v2] rcu: Change return type of
 rcu_spawn_one_boost_kthread()
Message-ID: <20190630193834.GU26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <1561619266-8850-1-git-send-email-byungchul.park@lge.com>
 <20190627134240.GB215968@google.com>
 <20190627205703.GF26519@linux.ibm.com>
 <20190628024339.GA13650@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628024339.GA13650@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-30_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906300252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 11:43:39AM +0900, Byungchul Park wrote:
> On Thu, Jun 27, 2019 at 01:57:03PM -0700, Paul E. McKenney wrote:
> > On Thu, Jun 27, 2019 at 09:42:40AM -0400, Joel Fernandes wrote:
> > > On Thu, Jun 27, 2019 at 04:07:46PM +0900, Byungchul Park wrote:
> > > > Hello,
> > > > 
> > > > I tested if the WARN_ON_ONCE() is fired with my box and it was ok.
> > > 
> > > Looks pretty safe to me and nice clean up!
> > > 
> > > Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > Agreed, but I still cannot find where this applies.  I did try rcu/next,
> > which is currently here:
> > 
> > commit b989ff070574ad8b8621d866de0a8e9a65d42c80 (rcu/rcu/next, rcu/next)
> > Merge: 4289ee7d5a83 11ca7a9d541d
> > Author: Paul E. McKenney <paulmck@linux.ibm.com>
> > Date:   Mon Jun 24 09:12:39 2019 -0700
> > 
> >     Merge LKMM and RCU commits
> > 
> > Help?
> 
> commit 204d7a60670f3f6399a4d0826667ab7863b3e429
> 
>      Merge LKMM and RCU commits
> 
> I made it on top of the above. And could you tell me which branch I'd
> better use when developing. I think it's been changing sometimes.

That would be because idiot here took so much care to avoid risking
pushing some early development commits into the upcoming merge window
that he managed to misplace them entirely.  The -rcu tree's "dev" branch
now includes them.  Could you please port to it?

a1af11a24cb0 ("rcu/nocb: Make __call_rcu_nocb_wake() safe for many callbacks")

> Thank you for the answer in advance!

And please accept my apologies for the very confusing tree layout this
time around!

							Thanx, Paul
