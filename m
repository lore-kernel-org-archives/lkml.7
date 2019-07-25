Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE14C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DDB522BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 12:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbfGYMg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 08:36:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46288 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbfGYMg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 08:36:26 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hqcyn-0004iy-7h; Thu, 25 Jul 2019 14:36:17 +0200
Date:   Thu, 25 Jul 2019 14:36:15 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Nadav Amit <namit@vmware.com>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 1/9] smp: Run functions concurrently in
 smp_call_function_many()
In-Reply-To: <93A98E8B-764F-4E9F-B0B6-FDAABE822B2D@vmware.com>
Message-ID: <alpine.DEB.2.21.1907251404060.1791@nanos.tec.linutronix.de>
References: <20190719005837.4150-1-namit@vmware.com> <20190719005837.4150-2-namit@vmware.com> <20190722182159.GB6698@worktop.programming.kicks-ass.net> <alpine.DEB.2.21.1907222033200.1659@nanos.tec.linutronix.de> <91940019-826C-4F33-904B-0767D95A5E21@vmware.com>
 <alpine.DEB.2.21.1907222045101.1659@nanos.tec.linutronix.de> <93A98E8B-764F-4E9F-B0B6-FDAABE822B2D@vmware.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1554082241-1564058177=:1791"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1554082241-1564058177=:1791
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 22 Jul 2019, Nadav Amit wrote:
> > On Jul 22, 2019, at 11:51 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > void on_each_cpu(void (*func) (void *info), void *info, int wait)
> > {
> >        unsigned long flags;
> > 
> >        preempt_disable();
> > 	smp_call_function(func, info, wait);
> > 
> > smp_call_function() has another preempt_disable as it can be called
> > separately and it does:
> > 
> >        preempt_disable();
> >        smp_call_function_many(cpu_online_mask, func, info, wait);
> > 
> > Your new on_each_cpu() implementation does not. So there is a
> > difference. Whether it matters or not is a different question, but that
> > needs to be explained and documented.
> 
> Thanks for explaining - so your concern is for CPUs being offlined.
> 
> But unless I am missing something: on_each_cpu() calls __on_each_cpu_mask(),
> which disables preemption and calls __smp_call_function_many().
> 
> Then  __smp_call_function_many() runs:
> 
> 	cpumask_and(cfd->cpumask, mask, cpu_online_mask);
> 
> … before choosing which remote CPUs should run the function. So the only
> case that I was missing is if the current CPU goes away and the function is
> called locally.
>
> Can it happen? I can add documentation and a debug assertion for this case.

I don't think it can happen:

  on_each_cpu()
    on_each_cpu_mask(....)
      preempt_disable()
        __smp_call_function_many()

So if a CPU goes offline between on_each_cpu() and preempt_disable() then
there is no damage. After the preempt_disable() it can't go away anymore
and the task executing this cannot be migrated either.

So yes, it's safe, but please add a big fat comment so future readers won't
be puzzled.

Thanks,

	tglx
--8323329-1554082241-1564058177=:1791--
