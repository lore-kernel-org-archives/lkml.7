Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3C6C606BD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A5321670
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfGHOHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:07:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727401AbfGHOHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:07:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68E6sLS050193
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 10:07:34 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm6q79ps5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:07:34 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 8 Jul 2019 15:07:32 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 15:07:30 +0100
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68E7THf46596450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 14:07:29 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1788B206A;
        Mon,  8 Jul 2019 14:07:28 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4A88B2067;
        Mon,  8 Jul 2019 14:07:28 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.26])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 14:07:28 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 321DE16C1D35; Mon,  8 Jul 2019 07:07:32 -0700 (PDT)
Date:   Mon, 8 Jul 2019 07:07:32 -0700
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH V2] cpu/hotplug: Cache number of online CPUs
Reply-To: paulmck@linux.ibm.com
References: <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de>
 <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de>
 <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com>
 <20190705084910.GA6592@gmail.com>
 <824482130.8027.1562341133252.JavaMail.zimbra@efficios.com>
 <alpine.DEB.2.21.1907052246220.3648@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907052256490.3648@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1907081531560.4709@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907081531560.4709@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 19070814-0060-0000-0000-0000035A5118
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011395; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01229232; UDB=6.00647365; IPR=6.01010491;
 MB=3.00027632; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-08 14:07:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070814-0061-0000-0000-00004A0EB23A
Message-Id: <20190708140732.GI26519@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080176
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 03:43:55PM +0200, Thomas Gleixner wrote:
> Revaluating the bitmap wheight of the online cpus bitmap in every

s/wheight/weight/?

> invocation of num_online_cpus() over and over is a pretty useless
> exercise. Especially when num_online_cpus() is used in code pathes like the
> IPI delivery of x86 or the membarrier code.
> 
> Cache the number of online CPUs in the core and just return the cached
> variable.

I do like this and the comments on limited guarantees make sense.
One suggestion for saving a few lines below, but either way:

Acked-by: Paul E. McKenney <paulmck@linux.ibm.com>

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Use READ/WRITE_ONCE() and add comment what it actually achieves. Remove
>     the bogus lockdep assert in the write path as the caller cannot hold the
>     lock. It's a task on the plugged CPU which is not the controlling task.
> ---
>  include/linux/cpumask.h |   26 +++++++++++++++++---------
>  kernel/cpu.c            |   22 ++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 9 deletions(-)
> 
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -95,8 +95,23 @@ extern struct cpumask __cpu_active_mask;
>  #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
>  #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
>  
> +extern unsigned int __num_online_cpus;
> +
>  #if NR_CPUS > 1
> -#define num_online_cpus()	cpumask_weight(cpu_online_mask)
> +/**
> + * num_online_cpus() - Read the number of online CPUs
> + *
> + * READ_ONCE() protects against theoretical load tearing and prevents
> + * the compiler from reloading the value in a function or loop.
> + *
> + * Even with that, this interface gives only a momentary snapshot and is
> + * not protected against concurrent CPU hotplug operations unless invoked
> + * from a cpuhp_lock held region.
> + */
> +static inline unsigned int num_online_cpus(void)
> +{
> +	return READ_ONCE(__num_online_cpus);
> +}
>  #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
>  #define num_present_cpus()	cpumask_weight(cpu_present_mask)
>  #define num_active_cpus()	cpumask_weight(cpu_active_mask)
> @@ -805,14 +820,7 @@ set_cpu_present(unsigned int cpu, bool p
>  		cpumask_clear_cpu(cpu, &__cpu_present_mask);
>  }
>  
> -static inline void
> -set_cpu_online(unsigned int cpu, bool online)
> -{
> -	if (online)
> -		cpumask_set_cpu(cpu, &__cpu_online_mask);
> -	else
> -		cpumask_clear_cpu(cpu, &__cpu_online_mask);
> -}
> +void set_cpu_online(unsigned int cpu, bool online);
>  
>  static inline void
>  set_cpu_active(unsigned int cpu, bool active)
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -2288,6 +2288,9 @@ EXPORT_SYMBOL(__cpu_present_mask);
>  struct cpumask __cpu_active_mask __read_mostly;
>  EXPORT_SYMBOL(__cpu_active_mask);
>  
> +unsigned int __num_online_cpus __read_mostly;
> +EXPORT_SYMBOL(__num_online_cpus);
> +
>  void init_cpu_present(const struct cpumask *src)
>  {
>  	cpumask_copy(&__cpu_present_mask, src);
> @@ -2303,6 +2306,25 @@ void init_cpu_online(const struct cpumas
>  	cpumask_copy(&__cpu_online_mask, src);
>  }
>  
> +void set_cpu_online(unsigned int cpu, bool online)
> +{
> +	int adj = 0;
> +
> +	if (online) {
> +		if (!cpumask_test_and_set_cpu(cpu, &__cpu_online_mask))
> +			adj = 1;
> +	} else {
> +		if (cpumask_test_and_clear_cpu(cpu, &__cpu_online_mask))
> +			adj = -1;
> +	}
> +	/*
> +	 * WRITE_ONCE() protects only against the theoretical stupidity of
> +	 * a compiler to tear the store, but won't protect readers which
> +	 * are not serialized against concurrent hotplug operations.
> +	 */
> +	WRITE_ONCE(__num_online_cpus, __num_online_cpus + adj);

	WRITE_ONCE(__num_online_cpus, cpumask_weight(__cpu_online_mask));

Then "adj" can be dispensed with, and the old non-value-returning atomic
updates can be used on __cpu_online_mask.  Or is someone now depending
on full ordering from set_cpu_online() or some such?

> +}
> +
>  /*
>   * Activate the first processor.
>   */
> 

