Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F693C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0977F2133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfDAPoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:44:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726887AbfDAPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:44:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31Fi0jQ119450
        for <linux-kernel@vger.kernel.org>; Mon, 1 Apr 2019 11:44:16 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rkmeg4ec8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 11:44:16 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 1 Apr 2019 16:44:15 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Apr 2019 16:44:11 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x31FiAfP15794426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Apr 2019 15:44:10 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3FEAB206C;
        Mon,  1 Apr 2019 15:44:10 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86B02B205F;
        Mon,  1 Apr 2019 15:44:10 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  1 Apr 2019 15:44:10 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9B85516C1B98; Mon,  1 Apr 2019 08:44:14 -0700 (PDT)
Date:   Mon, 1 Apr 2019 08:44:14 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitriy Vyukov <dvyukov@google.com>,
        James Y Knight <jyknight@google.com>
Subject: Re: Potentially missing "memory" clobbers in bitops.h for x86
Reply-To: paulmck@linux.ibm.com
References: <CAG_fn=X9tpSW6jvJd_COk_RU8zvcr-cxSWuJ05qcV0LotTxEEQ@mail.gmail.com>
 <20190328162222.GO4102@linux.ibm.com>
 <CAG_fn=WKA_4Vzsh6yH+=5TFv-EMrX87pr+2c_ANoH_MOVpbe1w@mail.gmail.com>
 <8e32ab34-c14c-1ccb-76f9-0dcd729a0ef6@zytor.com>
 <20190329210918.GZ4102@linux.ibm.com>
 <8092b8aa-bb1c-0266-b308-5cebfb25e2ef@zytor.com>
 <20190329220554.GD4102@linux.ibm.com>
 <20190401105348.GL11158@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401105348.GL11158@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19040115-0068-0000-0000-000003AE4E8A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010855; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01182835; UDB=6.00619206; IPR=6.00963577;
 MB=3.00026247; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-01 15:44:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19040115-0069-0000-0000-000048017604
Message-Id: <20190401154414.GM4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904010105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 12:53:48PM +0200, Peter Zijlstra wrote:
> On Fri, Mar 29, 2019 at 03:05:54PM -0700, Paul E. McKenney wrote:
> > On Fri, Mar 29, 2019 at 02:51:26PM -0700, H. Peter Anvin wrote:
> > > On 3/29/19 2:09 PM, Paul E. McKenney wrote:
> > > >>
> > > >> Note: the atomic versions of these functions obviously need to have
> > > >> "volatile" and the clobber anyway, as they are by definition barriers
> > > >> and moving memory operations around them would be a very serious error.
> > > > 
> > > > The atomic functions that return void don't need to order anything except
> > > > the input and output arguments.  The oddness with clear_bit() is that the
> > > > memory changed isn't necessarily the quantity referenced by the argument,
> > > > if the number of bits specified is large.
> > > > 
> > > > So (for example) atomic_inc() does not need a "memory" clobber, right?
> 
> Correct, and many implementations do not, including x86:
> 
> static __always_inline void arch_atomic_inc(atomic_t *v)
> {
> 	asm volatile(LOCK_PREFIX "incl %0"
> 		     : "+m" (v->counter));
> }

Very good!

> > > I don't believe that is true: the code calling it has a reasonable
> > > expectation that previous memory operations have finished and later
> > > memory operations have not started from the point of view of another
> > > processor. You are more of an expert on memory ordering than I am, but
> > > I'm 89% sure that there is plenty of code in the kernel which makes that
> > > assumption.
> > 
> > From Documentation/core-api/atomic_ops.rst:
> 
> We should delete that file.

Only if all of its content is fully present elsewhere.  ;-)

							Thanx, Paul

