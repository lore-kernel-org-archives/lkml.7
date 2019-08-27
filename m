Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6716C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B728D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 20:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bXg67KvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbfH0U6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 16:58:18 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35424 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbfH0U6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:58:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id d85so193334pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 13:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TXjsSAJv8McRWlbUcLkirZ2NM0D/RICs3+Zd+E1Xf+I=;
        b=bXg67KvMUzP60s0lVOxa4LPBAQxRnuEVPFTxoqhYno0kLCiiROzohMHKdhZTLYsKG7
         Y1EMSRv8gJaWxAcaIVota4/JNiPku5TKZHgtQugBcVPtNLd7kuDHhQ+o1Uc/I8Q2gNY8
         STBEjbGEf+otmPLiXl178YjOVzCYczBqgvy2ph9MLrwPXnDHn/o7QZ2lR9IbX2z6dN0m
         eae3er9tpRzQ/FBfiKfizwuhBpCE76p2uezoeMTGcSSOusd7HDOX96N1mwMwA8pdOT3y
         oxwMlheyCG73kV0pUtcOr5UsHVYiM+zqdqpHUyaP4/L9s0760Y8ceb2nsOiV1n6nY7qU
         tAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TXjsSAJv8McRWlbUcLkirZ2NM0D/RICs3+Zd+E1Xf+I=;
        b=q5p8yuc4pO4bOx2UEYNANoeVeG4BSfStjDpFwpsRWsxxAoECcPCX1VEBVfUlbF2GLe
         hb9h//09/Zb+0Krn3VfbJpJrEL9M1PtgzZhxXLPFqzzcx2YX6ZSh6vdntoR/n/RUjadO
         VP68Ab4I7ppfvXQBDgxEowjBvsXHyIO0yDmJvOD7/qUqhSpauaaOHgiqJ0yMENL/hYkM
         Y8GAUrRvEAIwZHRglsCXdDX4cWBGOOz3DzHHir55aUygA25ktk9cumfWnSK1fohTN83h
         jCGgehjc9RBQsky5cWpzTVKaf1sql3ZT3anGucMbVHE6gEjAyk+Z5fzCQlPJksK1gNy8
         bV7Q==
X-Gm-Message-State: APjAAAXrMHDGVtaN5UCERZXM2K8Mx9akYPEOKIHdla8iP6W0bsWPdfHf
        M8ZiReb8I2IkL7UsJ7jpa7wXnB4WUSUWBB/vkF0wEQ==
X-Google-Smtp-Source: APXvYqxBy6oZ2oWOmC1TadzVg1KFfhlT40FfxLvUs5iF21O8HhGNYx4Gg8CgxKza7lZL4FZb/CKdM2Zp82wqzyic1vM=
X-Received: by 2002:a63:61cd:: with SMTP id v196mr330561pgb.263.1566939496499;
 Tue, 27 Aug 2019 13:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190827103621.1073-1-yamada.masahiro@socionext.com> <20190827192811.GA24626@archlinux-threadripper>
In-Reply-To: <20190827192811.GA24626@archlinux-threadripper>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 27 Aug 2019 13:58:05 -0700
Message-ID: <CAKwvOd=7Jf13PDC9Q1FMhZUJQsq7Ggn=wRz5xpRY0YrU6tP9Kw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: enable unused-function warnings for W= build
 with Clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 12:28 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, Aug 27, 2019 at 07:36:21PM +0900, Masahiro Yamada wrote:
> > GCC and Clang have different policy for -Wunused-function; GCC never
> > reports unused-function warnings for 'static inline' functions whereas
> > Clang reports them if they are defined in source files instead of
> > included headers although it has been suppressed since commit
> > abb2ea7dfd82 ("compiler, clang: suppress warning for unused static
> > inline functions").
> >
> > We often miss to remove unused functions where 'static inline' is used
> > in .c files since there is no tool to detect them. Unused code remains
> > until somebody notices. For example, commit 075ddd75680f ("regulator:
> > core: remove unused rdev_get_supply()").
> >
> > Let's remove __maybe_unused from the inline macro to allow Clang to
> > start finding unused static inline functions. As always, it is not a
> > good idea to sprinkle warnings for the normal build, so I added
> > -Wno-unsued-function for no W= build.

s/unsued/unused/

> >
> > Per the documentation [1], -Wno-unused-function will also disable
> > -Wunneeded-internal-declaration, which can help find bugs like
> > commit 8289c4b6f2e5 ("platform/x86: mlx-platform: Properly use
> > mlxplat_mlxcpld_msn201x_items"). (pointed out by Nathan Chancellor)
> > I added -Wunneeded-internal-declaration to address it.
> >
> > If you contribute to code clean-up, please run "make CC=clang W=1"
> > and check -Wunused-function warnings. You will find lots of unused
> > functions.
> >
> > Some of them are false-positives because the call-sites are disabled
> > by #ifdef. I do not like to abuse the inline keyword for suppressing
> > unused-function warnings because it is intended to be a hint for the
> > compiler's optimization. I prefer __maybe_unused or #ifdef around the
> > definition.

I'd say __maybe_unused for function parameters that are used depending
of ifdefs in the body of the function, otherwise strictly ifdefs.

> >
> > [1]: https://clang.llvm.org/docs/DiagnosticsReference.html#wunused-function
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
>
> I am still not a big fan of this as I think it weakens clang as a
> standalone compiler but the change itself looks good so if it is going
> in anyways:
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
>
> I'm sure Nick would like to weigh in as well before this gets merged.

So right away for an x86_64 defconfig w/ this patch, clang points out:

drivers/gpu/drm/i915/i915_sw_fence.c:84:20: warning: unused function
'debug_fence_init_onstack' [-Wunused-function]
static inline void debug_fence_init_onstack(struct i915_sw_fence *fence)
                   ^
drivers/gpu/drm/i915/i915_sw_fence.c:105:20: warning: unused function
'debug_fence_free' [-Wunused-function]
static inline void debug_fence_free(struct i915_sw_fence *fence)
                   ^

The first looks fishy (grep -r debug_fence_init_onstack), the second
only has a callsite ifdef CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS.

drivers/gpu/drm/i915/intel_guc_submission.c:1117:20: warning: unused
function 'ctx_save_restore_disabled' [-Wunused-function]
static inline bool ctx_save_restore_disabled(struct intel_context *ce)
                   ^
drivers/gpu/drm/i915/display/intel_hdmi.c:1696:26: warning: unused
function 'intel_hdmi_hdcp2_protocol' [-Wunused-function]
enum hdcp_wired_protocol intel_hdmi_hdcp2_protocol(void)
                         ^
arm64 defconfig builds cleanly, same with arm.  Things might get more
hairy with all{yes|mod}config, but the existing things it finds don't
look insurmountable to me.  In fact, I'll file bugs in our issue
tracker (https://github.com/ClangBuiltLinux/linux/issues) for the
above.

So I'm not certain this patch weakens existing checks.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
-- 
Thanks,
~Nick Desaulniers
