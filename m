Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834D1C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579F42196E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 08:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570783176;
	bh=/DrW5ph3A5E4Hgsb7Sd3CajDjM9gMywett8FftQi6PM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ur5JSZSX2NFrUYtTI/GF88twS9bjgoSQlJ6OeI7+Y312Tm37IcNhL/l7mNbRKDDqp
	 cIiV4pRyWPH714o6SvPJ+A998ZYyGnt8VexC6RAthZQQ+rJD5fTnhyLRkSKqwgaEBa
	 YsYe6l4fLKB+Af7kQBJypnGYm3ga0+9VKZ1EkJEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfJKIjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 04:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbfJKIje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 04:39:34 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BA7820679;
        Fri, 11 Oct 2019 08:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570783174;
        bh=/DrW5ph3A5E4Hgsb7Sd3CajDjM9gMywett8FftQi6PM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s0mQaGhluvgb8qCJ2TOMEfGY32AjQDL9MrXwsO8ByB4lc5WvP2EE8v3fg7uOSxoYa
         iEsY0b0R6mDLLwl5XwZrJZR8pHCbegt7rrilqksIJmCvcuKHRMaJ+hA2RnlvggPYRb
         3x8zGilA3kzegeDzbIHb5RYqfzbW2LxKuu8Bf1j0=
Date:   Fri, 11 Oct 2019 17:39:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH] kprobes/x86: While list ftrace locations in kprobe
 blacklist areas
Message-Id: <20191011173929.9462a1414ff3a94ec93d6e98@kernel.org>
In-Reply-To: <20191010175216.4ceb3cf1@gandalf.local.home>
References: <20191010175216.4ceb3cf1@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Thu, 10 Oct 2019 17:52:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> I noticed some of my old tests failing on kprobes, and realized that
> this was due to black listing irq_entry functions on x86 from being
> used by kprobes. IIRC, this was due to the cr2 being corrupted and
> such, and I believe other things were to cause. But black listing all
> irq_entry code is a big hammer to this.

OK, I think if we can use ftrace for hooking, probing on "that address"
is good, but the function body still can not be probed.

> 
>  (See commit 0eae81dc9f026 "x86/kprobes: Prohibit probing on IRQ
>  handlers directly" for more details)
> 
> Anyway, if kprobes is using ftrace as a hook, there shouldn't be any
> problems here. If we white list ftrace locations in the range of
> kprobe_add_area_blacklist(), it should be safe.

Agreed.

> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index d9770a5393c8..9d28a279282c 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -2124,6 +2124,11 @@ int kprobe_add_area_blacklist(unsigned long start, unsigned long end)
>  	int ret = 0;
>  
>  	for (entry = start; entry < end; entry += ret) {
> +#ifdef CONFIG_KPROBES_ON_FTRACE
> +		/* We are safe if using ftrace */
> +		if (ftrace_location(entry))
> +			continue;
> +#endif

Have you tested the patch? it doesn't measure the entry function's size.
(kprobe_add_ksym_blacklist(entry) returns the function size)

Could you do this in kprobe_add_ksym_blacklist()?
Instead of continue, increment ent->start_addr by MCOUNT size(?) will be OK.
(Note that since each blacklist symbol is managed independently, you can make
 a "gap" between them as a safe area)

Thank you,

>  		ret = kprobe_add_ksym_blacklist(entry);
>  		if (ret < 0)
>  			return ret;


-- 
Masami Hiramatsu <mhiramat@kernel.org>
