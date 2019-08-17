Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1FFC3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 22:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC902173B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 22:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfHQWGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 18:06:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23412 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726089AbfHQWGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 18:06:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7HM6rIV084876
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 18:06:53 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uedrxk5uu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2019 18:06:33 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 17 Aug 2019 23:06:33 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 17 Aug 2019 23:06:27 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7HM6QTQ41091388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 17 Aug 2019 22:06:26 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A775CB2076;
        Sat, 17 Aug 2019 22:06:26 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 855C2B2073;
        Sat, 17 Aug 2019 22:06:26 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.201.199])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 17 Aug 2019 22:06:26 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 72EFB16C16E2; Sat, 17 Aug 2019 15:06:27 -0700 (PDT)
Date:   Sat, 17 Aug 2019 15:06:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Reply-To: paulmck@linux.ibm.com
References: <241506096.21688.1565977319832.JavaMail.zimbra@efficios.com>
 <CAEXW_YQrh42N5bYMmQJCFb6xa0nwXH8jmZMEAnGVBMjGF8wR1Q@mail.gmail.com>
 <alpine.DEB.2.21.1908162245440.1923@nanos.tec.linutronix.de>
 <CAHk-=wh9qDFfWJscAQw_w+obDmZvcE5jWJRdYPKYP6YhgoGgGA@mail.gmail.com>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <20190816221313.4b05b876@oasis.local.home>
 <39888715.23900.1566052831673.JavaMail.zimbra@efficios.com>
 <20190817112655.2277a9c5@oasis.local.home>
 <1360102474.23943.1566057317249.JavaMail.zimbra@efficios.com>
 <20190817124040.34c38e19@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190817124040.34c38e19@oasis.local.home>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19081722-0060-0000-0000-0000036D551B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011607; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01248307; UDB=6.00658883; IPR=6.01029819;
 MB=3.00028217; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-17 22:06:31
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19081722-0061-0000-0000-00004A96AD29
Message-Id: <20190817220627.GI28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-17_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=432 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908170242
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2019 at 12:40:40PM -0400, Steven Rostedt wrote:
> On Sat, 17 Aug 2019 11:55:17 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > ----- On Aug 17, 2019, at 11:26 AM, rostedt rostedt@goodmis.org wrote:
> > 
> > > On Sat, 17 Aug 2019 10:40:31 -0400 (EDT)
> > > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> > >   
> > >> > I'm now even more against adding the READ_ONCE() or WRITE_ONCE().  
> > >> 
> > >> I'm not convinced by your arguments.  
> > > 
> > > Prove to me that there's an issue here beyond theoretical analysis,
> > > then I'll consider that patch.
> > > 
> > > Show me a compiler used to compile the kernel that zeros out the
> > > increment. Show me were the race actually occurs.
> > > 
> > > I think the READ/WRITE_ONCE() is more confusing than helpful. And
> > > unneeded churn to the code. And really not needed for something that's
> > > not critical to execution.  
> > 
> > I'll have to let the authors of the LWN article speak up on this, because
> > I have limited time to replicate this investigation myself.
> 
> I'll let Paul McKenney convince me then, if he has any spare cycles ;-)

You guys do manage to time these things sometimes.  ;-)

> The one instance in that article is from a 2013 bug, which talks about
> storing a 64 bit value on a 32 bit machine. But the ref count is an int
> (32 bit), and I highly doubt any compiler will split it into 16 bit
> stores for a simple increment. And I don't believe Linux even supports
> any architecture that requires 16 bit stores anymore.

For a machine-sized and aligned increment, it is indeed hard to imagine,
even for me.  I would be more worried about stores of constants with
lots of zero bits between non-zero bits on systems with small-sized
store-immediate instructions.

							Thanx, Paul

