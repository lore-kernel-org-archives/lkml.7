Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B7FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C505D20692
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 21:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TK0eriJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfKOVGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 16:06:38 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46384 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfKOVGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:06:37 -0500
Received: by mail-qt1-f195.google.com with SMTP id r20so12203297qtp.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 13:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PVeUd0Z9qID74jwTLN71/X5ho1REfkJ1WwqU2FF2PSI=;
        b=TK0eriJDcFnWuO9O157SGzkRAyr6VHRcA7oMDgqrEmpehZYvWbIXiYVuMtdHtdn1y6
         6y8xxDuJ/xzb/5fbtQAjwpXd7iMrXIZz15GFEQ91jHgA0G/cOlbPnNZz5er57yCILzyf
         O6GsrUgx8v9gK+PFWALE9lj+lKn6q4lXdJ8hpTeU+EgLwr7TnG0p9Nm1k0uOKUSFQc2f
         wQKhKin3tmKzlNqngYtpxcgxw1fHrZfNdHzFj4Xgm9bYFUUrxYV2FDSxTT4NlXTJ25WG
         r+PzjOkX0Az2Pgtllj8bPpOC4gxl6f6lFtyPc/a3wuqoTQZnpVCJ6Ck//OxjJBe+TXry
         O9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PVeUd0Z9qID74jwTLN71/X5ho1REfkJ1WwqU2FF2PSI=;
        b=ZWMOVa263+ByJ91QQc5PsQB6XY9cAExX/kR669cjLbNhh2AJWtqjYNEj5Fqpzu5Lbz
         ZXE0FflkacvImkXDDzsJwZYQLufgGraoQnDZ4C1mTPmOqYMm5/yRiydksfGHtpLqJMie
         FGyA52ZJant6rPragfWWgc+JIZQcKNqfhrD7u8Gby4LlI13hxl9Y/anCQOzYW4AkBS0V
         s3kBo1OCMIjRHhkfSaHudUMF4VXl0fgtrU4SlsBPwDCGocugnWILIOJna8CqdZ0Dx16l
         AGvuMW4qpOUFnZFo3oWwc3CMAzEN4k9KWV0puTPCTsixxuljq8sMnBzOJn/Fh83aZSrE
         hapw==
X-Gm-Message-State: APjAAAXtvqwH3GcFiohTr0aFC9vHHFqRBp1XxpkvuaCe5J4BMUl978wa
        XImkmuCH7egwYJnb3XbR1qhkKQ==
X-Google-Smtp-Source: APXvYqw4SOGDOoWQJs12lnlimfm/ZUDq9OCmmNY6RKMEEYMcSf2xS9P8MXAO3XVBW7XJs3aVHB+K1Q==
X-Received: by 2002:ac8:3142:: with SMTP id h2mr16647308qtb.182.1573851996738;
        Fri, 15 Nov 2019 13:06:36 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m65sm5397635qte.54.2019.11.15.13.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 13:06:35 -0800 (PST)
Message-ID: <1573851994.5937.138.camel@lca.pw>
Subject: Re: powerpc ftrace broken due to "manual merge of the ftrace tree
 with the arm64 tree"
From:   Qian Cai <cai@lca.pw>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 15 Nov 2019 16:06:34 -0500
In-Reply-To: <20191115160230.78871d8f@gandalf.local.home>
References: <1573849732.5937.136.camel@lca.pw>
         <20191115160230.78871d8f@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-15 at 16:02 -0500, Steven Rostedt wrote:
> On Fri, 15 Nov 2019 15:28:52 -0500
> Qian Cai <cai@lca.pw> wrote:
> 
> > # echo function >/sys/kernel/debug/tracing/current_tracer
> > 
> > It hangs forever with today's linux-next on powerpc. Reverted the conflict fix
> > [1] as below fixes the issue.
> > 
> > [1] https://lore.kernel.org/linux-next/20191115135357.10386fac@canb.auug.org.au/
> 
> What's your config file.

https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config

> 
> And can you test the two conflicting commits to see which one caused
> your error?
> 
> Test this commit please: b83b43ffc6e4b514ca034a0fbdee01322e2f7022

# git reset --hard b83b43ffc6e4b514ca034a0fbdee01322e2f7022

Yes, that one is bad.

> 
> And see if the issue is with that one, and not with the one without it.
> 
> -- Steve
> 
> 
> > 
> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-
> > generic/vmlinux.lds.h
> > index 7d0d03a03d4d..a92222f79b53 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -136,29 +136,20 @@
> >  #endif
> >  
> >  #ifdef CONFIG_FTRACE_MCOUNT_RECORD
> > -/*
> > - * The ftrace call sites are logged to a section whose name depends on the
> > - * compiler option used. A given kernel image will only use one, AKA
> > - * FTRACE_CALLSITE_SECTION. We capture all of them here to avoid header
> > - * dependencies for FTRACE_CALLSITE_SECTION's definition.
> > - */
> > -/*
> > - * Need to also make ftrace_graph_stub point to ftrace_stub
> > - * so that the same stub location may have different protocols
> > - * and not mess up with C verifiers.
> > - */
> > -#define MCOUNT_REC()	. = ALIGN(8);				\
> > +#ifdef CC_USING_PATCHABLE_FUNCTION_ENTRY
> > +#define MCOUNT_REC()	. = ALIGN(8)				\
> >  			__start_mcount_loc = .;			\
> > -			KEEP(*(__mcount_loc))			\
> >  			KEEP(*(__patchable_function_entries))	\
> >  			__stop_mcount_loc = .;			\
> >  			ftrace_graph_stub = ftrace_stub;
> >  #else
> > -# ifdef CONFIG_FUNCTION_TRACER
> > -#  define MCOUNT_REC()	ftrace_graph_stub = ftrace_stub;
> > -# else
> > -#  define MCOUNT_REC()
> > -# endif
> > +#define MCOUNT_REC()	. = ALIGN(8);				\
> > +			__start_mcount_loc = .;			\
> > +			KEEP(*(__mcount_loc))			\
> > +			__stop_mcount_loc = .;
> > +#endif
> > +#else
> > +#define MCOUNT_REC()
> >  #endif
> >  
> >  #ifdef CONFIG_TRACE_BRANCH_PROFILING
> 
> 
