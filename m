Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD6BC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90AC32176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576675557;
	bh=9dtjGIQ5Qoox81UNGfLHKGGtqfpxNpzDQimQEyCVQH0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Xt5MrB148XqRyqV7RuA2Ztd2VxK7nyJmceOWh/D6QlPDskseO42oIn858ShBiI+XF
	 Q6vd8H0z2fIcnc68/NskvTxKiLKDOH0GKEybgdEbeyDEuyAJqny3o4aDxV9CegJSDd
	 iJtVaLZc/InDgO9JAvDg3a2KWpw+WTE5oZ6Uj5oA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfLRNZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 08:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfLRNZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 08:25:55 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10DE2146E;
        Wed, 18 Dec 2019 13:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576675555;
        bh=9dtjGIQ5Qoox81UNGfLHKGGtqfpxNpzDQimQEyCVQH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pnHpjtfQ2mKvo1sD/uItIJF3vGLuPYLsazzOQ+tHdrl6ElZgP5qIhWrS0TLf7PIP+
         lhjWsLgcVV9oOpqgjPkPZccioJhFq5yZHOqwlRaz0tUN+miH11WjT2n5e7AmPy8SHd
         gwgVQsy4ulBglwDaRYrEyQFX8KkwYEnIAC4E2ISU=
Date:   Wed, 18 Dec 2019 22:25:50 +0900
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
Message-Id: <20191218222550.51f0b681de7bbab7e49b09a9@kernel.org>
In-Reply-To: <20191218140622.57bbaca5@xhacker.debian>
References: <20191218140622.57bbaca5@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019 06:21:35 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> KPROBES_ON_FTRACE avoids much of the overhead with regular kprobes as it
> eliminates the need for a trap, as well as the need to emulate or
> single-step instructions.
> 
> Tested on berlin arm64 platform.
> 
> ~ # mount -t debugfs debugfs /sys/kernel/debug/
> ~ # cd /sys/kernel/debug/
> /sys/kernel/debug # echo 'p _do_fork' > tracing/kprobe_events
> 
> before the patch:
> 
> /sys/kernel/debug # cat kprobes/list
> ffffff801009fe28  k  _do_fork+0x0    [DISABLED]
> 
> after the patch:
> 
> /sys/kernel/debug # cat kprobes/list
> ffffff801009ff54  k  _do_fork+0x4    [DISABLED][FTRACE]

BTW, it seems this automatically changes the offset without
user's intention or any warnings. How would you manage if the user
pass a new probe on _do_fork+0x4?

IOW, it is still the question who really wants to probe on
the _do_fork+"0", if kprobes modifies it automatically,
no one can do that anymore.
This can be happen if the user want to record LR or SP value
at the function call for debug. If kprobe always modifies it,
we will lose the way to do it.

Could you remove below function at this moment?

> +kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
> +{
> +	unsigned long addr = kallsyms_lookup_name(name);
> +
> +	if (addr && !offset) {
> +		unsigned long faddr;
> +		/*
> +		 * with -fpatchable-function-entry=2, the first 4 bytes is the
> +		 * LR saver, then the actual call insn. So ftrace location is
> +		 * always on the first 4 bytes offset.
> +		 */
> +		faddr = ftrace_location_range(addr,
> +					      addr + AARCH64_INSN_SIZE);
> +		if (faddr)
> +			return (kprobe_opcode_t *)faddr;
> +	}
> +	return (kprobe_opcode_t *)addr;
> +}
> +
> +bool arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +	return offset <= AARCH64_INSN_SIZE;
> +}


Without this automatic change, we still can change the offset
in upper layer.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
