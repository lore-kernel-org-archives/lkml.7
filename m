Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2686C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD274206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfHUOiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:38:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45114 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728724AbfHUOiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:38:17 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7LEVQWA049345
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:38:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2uh61te01u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 10:38:15 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 21 Aug 2019 15:38:14 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 21 Aug 2019 15:38:13 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7LEcCab28443006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Aug 2019 14:38:12 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C30ADB2065;
        Wed, 21 Aug 2019 14:38:12 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A37CDB2064;
        Wed, 21 Aug 2019 14:38:12 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.154])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 21 Aug 2019 14:38:12 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 428FE16C1AFD; Wed, 21 Aug 2019 07:38:13 -0700 (PDT)
Date:   Wed, 21 Aug 2019 07:38:13 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: memory-barriers.txt questions
Reply-To: paulmck@linux.ibm.com
References: <CAJ+HfNiC3jEuP39-a5PoQuY=Vi-CeQJ6STSLKZZRqSRND4Fcyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+HfNiC3jEuP39-a5PoQuY=Vi-CeQJ6STSLKZZRqSRND4Fcyw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19082114-0072-0000-0000-0000045416D9
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011629; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01250027; UDB=6.00659936; IPR=6.01031581;
 MB=3.00028261; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-21 14:38:14
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082114-0073-0000-0000-00004CC5394A
Message-Id: <20190821143813.GE28441@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-21_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=726 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908210158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 21, 2019 at 04:24:42PM +0200, Björn Töpel wrote:
> Paul,
> 
> Reaching out directly, hope that's OK!

Adding LKML on CC, hope that's OK!

> >From memory-barriers.txt (what an excellent document. I've read it
> over and over, and never get all the details. :-)):
> --8<--
> MISCELLANEOUS FUNCTIONS
> -----------------------
> 
> Other functions that imply barriers:
> 
>  (*) schedule() and similar imply full memory barriers.
> -->8--
> 
> The "and similar" part puzzles me. IPI is a a full barrier on all
> platforms (I think). Are interrupts in general full barriers? What
> more?

Functions similar to schedule() include schedule_user(),
schedule_preempt_disabled(), preempt_schedule(), preempt_schedule_irq(),
and so on.  Plus any function that calls one of these functions.

Interrupts are quite architecture specific, and on many architectures an
interrupt does not imply any sort of cross-CPU ordering in and of itself.
So you would need to inspect the interrupt-entry/-exit code to see if
the needed full memory-barrier instructions were in place to answer
this question.

But what are you trying to achieve?

							Thanx, Paul

