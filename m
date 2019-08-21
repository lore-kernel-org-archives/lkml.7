Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEDC3A589
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCECD22DD3
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 02:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566353267;
	bh=Zqudwk65vUNNG7cwLAF4ZWtWBzan/Kk8MUshf8f8kpk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wER3Zp2oscRdA7xJXECKP+Wwoq53sJmCqyYNMHX6/eRsn9+Ewq0uQi2zKkf8yR7NG
	 jNLzKLWu1mZn+C2ANik/U5yUEbvMJutW9N9K7HaxZFs2odIP381JOLLPhJoNiomE39
	 0YnFMLyTTUXuRw2RkRJXyDPSuh6MNGd9Gy6jqdRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbfHUCHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 22:07:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:50214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfHUCHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 22:07:46 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E84E422DA7;
        Wed, 21 Aug 2019 02:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566353265;
        bh=Zqudwk65vUNNG7cwLAF4ZWtWBzan/Kk8MUshf8f8kpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ahk39hs1grZsNJL1+z7+Stu7VoJZ6O9TIOL6aijYhsOVJd9K6tq6DKj/KQriJd21r
         svftHv/8MJx99tArPBUKMT+U7s4YdKHNLSSKQpMISNCjo/gzLMrZLMkqHq+Ug/srgk
         ncfFglDJPhJxDZGJ/AK4fNUdUy2nxumdQ2pKTRsQ=
Date:   Wed, 21 Aug 2019 11:07:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] kprobes: adjust kprobe addr for
 KPROBES_ON_FTRACE
Message-Id: <20190821110739.fb3ab6b69423dff64a3b4a29@kernel.org>
In-Reply-To: <20190820114224.0c8963c4@xhacker.debian>
References: <20190820113928.1971900c@xhacker.debian>
        <20190820114224.0c8963c4@xhacker.debian>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,

On Tue, 20 Aug 2019 03:53:31 +0000
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> For KPROBES_ON_FTRACE case, we need to adjust the kprobe's addr
> correspondingly.

Either KPROBES_ON_FTRACE=y or not, ftrace_location() check must be
done correctly. If it failed, kprobes can modify the instruction
which can be modified by ftrace.

> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  kernel/kprobes.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 9873fc627d61..3fd2f68644da 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1484,15 +1484,19 @@ static inline int check_kprobe_rereg(struct kprobe *p)
>  
>  int __weak arch_check_ftrace_location(struct kprobe *p)
>  {
> -	unsigned long ftrace_addr;
> +	unsigned long ftrace_addr, addr = (unsigned long)p->addr;
>  
> -	ftrace_addr = ftrace_location((unsigned long)p->addr);
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +	addr = ftrace_call_adjust(addr);
> +#endif
> +	ftrace_addr = ftrace_location(addr);

No, this is not right way to do. If we always need to adjust address
before calling ftrace_location(), something wrong with ftrace_location()
interface.
ftrace_location(addr) must check the address is within the range which
can be changed by ftrace. (dyn->ip <= addr <= dyn->ip+MCOUNT_INSN_SIZE)


>  	if (ftrace_addr) {
>  #ifdef CONFIG_KPROBES_ON_FTRACE
>  		/* Given address is not on the instruction boundary */
> -		if ((unsigned long)p->addr != ftrace_addr)
> +		if (addr != ftrace_addr)
>  			return -EILSEQ;
>  		p->flags |= KPROBE_FLAG_FTRACE;
> +		p->addr = (kprobe_opcode_t *)addr;

And again, please don't change the p->addr silently.

Thank you,

>  #else	/* !CONFIG_KPROBES_ON_FTRACE */
>  		return -EINVAL;
>  #endif
> -- 
> 2.23.0.rc1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
