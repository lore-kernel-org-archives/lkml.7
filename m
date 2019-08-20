Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EF2C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F3222CF9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbfHTJ1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:27:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:43680 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729198AbfHTJ1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:27:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3195DADD9;
        Tue, 20 Aug 2019 09:27:46 +0000 (UTC)
Date:   Tue, 20 Aug 2019 11:27:38 +0200 (CEST)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Torsten Duwe <duwe@suse.de>
Subject: Re: [PATCH 1/3] ftrace: introdue ftrace_call_init
In-Reply-To: <20190819191622.57050fdf@xhacker.debian>
Message-ID: <alpine.LSU.2.21.1908201118190.9536@pobox.suse.cz>
References: <20190819191530.0f47b9b1@xhacker.debian> <20190819191622.57050fdf@xhacker.debian>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 19 Aug 2019, Jisheng Zhang wrote:

> On some arch, the FTRACE_WITH_REGS is implemented with gcc's
>  -fpatchable-function-entry (=2), gcc adds 2 NOPs at the beginning
> of each function, so this makes the MCOUNT_ADDR useless. In ftrace
> common framework, MCOUNT_ADDR is mostly used to "init" the nop, so
> let's introcude ftrace_call_init().
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  include/linux/ftrace.h | 1 +
>  kernel/trace/ftrace.c  | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index 8a8cb3c401b2..8175ffb671f0 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h
> @@ -458,6 +458,7 @@ extern void ftrace_regs_caller(void);
>  extern void ftrace_call(void);
>  extern void ftrace_regs_call(void);
>  extern void mcount_call(void);
> +extern int ftrace_call_init(struct module *mod, struct dyn_ftrace *rec);
>  
>  void ftrace_modify_all_code(int command);
>  
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index eca34503f178..9df5a66a6811 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -2500,7 +2500,11 @@ ftrace_code_disable(struct module *mod, struct dyn_ftrace *rec)
>  	if (unlikely(ftrace_disabled))
>  		return 0;
>  
> +#ifdef MCOUNT_ADDR
>  	ret = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +#else
> +	ret = ftrace_call_init(mod, rec);
> +#endif
>  	if (ret) {
>  		ftrace_bug_type = FTRACE_BUG_INIT;
>  		ftrace_bug(ret, rec);

I may be missing something, but the patch does not seem to be complete. 
There is no ftrace_call_init() implemented. MCOUNT_ADDR is still defined, 
so it does not change much. I don't think it is what Mark had in his mind.

Miroslav
