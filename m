Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7352CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CAA4205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 18:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sam.st header.i=@sam.st header.b="Qvre6CMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfHSSkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 14:40:14 -0400
Received: from sam.st ([5.44.101.18]:44383 "EHLO mail.sam.st"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfHSSkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 14:40:12 -0400
Received: from workstation-ibk (212-186-61-58.cable.dynamic.surfer.at [212.186.61.58])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.sam.st (Postfix) with ESMTPSA id 928EE300109;
        Mon, 19 Aug 2019 20:40:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sam.st; s=default;
        t=1566240008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xdL9I01Wyzr1jytnjjoTBGyvEzEJQA2seX7rzKT4CWs=;
        b=Qvre6CMzceaiZaWQ6Z7Y7rEtaP5eY0nPJ36IyPnyLUS9UuLNahbZwA6bP7eXWnR+AFqj42
        c47B4FFezAsU9SWeqMgoxWJ1XxvyUz4nyCR+Pzp7/ZiS5JaVXY7DuPWJYjHsjxBuOHkM3U
        tE17vdjS0OFdyveh0DmM2d5OyiaCh08=
Message-ID: <2d8f1744136431b5eb0bda24ea767374d6fde4e5.camel@sam.st>
Subject: Re: [PATCH] uprobes/x86: fix detection of 32-bit user mode
From:   Sebastian Mayr <me@sam.st>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 20:40:07 +0200
In-Reply-To: <20190728152617.7308-1-me@sam.st>
References: <20190728152617.7308-1-me@sam.st>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-07-28 at 17:26 +0200, Sebastian Mayr wrote:
> 32-bit processes running on a 64-bit kernel are not always detected
> correctly, causing the process to crash when uretprobes are
> installed.
> The reason for the crash is that in_ia32_syscall() is used to
> determine
> the process's mode, which only works correctly when called from a
> syscall. In the case of uretprobes, however, the function is called
> from
> a software interrupt and always returns 'false' (on a 64-bit kernel).
> In
> consequence this leads to corruption of the process's return address.
> 
> This can be fixed by using user_64bit_mode(), which should always be
> correct.
> 
> Signed-off-by: Sebastian Mayr <me@sam.st>
> ---
> 
> Please note that I just stumbled over this bug and am not really
> familiar with all the internals. So take the patch and, in
> particular,
> the commit message with a grain of salt. Thanks!
> 
>  arch/x86/kernel/uprobes.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 918b5092a85f..d6e261202c6b 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -508,9 +508,9 @@ struct uprobe_xol_ops {
>  	void	(*abort)(struct arch_uprobe *, struct pt_regs *);
>  };
>  
> -static inline int sizeof_long(void)
> +static inline int sizeof_long(struct pt_regs *regs)
>  {
> -	return in_ia32_syscall() ? 4 : 8;
> +	return user_64bit_mode(regs) ? 8 : 4;
>  }
>  
>  static int default_pre_xol_op(struct arch_uprobe *auprobe, struct
> pt_regs *regs)
> @@ -521,9 +521,9 @@ static int default_pre_xol_op(struct arch_uprobe
> *auprobe, struct pt_regs *regs)
>  
>  static int emulate_push_stack(struct pt_regs *regs, unsigned long
> val)
>  {
> -	unsigned long new_sp = regs->sp - sizeof_long();
> +	unsigned long new_sp = regs->sp - sizeof_long(regs);
>  
> -	if (copy_to_user((void __user *)new_sp, &val, sizeof_long()))
> +	if (copy_to_user((void __user *)new_sp, &val,
> sizeof_long(regs)))
>  		return -EFAULT;
>  
>  	regs->sp = new_sp;
> @@ -556,7 +556,7 @@ static int default_post_xol_op(struct arch_uprobe
> *auprobe, struct pt_regs *regs
>  		long correction = utask->vaddr - utask->xol_vaddr;
>  		regs->ip += correction;
>  	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
> -		regs->sp += sizeof_long(); /* Pop incorrect return
> address */
> +		regs->sp += sizeof_long(regs); /* Pop incorrect return
> address */
>  		if (emulate_push_stack(regs, utask->vaddr + auprobe-
> >defparam.ilen))
>  			return -ERESTART;
>  	}
> @@ -675,7 +675,7 @@ static int branch_post_xol_op(struct arch_uprobe
> *auprobe, struct pt_regs *regs)
>  	 * "call" insn was executed out-of-line. Just restore ->sp and
> restart.
>  	 * We could also restore ->ip and try to call
> branch_emulate_op() again.
>  	 */
> -	regs->sp += sizeof_long();
> +	regs->sp += sizeof_long(regs);
>  	return -ERESTART;
>  }
>  
> @@ -1056,7 +1056,7 @@ bool arch_uprobe_skip_sstep(struct arch_uprobe
> *auprobe, struct pt_regs *regs)
>  unsigned long
>  arch_uretprobe_hijack_return_addr(unsigned long trampoline_vaddr,
> struct pt_regs *regs)
>  {
> -	int rasize = sizeof_long(), nleft;
> +	int rasize = sizeof_long(regs), nleft;
>  	unsigned long orig_ret_vaddr = 0; /* clear high bits for 32-bit 
> apps */
>  
>  	if (copy_from_user(&orig_ret_vaddr, (void __user *)regs->sp,
> rasize))

Any feedback on this patch would be greatly appreciated.

Thanks,
Sebastian

