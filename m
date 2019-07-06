Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F398C5B578
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 23:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D35420830
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 23:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="qu6A8P68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfGFXYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jul 2019 19:24:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:44024 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGFXYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jul 2019 19:24:12 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EF8EF1E8D41;
        Sat,  6 Jul 2019 19:24:10 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id cp2qKWYTZ5-T; Sat,  6 Jul 2019 19:24:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 750481E8D36;
        Sat,  6 Jul 2019 19:24:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 750481E8D36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1562455450;
        bh=P26a3fCCQsDDOkTF1jkuk1uF8WuoT48FVgjeI4H1J1I=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=qu6A8P68T3L21GjZ1Af9XLk0zv7EPtx1MDSckIB1DM+MFEFHi7Jw5E0YvcxK/dViU
         h+eilCvj9eQyTAOw4FkL0yAEAviBzMJO79HWo2Ykqg7a+cLVk9YbSLv5qWjmWg/dTk
         1I4qqhvVs1DmmTJ/f79BOZb0lfn/BlYaVLWx6yVDb2s2NIrdyc+8/7mTchTssXwVoM
         obuoLrYVq/HCwa892m+esyE4IW2dDjeqQhYDs0BwKz0KyQ9YbuXtlqsq99jQ8PZgCz
         v76ERpxWeFzu+bZAn8m5+ZELCuCGv2WEU1JDhhkuBL+8jF9WRvOzUTrrPQ3kYgznPI
         famHBpZ4Q/RVQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id CQU21Ty_Uu_n; Sat,  6 Jul 2019 19:24:10 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 59E951E8D2D;
        Sat,  6 Jul 2019 19:24:10 -0400 (EDT)
Date:   Sat, 6 Jul 2019 19:24:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Nadav Amit <namit@vmware.com>,
        paulmck <paulmck@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Message-ID: <1770596925.11115.1562455450167.JavaMail.zimbra@efficios.com>
In-Reply-To: <alpine.DEB.2.21.1907052256490.3648@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1907042237010.1802@nanos.tec.linutronix.de> <1623929363.5480.1562277655641.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907050024270.1802@nanos.tec.linutronix.de> <611100399.5550.1562283294601.JavaMail.zimbra@efficios.com> <20190705084910.GA6592@gmail.com> <824482130.8027.1562341133252.JavaMail.zimbra@efficios.com> <alpine.DEB.2.21.1907052246220.3648@nanos.tec.linutronix.de> <alpine.DEB.2.21.1907052256490.3648@nanos.tec.linutronix.de>
Subject: Re: [PATCH] cpu/hotplug: Cache number of online CPUs
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF67 (Linux)/8.8.12_GA_3809)
Thread-Topic: cpu/hotplug: Cache number of online CPUs
Thread-Index: SXtuO0HRSYRHBd0Xt5VXgZcrXEsC3w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 5, 2019, at 5:00 PM, Thomas Gleixner tglx@linutronix.de wrote:

> On Fri, 5 Jul 2019, Thomas Gleixner wrote:
>> On Fri, 5 Jul 2019, Mathieu Desnoyers wrote:
>> > ----- On Jul 5, 2019, at 4:49 AM, Ingo Molnar mingo@kernel.org wrote:
>> > > * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> > >> The semantic I am looking for here is C11's relaxed atomics.
>> > > 
>> > > What does this mean?
>> > 
>> > C11 states:
>> > 
>> > "Atomic operations specifying memory_order_relaxed are  relaxed  only  with
>> > respect
>> > to memory ordering.  Implementations must still guarantee that any given atomic
>> > access
>> > to a particular atomic object be indivisible with respect to all other atomic
>> > accesses
>> > to that object."
>> > 
>> > So I am concerned that num_online_cpus() as proposed in this patch
>> > try to access __num_online_cpus non-atomically, and without using
>> > READ_ONCE().
>> >
>> > 
>> > Similarly, the update-side should use WRITE_ONCE(). Protecting with a mutex
>> > does not provide mutual exclusion against concurrent readers of that variable.
>> 
>> Again. This is nothing new. The current implementation of num_online_cpus()
>> has no guarantees whatsoever.
>> 
>> bitmap_hweight() can be hit by a concurrent update of the mask it is
>> looking at.
>> 
>> num_online_cpus() gives you only the correct number if you invoke it inside
>> a cpuhp_lock held section. So why do we need that fuzz about atomicity now?
>> 
>> It's racy and was racy forever and even if we add that READ/WRITE_ONCE muck
>> then it still wont give you a reliable answer unless you hold cpuhp_lock at
>> least for read. So fore me that READ/WRITE_ONCE is just a cosmetic and
>> misleading reality distortion.
> 
> That said. If it makes everyone happy and feel better, I'm happy to add it
> along with a bit fat comment which explains that it's just preventing a
> theoretical store/load tearing issue and does not provide any guarantees
> other than that.

One example where the lack of READ_ONCE() makes me uneasy is found
in drivers/net/wireless/intel/iwlwifi/pcie/trans.c: iwl_pcie_set_interrupt_capa():

static void iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
                                        struct iwl_trans *trans)
{
        struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
        int max_irqs, num_irqs, i, ret;
[...]
        max_irqs = min_t(u32, num_online_cpus() + 2, IWL_MAX_RX_HW_QUEUES);
        for (i = 0; i < max_irqs; i++)
                trans_pcie->msix_entries[i].entry = i;

max_entries is an array of IWL_MAX_RX_HW_QUEUES entries. AFAIU, if the compiler
decides to re-fetch num_online_cpus() for the loop condition after hot-plugging
of a few cpus, we end up doing an out-of bound access to the array.

The scenario would be:

- load __num_online_cpus into a register,
- compare register + 2 to IWL_MAX_RX_HW_QUEUES
  (let's say the current number of cpus is lower that IWL_MAX_RX_HW_QUEUES - 2)
- a few other cpus are brought online,
- compiler decides to re-fetch __num_online_cpus for the loop bound, because
  its value is rightfully assumed to have never changed,
- corruption and sadness follows.

I'm not saying the current compiler implementations actually generate this
for this specific function, but I'm concerned about the fact that they are
within their right to do so. It seems quite fragile to expose a kernel API
which can yield to this kind of subtle bug.

A quick kernel tree grep for both "num_online_cpus" and "min" on the same line
gives 64 results, so it's not an isolated case.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
