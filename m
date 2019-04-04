Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D12C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27CC206B7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbfDDSTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:19:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727310AbfDDSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:19:55 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34IGdJB007070
        for <linux-kernel@vger.kernel.org>; Thu, 4 Apr 2019 14:19:54 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rnncx4tuv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 14:19:53 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 4 Apr 2019 19:19:50 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Apr 2019 19:19:46 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x34IJjTU20775084
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Apr 2019 18:19:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EBFCEB206A;
        Thu,  4 Apr 2019 18:19:44 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BE162B205F;
        Thu,  4 Apr 2019 18:19:44 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  4 Apr 2019 18:19:44 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7DDEC16C1D70; Thu,  4 Apr 2019 11:19:46 -0700 (PDT)
Date:   Thu, 4 Apr 2019 11:19:46 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
Reply-To: paulmck@linux.ibm.com
References: <20190404152314.GG14111@linux.ibm.com>
 <Pine.LNX.4.44L0.1904041138070.1288-100000@iolanthe.rowland.org>
 <20190404180842.GB183378@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404180842.GB183378@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040418-2213-0000-0000-0000037178EA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010873; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01184313; UDB=6.00620099; IPR=6.00965066;
 MB=3.00026298; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-04 18:19:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040418-2214-0000-0000-00005DE76509
