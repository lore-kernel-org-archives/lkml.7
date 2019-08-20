Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8132C3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9978B22CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 00:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566259298;
	bh=Dygb+76S30NlTIz0E98ZuWWzV7OGS2DSaQKUzrhuObs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ANKSawLo6hTULSTo5Bv/bnvzPx0kVXY9z6g/2gofo3KgR8siQCHcqaSWfJo1IBkyV
	 cuhZ7zPVt7V4+U3q27a052/fQypcDNQPxLIuNt8z0z7MFw9CA30Y09SpolOu57/cW6
	 cYQJ69OF48s1MjomAJl8JEEFP3PUb8kUYpuuPakI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbfHTABh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 20:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbfHTABh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 20:01:37 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 472E82082F;
        Tue, 20 Aug 2019 00:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566259296;
        bh=Dygb+76S30NlTIz0E98ZuWWzV7OGS2DSaQKUzrhuObs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FRsrIwP79+XwJmcnEAvDLzIWZSmxMclwruPxmhgmjRCdJSaHwtKzRLl0WWC7CRXRK
         95gazBM+n2Es4NcakK9McZLYoxqKpcDYTUyQQMkQxKvFGo1IKgusw0QFJndCBU9jVE
         xJ1GsnFxBziE8PutDAeUpVaZDFWqfVrSYgkPKuHE=
Date:   Tue, 20 Aug 2019 09:01:30 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] kprobes: adjust kprobe addr for KPROBES_ON_FTRACE
Message-Id: <20190820090130.844fc064030db67efb05ceb1@kernel.org>
In-Reply-To: <20190819192505.483c0bf0@xhacker.debian>
References: <20190819192422.5ed79702@xhacker.debian>
        <20190819192505.483c0bf0@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Mon, 19 Aug 2019 11:36:09 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> For KPROBES_ON_FTRACE case, we need to adjust the kprobe's addr
> correspondingly.

No, I think you have misunderstood what the ftrace_call_adjust() does.
Ftrace's rec->ip is already adjusted when initializing it. Kprobes
checks the list after initialized (adjusted). So you don't need to
adjust it again.

BTW, this type of hidden adjustment should be avoided by design.
If you find user specifies wrong address, return error instead of
adjust it silently.

Thank you,

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  kernel/kprobes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9873fc627d61..f8400753a8a9 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1560,6 +1560,9 @@ int register_kprobe(struct kprobe *p)
>  	addr = kprobe_addr(p);
>  	if (IS_ERR(addr))
>  		return PTR_ERR(addr);
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	addr = (kprobe_opcode_t *)ftrace_call_adjust((unsigned long)addr);
> +#endif
>  	p->addr = addr;
>  
>  	ret = check_kprobe_rereg(p);
> -- 
> 2.23.0.rc1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
