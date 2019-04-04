Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD47C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8728E217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfDDUmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:42:10 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:46410 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729924AbfDDUmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:42:09 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hC9BU-0001LQ-7N; Thu, 04 Apr 2019 22:42:04 +0200
Date:   Thu, 4 Apr 2019 22:42:03 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Hook, Gary" <Gary.Hook@amd.com>
cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] x86/mm/mem_encrypt: Disable all instrumentation for SME
 early boot code
In-Reply-To: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
Message-ID: <alpine.DEB.2.21.1904042237020.1802@nanos.tec.linutronix.de>
References: <155440965936.6194.3202659723198724589.stgit@sosrh7.amd.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Hook, Gary wrote:

> Enablement of AMD's Secure Memory Encryption feature is determined
> very early in the boot cycle. Part of this procedure involves scanning
> the command line for the paramater 'mem_encrypt'.
> 
> To determine intended state, the function sme_enable() uses library
> functions cmdline_find_option() and strncmp().  Their use occurs early
> enough such that we can't assume that any instrumentation subsystem is
> initialized. For example, making calls to a KASAN-instrumented
> function before KASAN is set up will likely result in the use of
> uninitialized memory and a boot failure.
> 
> Avoid instrumenting these dependent functions by:
> 
> 1) Making a local, static, renamed copy of strncpy() for use solely in
> mem_encrypt_identity.c. In this file we are able to vet its few uses
> and avoid exposing the rest of the kernel to a ubiquitously used but
> un-instrumented function.
> 
> 2) Disable instrumention of arch/x86/lib/cmdline.c based on the
> assumption that the needed function (cmdline_find_option()) is vetted
> through its use to date, and contains no lurking flaws that have not
> yet been found through instrumentation such as KASAN.

Not happy about that :)

> +# SME early boot code checks the cmdline, so don't instrument
> +KCOV_INSTRUMENT_cmdline.o              := n
> +
> +KASAN_SANITIZE_cmdline.o               := n

If we can't come up with a better solution then this needs to depend on
CONFIG_MEM_ENCRYPT so we still can run KASAN on cmdline.c to catch crap
when the code is modified in the future.

Thanks,

	tglx
