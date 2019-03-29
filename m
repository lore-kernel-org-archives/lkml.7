Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A76EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D531218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 22:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbfC2WF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 18:05:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43722 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730220AbfC2WF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 18:05:59 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TM4Irx013676
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 18:05:58 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rhuk9gkp4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 18:05:57 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 29 Mar 2019 22:05:56 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 22:05:52 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2TM5pG015859912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 22:05:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC7E4B209A;
        Fri, 29 Mar 2019 22:05:51 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AEE0EB2098;
        Fri, 29 Mar 2019 22:05:51 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 22:05:51 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 2592916C3799; Fri, 29 Mar 2019 15:05:54 -0700 (PDT)
Date:   Fri, 29 Mar 2019 15:05:54 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8092b8aa-bb1c-0266-b308-5cebfb25e2ef@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032922-0072-0000-0000-000004126606
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010837; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01181543; UDB=6.00618423; IPR=6.00962264;
 MB=3.00026215; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-29 22:05:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032922-0073-0000-0000-00004BA5BB39
Message-Id: <20190329220554.GD4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 02:51:26PM -0700, H. Peter Anvin wrote:
> On 3/29/19 2:09 PM, Paul E. McKenney wrote:
> >>
> >> Note: the atomic versions of these functions obviously need to have
> >> "volatile" and the clobber anyway, as they are by definition barriers
> >> and moving memory operations around them would be a very serious error.
> > 
> > The atomic functions that return void don't need to order anything except
> > the input and output arguments.  The oddness with clear_bit() is that the
> > memory changed isn't necessarily the quantity referenced by the argument,
> > if the number of bits specified is large.
> > 
> > So (for example) atomic_inc() does not need a "memory" clobber, right?
> 
> I don't believe that is true: the code calling it has a reasonable
> expectation that previous memory operations have finished and later
> memory operations have not started from the point of view of another
> processor. You are more of an expert on memory ordering than I am, but
> I'm 89% sure that there is plenty of code in the kernel which makes that
> assumption.

From Documentation/core-api/atomic_ops.rst:

------------------------------------------------------------------------
	void atomic_add(int i, atomic_t *v);
	void atomic_sub(int i, atomic_t *v);
	void atomic_inc(atomic_t *v);
	void atomic_dec(atomic_t *v);

These four routines add and subtract integral values to/from the given
atomic_t value.  The first two routines pass explicit integers by
which to make the adjustment, whereas the latter two use an implicit
adjustment value of "1".

One very important aspect of these two routines is that they DO NOT
require any explicit memory barriers.  They need only perform the
atomic_t counter update in an SMP safe manner.
------------------------------------------------------------------------

So, no, these functions do not imply any ordering other than to the
variable modified.  This one predates my joining the Linux kernel
community.  ;-)  So any cases where someone is relying on atomic_inc()
to provide ordering are bugs.

Now for value-returning atomics, for example, atomic_inc_return(),
full ordering is indeed required.

							Thanx, Paul

