Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E6CC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8705D208E4
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 12:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbfFIMW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 08:22:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53914 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbfFIMW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 08:22:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x59CHLPA026875
        for <linux-kernel@vger.kernel.org>; Sun, 9 Jun 2019 08:22:27 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t0t06kd2u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2019 08:22:27 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 9 Jun 2019 13:22:26 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 9 Jun 2019 13:22:24 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x59CMNwY33489366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jun 2019 12:22:23 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 344B1B2067;
        Sun,  9 Jun 2019 12:22:23 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25F7CB2066;
        Sun,  9 Jun 2019 12:22:23 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.156.65])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jun 2019 12:22:23 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9402D16C5D98; Sun,  9 Jun 2019 05:22:26 -0700 (PDT)
Date:   Sun, 9 Jun 2019 05:22:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Eric Dumazet <edumazet@google.com>, rcu <rcu@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Question about cacheline bounching with percpu-rwsem and rcu-sync
Reply-To: paulmck@linux.ibm.com
References: <CAEXW_YTzUsT8xCD=vkSR=mT+L7ot7tCESTWYVqNt_3SQeVDUEA@mail.gmail.com>
 <20190531135051.GL28207@linux.ibm.com>
 <CAEXW_YReo2juN8A3CF+CKv8PcN_cH23gYWkLfkOJQqignyx85g@mail.gmail.com>
 <CAEXW_YT93U4OAVUggkR7E3KV2m7pdVwG-r+x6zjtrGzortvc4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEXW_YT93U4OAVUggkR7E3KV2m7pdVwG-r+x6zjtrGzortvc4w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060912-0064-0000-0000-000003EBC724
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011238; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01215471; UDB=6.00639004; IPR=6.00996561;
 MB=3.00027243; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-09 12:22:25
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060912-0065-0000-0000-00003DD1BA62
Message-Id: <20190609122226.GU28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-09_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906090092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 08, 2019 at 08:24:36PM -0400, Joel Fernandes wrote:
> On Fri, May 31, 2019 at 10:43 AM Joel Fernandes <joel@joelfernandes.org> wrote:
> [snip]
> > >
> > > Either way, it would be good for you to just try it.  Create a kernel
> > > module or similar than hammers on percpu_down_read() and percpu_up_read(),
> > > and empirically check the scalability on a largish system.  Then compare
> > > this to down_read() and up_read()
> >
> > Will do! thanks.
> 
> I created a test for this and the results are quite amazing just
> stressed read lock/unlock for rwsem vs percpu-rwsem.
> The test is conducted on a dual socket Intel x86_64 machine with 14
> cores each socket.
> 
> Test runs 10,000,000 loops of rwsem vs percpu-rwsem:
> https://github.com/joelagnel/linux-kernel/commit/8fe968116bd887592301179a53b7b3200db84424

Interesting location, but looks functional.  ;-)

> Graphs/Results here:
> https://docs.google.com/spreadsheets/d/1cbVLNK8tzTZNTr-EDGDC0T0cnFCdFK3wg2Foj5-Ll9s/edit?usp=sharing
> 
> The completion time of the test goes up somewhat exponentially with
> the number of threads, for the rwsem case, where as for percpu-rwsem
> it is the same. I could add this data to some of the documentation as
> well.

Actually, the completion time looks to be pretty close to linear in the
number of CPUs.  Which is still really bad, don't get me wrong.

Thank you for doing this, and it might be good to have some documentation
on this.  In perfbook, I use counters to make this point, and perhaps
I need to emphasize more that it also applies to other algorithms,
including locking.  Me, I learned this lesson from a logic analyzer
back in the very early 1990s.  This was back in the days before on-CPU
caches when a logic analyzer could actually tell you something about
the detailed execution.  ;-)

The key point is that you can often closely approximate the performance
of synchronization algorithms by counting the number of cache misses and
the number of CPUs competing for each cache line.

If you want to get the microbenchmark test code itself upstream,
one approach might be to have a kernel/locking/lockperf.c similar to
kernel/rcu/rcuperf.c.

Thoughts?

							Thanx, Paul

