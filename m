Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F256AC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F36217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DUU3S6K9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbfDEJ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:27:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52586 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbfDEJ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rmRDRrrBXgpiFDAiERO2uKmXa8X/tU5EIcxD32jyuDU=; b=DUU3S6K9fk2LZLZBwYd5G85s8
        7hRxUH82o2RVAFEieQaA4AH/uYBqBwEHED+NuJYdHChfKUaknh2DFRQvt1M/OQOxnJed+rhUzcaXA
        uRgV6uG+PD2cujVzlPmqUhhECEM/+sokRGk/9w5+/9JG5I6tZ6im8P6ldl5lcds0K2ju8bq4zN8oH
        9LWQ00e7x15kXO+RarWC2WRvOs7ws8Fiq75lutv/WNxZ/Eo6Ag7WoHRmhmvK9inqxUT+QeZk42pSO
        gXM2fAChDo2k2BgH2/tYr0KiumGTedf6NOfYqzdk5Kgb3mX1/6cPZ2OaIAGR/CcTK3vXtUgQK9kKU
        96oPRNJ6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hCL7j-0007KR-1H; Fri, 05 Apr 2019 09:26:59 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A9C7200BB74D; Fri,  5 Apr 2019 11:26:57 +0200 (CEST)
Date:   Fri, 5 Apr 2019 11:26:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH] sched/core: expand sched_getaffinity(2) to return number
 of CPUs
Message-ID: <20190405092657.GD4038@hirez.programming.kicks-ass.net>
References: <20190403200809.GA13876@avx2>
 <20190404084249.GS4038@hirez.programming.kicks-ass.net>
 <20190404180230.GA14800@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404180230.GA14800@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2019 at 09:02:30PM +0300, Alexey Dobriyan wrote:
> On Thu, Apr 04, 2019 at 10:42:49AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 03, 2019 at 11:08:09PM +0300, Alexey Dobriyan wrote:
> > > Currently there is no easy way to get the number of CPUs on the system.
> > 
> > And this patch doesn't change that :-)
> 
> It does! Application or a library could do one idempotent system call
> in a constructor.

You said: "get the number of CPUs on the system", but what this call
actually returns is: "size of CPU bitmask", these two things are
distinctly not the same.

> > The point is that nr_cpu_ids is the length of the bitmap, but does not
> > contain information on how many CPUs are in the system. Consider the
> > case where the bitmap is sparse.
> 
> I understand that but how do you ship number of CPUs _and_ possible mask
> in one go?

You don't, possible mask is unrelated to number of CPUs and both are
unrelated to bitmap size.

In particular:

  nr_cpus <= nr_possible_cpus <= nr_cpumask_bits

In absurdum an architecture could choose to iterate its CPUs as
1024*cpuid, just for giggles. Then suppose it has two sockets, and 16
CPUs per socket and only the second socket is populated.

The we get:

  nr_cpumask_bits = 32k
  nr_possible_cpus = 32
  nr_cpus = 16

see what I mean?

Now, luckily we typically don't have crap like that, but I suspect that
with a little creative ACPI table magic we could actually get something
slightly less absurd but still non-trivial even on x86.

Also see how num_possible_cpus() is defined as
cpumask_weight(cpu_possible_mask), which is very much not nr_cpu_ids in
the generic case.

> > > Nobody seems to parse "/sys/devices/system/cpu/possible".
> > > Even if someone does, parsing sysfs is much slower than necessary.
> > 
> > True; but I suppose glibc already does lots of that anyway, right? It
> > does contain the right information.
> 
> sched_getaffinity(3) does sched_getaffinity(2) + memset()
> 
> sysconf(_SC_NPROCESSORS_ONLN) does "/sys/devices/system/cpu/online"
> 
> sysconf(_SC_NPROCESSORS_CONF) does readdir("/sys/devices/system/cpu")
> which is 5 syscalls. I'm not sure which cpumask readdir represents.

It counts the number of CPUs, which is strictly not the same as the
bitmap size.

