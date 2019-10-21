Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE90CA9EB7
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CD521744
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571649230;
	bh=yqmr6bE4HTCk/kWaRLnlRHb3aZ8M5nE1t+SHzsWkT0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lJ6pQjOQVhlbKsizcjIf6nBlIQf7+bXGOSdhWAi0EiD54sbqwsRGIgciW5XIngF6N
	 /Z8xsDvQ5Q75YmZ3NiLjMyK0GTqSOk7E60wB2lm0n+Anbrcmn7vwXTYywFQ0vy/nhf
	 0tDk0DwUD8CL6dfUozxT3xo4lsxMwbt2dFINh7gE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfJUJNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:37830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726987AbfJUJNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:13:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF1320873;
        Mon, 21 Oct 2019 09:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571649223;
        bh=yqmr6bE4HTCk/kWaRLnlRHb3aZ8M5nE1t+SHzsWkT0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dILlMHxsapCwB/RkiKFBJRcDoTVeP8uZtjnYn4j8HijxhFuviJQGK9RLJptUZVwle
         rvnrlg/U39zZmz9e7H77HIsAXzMEN5hihlW58hLy52HHm+Ms7Lddmy2Cs/TeA0Xfw2
         af0VNH2gjKVSuPOS00xFIi5Vol9q+2hboQvET6FM=
Date:   Mon, 21 Oct 2019 18:13:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 10/18] kprobes: fix compilation without
 CONFIG_KRETPROBES
Message-Id: <20191021181337.a1f886fa62b400023c576be0@kernel.org>
In-Reply-To: <20191018130257.3376e397@gandalf.local.home>
References: <20191018161033.261971-1-samitolvanen@google.com>
        <20191018161033.261971-11-samitolvanen@google.com>
        <20191018130257.3376e397@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2019 13:02:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Added Masami who's the maintainer of kprobes.
> 
> -- Steve
> 
> 
> On Fri, 18 Oct 2019 09:10:25 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
> 
> > kprobe_on_func_entry and arch_kprobe_on_func_entry need to be available
> > even if CONFIG_KRETPROBES is not selected.

Good catch! Since nowadays all arch supports kretprobes, I've missed to
test it.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > ---
> >  kernel/kprobes.c | 38 +++++++++++++++++++-------------------
> >  1 file changed, 19 insertions(+), 19 deletions(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 53534aa258a6..b5e20a4669b8 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1829,6 +1829,25 @@ unsigned long __weak arch_deref_entry_point(void *entry)
> >  	return (unsigned long)entry;
> >  }
> >  
> > +bool __weak arch_kprobe_on_func_entry(unsigned long offset)
> > +{
> > +	return !offset;
> > +}
> > +
> > +bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
> > +{
> > +	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
> > +
> > +	if (IS_ERR(kp_addr))
> > +		return false;
> > +
> > +	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
> > +						!arch_kprobe_on_func_entry(offset))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  #ifdef CONFIG_KRETPROBES
> >  /*
> >   * This kprobe pre_handler is registered with every kretprobe. When probe
> > @@ -1885,25 +1904,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
> >  }
> >  NOKPROBE_SYMBOL(pre_handler_kretprobe);
> >  
> > -bool __weak arch_kprobe_on_func_entry(unsigned long offset)
> > -{
> > -	return !offset;
> > -}
> > -
> > -bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
> > -{
> > -	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
> > -
> > -	if (IS_ERR(kp_addr))
> > -		return false;
> > -
> > -	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
> > -						!arch_kprobe_on_func_entry(offset))
> > -		return false;
> > -
> > -	return true;
> > -}
> > -
> >  int register_kretprobe(struct kretprobe *rp)
> >  {
> >  	int ret = 0;
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
