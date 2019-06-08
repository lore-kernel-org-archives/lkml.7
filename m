Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87DFC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB9E212F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 16:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfFHQmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 12:42:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727203AbfFHQmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 12:42:03 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x58Gfg4W026299
        for <linux-kernel@vger.kernel.org>; Sat, 8 Jun 2019 12:42:01 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t096ubwat-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 12:42:01 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Sat, 8 Jun 2019 17:42:01 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 8 Jun 2019 17:41:57 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x58Gfu0g37618132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 8 Jun 2019 16:41:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE875B206B;
        Sat,  8 Jun 2019 16:41:56 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF628B2068;
        Sat,  8 Jun 2019 16:41:56 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.180.36])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat,  8 Jun 2019 16:41:56 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9610616C2E2C; Sat,  8 Jun 2019 09:41:58 -0700 (PDT)
Date:   Sat, 8 Jun 2019 09:41:58 -0700
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eb5d59f-37d0-0aab-1fc0-fcf48cc4164f@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19060816-0064-0000-0000-000003EB991C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011234; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01215077; UDB=6.00638768; IPR=6.00996168;
 MB=3.00027235; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-08 16:42:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060816-0065-0000-0000-00003DCEDB3C
Message-Id: <20190608164158.GK28207@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-08_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906080126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 03:29:32PM +0200, Dietmar Eggemann wrote:
> On 6/4/19 9:45 AM, Paul E. McKenney wrote:
> >On Mon, Jun 03, 2019 at 03:39:18PM +0200, Dietmar Eggemann wrote:
> >>On 6/3/19 1:44 PM, Mark Rutland wrote:
> >>>On Mon, Jun 03, 2019 at 10:38:48AM +0200, Peter Zijlstra wrote:
> >>>>On Sat, Jun 01, 2019 at 06:12:53PM -0700, Paul E. McKenney wrote:
> >>>>>Scheduling-clock interrupts can arrive late in the CPU-offline process,
> 
> [...]
> 
> >>>   05981277a4de1ad6 ("arm64: Use common outgoing-CPU-notification code")
> >>>
> >>>... but it looks like Paul's patch to do so [1] fell through the cracks;
> >>>I'm not aware of any reason that shouldn't have been taken.
> >>>[1] https://lore.kernel.org/lkml/1431467407-1223-8-git-send-email-paulmck@linux.vnet.ibm.com/
> >>>
> >>>Paul, do you want to resend that?
> >>
> >>Please do. We're carrying this patch out-of-tree for while now in
> >>our EAS integration to get cpu hotplug tests passing on TC2 (arm).
> >
> >Huh.  It still applies.  But I have no means of testing it.
> 
> We can do the testing part on our TC2 platform, i.e. we're testing
> it with each of our EAS mainline integration right now.
> 
> https://developer.arm.com/tools-and-software/open-source-software/linux-kernel/energy-aware-scheduling/eas-mainline-development
> 
> http://linux-arm.org/git?p=linux-power.git;a=commit;h=8cd16f1dc2cd896a0b1e2010b4992b33fdc11fe0
> 
> >And it looks like the reason I dropped it was that I didn't get any
> >response from the maintainer.  I sent a message to this effect to
> >linux-arm-kernel@lists.infradead.org and linux@arm.linux.org.uk on May
> >21, 2015.
> >
> >So here it is again.  ;-)
> >
> >I have queued this locally.  Left to myself, I add the two of you on its
> >Cc: list and run it through my normal process.  But given the history,
> >I would still want either an ack from the maintainer or, better, for
> >the maintainer to take the patch.
> >
> >Or is there a better way for us to proceed on this?
> 
> You could send this patch also to
> linux-arm-kernel@lists.infradead.org and cc rmk to get his opinion
> on the patch.

OK, please let me know how the testing goes.  My thought is to send the
patch as you suggest with your Tested-by.

							Thanx, Paul

