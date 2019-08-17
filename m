Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA59C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 22:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58E352075E
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 22:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfHQW3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 18:29:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbfHQW3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 18:29:21 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7HMLamP051424;
        Sat, 17 Aug 2019 18:28:35 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uee4538fm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Aug 2019 18:28:35 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7HMMDe0052380;
        Sat, 17 Aug 2019 18:28:35 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uee4538f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Aug 2019 18:28:35 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7HMP3AW009617;
        Sat, 17 Aug 2019 22:28:33 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 2ue9760efk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 17 Aug 2019 22:28:33 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7HMSXtt50004436
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 22:28:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61B30B2066;
        Sat, 17 Aug 2019 22:28:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CF42B205F;
        Sat, 17 Aug 2019 22:28:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 17 Aug 2019 22:28:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 20BC016C16E2; Sat, 17 Aug 2019 15:28:34 -0700 (PDT)
Date:   Sat, 17 Aug 2019 15:28:34 -0700
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
Message-ID: <20190817222834.GJ28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
 <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
 <20190817045217.GZ28441@linux.ibm.com>
 <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-17_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908170245
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 01:28:48AM -0700, Linus Torvalds wrote:

[ . . . ]

> Put another way: a WRITE_ONCE() without a paired READ_ONCE() is almost
> certainly pointless.

"Your honor, I have no further questions at this time, but I reserve
the right to recall this witness."

Outside of things like MMIO (where one could argue that the corresponding
READ_ONCE() is in the device firmware), the use cases I can imagine
for WRITE_ONCE() with no READ_ONCE() are quite strange.  For example,
doing the WRITE_ONCE()s while read-holding a given lock and doing plain
reads while write-holding that same lock.  While at the same time being
worried about store tearing and similar.

Perhaps I am suffering a failure of imagination, but I am not seeing
a reasonable use for such things at the moment.

> But the reverse is not really true. All a READ_ONCE() says is "I want
> either the old or the new value", and it can get that _without_ being
> paired with a WRITE_ONCE().
> 
> See? They just aren't equally important.
> 
> > > And yes, reads are different from writes. Reads don't have the same
> > > kind of "other threads of execution can see them" effects, so a
> > > compiler turning a single read into multiple reads is much more
> > > realistic and not the same kind of "we need to expect a certain kind
> > > of sanity from the compiler" issue.
> >
> > Though each of those compiler-generated multiple reads might return a
> > different value, right?
> 
> Right. See the examples I have in the email to Mathieu:
> 
>    unsigned int bits = some_global_value;
>    ...test different bits in in 'bits' ...
> 
> can easily cause multiple reads (particularly on a CPU that has a
> "test bits in memory" instruction and a lack of registers.
> 
> So then doing it as
> 
>    unsigned int bits = READ_ONCE(some_global_value);
>    .. test different bits in 'bits'...
> 
> makes a real and obvious semantic difference. In ways that changing a one-time
> 
>    ptr->flag = true;
> 
> to
> 
>    WRITE_ONCE(ptr->flag, true);
> 
> does _not_ make any obvious semantic difference what-so-ever.

Agreed, especially given that only one bit of ->flag is most likely
ever changing.

> Caching reads is also something that makes sense and is common, in
> ways that caching writes does not. So doing
> 
>     while (in_progress_global) /* twiddle your thumbs */;
> 
> obviously trivially translates to an infinite loop with a single
> conditional in front of it, in ways that
> 
>    while (READ_ONCE(in_progress_global)) /* twiddle */;
> 
> does not.
> 
> So there are often _obvious_ reasons to use READ_ONCE().
> 
> I really do not find the same to be true of WRITE_ONCE(). There are
> valid uses, but they are definitely much less common, and much less
> obvious.

Agreed, and I expect READ_ONCE() to continue to be used more heavily than
is WRITE_ONCE(), even including the documentation-only WRITE_ONCE() usage.

							Thanx, Paul
