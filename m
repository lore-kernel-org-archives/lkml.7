Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B59C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 859E820665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 10:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbfGOKfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 06:35:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47279 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbfGOKfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 06:35:45 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hmyKU-0001Va-Vz; Mon, 15 Jul 2019 12:35:35 +0200
Date:   Mon, 15 Jul 2019 12:35:33 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Mike Lothian <mike@fireburn.co.uk>
cc:     thomas.lendacky@amd.com, bhe@redhat.com,
        Borislav Petkov <bp@alien8.de>, dave.hansen@linux.intel.com,
        lijiang@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>
Subject: Re: [PATCH v3 1/2] x86/mm: Identify the end of the kernel area to
 be reserved
In-Reply-To: <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1907151140080.1669@nanos.tec.linutronix.de>
References: <7db7da45b435f8477f25e66f292631ff766a844c.1560969363.git.thomas.lendacky@amd.com> <20190713145909.30749-1-mike@fireburn.co.uk> <alpine.DEB.2.21.1907141215350.1669@nanos.tec.linutronix.de> <CAHbf0-EPfgyKinFuOP7AtgTJWVSVqPmWwMSxzaH=Xg-xUUVWCA@mail.gmail.com>
 <alpine.DEB.2.21.1907151011590.1669@nanos.tec.linutronix.de> <CAHbf0-F9yUDJ=DKug+MZqsjW+zPgwWaLUC40BLOsr5+t4kYOLQ@mail.gmail.com> <alpine.DEB.2.21.1907151118570.1669@nanos.tec.linutronix.de>
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

On Mon, 15 Jul 2019, Thomas Gleixner wrote:
> On Mon, 15 Jul 2019, Mike Lothian wrote:
> > That build failure is from the current tip of Linus's tree
> > If the fix is in, then it hasn't fixed the issue
> 
> The reverted commit caused a build fail with gold as well. Let me stare at
> your issue.

So with gold the build fails in the reloc tool complaining about that
relocation:

  Invalid absolute R_X86_64_32S relocation: __end_of_kernel_reserve

The commit does:
 
+extern char __end_of_kernel_reserve[];
+
 
 void __init setup_arch(char **cmdline_p)
 {
+	/*
+	 * Reserve the memory occupied by the kernel between _text and
+	 * __end_of_kernel_reserve symbols. Any kernel sections after the
+	 * __end_of_kernel_reserve symbol must be explicitly reserved with a
+	 * separate memblock_reserve() or they will be discarded.
+	 */
 	memblock_reserve(__pa_symbol(_text),
-			 (unsigned long)__bss_stop - (unsigned long)_text);
+			 (unsigned long)__end_of_kernel_reserve - (unsigned long)_text);

So it replaces __bss_stop with __end_of_kernel_reserve here.

--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -368,6 +368,14 @@ SECTIONS
 		__bss_stop = .;
 	}
 
+	/*
+	 * The memory occupied from _text to here, __end_of_kernel_reserve, is
+	 * automatically reserved in setup_arch(). Anything after here must be
+	 * explicitly reserved using memblock_reserve() or it will be discarded
+	 * and treated as available memory.
+	 */
+	__end_of_kernel_reserve = .;

And from the linker script __bss_stop and __end_of_kernel_reserve are
exactly the same. From System.map (of a successful ld build):

ffffffff82c00000 B __brk_base
ffffffff82c00000 B __bss_stop
ffffffff82c00000 B __end_bss_decrypted
ffffffff82c00000 B __end_of_kernel_reserve
ffffffff82c00000 B __start_bss_decrypted
ffffffff82c00000 B __start_bss_decrypted_unused

So how on earth can gold fail with that __end_of_kernel_reserve change?

For some unknown reason it turns that relocation into an absolute
one. That's clearly a gold bug^Wfeature and TBH, I'm more than concerned
about that kind of behaviour.

If we just revert that commit, then what do we achieve? We paper over the
underlying problem, which is not really helping anything.

Aside of that gold still fails to build the X32 VDSO and it does so for a
very long time....

Until we really understand what the problem is, this stays as is.

@H.J.: Any insight on that?

Thanks,

	tglx



