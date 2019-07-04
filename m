Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE15C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F98921850
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 22:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="hEkt+Gqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbfGDWA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 18:00:58 -0400
Received: from mail.efficios.com ([167.114.142.138]:33340 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDWA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 18:00:58 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 75A102679A2;
        Thu,  4 Jul 2019 18:00:56 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id HoAB4gGi-vwE; Thu,  4 Jul 2019 18:00:56 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 09DB6267998;
        Thu,  4 Jul 2019 18:00:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 09DB6267998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1562277656;
        bh=sK4acskXsVwFrr2FSyX+3B6hmT9vaAlTyzLaBWFchNg=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hEkt+GqmpTxFsppGCuxTIAQ0Kh1LGeDedrPkSgZbHbGnQma9XDHGYi9dM95VI5LhY
         UvNIoqiMY3MjhOCMt1ZN6XPs3RFTAZnOyLYzi0NiiiyXHBmrcp2a5PfYaWQok+i6xe
         akDx2aE+SwnMQAUUX0EK6qaR+SX8tTubAt5E9pv7OaigS1Ed04rgB5z30nyBHpATwh
         fbCJ/jIp9bkD509g96yVUCQ9WMvZfZ0HXZYjMVmmeyiNmaAV278VUgI5ylltqb1Kk7
         5JYVjjRH24h6cAfn8aVjpl9AAcy/9NacoT0u0eaYMGUcUJ2PPdLdFG38Io1Xgwf69J
         hCxq0ueZYv17g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id PumSh9vEE7eb; Thu,  4 Jul 2019 18:00:55 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id E157A267991;
        Thu,  4 Jul 2019 18:00:55 -0400 (EDT)
Date:   Thu, 4 Jul 2019 18:00:55 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>
Message-ID: <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de> <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3809)
Thread-Topic: cpu/hotplug: Cache number of online CPUs
Thread-Index: Xkq+kd3wh8PE9j8WksSvqaILMan4ow==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 4, 2019, at 5:10 PM, Thomas Gleixner tglx@linutronix.de wrote:

> On Thu, 4 Jul 2019, Mathieu Desnoyers wrote:
> 
>> ----- On Jul 4, 2019, at 4:42 PM, Thomas Gleixner tglx@linutronix.de wrote:
>> 
>> > Revaluating the bitmap wheight of the online cpus bitmap in every
>> > invocation of num_online_cpus() over and over is a pretty useless
>> > exercise. Especially when num_online_cpus() is used in code pathes like the
>> > IPI delivery of x86 or the membarrier code.
>> > 
>> > Cache the number of online CPUs in the core and just return the cached
>> > variable.
>> > 
>> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> > ---
>> > include/linux/cpumask.h |   16 +++++++---------
>> > kernel/cpu.c            |   16 ++++++++++++++++
>> > 2 files changed, 23 insertions(+), 9 deletions(-)
>> > 
>> > --- a/include/linux/cpumask.h
>> > +++ b/include/linux/cpumask.h
>> > @@ -95,8 +95,13 @@ extern struct cpumask __cpu_active_mask;
>> > #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
>> > #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
>> > 
>> > +extern unsigned int __num_online_cpus;
>> 
>> [...]
>> 
>> > +
>> > +void set_cpu_online(unsigned int cpu, bool online)
>> > +{
>> > +	lockdep_assert_cpus_held();
>> 
>> I don't think it is required that the cpu_hotplug lock is held
>> when reading __num_online_cpus, right ?
> 
> Errm, that's the update function. And this is better called from a hotplug
> lock held region and not from some random crappy code.

Sure, this is fine to assume this lock is held for the update.
It's the read-side I'm worried about (which does not hold the lock).

> 
>> I would have expected the increment/decrement below to be performed
>> with a WRITE_ONCE(), and use a READ_ONCE() when reading the current
>> value.
> 
> What for?
> 
> num_online_cpus() is racy today vs. CPU hotplug operations as
> long as you don't hold the hotplug lock.

Fair point, AFAIU none of the loads performed within num_online_cpus()
seem to rely on atomic nor volatile accesses. So not using a volatile
access to load the cached value should not introduce any regression.

I'm concerned that some code may rely on re-fetching of the cached
value between iterations of a loop. The lack of READ_ONCE() would
let the compiler keep a lifted load within a register and never
re-fetch, unless there is a cpu_relax() or a barrier() within the
loop.

Thoughts ?

Thanks,

Mathieu


> 
> Thanks,
> 
> 	tglx

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
