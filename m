Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 630F8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353292075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 21:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfC2VJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 17:09:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729939AbfC2VJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 17:09:23 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TL42Yd002812
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 17:09:21 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rhsvejv6f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 17:09:21 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Fri, 29 Mar 2019 21:09:20 -0000
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 21:09:17 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2TL9GI110682510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 21:09:16 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55348B2066;
        Fri, 29 Mar 2019 21:09:16 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36EBBB2064;
        Fri, 29 Mar 2019 21:09:16 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 21:09:16 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8E8CA16C3456; Fri, 29 Mar 2019 14:09:18 -0700 (PDT)
Date:   Fri, 29 Mar 2019 14:09:18 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e32ab34-c14c-1ccb-76f9-0dcd729a0ef6@zytor.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19032921-0040-0000-0000-000004D9423C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010836; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000283; SDB=6.01181524; UDB=6.00606765; IPR=6.00962244;
 MB=3.00026214; MTD=3.00000008; XFM=3.00000015; UTC=2019-03-29 21:09:19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032921-0041-0000-0000-000008E465D2
Message-Id: <20190329210918.GZ4102@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 01:52:33PM -0700, H. Peter Anvin wrote:
> On 3/29/19 8:54 AM, Alexander Potapenko wrote:
> > 
> >> Of course, this would force the compiler to actually compute the
> >> offset, which would slow things down.  I have no idea whether this
> >> would be better or worse than just using the "memory" clobber.
> > Just adding the "memory" clobber to clear_bit() changes sizes of 5
> > kernel functions (the three mentioned above, plus hub_activate() and
> > native_send_call_func_ipi()) by a small margin.
> > This probably means the performance impact of this clobber is
> > negligible in this case.
> 
> I would agree with that.
> 
> Could you perhaps verify whether or not any of the above functions
> contains a currently manifest bug?
> 
> Note: the atomic versions of these functions obviously need to have
> "volatile" and the clobber anyway, as they are by definition barriers
> and moving memory operations around them would be a very serious error.

The atomic functions that return void don't need to order anything except
the input and output arguments.  The oddness with clear_bit() is that the
memory changed isn't necessarily the quantity referenced by the argument,
if the number of bits specified is large.

So (for example) atomic_inc() does not need a "memory" clobber, right?

							Thanx, Paul

