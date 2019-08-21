Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B316AC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8386A2089E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 13:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfHUNXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 09:23:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30652 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728222AbfHUNXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 09:23:18 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LDMNod064590
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:23:16 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh6hx0nrk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 09:23:16 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Aug 2019 14:23:15 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Aug 2019 14:23:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LDNAG2852548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 13:23:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6031EB2064;
        Wed, 21 Aug 2019 13:23:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3213BB2066;
        Wed, 21 Aug 2019 13:23:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 13:23:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B47F316C1AFD; Wed, 21 Aug 2019 06:23:10 -0700 (PDT)
Date:   Wed, 21 Aug 2019 06:23:10 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Reply-To: paulmck@linux.ibm.com
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
 <20190820135612.GS2332@hirez.programming.kicks-ass.net>
 <20190820202932.GW28441@linux.ibm.com>
 <20190821103200.kpufwtviqhpbuv2n@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821103200.kpufwtviqhpbuv2n@willie-the-truck>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19082113-2213-0000-0000-000003BE73B6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011628; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250002; UDB=6.00659921; IPR=6.01031556;
 MB=3.00028260; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-21 13:23:15
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082113-2214-0000-0000-00005FB80F73
Message-Id: <20190821132310.GC28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:32:01AM +0100, Will Deacon wrote:
> On Tue, Aug 20, 2019 at 01:29:32PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 20, 2019 at 03:56:12PM +0200, Peter Zijlstra wrote:
> > > On Sat, Aug 17, 2019 at 01:08:02AM -0700, Linus Torvalds wrote:
> > > 
> > > > The data tearing issue is almost a non-issue. We're not going to add
> > > > WRITE_ONCE() to these kinds of places for no good reason.
> > > 
> > > Paulmck actually has an example of that somewhere; ISTR that particular
> > > case actually got fixed by GCC, but I'd really _love_ for some compiler
> > > people (both GCC and LLVM) to state that their respective compilers will
> > > not do load/store tearing for machine word sized load/stores.
> > 
> > I do very much recall such an example, but I am now unable to either
> > find it or reproduce it.  :-/
> > 
> > If I cannot turn it up in a few days, I will ask the LWN editors to
> > make appropriate changes to the "Who is afraid" article.
> > 
> > > Without this written guarantee (which supposedly was in older GCC
> > > manuals but has since gone missing), I'm loathe to rely on it.
> > > 
> > > Yes, it is very rare, but it is a massive royal pain to debug if/when it
> > > does do happen.
> > 
> > But from what I can see, Linus is OK with use of WRITE_ONCE() for data
> > races on any variable for which there is at least one READ_ONCE().
> > So we can still use WRITE_ONCE() as we would like in our own code.
> > Yes, you or I might be hit by someone else's omission of WRITE_ONCE(),
> > it is better than the proverbial kick in the teeth.
> > 
> > Of course, if anyone knows of a compiler/architecture combination that
> > really does tear stores of 32-bit constants, please do not keep it
> > a secret!  After all, it would be good to get that addressed easily
> > starting now rather than after a difficult and painful series of
> > debugging sessions.
> 
> It's not quite what you asked for, but if you look at the following
> silly code:
> 
> typedef unsigned long long u64;
> 
> struct data {
> 	u64 arr[1023];
> 	u64 flag;
> };
> 
> void foo(struct data *x)
> {
> 	int i;
> 
> 	for (i = 0; i < 1023; ++i)
> 		x->arr[i] = 0;
> 
> 	x->flag = 0;
> }
> 
> void bar(u64 *x)
> {
> 	*x = 0xabcdef10abcdef10;
> }
> 
> Then arm64 clang (-O2) generates the following for foo:
> 
> foo:                                    // @foo
> 	stp	x29, x30, [sp, #-16]!   // 16-byte Folded Spill
> 	orr	w2, wzr, #0x2000
> 	mov	w1, wzr
> 	mov	x29, sp
> 	bl	memset
> 	ldp	x29, x30, [sp], #16     // 16-byte Folded Reload
> 	ret
> 
> and so the store to 'flag' has become part of the memset, which could
> easily be bytewise in terms of atomicity (and this isn't unlikely given
> we have a DC ZVA instruction which only guaratees bytewise atomicity).
> 
> GCC (also -O2) generates the following for bar:
> 
> bar:
> 	mov	w1, 61200
> 	movk	w1, 0xabcd, lsl 16
> 	stp	w1, w1, [x0]
> 	ret
> 
> and so it is using a store-pair instruction to reduce the complexity in
> the immediate generation. Thus, the 64-bit store will only have 32-bit
> atomicity. In fact, this is scary because if I change bar to:
> 
> void bar(u64 *x)
> {
> 	*(volatile u64 *)x = 0xabcdef10abcdef10;
> }
> 
> then I get:
> 
> bar:
> 	mov	w1, 61200
> 	movk	w1, 0xabcd, lsl 16
> 	str	w1, [x0]
> 	str	w1, [x0, 4]
> 	ret
> 
> so I'm not sure that WRITE_ONCE would even help :/

Well, I can have the LWN article cite your email, then.  So thank you
very much!

Is generation of this code for a 64-bit volatile store considered a bug?
Or does ARMv8 exclude the possibility of 64-bit MMIO registers?  And I
would guess that Thomas and Linus would ask a similar bugginess question
for normal stores.  ;-)

> It's worth noting that:
> 
> void baz(atomic_long *x)
> {
> 	atomic_store_explicit(x, 0xabcdef10abcdef10, memory_order_relaxed)
> }
> 
> does the right thing:
> 
> baz:
> 	mov	x1, 61200
> 	movk	x1, 0xabcd, lsl 16
> 	movk	x1, 0xef10, lsl 32
> 	movk	x1, 0xabcd, lsl 48
> 	str	x1, [x0]
> 	ret

OK, the C11 and C++11 guys should be happy with this.

> Whilst these examples may be contrived, I do thing they illustrate that
> we can't simply say "stores to aligned, word-sized pointers are atomic".

And thank you again!

							Thanx, Paul

