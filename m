Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1109DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED5720857
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 21:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbfCaVzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 17:55:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731172AbfCaVzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 17:55:36 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2VLmmqL139154
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 17:55:34 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rk2gsdk9v-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 17:55:34 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sun, 31 Mar 2019 22:55:33 +0100
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 31 Mar 2019 22:55:29 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2VLtSqG15400982
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 31 Mar 2019 21:55:28 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A4EAB2065;
        Sun, 31 Mar 2019 21:55:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF91CB2064;
        Sun, 31 Mar 2019 21:55:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 31 Mar 2019 21:55:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 0534B16C34EA; Sun, 31 Mar 2019 14:55:31 -0700 (PDT)
Date:   Sun, 31 Mar 2019 14:55:31 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
Reply-To: paulmck@linux.ibm.com
References: <20190327145331.215360-1-joel@joelfernandes.org>
 <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
 <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com>
 <20190328023432.GA93275@google.com>
 <CAG48ez2bbSYpNHcC4oucx_AG=5y4K5pZfSOfN3mxGadJGpHuQQ@mail.gmail.com>
 <20190328143738.GA261521@google.com>
 <CAG48ez1-3dLvzQoxxoUzTUq8dc1wwvwPBBxX_X9FWMscWTS-FQ@mail.gmail.com>
 <20190328162641.GC19441@redhat.com>
 <20190328173707.GP4102@linux.ibm.com>
 <20190330023639.GA214473@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190330023639.GA214473@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19033121-0072-0000-0000-000004130BDF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010849; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01182491; UDB=6.00618992; IPR=6.00963221;
 MB=3.00026233; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-31 21:55:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19033121-0073-0000-0000-00004BAA8791
