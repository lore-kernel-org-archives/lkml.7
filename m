Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADADC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E3D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbfCYLix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:38:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:45629 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfCYLix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:38:53 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h8Nw5-0001in-2f; Mon, 25 Mar 2019 12:38:37 +0100
Date:   Mon, 25 Mar 2019 12:38:35 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
cc:     Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, x86@kernel.org
Subject: Re: [RESEND PATCH v6 04/12] x86/fsgsbase/64: Enable FSGSBASE
 instructions in the helper functions
In-Reply-To: <1552680405-5265-5-git-send-email-chang.seok.bae@intel.com>
Message-ID: <alpine.DEB.2.21.1903251107300.1798@nanos.tec.linutronix.de>
References: <1552680405-5265-1-git-send-email-chang.seok.bae@intel.com> <1552680405-5265-5-git-send-email-chang.seok.bae@intel.com>
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

On Fri, 15 Mar 2019, Chang S. Bae wrote:

> The helper functions will switch on faster accesses to FSBASE and GSBASE
> when the FSGSBASE feature is enabled.
> 
> Accessing user GSBASE needs a couple of SWAPGS operations. It is avoidable
> if the user GSBASE is saved at kernel entry, being updated as changes, and
> restored back at kernel exit. However, it seems to spend more cycles for
> savings and restorations. Little or no benefit was measured from
> experiments.

This smells fishy and looking at the end result of this series just
confirms it. This ends up being a mixture of SWAPGS and FSGSBASE usage and
as already pointed out in the other reply, it causes inconsistencies.

Let's look at the big picture.

For both variants GS needs to be swapped on kernel entry and on kernel
exit.

1) SWAPGS

   MSR_KERNEL_GS_BASE contains the user space GS when running in the kernel
   and the kernel GS when running in user space.

   SWAPGS is used to swap the content of GS and MSR_KERNEL_GS_BASE on the
   transitions from and to user space.

   On context switch MSR_KERNEL_GS_BASE has to be updated when switching
   between processes.

   User space cannot change GS other than through the PRCTL which updates
   MSR_KERNEL_GS_BASE.

2) FSGSBASE

   User space can set GS without kernel interaction.

   So on user space to kernel space transitions swapping in kernel GS should
   simply do:

     userGS = RDGSBASE()
     WRGSBASE(kernelGS)

   and on the way out:

     WRGSBASE(userGS)

   instead of SWAPGS all over the place.

   userGS is stored in thread_struct, except for the few paranoid
   exceptions which return straight to user space, e.g. NMI. Those can just
   keep it on stack or in a register.

   Context switch does not have to do anything at all vs. GS because
   thread_struct contains the correct value already.

   The PRCTL is straight forward to support. Instead of fiddling with
   MSR_KERNEL_GS_BASE it just updates thread struct.

   I don't see how that's NOT going to be an advantage and I don't see
   either how this seems to cause more cycles for save and restore.

Making it consistently FSGSBASE avoids especially this piece of art in the
context switch path:

        local_irq_save(flags);
        native_swapgs();
        gsbase = rdgsbase();
        native_swapgs();
        local_irq_restore(flags);

along with it's write counterpart.

The whole point of FSGSBASE support is performance, right?

So can please someone explain why having the following in the context
switch path when it can be completely avoided is enhancing performance:

  - 4 x SWAPGS
  - 1 x RDMSR
  - 1 x WRMSR
  - 2 x local_irq_save()
  - 2 x local_irq_restore()

Of course the local_irq_save/restore() pairs are utterly pointless because
switch_to() runs with interrupts disabled already.

SWAPGS instead needs:

  1 x WRMSR

and nothing else.

So trading the single WRMSR against the above in the context switch path is
gaining performance, right?

The only thing which gains performance is user space switching GS. And this
user space performance gain is achieved by:

  - Inconsistent and fragile code with a guarantee for subtle and hard to
    diagnose bugs

  - Pointless overhead in the context switch code

Sorry, not going to happen ever.

Get your act together and make this consistent. Either SWAPGS or FSGSBASE,
but not a mix of it.

Thanks,

	tglx
