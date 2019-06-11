Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1140EC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E68F9206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391929AbfFKT0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:26:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387563AbfFKT0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:26:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BJLqUT043341;
        Tue, 11 Jun 2019 15:25:29 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2fkbykrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jun 2019 15:25:29 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5BHBNwY008569;
        Tue, 11 Jun 2019 17:13:53 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 2t1x6sh04f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jun 2019 17:13:53 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BJPR3k40108430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 19:25:27 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79BF4B2096;
        Tue, 11 Jun 2019 19:25:27 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B5C2B2094;
        Tue, 11 Jun 2019 19:25:27 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.136.117])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 19:25:27 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 60BFF16C5DA1; Tue, 11 Jun 2019 12:25:27 -0700 (PDT)
Date:   Tue, 11 Jun 2019 12:25:27 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, mojha@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
Message-ID: <20190611192527.GN28207@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190602011253.GA6167@linux.ibm.com>
 <20190603083848.GB3436@hirez.programming.kicks-ass.net>
 <20190603114455.GA16119@lakrids.cambridge.arm.com>
 <ea4887fb-cc77-59d4-3ba7-a59f5237ca40@arm.com>
 <20190604074549.GP28207@linux.ibm.com>
 <6eb5d59f-37d0-0aab-1fc0-fcf48cc4164f@arm.com>
 <20190608164158.GK28207@linux.ibm.com>
 <16a424d1-0ab7-7e81-5c4f-93da23519b1d@arm.com>
 <20190611135429.GH28207@linux.ibm.com>
 <89ba6366-5be3-736e-ee78-3d9510aa2576@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ba6366-5be3-736e-ee78-3d9510aa2576@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110124
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 04:39:34PM +0200, Dietmar Eggemann wrote:
> On 6/11/19 3:54 PM, Paul E. McKenney wrote:
> >On Tue, Jun 11, 2019 at 03:14:54PM +0200, Dietmar Eggemann wrote:
> >>On 6/8/19 6:41 PM, Paul E. McKenney wrote:
> >>>On Tue, Jun 04, 2019 at 03:29:32PM +0200, Dietmar Eggemann wrote:
> >>>>On 6/4/19 9:45 AM, Paul E. McKenney wrote:
> >>>>>On Mon, Jun 03, 2019 at 03:39:18PM +0200, Dietmar Eggemann wrote:
> >>>>>>On 6/3/19 1:44 PM, Mark Rutland wrote:
> >>>>>>>On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:
> >>>>>>>>On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
> >>>>>>>>>Scheduling-clock interrupts can arrive late in the CPU-offline process,
> 
> [...]
> 
> >>Tested your patch on top of v5.2-rc4* on Arm TC2 (32bit) and CPU
> >>hotplug stress test. W/o your patch, the test fails within seconds
> >>since CPUs are not coming up again. W/ your patch, the test runs for
> >>hours just fine.
> >>
> >>You can add my:
> >>
> >>Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >
> >Thank you!!!
> >
> >>* just for the record: one additional unrelated patch (to disable
> >>the NOR flash) is necessary on Arm TC2:
> >>https://patchwork.kernel.org/patch/10968391 .
> >
> >Is this progressing, or does it also need help getting to mainline?
> 
> This is an unrelated specific issue w/ the TC2 platform which will
> progress independently. Other Arm32 platforms should profit from
> your patch independently of that. I just wanted to mention it here
> in case people try to recreate the test on this specific platform.
> >Left to myself, I will push my patch and assume that the NOR flash patch
> >will make it in its own good time -- or, alternatively, that there is
> >someone better positioned than me to push it.
> 
> IMHO, the best thing is you push your patch.

I just now sent it.  Here is hoping.  ;-)

							Thanx, Paul
