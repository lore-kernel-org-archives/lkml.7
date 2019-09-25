Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C9C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A20207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xrv8KSG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443155AbfIYRlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 13:41:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36314 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438383AbfIYRlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 13:41:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id f19so2820678plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1CTVsYgoIpsmY3rHqOtuzts6AZf4hXcs595qDdhE4QU=;
        b=Xrv8KSG+XJWafUl0OABPFBnzhF/qk0KChfGXSGYtDPnw1QYyxTl/a9xxUe5ewacdYC
         ni6tZsQkRLtdNy8uAXMuuuj9LVQuB2jhsNEK2HN08uxGqvbkzXRGP//sORNnDjt/5q1T
         pf0FNXgaioatTGreyHFD3hkKsLYtaKFViSTm1ij5FluAQoAHtF/UHt3XhL46CsDnhz89
         nWBltqxC3moigBKN0u+3e8Uw47btM0R7vMaU+Q1lr1fwLLf34GS+ZM1Cjf/ZMUjfGiXt
         NhmKWmXJs7zP7QIoy7hta1FWVhWL9PQP7VXL7+I8EbYTTA6UtloN93+Yty3uiNyFeXZr
         2ghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1CTVsYgoIpsmY3rHqOtuzts6AZf4hXcs595qDdhE4QU=;
        b=Zei+JyeUZsaKAVSzjNZQ+Heb4P1bHXbg4n86f2dQ2RHnyzHsw/yhPWuOlmXIrtGDFh
         XvGTqScb1haKcP93yMqw7nlS7YRvSzs/xgAUqSuqXHDtysNxbKD3ThC1VsQc51Ms2IZd
         i6CrxlXmn06UIRu2ge4WSuvkYZ3+ZCQdITp4SD2Kas9nW1N4NWlDoHqEYAUkKEuEi6EU
         0cUS3Y0YAMNvMyeHQ05nBZ6Z6L+BzCF+5m5DpJ0q48il/OYKhY5JFX2RH4D0C4NcF7Ro
         wH8rfNVHKxADMtuXTV/KBTB+35L5w+Gc47W6V7LKmLH2AltvmB9p7kWIgpaOD3O7YjDK
         4fuw==
X-Gm-Message-State: APjAAAWB/VOwPb3ywtOm4KVJzeTyhn0mJxFlGXBHvldAThmYMktvBUJ1
        ZDu2ZU/W9P1EKl/IJrljSUDN0tX5d234ztrsH1//eQ==
X-Google-Smtp-Source: APXvYqxImmFMWJWqkuKULVqb6WVgwAfYtxnwSuz7sgDW3wgTX6cYhfeNmOgdhJByzJEsPjO1A6QYPKyhFAD+etM0RLU=
X-Received: by 2002:a17:902:8484:: with SMTP id c4mr10189391plo.223.1569433305873;
 Wed, 25 Sep 2019 10:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190925172915.576755-1-natechancellor@gmail.com>
In-Reply-To: <20190925172915.576755-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 25 Sep 2019 10:41:34 -0700
Message-ID: <CAKwvOdmO255nWf2PrfJ54X95ShNbYPf0FK2x=f57LmzOrCmJug@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix clang -Wint-in-bool-context warnings in
 IF_ASSIGN macro
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        David Bolvansky <david.bolvansky@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 10:29 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> After r372664 in clang, the IF_ASSIGN macro causes a couple hundred
> warnings along the lines of:
>
> kernel/trace/trace_output.c:1331:2: warning: converting the enum
> constant to a boolean [-Wint-in-bool-context]
> kernel/trace/trace.h:409:3: note: expanded from macro
> 'trace_assign_type'
>                 IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,
>                 ^
> kernel/trace/trace.h:371:14: note: expanded from macro 'IF_ASSIGN'
>                 WARN_ON(id && (entry)->type != id);     \
>                            ^
> 264 warnings generated.
>
> Add the implicit '!= 0' to the WARN_ON statement to fix the warnings.
>
> Link: https://github.com/llvm/llvm-project/commit/28b38c277a2941e9e891b2db30652cfd962f070b
> Link: https://github.com/ClangBuiltLinux/linux/issues/686
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I can't think of a case that this warning is a bug (maybe David can
explain more), but seems like a small fix that can stop a big spew of
warnings, and IIUC this is the lone instance we see in the kernel.  In
that case, I prefer a tiny change to outright disabling the warning in
case it does find interesting cases later.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  kernel/trace/trace.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 26b0a08f3c7d..f801d154ff6a 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -365,11 +365,11 @@ static inline struct trace_array *top_trace_array(void)
>         __builtin_types_compatible_p(typeof(var), type *)
>
>  #undef IF_ASSIGN
> -#define IF_ASSIGN(var, entry, etype, id)               \
> -       if (FTRACE_CMP_TYPE(var, etype)) {              \
> -               var = (typeof(var))(entry);             \
> -               WARN_ON(id && (entry)->type != id);     \
> -               break;                                  \
> +#define IF_ASSIGN(var, entry, etype, id)                       \
> +       if (FTRACE_CMP_TYPE(var, etype)) {                      \
> +               var = (typeof(var))(entry);                     \
> +               WARN_ON(id != 0 && (entry)->type != id);        \
> +               break;                                          \
>         }
>
>  /* Will cause compile errors if type is not found. */
> --
> 2.23.0
>


-- 
Thanks,
~Nick Desaulniers
