Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF30C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CEDD218DA
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 22:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oHQq/J/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfDWWnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 18:43:02 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43653 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 18:43:01 -0400
Received: by mail-ua1-f65.google.com with SMTP id n16so5353643uae.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8OhF53LBTSmcQZXIbZSH1EGsVtAIvy5fyo8iBajKChc=;
        b=oHQq/J/zH19pkcrKKe6NrUccjfpF2z/08EbAqRm9u/Ig6TqmKD/GHwNEIOjBZEbNX9
         FqgkavHixLrDklt5wD+ujl+O8E4/aaRfj0VXknUF2NBLy25DoNHGU+JjDqn3YKC/IsaA
         3Q87s2qN1EKleYqx9pyXOsdeI0ON14PbX7e24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8OhF53LBTSmcQZXIbZSH1EGsVtAIvy5fyo8iBajKChc=;
        b=N9H0AkXrW/frUjA4Q5cAeVayC3pGDBNdgLAW1bvxzRQiID6rexLwubcrTHLTJQ3DT9
         A4m3ahUFHy5B54an9LpVOhUbsByayUKmSnz+GxkPEqvzeSogoDJ8gP1xdtFypy5kYkub
         1W5deUfui7t6gSIz4QEDie8k1zup4SEVyTu37WsJgMog2hq5NXGHdq3+fd3PJ0au/qBw
         kDvMMuTINIM68RI1om9hZ1I+nM0wiyq0EUoWpDUrobw59SQ/kkrp+BHKI0kmbd9Ccqrp
         BQmDcBJR3thA+wVEHw0DN7Yrq4ypztpaeOrkw7wpl6PVizUQN+ay4hhaMLJd6Y5B7bKG
         VpnQ==
X-Gm-Message-State: APjAAAX7apGWn99uwjRRzBNDtdIuQfhWzNxQ4eyF4bau4C7YXjEu/22W
        DK6ngScQz/XxeAdhYCAvKY99n3ebmEo=
X-Google-Smtp-Source: APXvYqwJnda6LqV42j/jMVdIA9QxYMEV3ZnJB6J/gbVpKyC3/57OsCOUbSp6ou3b+TY3tPz8HhuWvg==
X-Received: by 2002:ab0:315a:: with SMTP id e26mr14466832uam.139.1556059379817;
        Tue, 23 Apr 2019 15:42:59 -0700 (PDT)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id d134sm7420104vkf.6.2019.04.23.15.42.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 15:42:58 -0700 (PDT)
Received: by mail-ua1-f46.google.com with SMTP id 33so682569uay.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 15:42:58 -0700 (PDT)
X-Received: by 2002:a9f:2e06:: with SMTP id t6mr1231362uaj.112.1556059377893;
 Tue, 23 Apr 2019 15:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190212180441.15340-1-keescook@chromium.org> <20190212180441.15340-3-keescook@chromium.org>
 <CAMuHMdW6N40+0gGQ+LSrN64Mo4A0-ELAm0pR3gWQ0mNanyBuUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW6N40+0gGQ+LSrN64Mo4A0-ELAm0pR3gWQ0mNanyBuUQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 15:42:46 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL-J=VTmG4SnnXxFod4G=AxNL5mdeshEKs4yNWb4aYsFw@mail.gmail.com>
Message-ID: <CAGXu5jL-J=VTmG4SnnXxFod4G=AxNL5mdeshEKs4yNWb4aYsFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib: Introduce test_stackinit module
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Emese Revfy <re.emese@gmail.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        Jann Horn <jannh@google.com>,
        Alexander Potapenko <glider@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 3:52 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Kees,
>
> On Tue, Feb 12, 2019 at 7:08 PM Kees Cook <keescook@chromium.org> wrote:
> > Adds test for stack initialization coverage. We have several build options
> > that control the level of stack variable initialization. This test lets us
> > visualize which options cover which cases, and provide tests for some of
> > the pathological padding conditions the compiler will sometimes fail to
> > initialize.
>
> With current upstream, using gcc Ubuntu 8.2.0-1ubuntu2~18.04, I get
> on m68k:

Thanks for testing this on other architectures!

> test_stackinit: u8_zero: stack fill missed target!?

Hmpf. That's frustrating. That implies that the leaf function is
assembled in such a way that the "leaking" memory address and the
"controlled" memory address on the stack end up in different
locations. I had a lot of problems with this before I unified my leaf
function. I wonder if some inlining is happening with the m68k
compiler that I haven't accounted for?

> Any idea what is wrong? I find the test code a bit hard to understand...

Yeah, there was a lot of repetition, so I tried to save my sanity and
build macros. The particular problem above is with the "test_..."'s
call of the "leaf_..." functions:

        /* Fill stack with 0xFF. */                             \
        ignored = leaf_ ##name((unsigned long)&ignored, 1,      \
                                FETCH_ARG_ ## which(zero));     \
        /* Clear entire check buffer for later bit tests. */    \
        memset(check_buf, 0x00, sizeof(check_buf));             \
        /* Extract stack-defined variable contents. */          \
        ignored = leaf_ ##name((unsigned long)&ignored, 0,      \
                                FETCH_ARG_ ## which(zero));     \

those two leaf_* invocations should produce stack variables at the
same location on the stack:

        var_type var INIT_ ## which ## _ ## init_level;         \
                                                                \
        target_start = &var;                                    \
        target_size = sizeof(var);                              \
        /*                                                      \
         * Keep this buffer around to make sure we've got a     \
         * stack frame of SOME kind...                          \
         */                                                     \
        memset(buf, (char)(sp && 0xff), sizeof(buf));           \
        /* Fill variable with 0xFF. */                          \
        if (fill) {                                             \
                fill_start = &var;                              \
                fill_size = sizeof(var);                        \

(note "target_start" and "fill_start" being assigned the location of
(in theory) the same stack location)

This gets checked later:

        /* Validate that compiler lined up fill and target. */  \
        if (!range_contains(fill_start, fill_size,              \
                            target_start, target_size)) {       \
                pr_err(#name ": stack fill missed target!?\n"); \
                pr_err(#name ": fill %zu wide\n", fill_size);   \
                pr_err(#name ": target offset by %d\n", \
                        (int)((ssize_t)(uintptr_t)fill_start -  \
                        (ssize_t)(uintptr_t)target_start));     \
                return 1;                                       \

which is where you're seeing the report.

> Also, I see comments making assumptions that are not true:
>
>     struct test_small_hole {
>             size_t one;
>             char two;
>             /* 3 byte padding hole here. */
>             int three;
>             unsigned long four;
>     };
>
> On m68k (and a few other architectures), integrals of 16-bit and larger
> are aligned to a 2-byte address, so the padding may be only a single byte.

Ah! Good point. I can update the comments, but the test should still
be valid (it just has a smaller hole).

Thanks again!

-- 
Kees Cook