Message-Id: <20190404181946.GJ14111@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904040115
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 02:08:42PM -0400, Joel Fernandes wrote:
> Thanks a lot Paul and Allen, I replied below.
> 
> On Thu, Apr 04, 2019 at 12:01:32PM -0400, Alan Stern wrote:
> > On Thu, 4 Apr 2019, Paul E. McKenney wrote:
> > 
> > > On Mon, Apr 01, 2019 at 05:11:39PM -0400, Joel Fernandes wrote:
> > 
> > > > > > So I would have expected the following litmus to result in Never, but it
> > > > > > doesn't with Alan's patch:
> > > > > > 
> > > > > > P0(int *x, int *y)
> > > > > > {
> > > > > > 	*x = 1;
> > > > > > 	smp_mb();
> > > > > > 	*y = 1;
> > > > > > }
> > > > > > 
> > > > > > P1(int *x, int *y)
> > > > > > {
> > > > > > 	int r1;
> > > > > > 
> > > > > > 	r1 = READ_ONCE(*y);
> > > > > > 	if (r1)
> > > > > > 		WRITE_ONCE(*x, 2);
> > > > > > }
> > > > > > 
> > > > > > exists (1:r1=1 /\ ~x=2)
> > > > > 
> > > > > The problem is that the compiler can turn both of P0()'s writes into reads:
> > > > > 
> > > > > P0(int *x, int *y)
> > > > > {
> > > > > 	if (*x != 1)
> > > > > 		*x = 1;
> > > > > 	smp_mb();
> > > > > 	if (*y != 1)
> > > > > 		*y = 1;
> > > > > }
> > > > > 
> > > > > These reads will not be ordered by smp_wmb(), so you have to do WRITE_ONCE()
> > > > > to get an iron-clad ordering guarantee.
> > > > 
> > > > But the snippet above has smp_mb() which does order writes, even for the
> > > > plain accesses.
> > > 
> > > True, but that code has a data race, namely P0()'s plain write to y
> > > races with P1()'s READ_ONCE().  Data races give the compiler absolutely
> > > astonishing levels of freedom to rearrange your code.  So, if you
> > > as a developer or maintainer choose to have data races, it is your
> > > responsibility to ensure that the compiler cannot mess you up.  So what
> > > you should do in that case is to list the transformed code the compiler's
> > > optimizations can produce and feed the corresponding litmus tests to LKMM,
> > > using READ_ONCE() and WRITE_ONCE() for the post-optimization accesses.
> > 
> > In this case, I strongly suspect the compiler would not mess up the
> > code badly enough to allow the unwanted end result.  But the LKMM tries
> > to avoid making strong assumptions about what compilers will or will
> > not do.
> 
> Here I was just trying to understand better how any kind of code
> transformation can cause an issue. Certainly I can see an issue if the
> compiler uses the memory location as a temporary variable as Paul pointed, to
> which I agree that a WRITE_ONCE is better. I am in favor of being careful,
> but here I was just trying to understand this better.
> 
> > > > I understand. Are we talking about load/store tearing being the issue here?
> > > > Even under load/store tearing, I feel the program will produce correct
> > > > results because r1 is either 0 or 1 (a single bit cannot be torn).
> > > 
> > > The compiler can (at least in theory) also transform *y = 1 as follows:
> > > 
> > > 	*y = r1; /* Use *y as temporary storage. */
> > > 	do_something();
> > > 	r1 = *y;
> > > 	*y = 1;
> > > 
> > > Here r1 is some register and do_something() is an inline function visible
> > > to the compiler (hence not implying barrier() upon call and return).
> > > 
> > > I don't know of any compilers that actually do this, but for me use
> > > of WRITE_ONCE() is a small price to pay to prevent all past, present,
> > > and future compiler from ever destroying^W optimizing my code in this way.
> > > 
> > > In your own code, if you dislike WRITE_ONCE() so much that you are willing
> > > to commit to (now and forever!!!) checking all applicable versions of
> > > compilers to make sure that they don't do this, well and good, knock
> > > yourself out.  But it is your responsibility to do that checking, and you
> > > can attest to LKMM that you have done so by giving LKMM litmus tests that
> > > substitute WRITE_ONCE() for that plain C-language assignment statement.
> > 
> > Remember that the LKMM does not produce strict bounds.  That is, the
> > LKMM will say that some outcomes are allowed even though no existing
> > compiler/CPU combination would ever actually produce them.  This litmus
> > test is an example.
> 
> Ok.
> 
> > > > Further, from the herd simulator output (below), according to the "States",
> > > > r1==1 means P1() AFAICS would have already finished the the read and set the
> > > > r1 register to 1.  Then I am wondering why it couldn't take the branch to set
> > > > *x to 2.  According to herd, r1 == 1 AND x == 1 is a perfectly valid state
> > > > for the below program. I still couldn't see in my mind how for the below
> > > > program, this is possible - in terms of compiler optimizations or other kinds
> > > > of ordering. Because there is a smp_mb() between the 2 plain writes in P0()
> > > > and P1() did establish that r1 is 1 in the positive case. :-/.  I am surely
> > > > missing something :-)
> > > > 
> > > > ---8<-----------------------
> > > > C Joel-put_pid
> > > > 
> > > > {}
> > > > 
> > > > P0(int *x, int *y)
> > > > {
> > > > 	*x = 1;
> > > > 	smp_mb();
> > > > 	*y = 1;
> > > > }
> > > > 
> > > > P1(int *x, int *y)
> > > > {
> > > > 	int r1;
> > > > 
> > > > 	r1 = READ_ONCE(*y);
> > > > 	if (r1)
> > > > 		WRITE_ONCE(*x, 2);
> > > > }
> > > > 
> > > > exists (1:r1=1 /\ ~x=2)
> > > > 
> > > > ---8<-----------------------
> > > > Output:
> > > > 
> > > > Test Joel-put_pid Allowed
> > > > States 3
> > > > 1:r1=0; x=1;
> > > > 1:r1=1; x=1;	<-- Can't figure out why r1=1 and x != 2 here.
> > > 
> > > I must defer to Alan on this, but my guess is that this is due to
> > > the fact that there is a data race.
> > 
> > Yes, and because the plain-access/data-race patch for the LKMM was
> > intended only to detect data races, not to be aware of all the kinds of
> > ordering that plain accesses can induce.  I said as much at the start
> > of the patch's cover letter and it bears repeating.
> > 
> > In this case it is certainly true that the "*x = 1" write must be
> > complete before the value of *y is changed from 0.  Hence P1's
> > WRITE_ONCE will certainly overwrite the 1 with 2, and the final value
> > of *x will be 2 if r1=1.
> > 
> > But the notion of "visibility" of a write that I put into the LKMM
> > patch only allows for chains of marked accesses.  Since "*y = 1" is a
> > plain access, the model does not recognize that it can enforce the
> > ordering between the two writes to *x.
> > 
> > Also, you must remember, the LKMM's prediction about whether an outcome
> > will or will not occur are meaningless if a data race is present.  
> > Therefore the most fundamental the answer to why the "1:r1=1; x=1;"  
> > line is there is basically what Paul said: It's there because the
> > herd model gets completely messed up by data races.
> 
> Makes sense to me. Thanks for the good work on this.
> 
> FWIW, thought to mention (feel free ignore the suggestion if its
> meaningless): If there is any chance that the outcome can be better
> outputted, like r1=X; x=1; Where X stands for the result of a data race, that
> would be lovely.  I don't know much about herd internals (yet) to say if the
> suggestion makes sense but as a user, it would certainly help reduce
> confusion.

The "Flag data-race" that appeared in the herd output is your friend in
this case.  If you see that in the output, that means that herd detected
a data race, and the states output might or might not be reliable.

							Thanx, Paul

