Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C608C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C1621736
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IjC7afpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfK0XTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:19:34 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:46064 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfK0XTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:19:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ua2UG/3P9FGM6hlUDIsduttPdTTUDw7lB1+OC0/Vfew=; b=IjC7afpgiGMCcN4wtGhOcSgAp
        IBpLPlsr+Nb0dfjpSQITFGlg9cdDYE+YLytWxj+dAlh1QFZ5rsVVHTJEjeuPXLA+ZLytfzENdxqJC
        Xtl0lkHMghG6tdcGWtLM+Gu8QOjKU6T2NJXmkeUJuT3CDqrYgPC5CViy3LKtnRLd4YHPHmvAtD5oH
        pXSPlBWSep8AOrtyYM2g+Jye9/vNXyiDr7Y2tgxMtpo+tRcRxNMQCqcsifEbTfE4PYXBg5MvnJsbp
        w7ssCmpKKNTAQ+Nd9CTgcEIDsoFN/8MYItxVxm9ZNyqSdrlyuqCMfJH5QHd3NBzURQFvvtI0WOnA4
        fL0WaxJzw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45502)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ia6aW-0005x5-LR; Wed, 27 Nov 2019 23:19:12 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ia6aK-0000gJ-V4; Wed, 27 Nov 2019 23:19:00 +0000
Date:   Wed, 27 Nov 2019 23:19:00 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>,
        "nico@fluxnic.net" <nico@fluxnic.net>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: ARM expections for location of kernel, ramdisk and dtb
Message-ID: <20191127231900.GG25745@shell.armlinux.org.uk>
References: <e1f7cca54843abcef0c2703a5f7071c045b99baa.camel@alliedtelesis.co.nz>
 <20191127092615.GC25745@shell.armlinux.org.uk>
 <c108d58e3ee511040bb99edb28c893b27b238bdb.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c108d58e3ee511040bb99edb28c893b27b238bdb.camel@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 10:15:57PM +0000, Chris Packham wrote:
> Hi Russell,
> 
> On Wed, 2019-11-27 at 09:26 +0000, Russell King - ARM Linux admin
> wrote:
> > On Wed, Nov 27, 2019 at 08:20:12AM +0000, Chris Packham wrote:
> > > Hi All,
> > > 
> > > We're updating our systems to use the latest kernel. For many of them
> > > this is a fairly large leap. One problem we've hit is that durng boot
> > > the dtb is clobbered by the uncompressed kernel.
> > > 
> > > Here's a snippet of output from u-boot
> > > 
> > > ## Loading kernel from FIT Image at 62000000 ...
> > >    Using 'XS916MXS@2' configuration
> > >    Trying 'kernel@1' kernel subimage
> > >      Description:  linux
> > >      Created:      2019-11-27   6:53:48 UTC
> > >      Type:         Kernel Image
> > >      Compression:  uncompressed
> > >      Data Start:   0x62000174
> > >      Data Size:    3495432 Bytes = 3.3 MiB
> > >      Architecture: ARM
> > >      OS:           Linux
> > >      Load Address: 0x00800000
> > >      Entry Point:  0x60800000
> > >    ...
> > >    Booting using the fdt blob at 0x63b90f6c
> > >    Loading Kernel Image ... OK
> > >    Loading Ramdisk to 6e7c6000, end 70000000 ... OK
> > >    Loading Device Tree to 607fb000, end 607fffd8 ... OK
> > > 
> > > Starting kernel ...
> > > 
> > > Uncompressing Linux... done, booting the kernel.
> > > 
> > > Error: invalid dtb and unrecognized/unsupported machine ID
> > >   r1=0x0000206e, r2=0x00000000
> > > 
> > > Between old and new the location of the devicetree hasn't actually
> > > changed. But what has changed is the size of the kernel the self
> > > extracting kernel unpacks to 0x60008000 and with our current
> > > configuration extends into where the dtb is located.
> > > 
> > > Documentation/arm/booting.rst says that "The dtb must be placed in a
> > > region of memory where the kernel decompressor will not overwrite it". 
> > > 
> > > This suggests that the problem is with our u-boot configuration, but
> > > how is u-boot supposed to know where the self-extracting kernel is
> > > going to place things? As far as I can tell u-boot is doing a
> > > reasonable job of finding a place to put the dtb which it thinks is
> > > unused. I'm not sure why it's picked 0x607fb000 instead of putting it
> > > just under the ramdisk but regardless with the information u-boot has
> > > that address is up for grabs.
> > > 
> > > Has this come up before? The self-extraction code is fairly careful not
> > > to overwrite itself but doesn't seem to pay any attention to the dtb
> > > which surprised me. So I wonder if I'm missing something?
> > 
> > The self-extraction hasn't changed much over the years, and basically
> > follows the same method which has worked for the vast majority of
> > platforms.
> > 
> > Where things fall down is where things are placed too close, and yes,
> > as the kernel grows, what was reasonable years ago becomes too close
> > with modern kernels.
> > 
> > The problem has been compounded by the various different compression
> > algorithms that can now be used for the compressed kernel.
> > 
> 
> I don't think it's that we don't know how big the extracted kernel will
> be. It's just that we aren't doing anything with that information w.r.t
> the dtb.

I believe u-boot tried at one point to instigate some kind of standard
placement of the kernel / dtb with respect to the available RAM, but
vendors tried hard to ignore u-boot and go their own way - resulting
in systems that didn't boot without customising various u-boot
environment variables.  It's very annoying when vendors ignore the
community...

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
