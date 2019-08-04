Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49346C32750
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 18:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2724720844
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 18:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfHDSnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 14:43:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbfHDSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 14:43:31 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x74IfhHa039061;
        Sun, 4 Aug 2019 14:42:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u5qkywc2j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Aug 2019 14:42:47 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x74Igijb046865;
        Sun, 4 Aug 2019 14:42:46 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u5qkywc24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Aug 2019 14:42:46 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x74IeUet002393;
        Sun, 4 Aug 2019 18:42:45 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04wdc.us.ibm.com with ESMTP id 2u51w6914s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Aug 2019 18:42:45 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x74Igi9752953506
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Aug 2019 18:42:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8D3AEB2064;
        Sun,  4 Aug 2019 18:42:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B053B205F;
        Sun,  4 Aug 2019 18:42:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.150.228])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun,  4 Aug 2019 18:42:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BADC116C9A4A; Sun,  4 Aug 2019 11:42:46 -0700 (PDT)
Date:   Sun, 4 Aug 2019 11:42:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH RFC tip/core/rcu 01/14] rcu/nocb: Atomic ->len field in
 rcu_segcblist structure
Message-ID: <20190804184246.GD28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190802151435.GA1081@linux.ibm.com>
 <20190802151501.13069-1-paulmck@linux.ibm.com>
 <20190804145051.GG2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190804145051.GG2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908040217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 04, 2019 at 04:50:51PM +0200, Peter Zijlstra wrote:
> On Fri, Aug 02, 2019 at 08:14:48AM -0700, Paul E. McKenney wrote:
> > +/*
> > + * Exchange the numeric length of the specified rcu_segcblist structure
> > + * with the specified value.  This can cause the ->len field to disagree
> > + * with the actual number of callbacks on the structure.  This exchange is
> > + * fully ordered with respect to the callers accesses both before and after.
> > + */
> > +long rcu_segcblist_xchg_len(struct rcu_segcblist *rsclp, long v)
> > +{
> > +#ifdef CONFIG_RCU_NOCB_CPU
> > +	return atomic_long_xchg(&rsclp->len, v);
> > +#else
> > +	long ret = rsclp->len;
> > +
> > +	smp_mb(); /* Up to the caller! */
> > +	WRITE_ONCE(rsclp->len, v);
> > +	smp_mb(); /* Up to the caller! */
> > +	return ret;
> > +#endif
> > +}
> 
> That one's weird; for matching semantics the load needs to be between
> the memory barriers.

This is to match the concurrent version, which uses atomic_xchg().

							Thanx, Paul
