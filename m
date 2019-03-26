Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB146C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD4A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731382AbfCZInr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:43:47 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47630 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730795AbfCZInq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:43:46 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8hgH-0000K7-T3; Tue, 26 Mar 2019 09:43:38 +0100
Date:   Tue, 26 Mar 2019 09:43:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Saidi, Ali" <alisaidi@amazon.com>
cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Liguori, Anthony" <aliguori@amazon.com>
Subject: Re: [PATCH 2/2] x86/mmap: handle worst-case heap randomization in
 mmap_base
In-Reply-To: <037ACE94-A408-4CB0-BCA5-3FF9041E43B0@amazon.com>
Message-ID: <alpine.DEB.2.21.1903260942370.1789@nanos.tec.linutronix.de>
References: <20190312173248.13490-1-alisaidi@amazon.com> <20190312173248.13490-3-alisaidi@amazon.com> <alpine.DEB.2.21.1903211508440.1784@nanos.tec.linutronix.de> <037ACE94-A408-4CB0-BCA5-3FF9041E43B0@amazon.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1317506103-1553589817=:1789"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1317506103-1553589817=:1789
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 26 Mar 2019, Saidi, Ali wrote:
> ﻿On 3/21/19, 9:11 AM, "linux-arm-kernel on behalf of Thomas Gleixner" <linux-arm-kernel-bounces@lists.infradead.org on behalf of tglx@linutronix.de> wrote:
> 
>     On Tue, 12 Mar 2019, Ali Saidi wrote:
>     
>     > Increase mmap_base by the worst-case brk randomization so that
>     > the stack and heap remain apart.
>     > 
>     > In Linux 4.13 a change was committed that special cased the kernel ELF
>     > loader when the loader is invoked directly (eab09532d400; binfmt_elf: use
>     > ELF_ET_DYN_BASE only for PIE). Generally, the loader isn’t invoked
>     > directly and this issue is limited to cases where it is, (e.g to set a
>     > non-inheritable LD_LIBRARY_PATH, testing new versions of the loader). In
>     > those rare cases, the loader doesn't take into account the amount of brk
>     > randomization that will be applied by arch_randomize_brk(). This can
>     > lead to the stack and heap being arbitrarily close to each other.
>     
>     That explains not why you need this change. What's the consequence of them
>     being close to each other?
>
> The process doesn't get it's requested stack size and stack allocations
> could end up scribbling on the heap.

And exactly that information wants to be in the changelog.

Thanks,

	tglx
--8323329-1317506103-1553589817=:1789--
