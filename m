Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AEDC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659A521D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zfTZW9rI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfKTJv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:51:26 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37734 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbfKTJvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RkSscRrhSrXw7s5lW3vnoMLwwJ0fDW8Z1I2xrzJ2Ibo=; b=zfTZW9rILa4dMFwpU9F1DTM2l
        pRhjGmjzl7oT52KUUHJh+3BJp85uLDP8hv2IDiXKmXWknpdKMTEZRlfPkM7z9I/uwdwHdQLS6I+Ag
        BHukksm01gkdYNwOwoKLGhCz2wf/K+qetDFKi4eGLdITCY7Bt58YwW9rCZWNiFSRuBNZCB7oHmckp
        qMJ8sMuitG/0rsi6iqNUDHjyPhurcp40Sc0naQ+YgPYyaiV9k2h9OzAOisruufPzCF9FLVrL3GUJP
        0+fpVXpOq6kAM0e556MnsDGuw2Xyc3jceizOmF5/oRs1vRpROYGcRkuJBqDzxQ/b5ps4ZFU4JEYfS
        D+/fXx6ag==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42120)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iXMdp-0007Wm-W4; Wed, 20 Nov 2019 09:51:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iXMdj-0001cj-TD; Wed, 20 Nov 2019 09:51:11 +0000
Date:   Wed, 20 Nov 2019 09:51:11 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: don't export unused return_address()
Message-ID: <20191120095111.GI25745@shell.armlinux.org.uk>
References: <20190906154706.2449696-1-arnd@arndb.de>
 <CAMuHMdUMgDBo1gkvQ_Bd8mjMiPjdWWY=9AU6K1S7NcJy5jhvGQ@mail.gmail.com>
 <CAK7LNASNp4jPYHmh3e4QYwenYbVrK69tvB_LLyK_ew1eqBNrEw@mail.gmail.com>
 <20191113114517.GO25745@shell.armlinux.org.uk>
 <CAMuHMdXk9sWBpYWC-X6V3rp2e0+f5ebdRFFXn8Heuy0qkLq0GQ@mail.gmail.com>
 <20191113170058.GP25745@shell.armlinux.org.uk>
 <CAK7LNARiQnc+A0j4ORC-M8ZcbtDYdRF7tU1Zv8Lbst-g8dqmVQ@mail.gmail.com>
 <20191120090744.GH25745@shell.armlinux.org.uk>
 <CAK7LNARMjaCe8spDPMAKdViUN+uUycYL9LSCXumcR8DNDNKaPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARMjaCe8spDPMAKdViUN+uUycYL9LSCXumcR8DNDNKaPA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 06:42:52PM +0900, Masahiro Yamada wrote:
> Hi Russell,
> 
> 
> On Wed, Nov 20, 2019 at 6:07 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Nov 20, 2019 at 06:02:13PM +0900, Masahiro Yamada wrote:
> > > Hi Arnd,
> > >
> > >
> > >
> > > On Thu, Nov 14, 2019 at 2:01 AM Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Wed, Nov 13, 2019 at 02:15:00PM +0100, Geert Uytterhoeven wrote:
> > > > > Hi Russell,
> > > > >
> > > > > On Wed, Nov 13, 2019 at 12:45 PM Russell King - ARM Linux admin
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > > On Wed, Nov 13, 2019 at 08:40:39PM +0900, Masahiro Yamada wrote:
> > > > > > > On Tue, Oct 1, 2019 at 11:31 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > > > On Fri, Sep 6, 2019 at 5:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > > > > > Without the frame pointer enabled, return_address() is an inline
> > > > > > > > > function and does not need to be exported, as shown by this warning:
> > > > > > > > >
> > > > > > > > > WARNING: "return_address" [vmlinux] is a static EXPORT_SYMBOL_GPL
> > > > > > > > >
> > > > > > > > > Move the EXPORT_SYMBOL_GPL() into the #ifdef as well.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > > > > >
> > > > > > > > Thanks for your patch!
> > > > > > > >
> > > > > > > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > > >
> > > > > > > > > --- a/arch/arm/kernel/return_address.c
> > > > > > > > > +++ b/arch/arm/kernel/return_address.c
> > > > > > > > > @@ -53,6 +53,7 @@ void *return_address(unsigned int level)
> > > > > > > > >                 return NULL;
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > >
> > > > > > > > Checkpatch doesn't like the empty line above:
> > > > > > > >
> > > > > > > > WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
> > > > > > > >
> > > > > > > > > +EXPORT_SYMBOL_GPL(return_address);
> > > > > > > > > +
> > > > > > > > >  #endif /* if defined(CONFIG_FRAME_POINTER) && !defined(CONFIG_ARM_UNWIND) */
> > > > > > > > >
> > > > > > > > > -EXPORT_SYMBOL_GPL(return_address);
> > > > >
> > > > > > > What has happened to this patch?
> > > > > > >
> > > > > > > I still see this warning.
> > > > > >
> > > > > > Simple - it got merged, it caused build regressions, it got dropped.
> > > > > > A new version is pending me doing another round of patch merging.
> > > > >
> > > > > I believe that was not Arnd's patch, but Ben Dooks' alternative solution[*]?
> > > >
> > > > I don't keep track of who did what, sorry.
> > >
> > >
> > > Arnd,
> > >
> > > I believe this patch is the correct fix.
> > > Could you please put it into Russell's patch tracker?
> > > (patches@arm.linux.org.uk)
> >
> > Is there something wrong with:
> >
> > fb033c95c94c ARM: 8918/2: only build return_address() if needed
> >
> > I haven't seen any build issues with that.
> 
> 
> Sorry, I had not checked Ben's patch because you said
> "Simple - it got merged, it caused build regressions, it got dropped."

That was 8918/1.  Ben fixed his patch, and submitted an updated
version.

> Yup, I've checked it right now,
> and it looks good to me.
> 
> But, I do not see that commit in the latest linux-next
> (next-20191120).
> 
> Could you really apply it if you have not.

It was applied last Friday and was pushed out there and then.

$ git ls-remote zeniv | grep for-next
022eb8ae8b5ee8c5c813923c69b5ebb1e9612c4c        refs/heads/for-next
$ git lg for-next
022eb8ae8b5e ARM: 8938/1: kernel: initialize broadcast hrtimer based
clock event device
...
fb033c95c94c ARM: 8918/2: only build return_address() if needed

I've no idea why linux-next doesn't have it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
