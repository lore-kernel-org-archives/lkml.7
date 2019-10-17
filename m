Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FD2FA3733
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE0120854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="I6hadmvq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391475AbfJQMD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:03:26 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45546 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbfJQMDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7QFAM3FyNjZLdWgCaHNKxlUOPObBomQiiiC1wmyqmnc=; b=I6hadmvq9y5VVf5dyNAUB7pa5
        cUIfFm/JE/7T9C6zx9cvRw/63isjp+CLNHRUkWaHP7pF1c5zceKV2VVD2SGK/S/0IiaJ4SLzpD+TC
        /TMSjiLLFORwSj7wFomfLaugUIIx3ZGIf4QMB/SG84qzNW/eC/5pERNEGc7o7GKlBlsGHeNspk3ZZ
        q69Bx0NeHFQz0pw8qx1kf60qUTxtiDYh4X8l3ddRFpkrYR4CyUrWZAqYxSiKWqs16DKBI0BOQ9UNt
        GiCB5L3dG8s5rHOXerd24Anz8gkXYyf/bWWVoZQ0jJqGL+VB9im+L2NentYV4o/+ujbZOiIYCqYk+
        GjyGVxDyw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:43864)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iL4Us-0000c9-VM; Thu, 17 Oct 2019 13:03:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iL4Uo-0008B9-UN; Thu, 17 Oct 2019 13:03:10 +0100
Date:   Thu, 17 Oct 2019 13:03:10 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>, kernel@pengutronix.de,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/3] watchdog servicing during decompression
Message-ID: <20191017120310.GD25745@shell.armlinux.org.uk>
References: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We used to have this on ARM - it was called from the decompressor
code via an arch_decomp_wdog() hook.

That code got removed because it is entirely unsuitable for a multi-
platform kernel.  This looks like it takes an address for the watchdog
from the Kconfig, and builds that into the decompressor, making the
decompressor specific to that board or platform.

I'm not sure distros are going to like that given where we are with
multiplatform kernels.

On Thu, Oct 17, 2019 at 01:49:03PM +0200, Rasmus Villemoes wrote:
> Many custom boards have an always-running external watchdog
> circuit. When the timeout of that watchdog is small, one cannot boot a
> compressed kernel since the board gets reset before it even starts
> booting the kernel proper.
> 
> One way around that is to do the decompression in a bootloader which
> knows how to service the watchdog. However, one reason to prefer using
> the kernel's own decompressor is to be able to take advantage of
> future compression enhancements (say, a faster implementation of the
> current method, or switching over when a new method such a zstd is
> invented) - often, the bootloader cannot be updated without physical
> access or is locked down for other reasons, so the decompressor has to
> be bundled with the kernel image for that to be possible.
> 
> This POC adds a linux/decompress/keepalive.h header which provides a
> decompress_keepalive() macro. Wiring up any given decompressor just
> amounts to including that header and adding decompress_keepalive() in
> the main loop - for simplicity, this series just does it for lz4.
> 
> The actual decompress_keepalive() implementation is of course very
> board-specific. The third patch adds a kconfig knob that handles a
> common case (and in fact suffices for all the various boards I've come
> across): An external watchdog serviced by toggling a gpio, with the
> value of that gpio being settable in a memory-mapped register.
> 
> Rasmus Villemoes (3):
>   decompress/keepalive.h: prepare for watchdog keepalive during kernel
>     decompression
>   lib: lz4: wire up watchdog keepalive during decompression
>   decompress/keepalive.h: add config option for toggling a set of bits
> 
>  include/linux/decompress/keepalive.h | 22 +++++++++++++++++++
>  init/Kconfig                         | 33 ++++++++++++++++++++++++++++
>  lib/lz4/lz4_decompress.c             |  2 ++
>  3 files changed, 57 insertions(+)
>  create mode 100644 include/linux/decompress/keepalive.h
> 
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
