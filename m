Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92776C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D21922D6D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 20:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbfHTUxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 16:53:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbfHTUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 16:53:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KKpoXw144999;
        Tue, 20 Aug 2019 16:52:53 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugms59bcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 16:52:53 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x7KKpvbe146132;
        Tue, 20 Aug 2019 16:52:53 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugms59bcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 16:52:53 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7KKnWIY004191;
        Tue, 20 Aug 2019 20:52:52 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02dal.us.ibm.com with ESMTP id 2ue976a9kn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Aug 2019 20:52:52 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7KKqpYa51708406
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Aug 2019 20:52:51 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 489A9B205F;
        Tue, 20 Aug 2019 20:52:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AD64B2066;
        Tue, 20 Aug 2019 20:52:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 20 Aug 2019 20:52:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 61F8016C246B; Tue, 20 Aug 2019 13:52:52 -0700 (PDT)
Date:   Tue, 20 Aug 2019 13:52:52 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Message-ID: <20190820205252.GY28441@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <20190816205740.GF10481@google.com>
 <3c0cb8a2-eba2-7bea-8523-b948253a6804@arm.com>
 <CAHk-=wi_KeD1M-_-_SU_H92vJ-yNkDnAGhAS=RR1yNNGWKW+aA@mail.gmail.com>
 <20190817045217.GZ28441@linux.ibm.com>
 <20190820140116.GT2332@hirez.programming.kicks-ass.net>
 <20190820203135.GX28441@linux.ibm.com>
 <20190820203939.GV2349@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820203939.GV2349@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908200188
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 10:39:39PM +0200, Peter Zijlstra wrote:
> On Tue, Aug 20, 2019 at 01:31:35PM -0700, Paul E. McKenney wrote:
> > On Tue, Aug 20, 2019 at 04:01:16PM +0200, Peter Zijlstra wrote:
> 
> > > We really should get the compiler folks to give us a
> > > -fno-pointer-provenance. Waiting on the standards committee to get their
> > > act together seems unlikely, esp. given that some people actually seem
> > > to _want_ this nonsense :/
> > 
> > The reason that they want it is to enable some significant optimizations
> > in numerical code on the one hand and in heavily templated C++ code on
> > the other.  Neither of which has much bearing on kernel code.
> > 
> > Interested in coming to the next C standards committee meeting in October
> > to help me push for this?  ;-)
> 
> How about we try and get some compiler folks together at plumbers and
> bribe them with beer? Once we have our compiler knob, we happy :-)

C'mon, Peter!  Where is your sense of self-destruction???  ;-)

But yes, if nothing else there is a Toolchains MC [1].  Which happens to
have a topic entitled "Potential impact/benefit/detriment of recently
developed GCC optimizations on the kernel", now that you mention it.
Looking forward to seeing you in Lisbon!

						Thanx, Paul

[1] https://linuxplumbersconf.org/event/4/sessions/45/#20190909
