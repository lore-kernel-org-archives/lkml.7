Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63122C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A73D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 15:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfC0PDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 11:03:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbfC0PDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 11:03:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2RF3TiS077797
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:03:39 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rg9yjcw6b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:03:35 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Mar 2019 14:55:44 -0000
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Mar 2019 14:55:40 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2REtdFG22347824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Mar 2019 14:55:39 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45A50B2065;
        Wed, 27 Mar 2019 14:55:39 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1722DB205F;
        Wed, 27 Mar 2019 14:55:39 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Mar 2019 14:55:39 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id D7E5216C6125; Tue, 26 Mar 2019 20:33:44 -0700 (PDT)
Date:   Tue, 26 Mar 2019 20:33:44 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@gmail.com>, linux-kernel@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org
Subject: Re: [RFC 4/4] net/ipv4/fib: Don't synchronise_rcu() every 512Kb
Reply-To: paulmck@linux.ibm.com
References: <20190326153026.24493-1-dima@arista.com>
 <20190326153026.24493-5-dima@arista.com>
 <2f911647-f35f-13c2-8177-2fb93147b0fa@gmail.com>
 <d77c86d7-23da-c301-4443-08e9988ac801@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d77c86d7-23da-c301-4443-08e9988ac801@arista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032714-0068-0000-0000-000003ABD225
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010823; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000282; SDB=6.01180445; UDB=6.00617761; IPR=6.00961162;
 MB=3.00026180; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-27 14:55:43
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032714-0069-0000-0000-000047F3F38B
Message-Id: <20190327033344.GW4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-27_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903270106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:14:43PM +0000, Dmitry Safonov wrote:
> On 3/26/19 3:39 PM, David Ahern wrote:
> > On 3/26/19 9:30 AM, Dmitry Safonov wrote:
> >> Fib trie has a hard-coded sync_pages limit to call synchronise_rcu().
> >> The limit is 128 pages or 512Kb (considering common case with 4Kb
> >> pages).
> >>
> >> Unfortunately, at Arista we have use-scenarios with full view software
> >> forwarding. At the scale of 100K and more routes even on 2 core boxes
> >> the hard-coded limit starts actively shooting in the leg: lockup
> >> detector notices that rtnl_lock is held for seconds.
> >> First reason is previously broken MAX_WORK, that didn't limit pending
> >> balancing work. While fixing it, I've noticed that the bottle-neck is
> >> actually in the number of synchronise_rcu() calls.
> >>
> >> I've tried to fix it with a patch to decrement number of tnodes in rcu
> >> callback, but it hasn't much affected performance.
> >>
> >> One possible way to "fix" it - provide another sysctl to control
> >> sync_pages, but in my POV it's nasty - exposing another realisation
> >> detail into user-space.
> > 
> > well, that was accepted last week. ;-)
> > 
> > commit 9ab948a91b2c2abc8e82845c0e61f4b1683e3a4f
> > Author: David Ahern <dsahern@gmail.com>
> > Date:   Wed Mar 20 09:18:59 2019 -0700
> > 
> >     ipv4: Allow amount of dirty memory from fib resizing to be controllable
> > 
> > 
> > Can you see how that change (should backport easily) affects your test
> > case? From my perspective 16MB was the sweet spot.
> 
> FWIW, I would like to +Cc Paul here.
> 
> TLDR; we're looking with David into ways to improve a hardcoded limit
> tnode_free_size at net/ipv4/fib_trie.c: currently it's way too low
> (512Kb). David created a patch to provide sysctl that controls the limit
> and it would solve a problem for both of us. In parallel, I thought that
> exposing this to userspace is not much fun and added a shrinker with
> synchronize_rcu(). I'm not any sure that the latter is actually a sane
> solution..
> Is there any guarantee that memory to-be freed by call_rcu() will get
> freed in OOM conditions? Might there be a chance that we don't need any
> limit here at all?

Yes, unless whatever is causing the OOM is also stalling a CPU or task
that RCU is waiting on.  The extreme case is of course when the OOM is
in fact being caused by the fact that RCU is waiting on a stalled CPU
or task.  Of course, the fact that the CPU or task is being stalled is
a bug in its own right.

So, in the absence of bugs, yes, the memory that was passed to call_rcu()
should be freed within a reasonable length of time, even under OOM
conditions.

> Worth to mention that I don't argue David's patch as I pointed that it
> would (will) solve the problem for us both, but with good intentions
> wondering if we can do something here rather a new sysctl knob.

An intermediate position would be to have a reasonably high setting so
that the sysctl knob almost never needed to be adjusted.

RCU used to detect OOM conditions and work harder to finish the grace
period in those cases, but this was abandoned because it was found not
to make a significant difference in production.  Which might support
the position of assuming that memory passed to call_rcu() gets freed
reasonably quickly even under OOM conditions.

							Thanx, Paul

