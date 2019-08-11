Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F8EC0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 142CD2084D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 23:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHKXmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 19:42:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:19432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726055AbfHKXmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 19:42:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7BNfPGC112113
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 19:42:10 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uaqy2f4jp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 19:42:10 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 12 Aug 2019 00:42:09 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 12 Aug 2019 00:42:04 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7BNg3LT34603330
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 11 Aug 2019 23:42:03 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BBD3B2064;
        Sun, 11 Aug 2019 23:42:03 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDA91B205F;
        Sun, 11 Aug 2019 23:42:02 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.138.198])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 11 Aug 2019 23:42:02 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C0E5A16C9A70; Sun, 11 Aug 2019 16:42:05 -0700 (PDT)
Date:   Sun, 11 Aug 2019 16:42:05 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, max.byungchul.park@gmail.com,
        byungchul.park@lge.com, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        kernel-team@lge.com, Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC v1 2/2] rcuperf: Add kfree_rcu performance Tests
Reply-To: paulmck@linux.ibm.com
References: <20190806212041.118146-1-joel@joelfernandes.org>
 <20190806212041.118146-2-joel@joelfernandes.org>
 <20190807002915.GV28441@linux.ibm.com>
 <20190811020154.GA74292@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811020154.GA74292@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081123-0064-0000-0000-000004078049
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011583; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01245479; UDB=6.00657181; IPR=6.01026976;
 MB=3.00028138; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-11 23:42:07
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081123-0065-0000-0000-00003EA20A5A
Message-Id: <20190811234205.GB28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=906 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908110265
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 10:01:54PM -0400, Joel Fernandes wrote:
> On Tue, Aug 06, 2019 at 05:29:15PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 06, 2019 at 05:20:41PM -0400, Joel Fernandes (Google) wrote:

[ . . . ]

> > It is really easy to confuse "l" and "1" in some fonts, so please use
> > a different name.  (From the "showing my age" department:  On typical
> > 1970s typewriters, there was no numeral "1" -- you typed the letter
> > "l" instead, thus anticipating at least the first digit of "1337".)
> 
> Change l to loops ;). I did see typewriters around in my childhood, I thought
> they were pretty odd machines :-D. I am sure my daughter will think the same
> about land-line phones :-D

Given your daughter's life expectancy, there will likely be a great many
ca-2019 artifacts that will eventually seem quite odd to her.  ;-)

[ . . . ]

> > > +/*
> > > + * shutdown kthread.  Just waits to be awakened, then shuts down system.
> > > + */
> > > +static int
> > > +kfree_perf_shutdown(void *arg)
> > > +{
> > > +	do {
> > > +		wait_event(shutdown_wq,
> > > +			   atomic_read(&n_kfree_perf_thread_ended) >=
> > > +			   kfree_nrealthreads);
> > > +	} while (atomic_read(&n_kfree_perf_thread_ended) < kfree_nrealthreads);
> > > +
> > > +	smp_mb(); /* Wake before output. */
> > > +
> > > +	kfree_perf_cleanup();
> > > +	kernel_power_off();
> > > +	return -EINVAL;
> > > +}
> > 
> > Is there some way to avoid (almost) duplicating rcu_perf_shutdown()?
> 
> At the moment, I don't see a good way to do this without passing in function
> pointers or using macros which I think would look uglier than the above
> addition. Sorry.

No problem, just something to keep in mind.

							Thanx, Paul

