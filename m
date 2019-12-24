Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E445C2D0D2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A95920643
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 10:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577182164;
	bh=OcYvU6R9hPJgmJg3UwAfVCin1mEXqh7FP8N9hsHQNeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fAl/xk5F4lrANl6I6Q2cXgvXS3PGJcqhfrtexDkuv9OnvqySlifkFcDpOxj07PtEy
	 oBMFhQL0/Smv18GbCSKtGi+2jxDIy1vMQyxVcHNpDSUbBUhCKtUoc/vMWUO2OmTQvB
	 WZkth1XIxVSiBa9a3XWbwFOmhI4CtyiQCfBykISw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfLXKJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 05:09:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbfLXKJX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 05:09:23 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EAF72071A;
        Tue, 24 Dec 2019 10:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577182161;
        bh=OcYvU6R9hPJgmJg3UwAfVCin1mEXqh7FP8N9hsHQNeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X8ogjSxmBHca5nsL5BInqifxvj7nOhyh902O2b0NIdrXPscb+r1ItHnf9hJoLzZAv
         L9q7c04rXqWTvPYBsAVWDiyIXedtoYN+67rSjcq52yqNI50HL88+uCnLSaNFE3+I5Y
         ztzJ8syVplerh7dv0AfnWbgdi+rci75L2/USw358=
Date:   Tue, 24 Dec 2019 19:09:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6] arm64: implement KPROBES_ON_FTRACE
Message-Id: <20191224190916.2e47478445fb179e88f60cc3@kernel.org>
In-Reply-To: <20191223153300.30281a93@xhacker.debian>
References: <20191218140622.57bbaca5@xhacker.debian>
        <20191218222550.51f0b681de7bbab7e49b09a9@kernel.org>
        <20191223153300.30281a93@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Mon, 23 Dec 2019 07:47:24 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Hi Masami,
> 
> On Wed, 18 Dec 2019 22:25:50 +0900 Masami Hiramatsu wrote:
> 
> 
> > 
> > 
> > On Wed, 18 Dec 2019 06:21:35 +0000
> > Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> > 
> > > KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
> > > eliminates the need for a trap, as well as the need to emulate or
> > > single-step instructions.
> > >
> > > Tested on berlin arm64 platform.
> > >
> > > ~ # mount -t debugfs debugfs /sys/kernel/debug/
> > > ~ # cd /sys/kernel/debug/
> > > /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
> > >
> > > before the patch:
> > >
> > > /sys/kernel/debug # cat kprobes/list
> > > ffffff801009fe28  k  _do_fork+0x0    [DISABLED]
> > >
> > > after the patch:
> > >
> > > /sys/kernel/debug # cat kprobes/list
> > > ffffff801009ff54  k  _do_fork+0x4    [DISABLED][FTRACE]  
> > 
> > BTW, it seems this automatically changes the offset without
> > user's intention or any warnings. How would you manage if the user
> > pass a new probe on _do_fork+0x4?
> 
> In current implementation, two probes at the same address _do_fork+0x4

OK, that is my point.

> > IOW, it is still the question who really wants to probe on
> > the _do_fork+"0", if kprobes modifies it automatically,
> > no one can do that anymore.
> > This can be happen if the user want to record LR or SP value
> > at the function call for debug. If kprobe always modifies it,
> > we will lose the way to do it.
> 
> arm64's DYNAMIC_FTRACE_WITH_REGS implementation makes use of GCC
> -fpatchable-function-entry=2 option to insert two nops. When the function
> is traced, the first nop will be modified to the LR saver, then the
> second nop to "bl <ftrace-entry>", commit 3b23e4991fb6("
> arm64: implement ftrace with regs") explains the mechanism.

So both of the instruction at func+0 and func+4 are replaced.

> So on arm64(in fact any arch makes use of -fpatchable-function-entry will
> behave similarly), when DYNAMIC_FTRACE_WITH_REGS is enabled, the ftrace location
> is always on the first 4 bytes offset.
> 
> I think when users want to register a kprobe on _do_fork+0, what he really want
> is to kprobe on the patched(by -fpatchable-function-entry)_do_fork+4

OK, in this case, kprobe should treat the first 2 instructions as a
single virtual instruction. This means,

 - kprobes can probe func+0, but not func+4 if the function is ftraced.
    (-EILSEQ must be returned)
 - both debugfs/kprobes/list and tracefs/kprobe_events should show the
   probed address as func+0. Not func+4.

Then, user can use kprobes as if there is one big (8-byte) instruction
at the entry of the function. Since probing on func+4 is rejected and
the call-site LR/SP is restored in ftrace, there should be no
contradiction. It should work as if we put a breakpoint on the func + 0.

> 
> PS: per my understanding, powerpc's kprobes_on_ftrace also introduces an
> extra automatic offset due to its implementation.

Uh, that is also ugly.... must be fixed.


> > 
> > Could you remove below function at this moment?
> > 
> > > +kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
> > > +{
> > > +     unsigned long addr = kallsyms_lookup_name(name);
> > > +
> > > +     if (addr && !offset) {
> > > +             unsigned long faddr;
> > > +             /*
> > > +              * with -fpatchable-function-entry=2, the first 4 bytes is the
> > > +              * LR saver, then the actual call insn. So ftrace location is
> > > +              * always on the first 4 bytes offset.
> > > +              */
> > > +             faddr = ftrace_location_range(addr,
> > > +                                           addr + AARCH64_INSN_SIZE);
> > > +             if (faddr)
> > > +                     return (kprobe_opcode_t *)faddr;
> > > +     }
> > > +     return (kprobe_opcode_t *)addr;
> > > +}
> > > +
> > > +bool arch_kprobe_on_func_entry(unsigned long offset)
> > > +{
> > > +     return offset <= AARCH64_INSN_SIZE;
> > > +}  
> > 
> > 
> > Without this automatic change, we still can change the offset
> > in upper layer.
> 
> If remove the two functions, kprobe on  _do_fork can't ride on
> ftrace infrastructure, but kprobe on _do_fork+4 can. I'm not sure
> whether this is reasonable. Every kprobe users on arm64 will need to
> remember to pass an extra offset +4 to make use of kprobe_on_ftrace, could
> we hide the "+4"?

Yes, OK, as I said above, please hide +4. We will see the virtual
"call" instruction (= "mov x9, lr; br <addr>") at the entry of ftraced
function. :)

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
