Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A2C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E935207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKsm2kFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503218AbfIWWGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:06:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35185 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502949AbfIWWGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:06:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so10040263pfw.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqx3nwmhmvUj1INmgkpz5JOsEs9scYiCKN5Ub764u7Y=;
        b=aKsm2kFNzCzz74yg7H0cBXIp9vQnYJhsjfxDNK3dRf5szEjnJX0P9AK1lfpl5T5zD5
         rrok1si6velST616EexzDP5opuTg0rpryQGo1s9HqN6tT1GTECBtbLOY+ySE5y9vxA7s
         YF88IxcBPAncYgSqhTE3+dQnV0ZkPjRSh42YM2oGujCYL2z5zesYYPMoZzJp6awAvQ5/
         Rz/BhXjG8TNNBqwp63ThweswzuTuTWce2sHfaI+X1cCakZXKkH8iVIDik1jq5p4PMtgG
         g3CPgIZVFNDP54OCdKraXLzv3+mFQTqif4ahmGg00GBUK/tk+qAkgtOCKeMP2cEW+TpD
         YSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqx3nwmhmvUj1INmgkpz5JOsEs9scYiCKN5Ub764u7Y=;
        b=rTRCI8WZXZAPjHUp0ozDsOG3Urwat94BJKcR0yg+wUvqVwC6RnJRBtnrTHHPq+dlZl
         Ahl5eIaX15GcPCFEsJWsqURLzJs7KYBlljOcIp2f5hA0Um2fDFU4Dgo28lCL6RSalHC9
         FizbRF5PPjewaUvdDc8adWu0Aqqee4QFLT0Hd8bZ8ivI2oFzDHC1Yp6GLjMcPoVS6Sor
         mt4RZTFvj35HjSMbNNgqwMLAAXnGF2CrBcf7c8KvYR9g0pVxtrZrFWKl/vYDae0zimZT
         nBz23GdUeT0iHIlh6a+QaxwYhtZLgfNJmGKuUNdk/OW5N5C6H4XAgkqZ4Njnd4v3Eudu
         uL6Q==
X-Gm-Message-State: APjAAAXuz4+q3X9FS3IjBtpzauNDWZHX1uuJSP8CTjMwWWiuE+bMTXI/
        PbZLGUkH03cnSoRmIThFYzo0rDjLWFq8MZpbPEZo3XWynRQ=
X-Google-Smtp-Source: APXvYqz/iWff7PZT9I0zLghMOWwjyl6OK8L8vHVHY1WCJBv+odD1zF/m4UIMfdLOj2TkxqYgdlcvlWfaKwrGnYfXXmI=
X-Received: by 2002:a62:798e:: with SMTP id u136mr2009080pfc.3.1569276398816;
 Mon, 23 Sep 2019 15:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190712085908.4146364-1-arnd@arndb.de> <20190712174142.GB127917@archlinux-threadripper>
In-Reply-To: <20190712174142.GB127917@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Sep 2019 15:06:27 -0700
Message-ID: <CAKwvOdkhe=WMMTevMd7m_URjuOcjAkHc8zBibUD2_gX79U+p3g@mail.gmail.com>
Subject: Re: [PATCH] xen/trace: avoid clang warning on function pointers
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 10:41 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 10:58:48AM +0200, Arnd Bergmann wrote:
> > clang-9 does not like the way that the is_signed_type() compares
> > function pointers deep inside of the trace even macros:
> >
> > In file included from arch/x86/xen/trace.c:21:
> > In file included from include/trace/events/xen.h:475:
> > In file included from include/trace/define_trace.h:102:
> > In file included from include/trace/trace_events.h:467:
> > include/trace/events/xen.h:69:7: error: ordered comparison of function pointers ('xen_mc_callback_fn_t' (aka 'void (*)(void *)') and 'xen_mc_callback_fn_t') [-Werror,-Wordered-compare-function-pointers]
> >                     __field(xen_mc_callback_fn_t, fn)
> >                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/trace/trace_events.h:415:29: note: expanded from macro '__field'
> >  #define __field(type, item)     __field_ext(type, item, FILTER_OTHER)
> >                                 ^
> > include/trace/trace_events.h:401:6: note: expanded from macro '__field_ext'
> >                                  is_signed_type(type), filter_type);    \
> >                                  ^
> > include/linux/trace_events.h:540:44: note: expanded from macro 'is_signed_type'
> >  #define is_signed_type(type)    (((type)(-1)) < (type)1)
> >                                               ^
> > note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
> > include/trace/trace_events.h:77:16: note: expanded from macro 'TRACE_EVENT'
> >                              PARAMS(tstruct),                  \
> >                              ~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > include/linux/tracepoint.h:95:25: note: expanded from macro 'PARAMS'
> >  #define PARAMS(args...) args
> >                         ^
> > include/trace/trace_events.h:455:2: note: expanded from macro 'DECLARE_EVENT_CLASS'
> >         tstruct;                                                        \
> >         ^~~~~~~
> >
> > I guess the warning is reasonable in principle, though this seems to
> > be the only instance we get in the entire kernel today.
> > Shut up the warning by making it a void pointer in the exported
> > structure.
> >
> > Fixes: c796f213a693 ("xen/trace: add multicall tracing")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Nick suggested this as well, I think it's reasonable to work around it
> in this one location since this is indeed the only instance of this
> warning that I see in the kernel tree across all of my builds.
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>


Steven, Ingo, would one of you mind picking up this fix, please?  See
for multiple reports:
https://github.com/ClangBuiltLinux/linux/issues/216
-- 
Thanks,
~Nick Desaulniers
