Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06C7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996592175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCTJmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:42:02 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43737 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCTJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:42:01 -0400
Received: by mail-qk1-f194.google.com with SMTP id c20so8913860qkc.10;
        Wed, 20 Mar 2019 02:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wcem8o0HHIzqutiHXBbDWombZs0tH1uJm1IkFEOS1gM=;
        b=K00Zg9JACrnbs/JhvwjDpPiHiu2XYf6RNfh7dywAcagQkS0qyCc36otGSKldfF64AS
         TlqER+c4AmmlTP/JJnoDF9Gkmw6BKzjJut3b8RSsHejXUOTd7UkGXXWyjMLoX/JEhVGl
         V37efC6Hvkb1QNjE4R4Mf2KUmUR0HR4pA+UFz7CtBxThsg4WJJglpO+bXOsZxGmjfSlk
         4Ee4eEnxjPD8VwQGh+Bu91e7hIZQIOR63N7q2rLElLH62/6Yu6B8UAFima093nB3grEp
         EOzC5Z87Dl5lFUZzPDsPK4UVouqMzcUMbqmBcpO/zW8fq9zB9Lybv+bZWIytUE7SrKu2
         bYcw==
X-Gm-Message-State: APjAAAXQllMFQG1x6kBBD0cHUGtXp4t01USZrPxo93UAve+70bGD7rJm
        KOnvn0U/BJ4YHsSt5YJaVa5YWKrSp/w5G/tWkOU=
X-Google-Smtp-Source: APXvYqzQSLM2qs76g1mPFR6+NFZQ+VxO7eK9lVtHjHmQgwnJhO043jU8NlghsFKH8kP1B/2Ljhps92bIbDCGPPfMWi4=
X-Received: by 2002:ae9:dec2:: with SMTP id s185mr5394316qkf.107.1553074920561;
 Wed, 20 Mar 2019 02:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Mar 2019 10:41:43 +0100
Message-ID: <CAK8P3a3BG_mxYxxCx4S_+ZKAer_+5FpmkzLk0VrACZekuD=2GQ@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Dave Hansen <dave@sr71.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linux-mips@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 7:21 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
>
> The idea is obviously arch-agnostic although we need some code fixups.
> This commit moves the config entry from arch/x86/Kconfig.debug to
> lib/Kconfig.debug so that all architectures (except MIPS for now) can
> benefit from it.
>
> At this moment, I added "depends on !MIPS" because fixing 0day bot reports
> for MIPS was complex to me.
>
> I tested this patch on my arm/arm64 boards.
>
> This can make a huge difference in kernel image size especially when
> CONFIG_OPTIMIZE_FOR_SIZE is enabled.
>
> For example, I got 3.5% smaller arm64 kernel image for v5.1-rc1.
>
>   dec       file
>   18983424  arch/arm64/boot/Image.before
>   18321920  arch/arm64/boot/Image.after
>
> This also slightly improves the "Kernel hacking" Kconfig menu.
> Commit e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen')
> mentioned this config option would be a good fit in the "compiler option"
> menu. I did so.

I think this is a good idea in general, but it is likely to cause a lot of
new warnings. Especially the -Wmaybe-uninitialized warnings get
new false positives every time we get substantially different inlining
decisions.

I've added your patch to my randconfig test setup and will let you
know if I see anything noticeable. I'm currently testing clang-arm32,
clang-arm64 and gcc-x86.

      Arnd
