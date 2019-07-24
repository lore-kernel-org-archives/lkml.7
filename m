Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68712C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3412199C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 07:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563953962;
	bh=3OKqgzs2jnudJmaJ1fcYoQAJqJWDM8bUh9bJQ45NSkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CHC8ktl0NIQfy3OhcvtqKnTb33q5X7fKsTWv3UTFCCNO9Hf32mL/c1IQgy3b3DWI+
	 hXN8t00OfchQS3ugR67HdlJzj9zy1c4Kh9BJHg0z2UPc81kNHLQlcwZ2myo4EyUP0k
	 c3d1lDc8srGUY2cs+l/gVASros2stMhoL3EDfO8g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbfGXHjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 03:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfGXHjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 03:39:20 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A905E2190F;
        Wed, 24 Jul 2019 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563953959;
        bh=3OKqgzs2jnudJmaJ1fcYoQAJqJWDM8bUh9bJQ45NSkI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hA5wQJB8VlSNHaopfRrW7e8DmkAvgmuY5km09VFj+Yq3nKbkU5r4vaq9IyLnNcTim
         YnSznD43WXE5G8u+azjQMxtazOvFUZud+1Wtv9MKYQ7rIfGTkgRVoqsctKPR55XHyj
         wPF1nikOuCz6xxX345efpmjyHjkYjNnQBEJciH/g=
Date:   Wed, 24 Jul 2019 16:39:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     James Morse <james.morse@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Dan Rue <dan.rue@linaro.org>,
        Matt Hart <matthew.hart@linaro.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Diaz <daniel.diaz@linaro.org>
Subject: Re: [PATCH v2 2/4] arm64: unwind: Prohibit probing on
 return_address()
Message-Id: <20190724163914.c4a9cea2b5b9df3116e5e694@kernel.org>
In-Reply-To: <038c4b88-e7ef-aaab-0a79-5d7371719aa5@arm.com>
References: <156378170297.12011.17385386326930403235.stgit@devnote2>
        <156378172702.12011.1144595747474511323.stgit@devnote2>
        <038c4b88-e7ef-aaab-0a79-5d7371719aa5@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jul 2019 17:04:21 +0100
James Morse <james.morse@arm.com> wrote:

> Hi,
> 
> On 22/07/2019 08:48, Masami Hiramatsu wrote:
> > Prohibit probing on return_address() and subroutines which
> > is called from return_address(), since the it is invoked from
> > trace_hardirqs_off() which is also kprobe blacklisted.
> 
> (Nits: "which are called" and "since it is")

Thanks!

> 
> 
> > diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
> > index b21cba90f82d..7f8a143268b0 100644
> > --- a/arch/arm64/kernel/return_address.c
> > +++ b/arch/arm64/kernel/return_address.c
> > @@ -8,6 +8,7 @@
> >  
> >  #include <linux/export.h>
> >  #include <linux/ftrace.h>
> > +#include <linux/kprobes.h>
> >  
> >  #include <asm/stack_pointer.h>
> >  #include <asm/stacktrace.h>
> > @@ -17,7 +18,7 @@ struct return_address_data {
> >  	void *addr;
> >  };
> >  
> > -static int save_return_addr(struct stackframe *frame, void *d)
> > +static nokprobe_inline int save_return_addr(struct stackframe *frame, void *d)
> 
> This nokprobe_inline ends up as __always_inline if kprobes is enabled.
> What do we expect the compiler to do with this? save_return_addr is passed as a
> function-pointer to walk_stackframe()... I don't see how the compiler can inline it!

Oops, that's my mistake. Then it should be NOKPROBE_SYMBOL.

> 
> This would be needed for on_accessible_stack().
> Should we cover ftrace_graph_get_ret_stack()?, or is that already in hand?

No, that is OK. It just covers that the functions which are involved in
the kprobe execution path. ftrace_graph_ret_stack() is out of the debug
exception handler.

Thank you,

> >  {
> >  	struct return_address_data *data = d;
> >  
> > @@ -52,3 +53,4 @@ void *return_address(unsigned int level)
> >  		return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(return_address);
> > +NOKPROBE_SYMBOL(return_address);
> 
> 
> Thanks,
> 
> James


-- 
Masami Hiramatsu <mhiramat@kernel.org>
