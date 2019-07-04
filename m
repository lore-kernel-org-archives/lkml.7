Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC9CC0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78EA216E3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 07:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfGDHYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 03:24:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33045 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfGDHYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 03:24:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so4893010qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 00:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDiJLmK4lsRv09/RWmHspT7s3JNRwYIRRTfdV0/KcPk=;
        b=gJsMi6U2llYn7n+ocKBEioqzM4MOMoZa7aZGmMNAJGkIR4DOYezB8CYvGo6H36bRUC
         Wo3HsdTZDHB8ZDw059Xm3Bm1f3aXG2zPlUHWSdVUDaWeiggJpg6GQ3I/wWZ7dfYl3JD5
         lkzYOd0hr32+hHpmbIBAMcE5TXTfoLT9kkhzg3U1P1+/jDHtq6gf7HIIaHu4h/lUpOnX
         ThK3zGP/SGu6dmfBSEnECV46OfoXL/iJkhp2OsLl7DGUabTc9QeQvDFTX7nc5KKL5RA0
         Q4ALeuX6vByKNOFxfIKODedU9a8Z1PVFS3M+pL+YRFRKSb60UYSC58nmyb/NSpnhKcBz
         V5qA==
X-Gm-Message-State: APjAAAXizAlpQfHm6A3qg4af7I4zNK8ipOEG0AaNms/7Jp34xl/oYq0/
        ODxtlnqXlmuf0iaRbbMXc51gDlt9NkHvvbaaylAV75dTcxo=
X-Google-Smtp-Source: APXvYqwxlD/P4CCDKjMVGdG8xPJcet52JK9nvRYqifka3GsmjS95OecKwRPDaEtQSxIxvevA4hsIaxG54zrpthr+8r8=
X-Received: by 2002:a37:ad12:: with SMTP id f18mr33567291qkm.3.1562225082093;
 Thu, 04 Jul 2019 00:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190625210441.199514-1-ndesaulniers@google.com>
In-Reply-To: <20190625210441.199514-1-ndesaulniers@google.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jul 2019 09:24:24 +0200
Message-ID: <CAK8P3a2uW+a_=siusLTt=rq-erw1tyJfU8PDGaXuVcJoKHjpRw@mail.gmail.com>
Subject: Re: [PATCH] ARM: Kconfig: default to AEABI w/ Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:04 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> Clang produces references to __aeabi_uidivmod and __aeabi_idivmod for
> arm-linux-gnueabi and arm-linux-gnueabihf targets incorrectly when AEABI
> is not selected (such as when OABI_COMPAT is selected).
>
> While this means that OABI userspaces wont be able to upgraded to
> kernels built with Clang, it means that boards that don't enable AEABI
> like s3c2410_defconfig will stop failing to link in KernelCI when built
> with Clang.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/482
> Link: https://groups.google.com/forum/#!msg/clang-built-linux/yydsAAux5hk/GxjqJSW-AQAJ
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Looks good to me,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Please add it to Russell's patch tracker if you haven't already.

Most of the .config files that don't set AEABI (and a lot of the others
as well) have likely never been booted on real hardware with a modern
kernel in a long time. There have not been any distros using OABI in
a long time (Debian Lenny was released in 2009), and gcc dropped
support for it a few years later.

We could probably change most of these to use OABI_COMPAT
instead, aside from any ones that Russell wants to keep building as
OABI for his own machines.

       Arnd
