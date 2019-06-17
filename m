Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF53DC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4EE2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 13:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbfFQNHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 09:07:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbfFQNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 09:07:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5HD09mS077636;
        Mon, 17 Jun 2019 09:06:56 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t69mpcmxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jun 2019 09:06:56 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x5HD2nlr017232;
        Mon, 17 Jun 2019 13:06:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma01wdc.us.ibm.com with ESMTP id 2t4ra6ddyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jun 2019 13:06:56 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5HD6sxS18284920
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jun 2019 13:06:54 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E70BB2066;
        Mon, 17 Jun 2019 13:06:54 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1D6EB205F;
        Mon, 17 Jun 2019 13:06:53 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.85.132.58])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jun 2019 13:06:53 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5A87016C17E5; Mon, 17 Jun 2019 06:06:57 -0700 (PDT)
Date:   Mon, 17 Jun 2019 06:06:57 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux@arm.linux.org.uk, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH arm] Use common outgoing-CPU-notification code
Message-ID: <20190617130657.GL26519@linux.ibm.com>
Reply-To: paulmck@linux.ibm.com
References: <20190611192410.GA27930@linux.ibm.com>
 <20190617115809.GA3767@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617115809.GA3767@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-17_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906170119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 12:58:19PM +0100, Mark Rutland wrote:
> On Tue, Jun 11, 2019 at 12:24:10PM -0700, Paul E. McKenney wrote:
> > This commit removes the open-coded CPU-offline notification with new
> > common code.  In particular, this change avoids calling scheduler code
> > using RCU from an offline CPU that RCU is ignoring.  This is a minimal
> > change.  A more intrusive change might invoke the cpu_check_up_prepare()
> > and cpu_set_state_online() functions at CPU-online time, which would
> > allow onlining throw an error if the CPU did not go offline properly.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> FWIW:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> On the assumption that Russell is ok with this, I think this should be
> dropped into the ARM patch system [1].
> 
> Paul, are you familiar with that, or would you prefer that someone else
> submits the patch there? I can do so if you'd like.

I never have used this system, so please do drop it in there!  Let me
know when you have done so, and I will then drop it from -rcu.

							Thanx, Paul

> Thanks,
> Mark.
> 
> [1] https://www.armlinux.org.uk/developer/patches/info.php
> 
> > 
> > diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> > index ebc53804d57b..8687d619260f 100644
> > --- a/arch/arm/kernel/smp.c
> > +++ b/arch/arm/kernel/smp.c
> > @@ -267,15 +267,13 @@ int __cpu_disable(void)
> >  	return 0;
> >  }
> >  
> > -static DECLARE_COMPLETION(cpu_died);
> > -
> >  /*
> >   * called on the thread which is asking for a CPU to be shutdown -
> >   * waits until shutdown has completed, or it is timed out.
> >   */
> >  void __cpu_die(unsigned int cpu)
> >  {
> > -	if (!wait_for_completion_timeout(&cpu_died, msecs_to_jiffies(5000))) {
> > +	if (!cpu_wait_death(cpu, 5)) {
> >  		pr_err("CPU%u: cpu didn't die\n", cpu);
> >  		return;
> >  	}
> > @@ -322,7 +320,7 @@ void arch_cpu_idle_dead(void)
> >  	 * this returns, power and/or clocks can be removed at any point
> >  	 * from this CPU and its cache by platform_cpu_kill().
> >  	 */
> > -	complete(&cpu_died);
> > +	(void)cpu_report_death();
> >  
> >  	/*
> >  	 * Ensure that the cache lines associated with that completion are
> > 
> 