Message-Id: <20190331215531.GF4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-31_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903310165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 10:36:39PM -0400, Joel Fernandes wrote:
> On Thu, Mar 28, 2019 at 10:37:07AM -0700, Paul E. McKenney wrote:
> > On Thu, Mar 28, 2019 at 05:26:42PM +0100, Oleg Nesterov wrote:
> > > On 03/28, Jann Horn wrote:
> > > >
> > > > Since we're just talking about RCU stuff now, adding Paul McKenney to
> > > > the thread.
> > > 
> > > Since you added Paul let me add more confusion to this thread ;)
> > 
> > Woo-hoo!!!  More confusion!  Bring it on!!!  ;-)
> 
> Nice to take part in the confusion fun too!!! ;-)
> 
> > > There were some concerns about the lack of barriers in put_pid(), but I can't
> > > find that old discussion and I forgot the result of that discussion...
> > > 
> > > Paul, could you confirm that this code
> > > 
> > > 	CPU_0		CPU_1
> > > 
> > > 	X = 1;		if (READ_ONCE(Y))
> > > 	mb();			X = 2;
> > > 	Y = 1;		BUG_ON(X != 2);
> > > 
> > > 
> > > is correct? I think it is, control dependency pairs with mb(), right?
> > 
> > The BUG_ON() is supposed to happen at the end of time, correct?
> > As written, there is (in the strict sense) a data race between the load
> > of X in the BUG_ON() and CPU_0's store to X.  In a less strict sense,
> > you could of course argue that this data race is harmless, especially
> > if X is a single byte.  But the more I talk to compiler writers, the
> > less comfortable I become with data races in general.  :-/
> > 
> > So I would also feel better if the "Y = 1" was WRITE_ONCE().
> > 
> > On the other hand, this is a great opportunity to try out Alan Stern's
> > prototype plain-accesses patch to the Linux Kernel Memory Model (LKMM)!
> > 
> > https://lkml.kernel.org/r/Pine.LNX.4.44L0.1903191459270.1593-200000@iolanthe.rowland.org
> > 
> > Also adding Alan on CC.
> > 
> > Here is what I believe is the litmus test that your are interested in:
> > 
> > ------------------------------------------------------------------------
> > C OlegNesterov-put_pid
> > 
> > {}
> > 
> > P0(int *x, int *y)
> > {
> > 	*x = 1;
> > 	smp_mb();
> > 	*y = 1;
> > }
> > 
> > P1(int *x, int *y)
> > {
> > 	int r1;
> > 
> > 	r1 = READ_ONCE(*y);
> > 	if (r1)
> > 		*x = 2;
> > }
> > 
> > exists (1:r1=1 /\ ~x=2)
> > ------------------------------------------------------------------------
> > 
> > Running this through herd with Alan's patch detects the data race
> > and says that the undesired outcome is allowed:
> > 
> > 	$ herd7  -conf linux-kernel.cfg /tmp/OlegNesterov-put_pid.litmus 
> > 	Test OlegNesterov-put_pid Allowed
> > 	States 3
> > 	1:r1=0; x=1;
> > 	1:r1=1; x=1;
> > 	1:r1=1; x=2;
> > 	Ok
> > 	Witnesses
> > 	Positive: 1 Negative: 2
> > 	Flag data-race
> > 	Condition exists (1:r1=1 /\ not (x=2))
> > 	Observation OlegNesterov-put_pid Sometimes 1 2
> > 	Time OlegNesterov-put_pid 0.00
> > 	Hash=a3e0043ad753effa860fea37eeba0a76
> > 
> > Using WRITE_ONCE() for P0()'s store to y still allows this outcome,
> > although it does remove the "Flag data-race".
> > 
> > Using WRITE_ONCE() for both P0()'s store to y and P1()'s store to x
> > gets rid of both the "Flag data-race" and the undesired outcome:
> > 
> > 	$ herd7  -conf linux-kernel.cfg /tmp/OlegNesterov-put_pid-WO-WO.litmus 
> > 	Test OlegNesterov-put_pid-WO-WO Allowed
> > 	States 2
> > 	1:r1=0; x=1;
> > 	1:r1=1; x=2;
> > 	No
> > 	Witnesses
> > 	Positive: 0 Negative: 2
> > 	Condition exists (1:r1=1 /\ not (x=2))
> > 	Observation OlegNesterov-put_pid-WO-WO Never 0 2
> > 	Time OlegNesterov-put_pid-WO-WO 0.01
> > 	Hash=6e1643e3c5e4739b590bde0a8e8a918e
> > 
> > Here is the corresponding litmus test, in case I messed something up:
> > 
> > ------------------------------------------------------------------------
> > C OlegNesterov-put_pid-WO-WO
> > 
> > {}
> > 
> > P0(int *x, int *y)
> > {
> > 	*x = 1;
> > 	smp_mb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int *x, int *y)
> > {
> > 	int r1;
> > 
> > 	r1 = READ_ONCE(*y);
> > 	if (r1)
> > 		WRITE_ONCE(*x, 2);
> > }
> > 
> > exists (1:r1=1 /\ ~x=2)
> 
> I ran the above examples too. Its a bit confusing to me why the WRITE_ONCE in
> P0() is required, and why would the READ_ONCE / WRITE_ONCE in P1() not be
> sufficient to prevent the exists condition. Shouldn't the compiler know that,
> in P0(), it should not reorder the store to y=1 before the x=1 because there
> is an explicit barrier between the 2 stores? Looks me to me like a broken
> compiler :-|. 
> 
> So I would have expected the following litmus to result in Never, but it
> doesn't with Alan's patch:
> 
> P0(int *x, int *y)
> {
> 	*x = 1;
> 	smp_mb();
> 	*y = 1;
> }
> 
> P1(int *x, int *y)
> {
> 	int r1;
> 
> 	r1 = READ_ONCE(*y);
> 	if (r1)
> 		WRITE_ONCE(*x, 2);
> }
> 
> exists (1:r1=1 /\ ~x=2)

The problem is that the compiler can turn both of P0()'s writes into reads:

