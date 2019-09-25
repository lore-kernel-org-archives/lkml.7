Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705B2C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42A7A21D7B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 23:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikC+0Dzi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbfIYXl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 19:41:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42284 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfIYXl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 19:41:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id i185so467807oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 16:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EHbkABYA72FSTQ3pj3ZvFRjeV+Q+MQiZLIOILleg91w=;
        b=ikC+0DziOlmeugQL6JFEl1u8w6d6laAEphMOizKfH/HWBjn1vMApg1IOxnvQ2JsRP3
         hCZEw3oEQKZl/4qdPmcQhmcO+X9Y+O0Fzx5iScN0GS5BdRRsFiZCIRLKF138viJXRuhc
         inekVOFcjrFs4OOb/OJcOrP/rBdPuIHACFxmC/c51qg6reADN81vg8ydh5HnVuZhK7zF
         2HILp4GiCx0bTqJHW6CwNRvhrnV1oQqH3UhaQ3hQR0mYhOBIA7XGobMO1ZEdRS++X94G
         rqfzn/xlNZAybgMzhCkJezhXqlDVJu8hgaS8m5w7e65q2KbrYfGDuusZEta4ADshFypu
         WbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EHbkABYA72FSTQ3pj3ZvFRjeV+Q+MQiZLIOILleg91w=;
        b=U7r8+anbRN677tVPMMtCHHVGIY19/XFs+qjYHICYoSNHsGyzq4u8I6r2FB2GlGXo1p
         0KenS3xbP/wNFaHROCXnW6u6T5ZoVNzZ94T8VmHGcDF0t1iB3Znqp+IuyU8r3eA42dMo
         shStS5sF0lg56IHMyOAgt2IRjZhU18CSkxCpoGR4GZRk3j/1JSOiIplavsSRtpKW1XI6
         ah1QPzS/fYKIL99mRj0Z1Mfi6AenakIU8s8QbJy+Um5wiHW8L4kmRiMkuUEdPCGrjrPO
         M/GcYn2EQTf9jGXdAZC0KUTR0+mVmCSA7Si5dCyuPP7ZOx2fnoSAo0PEyU+rHpEBCzP1
         KhlQ==
X-Gm-Message-State: APjAAAXkdrvzuQsHMqm6XnZwN9ME0Qudj0LNpgmXUs5acyhNx/Io4Qog
        X+8wVsqeCiflh8qZJ1fUdq0SnzBDXWzLEaMgGboS8bwdEqk=
X-Google-Smtp-Source: APXvYqzZiSs0E0jE6HKza5JlGSFS4o6JjlD3XGwMpMsW7T7hvLwXX0vE4z3xrsupBQG6/XB44pBdJVOq4h79715K9aA=
X-Received: by 2002:aca:5b84:: with SMTP id p126mr505449oib.4.1569454883752;
 Wed, 25 Sep 2019 16:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190925172915.576755-1-natechancellor@gmail.com> <CAKwvOdmO255nWf2PrfJ54X95ShNbYPf0FK2x=f57LmzOrCmJug@mail.gmail.com>
In-Reply-To: <CAKwvOdmO255nWf2PrfJ54X95ShNbYPf0FK2x=f57LmzOrCmJug@mail.gmail.com>
From:   =?UTF-8?B?RMOhdmlkIEJvbHZhbnNrw70=?= <david.bolvansky@gmail.com>
Date:   Thu, 26 Sep 2019 01:41:12 +0200
Message-ID: <CAOrgDVNraVQT7kLvPJ36OZM8tQ5atfvy7TYG+JCw9XXwzb1HBQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix clang -Wint-in-bool-context warnings in
 IF_ASSIGN macro
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC C frontend does not warn, GCC C++ FE does. https://godbolt.org/z/_sczyM

So I (we?) think there is something weird in gcc frontends.

>> I can't think of a case that this warning is a bug (maybe David can
explain more),

In this case or generally? General bug example:

if (state =3D=3D A || B)

(should be if (state =3D=3D A || state =3D=3D B))

Since this is just one occurrence and I recommend to just land this small f=
ix.


st 25. 9. 2019 o 19:41 Nick Desaulniers <ndesaulniers@google.com> nap=C3=AD=
sal(a):
>
> On Wed, Sep 25, 2019 at 10:29 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > After r372664 in clang, the IF_ASSIGN macro causes a couple hundred
> > warnings along the lines of:
> >
> > kernel/trace/trace_output.c:1331:2: warning: converting the enum
> > constant to a boolean [-Wint-in-bool-context]
> > kernel/trace/trace.h:409:3: note: expanded from macro
> > 'trace_assign_type'
> >                 IF_ASSIGN(var, ent, struct ftrace_graph_ret_entry,
> >                 ^
> > kernel/trace/trace.h:371:14: note: expanded from macro 'IF_ASSIGN'
> >                 WARN_ON(id && (entry)->type !=3D id);     \
> >                            ^
> > 264 warnings generated.
> >
> > Add the implicit '!=3D 0' to the WARN_ON statement to fix the warnings.
> >
> > Link: https://github.com/llvm/llvm-project/commit/28b38c277a2941e9e891b=
2db30652cfd962f070b
> > Link: https://github.com/ClangBuiltLinux/linux/issues/686
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
>
> I can't think of a case that this warning is a bug (maybe David can
> explain more), but seems like a small fix that can stop a big spew of
> warnings, and IIUC this is the lone instance we see in the kernel.  In
> that case, I prefer a tiny change to outright disabling the warning in
> case it does find interesting cases later.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > ---
> >  kernel/trace/trace.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> > index 26b0a08f3c7d..f801d154ff6a 100644
> > --- a/kernel/trace/trace.h
> > +++ b/kernel/trace/trace.h
> > @@ -365,11 +365,11 @@ static inline struct trace_array *top_trace_array=
(void)
> >         __builtin_types_compatible_p(typeof(var), type *)
> >
> >  #undef IF_ASSIGN
> > -#define IF_ASSIGN(var, entry, etype, id)               \
> > -       if (FTRACE_CMP_TYPE(var, etype)) {              \
> > -               var =3D (typeof(var))(entry);             \
> > -               WARN_ON(id && (entry)->type !=3D id);     \
> > -               break;                                  \
> > +#define IF_ASSIGN(var, entry, etype, id)                       \
> > +       if (FTRACE_CMP_TYPE(var, etype)) {                      \
> > +               var =3D (typeof(var))(entry);                     \
> > +               WARN_ON(id !=3D 0 && (entry)->type !=3D id);        \
> > +               break;                                          \
> >         }
> >
> >  /* Will cause compile errors if type is not found. */
> > --
> > 2.23.0
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
