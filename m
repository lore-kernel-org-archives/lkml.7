Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866E0C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F46D2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hFiAXPqK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfKNIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:44:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbfKNIoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:44:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dUbZ3iEISBXsb87JG4kpEeTnsib8HLKkTuk0V23bNhM=; b=hFiAXPqKcmsJqgPyXkxxZp8hH
        l2sixI2AQTeFV3mrF5y9vc/Y9z+gQGpFqtgmgPt9yyhCUSM0T57vdHsesi5fTzWtIFRkbgLrLEaHw
        zvLrXDa8yffxrsgYJGazoT9AVqKNQuWgPZJ+MDGRfPRe/oNrt7/E4+ZllwAJK8nMAnqsPF/t4wfDy
        E0QEoViDAkRznp5GJBoSvj1UlwIwqzHpjGuK3uuNTzh9vJLMOLwPCsyg1Or7AqUU/q1Bxdyg01em+
        axEd1eKKWucZuX+XtYd9KXvBDmi+ggRh/KU7XLHRsa8ClnbvAIYl7o0MCy0tTRMUa/CBajYununJA
        7u2e6NvAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iVAjE-0002j6-N1; Thu, 14 Nov 2019 08:43:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7969304637;
        Thu, 14 Nov 2019 09:42:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5D6C629DF1241; Thu, 14 Nov 2019 09:43:45 +0100 (CET)
Date:   Thu, 14 Nov 2019 09:43:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>, Juergen Gross <jgross@suse.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch V3 00/20] x86/iopl: Prevent user space from using CLI/STI
 with iopl(3)
Message-ID: <20191114084345.GK4131@hirez.programming.kicks-ass.net>
References: <20191113204240.767922595@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191113204240.767922595@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 09:42:40PM +0100, Thomas Gleixner wrote:

> iopl(level = 3) enables aside of access to all 65536 I/O ports also the
> usage of CLI/STI in user space.
> 
> Disabling interrupts in user space can lead to system lockups and breaks
> assumptions in the kernel that userspace always runs with interrupts
> enabled.
> 
> iopl() is often preferred over ioperm() as it avoids the overhead of
> copying the tasks I/O bitmap to the TSS bitmap on context switch. This
> overhead can be avoided by providing a all zeroes bitmap in the TSS and
> switching the TSS bitmap offset to this permit all IO bitmap. It's
> marginally slower than iopl() which is a one time setup, but prevents the
> usage of CLI/STI in user space.

> ---
>  arch/x86/Kconfig                        |   18 ++
>  arch/x86/entry/common.c                 |    4 
>  arch/x86/include/asm/io_bitmap.h        |   29 ++++
>  arch/x86/include/asm/paravirt.h         |    4 
>  arch/x86/include/asm/paravirt_types.h   |    2 
>  arch/x86/include/asm/pgtable_32_types.h |    2 
>  arch/x86/include/asm/processor.h        |  113 ++++++++++-------
>  arch/x86/include/asm/ptrace.h           |    6 
>  arch/x86/include/asm/switch_to.h        |   10 +
>  arch/x86/include/asm/thread_info.h      |   14 +-
>  arch/x86/include/asm/xen/hypervisor.h   |    2 
>  arch/x86/kernel/cpu/common.c            |  188 ++++++++++++----------------
>  arch/x86/kernel/doublefault.c           |    2 
>  arch/x86/kernel/ioport.c                |  209 +++++++++++++++++++++-----------
>  arch/x86/kernel/paravirt.c              |    2 
>  arch/x86/kernel/process.c               |  200 ++++++++++++++++++++++++------
>  arch/x86/kernel/process_32.c            |   77 -----------
>  arch/x86/kernel/process_64.c            |   86 -------------
>  arch/x86/kernel/ptrace.c                |   12 +
>  arch/x86/kvm/vmx/vmx.c                  |    8 -
>  arch/x86/mm/cpu_entry_area.c            |    8 +
>  arch/x86/xen/enlighten_pv.c             |   10 -
>  tools/testing/selftests/x86/ioperm.c    |   16 ++
>  tools/testing/selftests/x86/iopl.c      |  129 ++++++++++++++++++-
>  24 files changed, 674 insertions(+), 477 deletions(-)


Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
