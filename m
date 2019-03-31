Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E29C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3EBC2082C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 17:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfCaRfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 13:35:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45948 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbfCaRfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 13:35:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id v20so7943392qtv.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 10:35:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/gjdB4SoHlm9ZmWAZsmFD/rFsiLq8oc9ztEdOrcodA8=;
        b=kmMR9MSAdkKVnKiun9oVj6WwfXbHZwdrrc71ybukxRCuCqHzgxTUAY4iHu9NW3o0iz
         7Sx5BkqLHbIx4hvKAj9H/KZX6p9+5oZMZIFcSVUaGKmMGWjvk3OrjQp5YVGOJdPeSyOk
         +TjXYTMQ8Ow3YH+8mkahHlyBisFlwAOGW9at5DWmuMmxmpVqtZ9oijzQ7c84ChocqRiD
         72JmshI2zaYV86V6O7Jq885q7apSZHC6N7bWcJ0IcZYrCBXcdOU6csxl8uX1aBp3cJqy
         /C/8jb74McwntJmHgodGvQRS1/W9jG/teR1cbWpLB/xWezsyTWHPSiAojAu/MmY7T1wf
         nC/g==
X-Gm-Message-State: APjAAAVEkbs8o3CRFtg8tU1Ci0H/5S+PnSvs1Bk2XzpZOnageDaKdxuM
        VvsgTkndhx1bZi2aMAu6RsddDQEZ50/qqPZBjTI=
X-Google-Smtp-Source: APXvYqwvqoZ2leHF6sRF3IlsLTRCun5cqiDQVOJUNPVrYTyRsFVp20NhIqcQHS5eZLvpPm6iNyCc6ycjDCAXo0aYFis=
X-Received: by 2002:ac8:1637:: with SMTP id p52mr49432977qtj.212.1554053707273;
 Sun, 31 Mar 2019 10:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <9641c58c03720104186a797a96e30a52ae9805e4.1553356359.git.stefan@agner.ch>
 <CAK8P3a0XBN+noCkdGT_TYfPNY1j9CcVH8mTjh_mQL3w+Z6jfaw@mail.gmail.com>
In-Reply-To: <CAK8P3a0XBN+noCkdGT_TYfPNY1j9CcVH8mTjh_mQL3w+Z6jfaw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 1 Apr 2019 00:34:49 +0700
Message-ID: <CAK8P3a0=-JBSkOO8=68QWvNagaHm7ij2aNOJ_1Oo9GyVSeTAoQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: use arch_extension directive instead of arch argument
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 3:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sat, Mar 23, 2019 at 4:52 PM Stefan Agner <stefan@agner.ch> wrote:
> >
> > The LLVM Target parser currently does not allow to specify the security
> > extension as part of -march (see also LLVM Bug 40186 [0]). When trying
> > to use Clang with LLVM's integrated assembler, this leads to a build
> > errors such as this:
> >   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
> >
> > Use ".arch_extension sec" to enable the security extension in a more
> > portable fasion.
> >
> > Note that this is technically not exactly the same as the old code
> > checked for availabilty of the security extension by calling as-instr.
> > However, there are already other sites which use ".arch_extension sec"
> > unconditionally, hence de-facto we need an assembler capable of
> > ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
> > arch extension "sec" is available since binutils 2.21 according to
> > its documentation [1].
> >
> > [0] https://bugs.llvm.org/show_bug.cgi?id=40186
> > [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
> >
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>
> This sounds like a good idea. I think we have platform specific
> minimum toolchain versions elsewhere, but I don't see a problem
> with raising the minimum version for all the armv7ve platforms.
>
> I've added this patch to my randconfig test queue, but please
> send it to arm@kernel.org for inclusion when you have
> collected more Acks.
>
> Do you have a git tree with other patches required for the
> integrated assembler? I might try that out as well with
> my randconfig tree. At the moment I'm building with
> clang-8 and a small number of patches on top.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I only now looked at the results and found a problem:
In a mixed v6/v7 configuration, the arch_extension flag
is not sufficient, and for armv6+sec, we get failures like

/git/arm-soc/arch/arm/mach-omap2/sleep44xx.S: Assembler messages:
/git/arm-soc/arch/arm/mach-omap2/sleep44xx.S:343: Error: selected
processor does not support `isb' in ARM mode
/git/arm-soc/arch/arm/mach-omap2/sleep44xx.S:350: Error: selected
processor does not support `dsb' in ARM mode
/git/arm-soc/arch/arm/mach-omap2/sleep44xx.S:351: Error: selected
processor does not support `dmb' in ARM mode
clang: error: assembler command failed with exit code 1 (use -v to see
invocation)
/git/arm-soc/scripts/Makefile.build:369: recipe for target
'arch/arm/mach-omap2/sleep44xx.o' failed
make[3]: *** [arch/arm/mach-omap2/sleep44xx.o] Error 1

==> build/arm/0x64728DCE_defconfig/log <==
/git/arm-soc/arch/arm/mach-omap2/omap-smc.S: Assembler messages:
/git/arm-soc/arch/arm/mach-omap2/omap-smc.S:31: Error: selected
processor does not support `dsb' in ARM mode
/git/arm-soc/arch/arm/mach-omap2/omap-smc.S:53: Error: selected
processor does not support `dsb' in ARM mode
/git/arm-soc/arch/arm/mach-omap2/omap-smc.S:54: Error: selected
processor does not support `dmb' in ARM mode

         Arnd
