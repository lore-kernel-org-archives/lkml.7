Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38412C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C8121479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 21:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uu+pR4K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbfJGVqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:46:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34722 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbfJGVqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 17:46:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id y35so9039651pgl.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 14:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QXb17KO+aaTb9iSIuGo/6wibZdR0MZ0rDkPqukvilAM=;
        b=Uu+pR4K3lVtvbqUe+qBy2kwwSW987fMlpT86iMKCGuTNzumfkGvgSvaLPbgBoURd+z
         eo/xS9U8Vkqx9YrbIGg7WvZoz5oVBhp/PyaAD3k/883nlYImUXWcnznvUgR61KS1qQMS
         Uf1P6HBgtlmlEUf5fuNWT6GnbzUwQqyKNruL/lpESCRcwmD4NKfjTCWqiNO71ZJTklvr
         HbDvsa0R7yzCPAPsJkE5n0HTFCZCA2KTbnnEmZqzy7hvxhQbNSRSDwxi9f+dtZbBrOAZ
         IWS02u65LnOicJtK2m73IiGbl1vIahncmXXHtLAMp38/Fk9dypnSq6N9qR0LHloHOjcH
         7KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QXb17KO+aaTb9iSIuGo/6wibZdR0MZ0rDkPqukvilAM=;
        b=tVjgFOygHWvzwM1OggUNCdp1cwW7mpoWOwmG2fL7xjKhqgDTI85UeXA6USPfV2jI6u
         H+FXxr3/a3AgGJnlVhPOtecsw0otoKXXndR+IsJYJUOw2d57uTUrcijhUUWNdpUEp7pj
         WmHY3YJh3P8gRjCo3oRLGTEls2SBdAcmD5EN+gnN2aYD4NKLR7KxAeIvPJieUEX5Dk4c
         RKfAlsUVn3ApCyZtr/Xzdw1CXMZr6Yzoe4/77m6va20KwyWCz8TF4zf5toSlwRp8UrlX
         oFS8NDNDni8vNstXlb66Or1wzD72fnWrrMzprET6OhuV2Z8kG2z4vukJlk+ya2X898rd
         /5Jw==
X-Gm-Message-State: APjAAAWUQGYO7216narRuf6OYuPrtF3gO0tQKFJYj9/gV19AMUBGAG7l
        hANPHhqjKyYjV5nhrT6LgqO2jyx058AvGl0wQvtQtw==
X-Google-Smtp-Source: APXvYqw+0il7qlP4A2/lUfKoYuXJsc5yiAMjSSfJLRuXEdwLXtGPjG1nzT2ac7ISvwG4aa3gbooME1RCU4UO8GVgTYY=
X-Received: by 2002:a62:798e:: with SMTP id u136mr35718450pfc.3.1570484808071;
 Mon, 07 Oct 2019 14:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191007201452.208067-1-samitolvanen@google.com>
 <CAKwvOdmaMaO-Gpv2x0CWG+CRUCNKbNWJij97Jr0LaRaZXjAiTA@mail.gmail.com> <CABCJKufxncBPOx6==57asbMF_On=g1sZAv+w6RnqHJFSwOSeTw@mail.gmail.com>
In-Reply-To: <CABCJKufxncBPOx6==57asbMF_On=g1sZAv+w6RnqHJFSwOSeTw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 7 Oct 2019 14:46:36 -0700
Message-ID: <CAKwvOd=k5iE8L5xbxwYDF=hSftqUXDdpgKYBDBa35XOkAx3d0w@mail.gmail.com>
Subject: Re: [PATCH] arm64: lse: fix LSE atomics with LLVM's integrated assembler
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 2:24 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> On Mon, Oct 7, 2019 at 1:28 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> > I tried adding `.arch armv8-a+lse` directives to all of the inline asm:
> > https://github.com/ClangBuiltLinux/linux/issues/573#issuecomment-535098996
>
> Yes, I had a similar patch earlier. I feel like using a command line
> parameter here is cleaner, but I'm fine with either solution.
>
> > One thing to be careful about is that blankets the entire kernel in
> > `+lse`, allowing LSE atomics to be selected at any point.
>
> Is that a problem? The current code allows LSE instructions with gcc
> in any file that includes <asm/lse.h>, which turns out to be quite a
> few places.

I may be mistaken, but I don't think inline asm directives allow the C
compiler to change what instructions it selects for C code, but
command line arguments to the C compiler do.

Grepping the kernel for some of the functions and memory orderings
turns up a few hits:
https://gcc.gnu.org/onlinedocs/gcc/_005f_005fatomic-Builtins.html

I'm worried that one of these might lower to LSE atomics without
ALTERNATIVE guards by blanketing all C code with `-march=armv8-a+lse`.
But I did just boot test this patch but using GAS in QEMU (on a -cpu
cortex-a72 which I suspect should not have lse instructions by default
IIUC), FWIW.
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Maybe the maintainers have more thoughts?
-- 
Thanks,
~Nick Desaulniers
