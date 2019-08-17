Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344F1C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 064F921019
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 04:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbfHQEwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 00:52:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbfHQEwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 00:52:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7H4q8FH142568
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 00:52:23 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ue4m4ha0y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 00:52:22 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 17 Aug 2019 05:52:22 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 17 Aug 2019 05:52:18 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7H4qH0249873378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 04:52:17 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C5CC5B2066;
        Sat, 17 Aug 2019 04:52:17 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9087FB205F;
        Sat, 17 Aug 2019 04:52:17 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 17 Aug 2019 04:52:17 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 671D716C1AF7; Fri, 16 Aug 2019 21:52:17 -0700 (PDT)
Date:   Fri, 16 Aug 2019 21:52:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Reply-To: paulmck@linux.ibm.com
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
 <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081704-0060-0000-0000-0000036D4246
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011602; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01247963; UDB=6.00658679; IPR=6.01029477;
 MB=3.00028210; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-17 04:52:21
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081704-0061-0000-0000-00004A94C9DA
Message-Id: <20190817045217.GZ28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-17_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908170052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 03:57:43PM -0700, Linus Torvalds wrote:

[ . . . ]

> We add READ_ONCE and WRITE_ONCE annotations when they make sense. Not
> because of some theoretical "compiler is free to do garbage"
> arguments. If such garbage happens, we need to fix the compiler, the
> same way we already do with
> 
>   -fno-strict-aliasing

Yeah, the compete-with-FORTRAN stuff.  :-/

There is some work going on in the C committee on this, where the
theorists would like to restrict strict-alias based optimizations to
enable better analysis tooling.  And no, although the theorists are
pushing in the direction we would like them to, as far as I can see
they are not pushing as far as we would like.  But it might be that
-fno-strict-aliasing needs some upgrades as well.  I expect to learn
more at the next meeting in a few months.

http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2364.pdf
http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2363.pdf
http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2362.pdf

>   -fno-delete-null-pointer-checks
>   -fno-strict-overflow
> 
> because all those "optimizations" are just fundamentally unsafe and wrong.

I was hoping that -fno-strict-overflow might go into the C++ (not C)
standard, and even thought that it had at one point, but what went into
the standard was that signed integers are twos complement, not that
overflowing them is well defined.

We are pushing to hopefully end but at least to restrict the current
pointer lifetime-end zap behavior in both C and C++, which is similar
to the pointer provenance/alias analysis that -fno-strict-aliasing at
least partially suppresses.  The zapping invalidates loading, storing,
comparing, or doing arithmetic on a pointer to an object whose lifetime
has ended.  (The WG14 PDF linked to below gives a non-exhaustive list
of problems that this causes.)

The Linux kernel used to avoid this by refusing to tell the compiler about
kmalloc() and friends, but that changed a few years ago.  This zapping
rules out a non-trivial class of concurrent algorithms, but for once
RCU is unaffected.  Some committee members complained that zapping has
been part of the standard since about 1990, but Maged Michael found a
writeup of one of the algorithms dating back to 1973.  ;-)

http://www.open-std.org/jtc1/sc22/wg14/www/docs/n2369.pdf
http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2019/p1726r0.pdf

> I really wish the compiler would never take advantage of "I can prove
> this is undefined behavior" kind of things when it comes to the kernel
> (or any other projects I am involved with, for that matter). If you
> can prove that, then you shouldn't decide to generate random code
> without a big warning. But that's what those optimizations that we
> disable effectively all do.
> 
> I'd love to have a flag that says "all undefined behavior is treated
> as implementation-defined". There's a somewhat subtle - but very
> important - difference there.

It would also be nice to downgrade some of the undefined behavior in
the standard itself.  Compiler writers usually hate this because it
would require them to document what their compiler does in each case.
So they would prefer "unspecified" if the could not have "undefined".

> And that's what some hypothetical speculative write optimizations do
> too. I do not believe they are valid for the kernel. If the code says
> 
>    if (a)
>       global_var = 1
>    else
>       global_var = 0
> 
> then the compiler had better not turn that into
> 
>      global_var = 0
>      if (a)
>          global_var = 1
> 
> even if there isn't a volatile there. But yes, we've had compiler
> writers that say "if you read the specs, that's ok".
> 
> No, it's not ok. Because reality trumps any weasel-spec-reading.
> 
> And happily, I don't think we've ever really seen a compiler that we
> use that actually does the above kind of speculative write thing (but
> doing it for your own local variables that can't be seen by other
> threads of execution - go wild).

Me, I would still want to use WRITE_ONCE() in this case.

> So in general, we very much expect the compiler to do sane code
> generation, and not (for example) do store tearing on normal
> word-sized things or add writes that weren't there originally etc.
> 
> And yes, reads are different from writes. Reads don't have the same
> kind of "other threads of execution can see them" effects, so a
> compiler turning a single read into multiple reads is much more
> realistic and not the same kind of "we need to expect a certain kind
> of sanity from the compiler" issue.

Though each of those compiler-generated multiple reads might return a
different value, right?

							Thanx, Paul

