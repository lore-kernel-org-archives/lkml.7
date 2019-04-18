Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DB6C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0785C214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 08:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbfDRIR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 04:17:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:32858 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfDRIR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 04:17:26 -0400
Received: from pd9ef12d2.dip0.t-ipconnect.de ([217.239.18.210] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hH2EU-0000hD-O7; Thu, 18 Apr 2019 10:17:22 +0200
Date:   Thu, 18 Apr 2019 10:17:21 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Kees Cook <keescook@chromium.org>
cc:     Hector Marco-Gisbert <hecmargi@upv.es>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Huaitong Han <huaitong.han@intel.com>,
        Ismael Ripoll Ripoll <iripoll@upv.es>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] x86_64: Disabling read-implies-exec when the stack is
 executable
In-Reply-To: <CAGXu5jLZ-DgTfokLTqUHOUphO4C1FwHgYDLTA1oB9HBHnH-a1Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904181015270.3174@nanos.tec.linutronix.de>
References: <1462963502-11636-1-git-send-email-hecmargi@upv.es> <CAGXu5jLZ-DgTfokLTqUHOUphO4C1FwHgYDLTA1oB9HBHnH-a1Q@mail.gmail.com>
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

On Thu, 18 Apr 2019, Kees Cook wrote:
> On Wed, May 11, 2016 at 5:45 AM Hector Marco-Gisbert <hecmargi@upv.es> wrote:
> *thread necromancy*
> 
> I'd still like to see this get landed. READ_IMPLIES_EXEC is way too
> powerful (it impacts, for example, mmap() regions of device driver
> memory, forcing drivers to not be able to disallow VM_EXEC[1]).
> 
> The only case it could break is on an AMD K8 (Athlon only, I assume?),
> which seems unlikely to have a modern kernel run on it. If there is
> still concern, then we could just test against the NX CPU feature:
> 
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 69c0f892e310..367cd36259a4 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -280,10 +280,12 @@ extern u32 elf_hwcap2;
> 
>  /*
>   * An executable for which elf_read_implies_exec() returns TRUE will
> - * have the READ_IMPLIES_EXEC personality flag set automatically.
> + * have the READ_IMPLIES_EXEC personality flag set automatically when
> + * a CPU did not support NX or is using a 32-bit memory layout.
>   */
> -#define elf_read_implies_exec(ex, executable_stack)    \
> -       (executable_stack != EXSTACK_DISABLE_X)
> +#define elf_read_implies_exec(ex, executable_stack)            \
> +       (mmap_is_ia32() || !(__supported_pte_mask & _PAGE_NX) ? \

What's special about ia32? All what matters is whether PAGE_NX is supported
or not. That has nothing to do with 32/64bit unless I'm missing something
(as usual).

Thanks,

	tglx
