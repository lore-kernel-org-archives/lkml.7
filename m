Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BD4C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5D3218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbfGDI3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:29:55 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36749 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbfGDI3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:29:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so3761002qtc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 01:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RFmMgkVZHIc+hggtnVg4fw1omd/KE2MoFxH+LLbDpD4=;
        b=IJnzPhJHx7ycV3N+r7zZ7vezmJU4eh+qPOPOf9fV9wrcWT3w8MyFIlyl3g+FszCNX3
         tVRIdtNuW8l4oYLdPO4d5DMcKKDmbr5yBhPKoDryWJlXiX5cHCj0GEoCiFpseLNMMj66
         Wd93z0jiR9TJvh0r3FCuBxk4BvbNXd7ONnvG5hQObum+Swd3F1NeHhagYeAUHYQyceHh
         bJrLuXJgp6lVClez8yXbZcs97JjI0GBy6Tr1ytnBM0Vqz0N6slG367PtPBcclBklrxF9
         WjaVzwnT4NoN6IB+sStMhTT4BQOF3gMKFWflQUw3JvoN66LH4+O1OomU0kYp3NlQRtW6
         ZJeg==
X-Gm-Message-State: APjAAAW3DFVTfk1gwzMU/eb0w4VMCdlCadm0vBrIeD/WrwMw1zNmqaSq
        JAql+1wcqU7o4YVuk9A9ow6FtjEZhVCt9uf8G6U=
X-Google-Smtp-Source: APXvYqwJFMCQCtMsTiaLiR6XMLB1UTBw7xYeSw8A7ovdT5Dz/5yZZGGu3AyB+xVCIvV7IyZSiu3LSVM0ayKR5cZo3rc=
X-Received: by 2002:a0c:d941:: with SMTP id t1mr36020008qvj.176.1562228992003;
 Thu, 04 Jul 2019 01:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190625210441.199514-1-ndesaulniers@google.com> <CACRpkdb+WO4WDS5S1uqPgYFHnz1ch0=DwTKaAxTF3_zid+zH4g@mail.gmail.com>
In-Reply-To: <CACRpkdb+WO4WDS5S1uqPgYFHnz1ch0=DwTKaAxTF3_zid+zH4g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Jul 2019 10:29:35 +0200
Message-ID: <CAK8P3a1Oucpi0smL1poiKJj9Gc=s_6tVirTDkZwA68cuOjvB7g@mail.gmail.com>
Subject: Re: [PATCH] ARM: Kconfig: default to AEABI w/ Clang
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Mark Brown <broonie@kernel.org>,
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

On Thu, Jul 4, 2019 at 10:13 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jun 25, 2019 at 11:04 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> > Clang produces references to __aeabi_uidivmod and __aeabi_idivmod for
> > arm-linux-gnueabi and arm-linux-gnueabihf targets incorrectly when AEABI
> > is not selected (such as when OABI_COMPAT is selected).
> >
> > While this means that OABI userspaces wont be able to upgraded to
> > kernels built with Clang, it means that boards that don't enable AEABI
> > like s3c2410_defconfig will stop failing to link in KernelCI when built
> > with Clang.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/482
> > Link: https://groups.google.com/forum/#!msg/clang-built-linux/yydsAAux5hk/GxjqJSW-AQAJ
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
> As reflecting the state of things with CLANG it's:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> But I think we in general need to have some discussion on how to
> proceed with OABI userspaces.
>
> I am well aware of distributions like OpenWrt using EABI even
> on ARMv4 with "tricks" like this:
> https://github.com/openwrt/openwrt/blob/master/toolchain/gcc/patches/9.1.0/840-armv4_pass_fix-v4bx_to_ld.patch

I did not expect that to be necessary in gcc as long as it supports
building for armv4 (non-t), but I might be missing something here.

> I have one OABI that I can think of would be nice to live on
> and it's the RedHat derivative on my Foorbridge NetWinder.
> OK I wouldn't cry if we have to kill it because it is too hard to
> keep supporting it, but it has been running the latest kernels
> all along so if it's not a huge effort I'd be interested in knowing
> the options.

But do you see any problems with cross-compiling kernels to
EABI with CONFIG_OABI_COMPAT for machines like that?

I would guess that you can't actually build modern kernels
on the RedHat OABI compiler any more as they presumably
predate the current minimum gcc-4.6.

      Arnd
