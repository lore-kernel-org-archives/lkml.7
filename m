Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA36EC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 23:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01C52086C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 23:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfHQXAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 19:00:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5646 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbfHQXAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 19:00:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7HMvYFD133453
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 19:00:38 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uedf0md7g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 19:00:38 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 18 Aug 2019 00:00:37 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 18 Aug 2019 00:00:34 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7HN0X2u52363676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 23:00:33 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C67FFB205F;
        Sat, 17 Aug 2019 23:00:33 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91276B2066;
        Sat, 17 Aug 2019 23:00:33 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 17 Aug 2019 23:00:33 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8E35216C1AF7; Sat, 17 Aug 2019 16:00:34 -0700 (PDT)
Date:   Sat, 17 Aug 2019 16:00:34 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Reply-To: paulmck@linux.ibm.com
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
 <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
 <20190817045217.GZ28441@linux.ibm.com>
 <CAHk-=wiOhiAJVU71968tAND6rrEJSaYPg7DXK6Y6iiz7_RJACw@mail.gmail.com>
 <CAHk-=whjEq6uEt0o0Ur9Epa7EKVvEFUVJVFJ+heJCv9ehV7pyA@mail.gmail.com>
 <1065930957.23914.1566054178444.JavaMail.zimbra@efficios.com>
 <600fd72f-11a0-ff1a-c87a-b26349f6f54a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <600fd72f-11a0-ff1a-c87a-b26349f6f54a@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081723-2213-0000-0000-000003BCD675
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011607; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01248326; UDB=6.00658894; IPR=6.01029836;
 MB=3.00028217; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-17 23:00:37
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081723-2214-0000-0000-00005FAF061E
Message-Id: <20190817230034.GK28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-17_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908170252
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 09:03:30PM +0100, Valentin Schneider wrote:
> Apologies to Steve for continuing this thread when all he wanted was moving
> an operation inside a mutex...
> 
> On 17/08/2019 16:02, Mathieu Desnoyers wrote:
> [...]
> > However, if the state of "x" can be any pointer value, or a reference
> > count value, then not using "WRITE_ONCE()" to store a constant leaves
> > the compiler free to perform that store in more than one memory access.
> > Based on [1], section "Store tearing", there are situations where this
> > happens on x86 in the wild today when storing 64-bit constants: the
> > compiler is then free to decide to use two 32-bit immediate store
> > instructions.
> > 
> 
> That's also how I understand things, and it's also one of the points raised
> in the compiler barrier section of memory-barriers.txt
> 
> Taking this store tearing, or the invented stores - e.g. the branch
> optimization pointed out by Linus:
> 
> >    if (a)
> >       global_var = 1
> >    else
> >       global_var = 0
> > 
> > then the compiler had better not turn that into
> > 
> >      global_var = 0
> >      if (a)
> >          global_var = 1
> 
> AFAICT nothing prevents this from happening inside a critical section (where
> the locking primitives provide the right barriers, but that's it). That's
> all fine when data is never accessed locklessly, but in the case of locked
> writes vs lockless reads, couldn't there be "leaks" of these transient
> states? In those cases we would want WRITE_ONCE() for the writes.
> 
> So going back to:
> 
> > But the reverse is not really true. All a READ_ONCE() says is "I want
> > either the old or the new value", and it can get that _without_ being
> > paired with a WRITE_ONCE().
> 
> AFAIU it's not always the case, since a lone READ_ONCE() could get transient
> values.

Linus noted that he believes that compilers for architectures supporting
Linux can be trusted to avoid store-to-load transformations, invented
stores, and unnecessary store tearing.  Should these appear, Linus would
report a bug against the compiler and expect it to be fixed.

> I'll be honest, it's not 100% clear to me when those optimizations can
> actually be done (maybe the branch thingy but the others are dubious), and
> it's even less clear when compilers *actually* do it - only that they have
> been reported to do it (so it's not made up).

There is significant unclarity inherent in the situation.  The standard
says one thing, different compilers do other things, and developers
often expect yet a third thing.  And sometimes things change over time,
for example, the ca. 2011 dictim against compilers inventing data races.

Hey, they didn't teach me this aspect of software development in school,
either.  ;-)

							Thanx, Paul

