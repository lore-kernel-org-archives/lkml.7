Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8991BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6326822CE3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 16:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfHUQOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 12:14:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727222AbfHUQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:14:34 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LG5hft074632
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:14:32 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uh81xv6r0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 12:14:32 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Aug 2019 17:14:31 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Aug 2019 17:14:26 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LGEPaa54460926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 16:14:25 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C858EB2068;
        Wed, 21 Aug 2019 16:14:25 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 983EEB205F;
        Wed, 21 Aug 2019 16:14:25 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 16:14:25 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5276E16C65BA; Wed, 21 Aug 2019 09:14:26 -0700 (PDT)
Date:   Wed, 21 Aug 2019 09:14:26 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/1] Fix: trace sched switch start/stop racy updates
Reply-To: paulmck@linux.ibm.com
References: <Pine.LNX.4.44L0.1908161505400.1525-100000@iolanthe.rowland.org>
 <1642847744.23403.1566005809759.JavaMail.zimbra@efficios.com>
 <CAHk-=wgC4+kV9AiLokw7cPP429rKCU+vjA8cWAfyOjC3MtqC4A@mail.gmail.com>
 <20190820135612.GS2332@hirez.programming.kicks-ass.net>
 <20190820202932.GW28441@linux.ibm.com>
 <20190821103200.kpufwtviqhpbuv2n@willie-the-truck>
 <20190821132310.GC28441@linux.ibm.com>
 <20190821153325.GD2349@hirez.programming.kicks-ass.net>
 <52600272.1909.1566402523680.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52600272.1909.1566402523680.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19082116-2213-0000-0000-000003BE7CD7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011629; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250059; UDB=6.00659956; IPR=6.01031613;
 MB=3.00028262; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-21 16:14:30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082116-2214-0000-0000-00005FB85AB8
Message-Id: <20190821161426.GK28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=919 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210167
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 11:48:43AM -0400, Mathieu Desnoyers wrote:
> ----- On Aug 21, 2019, at 8:33 AM, Peter Zijlstra peterz@infradead.org wrote:
> 
> > On Wed, Aug 21, 2019 at 06:23:10AM -0700, Paul E. McKenney wrote:
> >> On Wed, Aug 21, 2019 at 11:32:01AM +0100, Will Deacon wrote:
> > 
> >> > and so it is using a store-pair instruction to reduce the complexity in
> >> > the immediate generation. Thus, the 64-bit store will only have 32-bit
> >> > atomicity. In fact, this is scary because if I change bar to:
> >> > 
> >> > void bar(u64 *x)
> >> > {
> >> > 	*(volatile u64 *)x = 0xabcdef10abcdef10;
> >> > }
> >> > 
> >> > then I get:
> >> > 
> >> > bar:
> >> > 	mov	w1, 61200
> >> > 	movk	w1, 0xabcd, lsl 16
> >> > 	str	w1, [x0]
> >> > 	str	w1, [x0, 4]
> >> > 	ret
> >> > 
> >> > so I'm not sure that WRITE_ONCE would even help :/
> >> 
> >> Well, I can have the LWN article cite your email, then.  So thank you
> >> very much!
> >> 
> >> Is generation of this code for a 64-bit volatile store considered a bug?
> >> Or does ARMv8 exclude the possibility of 64-bit MMIO registers?  And I
> >> would guess that Thomas and Linus would ask a similar bugginess question
> >> for normal stores.  ;-)
> > 
> > I'm calling this a compiler bug; the way I understand volatile this is
> > very much against the intentended use case. That is, this is buggy even
> > on UP vs signals or MMIO.
> 
> And here is a simpler reproducer on my gcc-8.3.0 (aarch64) compiled with O2:
> 
> volatile unsigned long a;
>  
> void fct(void)
> {
>         a = 0x1234567812345678ULL;
> }
> 
> void fct(void)
> {
>         a = 0x1234567812345678ULL;
>    0:   90000000        adrp    x0, 8 <fct+0x8>
>    4:   528acf01        mov     w1, #0x5678                     // #22136
>    8:   72a24681        movk    w1, #0x1234, lsl #16
>    c:   f9400000        ldr     x0, [x0]
>   10:   b9000001        str     w1, [x0]
>   14:   b9000401        str     w1, [x0, #4]
> }
>   18:   d65f03c0        ret
> 
> And the non-volatile case uses stp (is it a single store to memory ?):
> 
> unsigned long a;
>   
> void fct(void)
> {
>         a = 0x1234567812345678ULL;
> }
> 
> void fct(void)
> {
>         a = 0x1234567812345678ULL;
>    0:   90000000        adrp    x0, 8 <fct+0x8>
>    4:   528acf01        mov     w1, #0x5678                     // #22136
>    8:   72a24681        movk    w1, #0x1234, lsl #16
>    c:   f9400000        ldr     x0, [x0]
>   10:   29000401        stp     w1, w1, [x0]
> }
>   14:   d65f03c0        ret
> 
> It would probably be a good idea to audit other architectures, since this
> is done by the compiler backend.

That does seem like a very good idea!

							Thanx, Paul

