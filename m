Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E13C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012402555B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:37:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fLRznBU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfEaIhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:37:34 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:56896 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:37:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aD3U7N/s0lwF+/SYuqBwQeQwlIeOJ1o/iBWxkc0TtmA=; b=fLRznBU+sBWjub6ytJS5zqE3H
        r+vhsP6RHXhKgEAnci111laadWQiVtg7PNfpY6qmAitP/O1cJfaOzL1EBdSOXLJyebmRpqUGjsOXM
        EvTQimWdYku6ZHhuzqlYow+WDeYt5qIBUQHWNxRzIOBZ23RFj6oPLp0Mc2H7OusFVGK46CAj/B5rr
        uTICFtdV91+X0m2U7Pt0JmkcyCTPpXUDDAHDiXoPiqnH3pN9c3QMDuua8TrXhsSR4xDa+zQ+/y3rB
        7djHQKNBy6sarZjVWT/U+KUABnNCax+91YcasFUZkoZsH+c8ABlOON10Q2CyHCK63UfBHGGUv68UI
        pzCyysAeA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:38394)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1hWd2V-00088P-32; Fri, 31 May 2019 09:37:27 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1hWd2T-00068p-1y; Fri, 31 May 2019 09:37:25 +0100
Date:   Fri, 31 May 2019 09:37:24 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] arm: vdso: pass --be8 to linker if necessary
Message-ID: <20190531083724.uc32co24qxfodlty@shell.armlinux.org.uk>
References: <20190529182324.8140-1-Jason@zx2c4.com>
 <CAK7LNARFUaaJH+g3oGzwFyKnELum72nOzxnvUfMKYBaAoGVkug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARFUaaJH+g3oGzwFyKnELum72nOzxnvUfMKYBaAoGVkug@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2019 at 11:01:23AM +0900, Masahiro Yamada wrote:
> Hi Jason,
> 
> Thanks for catching this.
> 
> On Thu, May 30, 2019 at 3:26 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > The commit fe00e50b2db8 ("ARM: 8858/1: vdso: use $(LD) instead of $(CC)
> > to link VDSO") removed the passing of CFLAGS, since ld doesn't take
> > those directly. However, prior, big-endian ARM was relying on gcc to
> > translate its -mbe8 option into ld's --be8 option. Lacking this, ld
> 
> 
> 'git grep -- -mbe8' has no hit.

It isn't -mbe8, it is --be8

$ arm-linux-gcc --target-help
...
  --be8                       Output BE8 format image

> 
> Is it a toolchain internal flag?
> 
> 
> 
> > generated be32 code, making the VDSO generate SIGILL when called by
> > userspace.
> >
> > This commit passes --be8 if CONFIG_CPU_ENDIAN_BE8 is enabled.
> >
> > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  arch/arm/vdso/Makefile | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> > index fadf554d9391..1f5ec9741e6d 100644
> > --- a/arch/arm/vdso/Makefile
> > +++ b/arch/arm/vdso/Makefile
> > @@ -10,9 +10,10 @@ obj-vdso := $(addprefix $(obj)/, $(obj-vdso))
> >  ccflags-y := -fPIC -fno-common -fno-builtin -fno-stack-protector
> >  ccflags-y += -DDISABLE_BRANCH_PROFILING
> >
> > -ldflags-y = -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> > +ldflags-$(CONFIG_CPU_ENDIAN_BE8) := --be8
> > +ldflags-y := -Bsymbolic --no-undefined -soname=linux-vdso.so.1 \
> >             -z max-page-size=4096 -z common-page-size=4096 \
> > -           -nostdlib -shared \
> > +           -nostdlib -shared $(ldflags-y) \
> >             $(call ld-option, --hash-style=sysv) \
> >             $(call ld-option, --build-id) \
> >             -T
> > --
> > 2.21.0
> >
> 
> 
> --
> Best Regards
> Masahiro Yamada
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