P0(int *x, int *y)
{
	if (*x != 1)
		*x = 1;
	smp_mb();
	if (*y != 1)
		*y = 1;
}

These reads will not be ordered by smp_wmb(), so you have to do WRITE_ONCE()
to get an iron-clad ordering guarantee.

> > ------------------------------------------------------------------------
> > 
> > > If not, then put_pid() needs atomic_read_acquire() as it was proposed in that
> > > discussion.
> > 
> > Good point, let's try with smp_load_acquire() in P1():
> > 
> > 	$ herd7  -conf linux-kernel.cfg /tmp/OlegNesterov-put_pid-WO-sla.litmus 
> > 	Test OlegNesterov-put_pid-WO-sla Allowed
> > 	States 2
> > 	1:r1=0; x=1;
> > 	1:r1=1; x=2;
> > 	No
> > 	Witnesses
> > 	Positive: 0 Negative: 2
> > 	Condition exists (1:r1=1 /\ not (x=2))
> > 	Observation OlegNesterov-put_pid-WO-sla Never 0 2
> > 	Time OlegNesterov-put_pid-WO-sla 0.01
> > 	Hash=4fb0276eabf924793dec1970199db3a6
> > 
> > This also works.  Here is the litmus test:
> > 
> > ------------------------------------------------------------------------
> > C OlegNesterov-put_pid-WO-sla
> > 
> > {}
> > 
> > P0(int *x, int *y)
> > {
> > 	*x = 1;
> > 	smp_mb();
> > 	WRITE_ONCE(*y, 1);
> > }
> > 
> > P1(int *x, int *y)
> > {
> > 	int r1;
> > 
> > 	r1 = smp_load_acquire(y);
> > 	if (r1)
> > 		*x = 2;
> > }
> > 
> > exists (1:r1=1 /\ ~x=2)
> > ------------------------------------------------------------------------
> > 
> > Demoting P0()'s WRITE_ONCE() to a plain write while leaving P1()'s
> > smp_load_acquire() gets us a data race and allows the undesired
> > outcome:
> 
> Yeah, I think this is also what I was confused about above, is why is that
> WRITE_ONCE required in P0() because there's already an smp_mb there. Surely
> I'm missing something. ;-)

The first of P0()'s writes can be a plain write, at least assuming
sufficient synchronization to avoid the data race.  But turning the second
of P0()'s writes into a plain write is a bit riskier: That is a write of
a constant, and those really are torn in some cases on some architectures.
Like x86, for example.

> > 	$ herd7  -conf linux-kernel.cfg /tmp/OlegNesterov-put_pid-sla.litmus 
> > 	Test OlegNesterov-put_pid-sla Allowed
> > 	States 3
> > 	1:r1=0; x=1;
> > 	1:r1=1; x=1;
> > 	1:r1=1; x=2;
> > 	Ok
> > 	Witnesses
> > 	Positive: 1 Negative: 2
> > 	Flag data-race
> > 	Condition exists (1:r1=1 /\ not (x=2))
> > 	Observation OlegNesterov-put_pid-sla Sometimes 1 2
> > 	Time OlegNesterov-put_pid-sla 0.01
> > 	Hash=ec6f71f3d9f7cd6e45a874c872e3d946
> > 
> > But what if you are certain that the compiler cannot mess up your use
> > of plain C-language loads and stores?  Then simply tell LKMM that they
> > are READ_ONCE() and WRITE_ONCE(), respectively.  LKMM is admittedly
> > somewhat paranoid, but real C compilers really do tear stores of certain
> > constants on systems (like x86) that have store-immediate instructions,
> > so a bit of paranoia is not misplaced here.  ;-)
> > 
> > Plus please note that this patch to LKMM is prototype and thus subject
> > to change.
> 
> Ah I see. Appreciate if Alan can also CC me on future posting of this since
> I'm quite interested. ;-)

His last posting should be easy to find.  But please let me know if not,
as I would be happy to send it along.

							Thanx, Pau

