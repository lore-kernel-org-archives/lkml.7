Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386EC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B5CA2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 20:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="NNX74Fvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGDU7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 16:59:50 -0400
Received: from mail.efficios.com ([167.114.142.138]:39902 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfGDU7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 16:59:49 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4D94D266903;
        Thu,  4 Jul 2019 16:59:48 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LCrPijhEEOsL; Thu,  4 Jul 2019 16:59:47 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id D70B52668FD;
        Thu,  4 Jul 2019 16:59:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D70B52668FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1562273987;
        bh=vuzmbs+6sYmcAJGMLx4SBDok5g+cqVW2omO6aIKhUQw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NNX74Fvcm1A0IjCnuTGGXBkXJcfYW+MprjzHT7lx9eGhqf7ivwdZo/P7q+5Li3IoC
         cXVU76qCX82dJhVFm2kTMqE6ADSyV8QszBQBv1ED8ppbbHXVCL6lwTf0Oc8VTDfUpX
         dZqBcHzvnq1GJXY/5XB788L4DUkoCbus2L8Ns4VkvYsg3R6/glkWuOHtAMaJbCKY8k
         O/tUe19HDG6PTMKvdk7OLffc2+BMJ9XqT/5EvBLUpCJ6D7Mdojy2601fMhX38tPCVz
         q/VMw+nkZ2TniZWsEsVlQlbwf3ipTsAyodb7vKz70sr7BD7TJmJ8r87E7Y62CRfG1c
         cgQ1eh2Z9/IPQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id cUXNcUe0v83e; Thu,  4 Jul 2019 16:59:47 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id BF63A2668F5;
        Thu,  4 Jul 2019 16:59:47 -0400 (EDT)
Date:   Thu, 4 Jul 2019 16:59:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>
Message-ID: <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3809)
Thread-Topic: cpu/hotplug: Cache number of online CPUs
Thread-Index: Lx5kDbIPo/Sirl5koO5V7KUELm3tDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 4, 2019, at 4:42 PM, Thomas Gleixner tglx@linutronix.de wrote:

> Revaluating the bitmap wheight of the online cpus bitmap in every
> invocation of num_online_cpus() over and over is a pretty useless
> exercise. Especially when num_online_cpus() is used in code pathes like the
> IPI delivery of x86 or the membarrier code.
> 
> Cache the number of online CPUs in the core and just return the cached
> variable.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> include/linux/cpumask.h |   16 +++++++---------
> kernel/cpu.c            |   16 ++++++++++++++++
> 2 files changed, 23 insertions(+), 9 deletions(-)
> 
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -95,8 +95,13 @@ extern struct cpumask __cpu_active_mask;
> #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
> #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
> 
> +extern unsigned int __num_online_cpus;

[...]

> +
> +void set_cpu_online(unsigned int cpu, bool online)
> +{
> +	lockdep_assert_cpus_held();

I don't think it is required that the cpu_hotplug lock is held
when reading __num_online_cpus, right ?

I would have expected the increment/decrement below to be performed
with a WRITE_ONCE(), and use a READ_ONCE() when reading the current
value.

Thanks,

Mathieu

> +
> +	if (online) {
> +		if (!cpumask_test_and_set_cpu(cpu, &__cpu_online_mask))
> +			__num_online_cpus++;
> +	} else {
> +		if (cpumask_test_and_clear_cpu(cpu, &__cpu_online_mask))
> +			__num_online_cpus--;
> +	}
> +}
> +
> /*
>  * Activate the first processor.
>   */

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
