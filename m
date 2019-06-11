Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C86C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23EEE206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391397AbfFKNz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:55:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46862 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387760AbfFKNz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:55:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5BDrF82006516
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:55:55 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t2dc28vgk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 09:55:53 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 11 Jun 2019 14:55:50 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 11 Jun 2019 14:55:45 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5BDsUrJ35979632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 13:54:30 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0798FB2065;
        Tue, 11 Jun 2019 13:54:30 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE1AEB2064;
        Tue, 11 Jun 2019 13:54:29 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.164.193])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 Jun 2019 13:54:29 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id EC05116C2F18; Tue, 11 Jun 2019 06:54:29 -0700 (PDT)
Date:   Tue, 11 Jun 2019 06:54:29 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        mingo@kernel.org, jpoimboe@redhat.com, mojha@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH HACK RFC] cpu: Prevent late-arriving interrupts from
 disrupting offline
Reply-To: paulmck@linux.ibm.com
References: <20190602011253.GA6167@linux.ibm.com>
 <20190603083848.GB3436@hirez.programming.kicks-ass.net>
 <20190603114455.GA16119@lakrids.cambridge.arm.com>
 <ea4887fb-cc77-59d4-3ba7-a59f5237ca40@arm.com>
 <20190604074549.GP28207@linux.ibm.com>
 <6eb5d59f-37d0-0aab-1fc0-fcf48cc4164f@arm.com>
 <20190608164158.GK28207@linux.ibm.com>
 <16a424d1-0ab7-7e81-5c4f-93da23519b1d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a424d1-0ab7-7e81-5c4f-93da23519b1d@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19061113-0064-0000-0000-000003ECC39D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011246; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01216451; UDB=6.00639598; IPR=6.00997550;
 MB=3.00027261; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-11 13:55:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061113-0065-0000-0000-00003DD9B8A3
Message-Id: <20190611135429.GH28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-11_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906110094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 03:14:54PM +0200, Dietmar Eggemann wrote:
> On 6/8/19 6:41 PM, Paul E. McKenney wrote:
> >On Tue, Jun 04, 2019 at 03:29:32PM +0200, Dietmar Eggemann wrote:
> >>On 6/4/19 9:45 AM, Paul E. McKenney wrote:
> >>>On Mon, Jun 03, 2019 at 03:39:18PM +0200, Dietmar Eggemann wrote:
> >>>>On 6/3/19 1:44 PM, Mark Rutland wrote:
> >>>>>On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:
> >>>>>>On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
> >>>>>>>Scheduling-clock interrupts can arrive late in the CPU-offline process,
> 
> [...]
> 
> >>>And it looks like the reason I dropped it was that I didn't get any
> >>>response from the maintainer.  I sent a message to this effect to
> >>>linux-arm-kernel@lists.infradead.org and linux@arm.linux.org.uk on May
> >>>21, 2015.
> >>>
> >>>So here it is again.  ;-)
> >>>
> >>>I have queued this locally.  Left to myself, I add the two of you on its
> >>>Cc: list and run it through my normal process.  But given the history,
> >>>I would still want either an ack from the maintainer or, better, for
> >>>the maintainer to take the patch.
> >>>
> >>>Or is there a better way for us to proceed on this?
> >>
> >>You could send this patch also to
> >>linux-arm-kernel@lists.infradead.org and cc rmk to get his opinion
> >>on the patch.
> >
> >OK, please let me know how the testing goes.  My thought is to send the
> >patch as you suggest with your Tested-by.
> 
> Tested your patch on top of v5.2-rc4* on Arm TC2 (32bit) and CPU
> hotplug stress test. W/o your patch, the test fails within seconds
> since CPUs are not coming up again. W/ your patch, the test runs for
> hours just fine.
> 
> You can add my:
> 
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thank you!!!

> * just for the record: one additional unrelated patch (to disable
> the NOR flash) is necessary on Arm TC2:
> https://patchwork.kernel.org/patch/10968391 .

Is this progressing, or does it also need help getting to mainline?

Left to myself, I will push my patch and assume that the NOR flash patch
will make it in its own good time -- or, alternatively, that there is
someone better positioned than me to push it.

							Thanx, Paul

