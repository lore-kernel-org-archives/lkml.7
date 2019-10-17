Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809FCFA373A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 560DE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 12:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UAxwMGPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502634AbfJQMsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 08:48:32 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46136 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502595AbfJQMs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 08:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BSKcCWiRviL7yuVf7QVZQ1HezXwIp2YHkhMLls+eGWI=; b=UAxwMGPH0baHzDDrCvBpoyp5t
        20cOK9b6vMF3TqTdgjFsEJDQ15gptizcZXRwf8aEbt5KiUP7h0rHplnsHP5ZiH0VBIDv8Ts7tglRU
        /jD90DoI6nTfe+SbL0fYwnKH0OEVkkWLlgLoTpO5wIDwZi0iJESyrotG2ocJXU+12CAzlX2Tk8v9O
        y76ilUCx9ImCodYn8PKctQS0dQXe8rTBd5I2YFcOcC7115UjAwjLojW5CjVcaGDts3fIJVRJLj0pa
        Ts0YiQmU3LoFu5buxbkFHpODMkokds8HhDilIcNOdgykS+00D/kXqAd6S4G9tnUwCvCIkjS3WxNfm
        6yWxmSHLQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55528)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iL5CS-0000pi-VL; Thu, 17 Oct 2019 13:48:17 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iL5CR-0008DC-7e; Thu, 17 Oct 2019 13:48:15 +0100
Date:   Thu, 17 Oct 2019 13:48:15 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>, kernel@pengutronix.de,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/3] watchdog servicing during decompression
Message-ID: <20191017124815.GE25745@shell.armlinux.org.uk>
References: <20191017114906.30302-1-linux@rasmusvillemoes.dk>
 <20191017120310.GD25745@shell.armlinux.org.uk>
 <c4b6805b-67fe-6bce-1777-2d81e96b4ac9@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4b6805b-67fe-6bce-1777-2d81e96b4ac9@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 02:34:52PM +0200, Rasmus Villemoes wrote:
> On 17/10/2019 14.03, Russell King - ARM Linux admin wrote:
> > We used to have this on ARM - it was called from the decompressor
> > code via an arch_decomp_wdog() hook.
> > 
> > That code got removed because it is entirely unsuitable for a multi-
> > platform kernel.  This looks like it takes an address for the watchdog
> > from the Kconfig, and builds that into the decompressor, making the
> > decompressor specific to that board or platform.
> > 
> > I'm not sure distros are going to like that given where we are with
> > multiplatform kernels.
> 
> This is definitely not for multiplatform kernels or general distros,
> it's for kernels that are built as part of a BSP for a specific board -
> hence the "Say N unless you know you need this.".
> 
> I didn't know it used to exist. But I do know that something like this
> is carried out-of-tree for lots of boards, so I thought I'd try to get
> upstream support.

Sorry, it does still exist, just been moved around a bit.

See lib/inflate.c:

STATIC int INIT inflate(void)
{
...
#ifdef ARCH_HAS_DECOMP_WDOG
    arch_decomp_wdog();
#endif

Given that it still exists, maybe this hook name should be used for
this same issue in the LZ4 code?

> The first two patches, or something like them, would be nice on their
> own, as that would minimize the conflicts when forward-porting the
> board-specific patch. But such a half-implemented feature that requires
> out-of-tree patches to actually do anything useful of course won't fly.
> 
> I'm not really a big fan of the third patch, even though it does work
> for all the cases I've encountered so far - I'm sure there would be
> boards where a much more complicated solution would be needed. Another
> method I thought of was to just supply a __weak no-op
> decompress_keepalive(), and then have a config option to point at an
> extra object file to link into the compressed/vmlinux (similar to the
> initramfs_source option that also points to some external resource).
> 
> But if the mainline kernel doesn't want anything like this
> re-introduced, that's also fine, that just means a bit of job security.

Well, we'll see whether the arm-soc people have anything to add...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
