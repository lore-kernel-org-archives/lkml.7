Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7917C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90DFA20883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 00:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554684927;
	bh=69ZEf06/hipoeP+0rCqW7TIMw/4w3e3uOSO/mZQZzIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D8vRAKmDpfNinUXIXb8Oc5MOLQhPLabtIPCKobG4AvLDfO22mznK2QZYQ5n8jZ43Y
	 Lqu6Zqxs/P71l1AP2k1V0Lj/E2NdXEtipSIkEBFzXxzfaJjaKR3JU6BINF2FZpCH0D
	 ci3TuwE8A5JVWtvUmU3k4/yx7bEAOB/YR7U92DGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDHAzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 20:55:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbfDHAzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 20:55:24 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF6620833;
        Mon,  8 Apr 2019 00:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554684923;
        bh=69ZEf06/hipoeP+0rCqW7TIMw/4w3e3uOSO/mZQZzIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FSt4iPnPaxbk7nc2HPQ8Admxegh6TmLm6uAnL6HOtR3gUwZ5xIf2xlnY6m0zabJgD
         GUPxZh7YOLDl8BTK/WQYqTwv/wZ0+Df9BcX/C4xfkrsxE4f+v4R0JQkRrPHkU42Ypk
         IlR1NLYuNKmKonBUzQGs7F2D0omCl3X51FVYVuC0=
Date:   Mon, 8 Apr 2019 09:55:19 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sven Schnelle <svens@stackframe.org>
Cc:     linux-kernel@vger.kernel.org,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] kprobes: fix compilation when KPROBE_EVENTS is enabled
 without kretpobes
Message-Id: <20190408095519.751c13615842a077745f3914@kernel.org>
In-Reply-To: <20190406155543.15353-1-svens@stackframe.org>
References: <20190406155543.15353-1-svens@stackframe.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Apr 2019 17:55:43 +0200
Sven Schnelle <svens@stackframe.org> wrote:

> While implementing kprobes on PA-RISC (without kretprobes) compilation
> fails when CONFIG_KPROBE_EVENTS is enabled:
> 
> kernel/trace/trace_kprobe.o: in function `trace_kprobe_create':
> kernel/trace/trace_kprobe.c:666: undefined reference to `kprobe_on_func_entry'
> kernel/trace/trace_kprobe.o: in function `trace_kprobe_on_func_entry':
> kernel/trace/trace_kprobe.c:167: undefined reference to `kprobe_on_func_entry'
> kernel/trace/trace_kprobe.c:167: undefined reference to `kprobe_on_func_entry'
> make: *** [Makefile:1029: vmlinux] Error 1
> 
> Given the fact that these functions have no dependencies on kretprobes i think
> they should be moved out of the #ifdef CONFIG_KRETPROBES block.

Ah, I got it. Yes, this function had been introduced for kretprobe (because
kretprobe must be the entry of functions) but is used for kprobe_event and
bpf now.

It should be moved out of CONFIG_KPROBE_EVENTS.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index c83e54727131..10a7e67fea67 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1819,6 +1819,26 @@ unsigned long __weak arch_deref_entry_point(void *entry)
>  	return (unsigned long)entry;
>  }
>  
> +bool __weak arch_kprobe_on_func_entry(unsigned long offset)
> +{
> +	return !offset;
> +}
> +
> +bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym,
> +			  unsigned long offset)
> +{
> +	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
> +
> +	if (IS_ERR(kp_addr))
> +		return false;
> +
> +	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
> +					 !arch_kprobe_on_func_entry(offset))
> +		return false;
> +
> +	return true;
> +}
> +
>  #ifdef CONFIG_KRETPROBES
>  /*
>   * This kprobe pre_handler is registered with every kretprobe. When probe
> @@ -1875,25 +1895,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
>  
> -bool __weak arch_kprobe_on_func_entry(unsigned long offset)
> -{
> -	return !offset;
> -}
> -
> -bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
> -{
> -	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
> -
> -	if (IS_ERR(kp_addr))
> -		return false;
> -
> -	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
> -						!arch_kprobe_on_func_entry(offset))
> -		return false;
> -
> -	return true;
> -}
> -
>  int register_kretprobe(struct kretprobe *rp)
>  {
>  	int ret = 0;
> -- 
> 2.20.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
