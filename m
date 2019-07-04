Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A8C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BCC218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APAkpnfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfGDINn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:13:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37434 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbfGDINn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:13:43 -0400
Received: by mail-lj1-f195.google.com with SMTP id 131so5259839ljf.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8/CcxemkjOqw5vcRGpz7IYCIwc+17181uPGqaEJ7DY=;
        b=APAkpnfHLvATo/cfO3VfhryPgqeKWK3eEzpcEb4pRP1HLVWneySxnm8R2wn6T44lcQ
         Dvum7So8gTEHI6athp0y5DDOIDKEr0UHL+SMuN2r/iWLAGUUSXBKo7ee6X6SNTXN2PSx
         K70PNJw0ET+Lrq1cVf0W28fL1Tmw1yhEshBcTe0DhcFgAAomD/C0Uhock2tBPmZNYQsD
         Nei1naxT+HjPVUa2JIPGcD5/JCqHQlpx5c8cVIhBHTJWl9U072uiFf2h7Poz6hQ2UgWB
         VPR7dETeyIFU2ISmA5ow6Az2GQL85/AFU+803NNSYdJlGXM3lFkBM+ppggCKbJXnQg4i
         Q6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8/CcxemkjOqw5vcRGpz7IYCIwc+17181uPGqaEJ7DY=;
        b=SN1VTe9OkX64QaLX7nNgCQNp9V5OsK5nwz3vUQYTTrga2Au24z+ct82/y+ncZfsXcF
         /19umul3UFyIW/itGwx5FpT8giZhGKkbeA3WwD/tAp5kDW29NPyyNes7dCf5R46DlsYt
         QBgWmFlS/n9VgVBCP5hVov/Hz5ARAFLxlyyC88T+6qd+YtElx9uJeAqMRelaUeIO3MXl
         Cv3lJhH5XJxnO9kh5PBSFZj319fQgJ5JzCcjppcalLDyui1owlDhbG80nEjpM63kh8qw
         X9Y8okVmynY8diiGaZjsx4tMCld+YN5VOk7gRAWUnokfZ+V0M5PdpmxpjO4OkerpoiaU
         sERA==
X-Gm-Message-State: APjAAAWmeTCSFIr3CI21Qs8imvZeI1emNCqGhgVvhJxyqAPvxMnsxQW0
        i17dfLaCA/T7PvvYTA/R9tIPkt6K9Wk96/AcDukRRQ==
X-Google-Smtp-Source: APXvYqwqS8eE5mm2UJA47bQpgGFKawwQlQgyL0E+56rYCcHzHx7Ty1GdAApYQ9TLFZ0jRsmLISKBV0pCKV38BATWBLI=
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr24105118ljm.180.1562228020926;
 Thu, 04 Jul 2019 01:13:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190625210441.199514-1-ndesaulniers@google.com>
In-Reply-To: <20190625210441.199514-1-ndesaulniers@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 4 Jul 2019 10:13:29 +0200
Message-ID: <CACRpkdb+WO4WDS5S1uqPgYFHnz1ch0=DwTKaAxTF3_zid+zH4g@mail.gmail.com>
Subject: Re: [PATCH] ARM: Kconfig: default to AEABI w/ Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        clang-built-linux@googlegroups.com,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 11:04 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:

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

As reflecting the state of things with CLANG it's:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

But I think we in general need to have some discussion on how to
proceed with OABI userspaces.

I am well aware of distributions like OpenWrt using EABI even
on ARMv4 with "tricks" like this:
https://github.com/openwrt/openwrt/blob/master/toolchain/gcc/patches/9.1.0/840-armv4_pass_fix-v4bx_to_ld.patch

I have one OABI that I can think of would be nice to live on
and it's the RedHat derivative on my Foorbridge NetWinder.
OK I wouldn't cry if we have to kill it because it is too hard to
keep supporting it, but it has been running the latest kernels
all along so if it's not a huge effort I'd be interested in knowing
the options.

Yours,
Linus Walleij
