Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA62C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF0B20835
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 23:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nqfCPKIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfJGXre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 19:47:34 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41524 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729285AbfJGXre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 19:47:34 -0400
Received: by mail-io1-f66.google.com with SMTP id n26so32566995ioj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnyKJXgvVV5y+/tv5Bz/6ObFZv040M9Q4q4p9btukJg=;
        b=nqfCPKIkw/QtLVf4eqHJtTDJXz37adv415i9bljTDdUGy2FjcbLL/+aXv3HaqtSxzD
         yyS7OY28oZ38h61wHIUTpkHqgPwy6gSQ7roDyoDUyfVEe+Y0qKoBqItPwxu7fzX7Ouy5
         nM4wfdGeLVf8PFVIOctRD2ixiFPLRqvphtBDZYlntcud2Gu1X60dT8wGbEvPL5MGP0x3
         WntykciyaoRdEJbXHMPGD4iMSL7sQcz0bBNPdT/1EyYhbN6UULKkc6DcWyvBREpVqIz7
         rexpyOXoMR/4YilIk1wmq9DLj6nWFq16ohWPfKCKdzYKg582zTzu/ae5dkjphuEJEY2K
         AkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnyKJXgvVV5y+/tv5Bz/6ObFZv040M9Q4q4p9btukJg=;
        b=OoKUWT1LH+B9bvfX2gcxiI2Yu1a+iTCrL2DBGAjQaaI/7ZxK3LXLRo5VLMyoBlEApn
         nmOBpi+7xcgqME7wTnxbliSxYg+ZXpfckwJELEU8vFXQkB0LRLMTuAYDj+w9YhXIUcrb
         ngMPaGO4gu8zrJJ8r5LBkNsmWqeY961/4av4wDpMcvJJl4oXquE7LUthylRirtH7Ba7L
         KdOu7EmEjbthDlmK7t5XjQA7MmJjOxgzv9lY5aYiIITEJjn4tFCnFqe+DbR8HoC8Swq7
         2QvN6Bisp944nLrqCjPuebFHdsGOIr77vOnjS28+nYTeDl+9tHJCQctvkmN6mJ1LaJPB
         j1PA==
X-Gm-Message-State: APjAAAWv3z+svOzqVUUd+NhFKCnRNO+q2nhnULuValYj91VMOyRcLmWv
        aH+vK+6rVUFtXhTuaGq7Bkgp9cri5fxVkBnJ6gbubg==
X-Google-Smtp-Source: APXvYqy3iuwM+fuQ2e1niDMO0G88x663EHTMj7UbRHawO+HQzH+oAmqg7JZkS6dXuTQiJmf70kkjxNJREraGq/21fFc=
X-Received: by 2002:a6b:f411:: with SMTP id i17mr27210166iog.201.1570492052741;
 Mon, 07 Oct 2019 16:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20191007211418.30321-1-samitolvanen@google.com> <CAKwvOdnX6O0Grth11R8JLoD9bp-BECheucZKHbiHt4=XpQferA@mail.gmail.com>
In-Reply-To: <CAKwvOdnX6O0Grth11R8JLoD9bp-BECheucZKHbiHt4=XpQferA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 7 Oct 2019 16:47:20 -0700
Message-ID: <CABCJKudGtvVazLpZFdbhe9z-4mx_t16zxzkcwYbdAJriakrWqw@mail.gmail.com>
Subject: Re: [PATCH] arm64: fix alternatives with LLVM's integrated assembler
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 2:34 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> Should the definition of the ALTERNATIVE macro
> (arch/arm64/include/asm/alternative.h#L295) also be updated in this
> patch to not pass `1` as the final parameter?

No, that's the default value for cfg in case the caller omits the
parameter, and it's still needed.

> I get one error on linux-next that looks related:
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make CC=clang AS=clang
> -j71 arch/arm64/kvm/
> ...

This patch only touches the inline assembly version (i.e. when
compiling without -no-integrated-as), while with AS=clang you are
using clang also for stand-alone assembly code. I believe some
additional work is needed before we can do that.

> arch/arm64/kvm/hyp/entry.S:109:87: error: too many positional arguments
>  alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) |
> ((!!1) << 8)), 4, 1
>
>                ^
>
> Since __ALTERNATIVE_CFG now takes one less arg, with your patch?

__ALTERNATIVE_CFG (with two underscores) is only defined for C code,
and this patch doesn't change the definition of _ALTERNATIVE_CFG (with
one underscore) that's used for stand-alone assembly.

Sami
