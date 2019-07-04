Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2170C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD49E2189E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 23:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="eaggBhFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbfGDXe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 19:34:57 -0400
Received: from mail.efficios.com ([167.114.142.138]:33292 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfGDXe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 19:34:56 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 592AA267EEC;
        Thu,  4 Jul 2019 19:34:55 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 5oFTznazSfaV; Thu,  4 Jul 2019 19:34:54 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DACA2267EE2;
        Thu,  4 Jul 2019 19:34:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DACA2267EE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1562283294;
        bh=CDSR8widGI+xOpyyUk+TWjKxOAyh0/F4/sA39bSn4U0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=eaggBhFjI8B7SYUBopZeVcRzToFU+56rI3hH3CfUiJBBdJmtWoMHXHw/XBILxxxnf
         geFmcD0OBJCu5s7FRbI9oy2Loxnp7G/ybSC6eG2AjCzrJq0XVlZFqj6h31nJfIfiCU
         wJ53F0BxYK47cpq5nK+X1F+ZDgQ/3eTnr1IxH4IxtbOrwjnIauRSVDJkn+ZMKUbSqL
         tvll67wyTF5AvVeu1AH09wlhEP49ueGEp/Wr0bDqjabv4B0XIQKyWKHCO2ES+qoitW
         xjZJa0/uASa/XVO7q1Ia/usm/n6vv2kpn8P7qLUcJqexSg3aqwNPBjral8soFOjJdh
         zkHe7RQ8UtfCw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id Kc9nv4UKOwVf; Thu,  4 Jul 2019 19:34:54 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id C43E0267EDB;
        Thu,  4 Jul 2019 19:34:54 -0400 (EDT)
Date:   Thu, 4 Jul 2019 19:34:54 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Message-ID: <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de> <1987107359.5048.1562273987626.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907042302570.1802@nanos.tec.linutronix.de> <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3809)
Thread-Topic: cpu/hotplug: Cache number of online CPUs
Thread-Index: X6m4RuO1d7NTukM4aWABu4LGgX0TIQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 4, 2019, at 6:33 PM, Thomas Gleixner tglx@linutronix.de wrote:

> On Thu, 4 Jul 2019, Mathieu Desnoyers wrote:
>> ----- On Jul 4, 2019, at 5:10 PM, Thomas Gleixner tglx@linutronix.de wrote:
>> >
>> > num_online_cpus() is racy today vs. CPU hotplug operations as
>> > long as you don't hold the hotplug lock.
>> 
>> Fair point, AFAIU none of the loads performed within num_online_cpus()
>> seem to rely on atomic nor volatile accesses. So not using a volatile
>> access to load the cached value should not introduce any regression.
>> 
>> I'm concerned that some code may rely on re-fetching of the cached
>> value between iterations of a loop. The lack of READ_ONCE() would
>> let the compiler keep a lifted load within a register and never
>> re-fetch, unless there is a cpu_relax() or a barrier() within the
>> loop.
> 
> If someone really wants to write code which can handle concurrent CPU
> hotplug operations and rely on that information, then it's probably better
> to write out:
> 
>     ncpus = READ_ONCE(__num_online_cpus);
> 
> explicitely along with a big fat comment.
> 
> I can't figure out why one wants to do that and how it is supposed to work,
> but my brain is in shutdown mode already :)
> 
> I'd rather write a proper kernel doc comment for num_online_cpus() which
> explains what the constraints are instead of pretending that the READ_ONCE
> in the inline has any meaning.

The other aspect I am concerned about is freedom given to the compiler
to perform the store to __num_online_cpus non-atomically, or the load
non-atomically due to memory pressure. Is that something we should be
concerned about ?

I thought we had WRITE_ONCE and READ_ONCE to take care of that kind of
situation.

The semantic I am looking for here is C11's relaxed atomics.

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
