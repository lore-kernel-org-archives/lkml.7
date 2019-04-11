Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB2AC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D88D720818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 15:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfDKPmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 11:42:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726391AbfDKPmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 11:42:44 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BFaRWG008630
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:42:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rt6huqqde-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:42:42 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Thu, 11 Apr 2019 16:42:41 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 16:42:39 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BFgcMI35258410
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 15:42:38 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 291C1B2067;
        Thu, 11 Apr 2019 15:42:38 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B0E4B205F;
        Thu, 11 Apr 2019 15:42:38 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.188])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 15:42:37 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 35BC116C36C6; Thu, 11 Apr 2019 08:42:39 -0700 (PDT)
Date:   Thu, 11 Apr 2019 08:42:39 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 0/4] Allow CPU0 to be nohz full
Reply-To: paulmck@linux.ibm.com
References: <20190404120704.18479-1-npiggin@gmail.com>
 <alpine.DEB.2.21.1904041635190.1685@nanos.tec.linutronix.de>
 <1554393113.wbjxx9ccdx.astroid@bobo.none>
 <alpine.DEB.2.21.1904051952160.1802@nanos.tec.linutronix.de>
 <1554800737.v126tflazd.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554800737.v126tflazd.astroid@bobo.none>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19041115-0060-0000-0000-0000032BA1DF
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010909; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000284; SDB=6.01187590; UDB=6.00622081; IPR=6.00968353;
 MB=3.00026395; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-11 15:42:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041115-0061-0000-0000-000048EA0408
Message-Id: <20190411154239.GA29448@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=439 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2019 at 07:21:54PM +1000, Nicholas Piggin wrote:
> Thomas Gleixner's on April 6, 2019 3:54 am:
> > On Fri, 5 Apr 2019, Nicholas Piggin wrote:
> >> Thomas Gleixner's on April 5, 2019 12:36 am:
> >> > On Thu, 4 Apr 2019, Nicholas Piggin wrote:
> >> > 
> >> >> I've been looking at ways to fix suspend breakage with CPU0 as a
> >> >> nohz CPU. I started looking at various things like allowing CPU0
> >> >> to take over do_timer again temporarily or allowing nohz full
> >> >> to be stopped at runtime (that is quite a significant change for
> >> >> little real benefit). The problem then was having the housekeeping
> >> >> CPU go offline.
> >> >> 
> >> >> So I decided to try just allowing the freeze to occur on non-zero
> >> >> CPU. This seems to be a lot simpler to get working, but I guess
> >> >> some archs won't be able to deal with this? Would it be okay to
> >> >> make it opt-in per arch?
> >> > 
> >> > It needs to be opt in. x86 will fall on its nose with that.
> >> 
> >> Okay I can add that.
> >> 
> >> > Now the real interesting question is WHY do we need that at all?
> >> 
> >> Why full nohz for CPU0? Basically this is how their job system was
> >> written and used, testing nohz full was a change that came much later 
> >> as an optimisation.
> >> 
> >> I don't think there is a fundamental reason an equivalent system
> >> could not be made that uses a different CPU for housekeeping, but I
> >> was assured the change would be quite difficult for them.
> >> 
> >> If we can support it, it seems nice if you can take a particular
> >> configuration and just apply nohz_full to your application processors
> >> without any other changes.
> > 
> > This wants an explanation in the patches.
> 
> Okay.
> 
> > And patch 4 has in the changelog:
> > 
> >    nohz_full has been successful at significantly reducing jitter for a
> >    large supercomputer customer, but their job control system requires CPU0
> >    to be for housekeeping.
> > 
> > which just makes me dazed and confused :)
> > 
> > Other than some coherent explanation and making it opt in, I don't think
> > there is a fundamental issue with that.
> 
> I will try to make the changelogs less jibberish then :)

Maybe this is all taken care of now, but do the various clocks stay
synchronized with wall-clock time if all CPUs are in nohz_full mode?
At one time, at least one CPU needed to keep its scheduler-clock
interrupt going in order to keep things in sync.

The ppc timebase register might make it possible to do this without any
scheduler-clock interrupts, but figured I should check.  ;-)

							Thanx, Paul

