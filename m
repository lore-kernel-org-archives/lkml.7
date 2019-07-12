Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0FAC742AE
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D31DF2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 09:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dnnex1Kx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbfGLJQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 05:16:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36253 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGLJQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 05:16:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so4118514wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BjF+ONSbp6B14RKm+Tax0BQaH7sheYWSZqJV3uG+niY=;
        b=Dnnex1KxPnN9XE4evRGSwbWif2Bg/1d6Z9Le9QERlgC+Y3bhCK75YHVMzKEQwjtNq6
         INee+5Y2aCG16Du9j+mnyMNX6ifjzwkjoeRh5BU4I9iutqb8bSKl1QqJMDzN5DAGORS4
         ZRE2L4DJ3AQzN1EyyUjRg5MWo6TbbEtRLorrzNjfWV3n29TCag1TO/ROqlzlAHGocz00
         ERHaHsc+fqOLqYb2AYefGa82Yrmb1Pi4jsEBiXVQkpOS0t2p3KiUczFeVasqlaFkYndK
         f/nRfKhQ5DcDtwWkNe4iu/M+A2SCSPTFBpqHwyTB/Dm2XHu49NXq4CaSxeggxc+vkuzT
         haww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BjF+ONSbp6B14RKm+Tax0BQaH7sheYWSZqJV3uG+niY=;
        b=qIzKN2T6aKMkLrnUbGt0AtjBJ6UqTX7WTuMNIIGtHGrWGbKv5yFMfPNkMGDtGOfP6V
         fBxZ8CWE3lzHAcUg5+8o1Tji2dBNSjRzcuSP60QiUJm0FdyfDHB16oFDWJY2ULSNJ7Jc
         HG1mSvI0geUy8WRsg+ULQxCe9hrNP0qYsx33I9hrhAI12PPOGaCMUU/tLt6xkcjKljDs
         xQmS/CS6YDeLEbt6Sx8BhRffUDcGgeQA05yvmaG/AGdu6BbIxvY/2RFsYTdhdJWPvzDe
         YFDA3UP33jlWmPFYwzknlrMIZr8u1VxHFyzAHzwZq6H8kTIu6Nku1LFqP5g6ssel24Za
         P3qQ==
X-Gm-Message-State: APjAAAVpuhN1JF0DqZ7o0gQyh9vDeOIyXjStPF2+cR8GAIXOPNTr4Bk6
        Jaf4DITA6r7mIKEFc226GhNUkahargcysSyP5bk=
X-Google-Smtp-Source: APXvYqwgX3AqPXmTLNAPPdWgmmmjvA2Q/efqpmnyWFZBtk6+9xHPcq3V/TkbM52Hmem4RVsdEx+t4yo9zSDyCGawYw0=
X-Received: by 2002:a7b:c215:: with SMTP id x21mr8843992wmi.38.1562923006803;
 Fri, 12 Jul 2019 02:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190712085908.4146364-1-arnd@arndb.de>
In-Reply-To: <20190712085908.4146364-1-arnd@arndb.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Jul 2019 11:16:35 +0200
Message-ID: <CA+icZUVJsTMmmUY5i9=hZe9u4bxGgEG03Of5Xkh-QVvoHZW50A@mail.gmail.com>
Subject: Re: [PATCH] xen/trace: avoid clang warning on function pointers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> clang-9 does not like the way that the is_signed_type() compares
> function pointers deep inside of the trace even macros:
>
> In file included from arch/x86/xen/trace.c:21:
> In file included from include/trace/events/xen.h:475:
> In file included from include/trace/define_trace.h:102:
> In file included from include/trace/trace_events.h:467:
> include/trace/events/xen.h:69:7: error: ordered comparison of function pointers ('xen_mc_callback_fn_t' (aka 'void (*)(void *)') and 'xen_mc_callback_fn_t') [-Werror,-Wordered-compare-function-pointers]
>                     __field(xen_mc_callback_fn_t, fn)
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/trace/trace_events.h:415:29: note: expanded from macro '__field'
>  #define __field(type, item)     __field_ext(type, item, FILTER_OTHER)
>                                 ^
> include/trace/trace_events.h:401:6: note: expanded from macro '__field_ext'
>                                  is_signed_type(type), filter_type);    \
>                                  ^
> include/linux/trace_events.h:540:44: note: expanded from macro 'is_signed_type'
>  #define is_signed_type(type)    (((type)(-1)) < (type)1)
>                                               ^
> note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
> include/trace/trace_events.h:77:16: note: expanded from macro 'TRACE_EVENT'
>                              PARAMS(tstruct),                  \
>                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> include/linux/tracepoint.h:95:25: note: expanded from macro 'PARAMS'
>  #define PARAMS(args...) args
>                         ^
> include/trace/trace_events.h:455:2: note: expanded from macro 'DECLARE_EVENT_CLASS'
>         tstruct;                                                        \
>         ^~~~~~~
>
> I guess the warning is reasonable in principle, though this seems to
> be the only instance we get in the entire kernel today.
> Shut up the warning by making it a void pointer in the exported
> structure.
>

Thanks for bringing this up (again), Arnd.

As this is a known CBL issue please add...

Link: https://github.com/ClangBuiltLinux/linux/issues/97

...and...

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

For the sake of completeness see also the comments of Steven Rostedt
and user "Honeybyte" in the above Link - if not known/read.

- Sedat -

P.S.: I am using this patch since 6 months in my
for-5.x/clang-warningfree local Git repository.

> Fixes: c796f213a693 ("xen/trace: add multicall tracing")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/trace/events/xen.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/trace/events/xen.h b/include/trace/events/xen.h
> index 9a0e8af21310..f75b77414ac1 100644
> --- a/include/trace/events/xen.h
> +++ b/include/trace/events/xen.h
> @@ -66,7 +66,7 @@ TRACE_EVENT(xen_mc_callback,
>             TP_PROTO(xen_mc_callback_fn_t fn, void *data),
>             TP_ARGS(fn, data),
>             TP_STRUCT__entry(
> -                   __field(xen_mc_callback_fn_t, fn)
> +                   __field(void *, fn)
>                     __field(void *, data)
>                     ),
>             TP_fast_assign(
> --
> 2.20.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190712085908.4146364-1-arnd%40arndb.de.
