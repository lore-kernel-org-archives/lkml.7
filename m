Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8383EC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 396532082F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 16:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LGmByqEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfCDQfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 11:35:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33880 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfCDQfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 11:35:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so3393312pfn.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 08:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUXdYEWW/NLP63SPMj7tVjB2+ggu7S4LcSG8I5D5xU0=;
        b=LGmByqEmQ8xVitO0Xw+3AMIXpN7/cxY97kRcvl6nD15iIGBsYvgszZDShJYPw6G6hG
         GI1f2OJclvDtUyLALesV/8i2k0S/9lpgjTpZ+/U7yh8MsWMnu8YjjeqRqTiGW8ykfjOO
         t98vl6GZcCuTcroolzsJe/MU/LvgG5/EkbO9TydG1ZhR7Gi2mKBMW39/D7m4yLMpXpCj
         caDwxjtnjFuZpMYsMKsGvHVc/rMGobDiuUnCxthOHbue9sJDa91qnIrq5fuFJ9YW6c3O
         sKiUNetcBJqsSB1jdqnmPBOQQcRO2pT5NgnvHHWolQw+GlMB5GlFrp3UDct7f4e6dslN
         4xzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUXdYEWW/NLP63SPMj7tVjB2+ggu7S4LcSG8I5D5xU0=;
        b=ru+TkUQdHJNl3hNBSw1CutfJjNCw8B6GrLvQnvy9DS/Y++ff8Cvlx8q61ysosV228v
         IjYl9fHtXos4pIICCcaxZzM6o8SwJFTwTxWftKp9cbwJ9ilO4uWCeqfN+sBw0HWBpTHu
         3K/8mJVmrbzAdyPbYOcAdVEiPJ5UGBtinNPkqXvzldjdOGatE46O0tarWix8g3qXVWje
         QuamtQM781GoVXJM/7fg21uWpUKjexu7QHT0Oyvhf2cmwjHzWJnm7Enw9p8JTZkqeyRc
         gWPsQnFB/Itqu4NIUiu6RRW+ze3roVaToaUVj0+YqH2jYrXLA/uODAYVHhIfH5nTmAiX
         kpCg==
X-Gm-Message-State: APjAAAWfaWrKCVPzhLPDFwiDehZ+7+R3EpovGFGWLLKvYZoBI4FdlaFk
        KqQyNIVpiXkrKYtdNOREMxkZic9bBlN8bjR2uIsnrr3V8v0=
X-Google-Smtp-Source: APXvYqzxyqQumb7wTbxBK8SgnwbQRc4nOGzY0QQndDM7AUj6U6BNGlIer7vPHJSJsmijA6qBNqbeQN2Y5rRRQWbl7no=
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr4073496plr.61.1551717342640;
 Mon, 04 Mar 2019 08:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20190228015223.34563-1-venture@google.com> <19097a78-7066-4fcd-aa79-aca4a8c3cb0c@www.fastmail.com>
 <CAO=notwGb2_HpcaMNRnaJfcjqoqWj1fws8A_OEH=kzH7PxJy0w@mail.gmail.com>
 <20190304163116.GC2301@kroah.com> <CAO=notyD9+FhER1i2aGx099VPtXWpRVxNK-pzKiFjRdgCKSpjw@mail.gmail.com>
In-Reply-To: <CAO=notyD9+FhER1i2aGx099VPtXWpRVxNK-pzKiFjRdgCKSpjw@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Mon, 4 Mar 2019 08:35:31 -0800
Message-ID: <CAO=notwaHMAnKv3aLakQHrw2=y_vvnKTtN=2tuVrnwVGpkzk7Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] drivers/misc: Add Aspeed P2A control driver
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andrew Jeffery <andrew@aj.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Joel Stanley <joel@jms.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 8:31 AM Patrick Venture <venture@google.com> wrote:
>
> On Mon, Mar 4, 2019 at 8:31 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Mar 04, 2019 at 07:45:31AM -0800, Patrick Venture wrote:
> > > On Sun, Mar 3, 2019 at 4:04 PM Andrew Jeffery <andrew@aj.id.au> wrote:
> > > >
> > > > Hi Patrick.
> > > >
> > > > I've got some minor comments, otherwise it looks reasonable to me.
> > > >
> > > > On Thu, 28 Feb 2019, at 12:22, Patrick Venture wrote:
> > > > > The ASPEED AST2400, and AST2500 in some configurations include a
> > > > > PCI-to-AHB MMIO bridge.  This bridge allows a server to read and write
> > > > > in the BMC's physical address space.  This feature is especially useful
> > > > > when using this bridge to send large files to the BMC.
> > > > >
> > > > > The host may use this to send down a firmware image by staging data at a
> > > > > specific memory address, and in a coordinated effort with the BMC's
> > > > > software stack and kernel, transmit the bytes.
> > > > >
> > > > > This driver enables the BMC to unlock the PCI bridge on demand, and
> > > > > configure it via ioctl to allow the host to write bytes to an agreed
> > > > > upon location.  In the primary use-case, the region to use is known
> > > > > apriori on the BMC, and the host requests this information.  Once this
> > > > > request is received, the BMC's software stack will enable the bridge and
> > > > > the region and then using some software flow control (possibly via IPMI
> > > > > packets), copy the bytes down.  Once the process is complete, the BMC
> > > > > will disable the bridge and unset any region involved.
> > > > >
> > > > > The default behavior of this bridge when present is: enabled and all
> > > > > regions marked read-write.  This driver will fix the regions to be
> > > > > read-only and then disable the bridge entirely.
> > > > >
> > > > > The memory regions protected are:
> > > > >  * BMC flash MMIO window
> > > > >  * System flash MMIO windows
> > > > >  * SOC IO (peripheral MMIO)
> > > > >  * DRAM
> > > > >
> > > > > The DRAM region itself is all of DRAM and cannot be further specified.
> > > > > Once the PCI bridge is enabled, the host can read all of DRAM, and if
> > > > > the DRAM section is write-enabled, then it can write to all of it.
> > > > >
> > > > > Signed-off-by: Patrick Venture <venture@google.com>
> > > > > ---
> > > > > Changes for v5:
> > > > > - Fixup missing exit condition and remove extra jump.
> > > > > Changes for v4:
> > > > > - Added ioctl for reading back the memory-region configuration.
> > > > > - Cleaned up some unused variables.
> > > > > Changes for v3:
> > > > > - Deleted unused read and write methods.
> > > > > Changes for v2:
> > > > > - Dropped unused reads.
> > > > > - Moved call to disable bridge to before registering device.
> > > > > - Switch from using regs to using a syscon regmap. <<< IN PROGRESS
> > > > > - Updated the commit message. <<< TODO
> > > > > - Updated the bit flipped for SCU180_ENP2A
> > > > > - Dropped boolean region_specified variable.
> > > > > - Renamed p2a_ctrl in _probe to misc_ctrl per suggestion.
> > > > > - Renamed aspeed_p2a_region_search to aspeed_p2a_region_acquire
> > > > > - Updated commit message.
> > > > > ---
> > > > >  drivers/misc/Kconfig                 |   8 +
> > > > >  drivers/misc/Makefile                |   1 +
> > > > >  drivers/misc/aspeed-p2a-ctrl.c       | 456 +++++++++++++++++++++++++++
> > > > >  include/uapi/linux/aspeed-p2a-ctrl.h |  59 ++++
> > > > >  4 files changed, 524 insertions(+)
> > > > >  create mode 100644 drivers/misc/aspeed-p2a-ctrl.c
> > > > >  create mode 100644 include/uapi/linux/aspeed-p2a-ctrl.h
> > > > >
> > > > > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > > > > index f417b06e11c5..9de1bafe5606 100644
> > > > > --- a/drivers/misc/Kconfig
> > > > > +++ b/drivers/misc/Kconfig
> > > > > @@ -485,6 +485,14 @@ config VEXPRESS_SYSCFG
> > > > >         bus. System Configuration interface is one of the possible means
> > > > >         of generating transactions on this bus.
> > > > >
> > > > > +config ASPEED_P2A_CTRL
> > > > > +     depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > > > > +     tristate "Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC bridge control"
> > > > > +     help
> > > > > +       Control Aspeed ast2400/2500 HOST P2A VGA MMIO to BMC mappings
> > > > > through
> > > > > +       ioctl()s, the driver also provides an interface for userspace
> > > > > mappings to
> > > > > +       a pre-defined region.
> > > > > +
> > > > >  config ASPEED_LPC_CTRL
> > > > >       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > > > >       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> > > > > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > > > > index e39ccbbc1b3a..57577aee354f 100644
> > > > > --- a/drivers/misc/Makefile
> > > > > +++ b/drivers/misc/Makefile
> > > > > @@ -55,6 +55,7 @@ obj-$(CONFIG_VEXPRESS_SYSCFG)       += vexpress-syscfg.o
> > > > >  obj-$(CONFIG_CXL_BASE)               += cxl/
> > > > >  obj-$(CONFIG_ASPEED_LPC_CTRL)        += aspeed-lpc-ctrl.o
> > > > >  obj-$(CONFIG_ASPEED_LPC_SNOOP)       += aspeed-lpc-snoop.o
> > > > > +obj-$(CONFIG_ASPEED_P2A_CTRL)        += aspeed-p2a-ctrl.o
> > > > >  obj-$(CONFIG_PCI_ENDPOINT_TEST)      += pci_endpoint_test.o
> > > > >  obj-$(CONFIG_OCXL)           += ocxl/
> > > > >  obj-y                                += cardreader/
> > > > > diff --git a/drivers/misc/aspeed-p2a-ctrl.c
> > > > > b/drivers/misc/aspeed-p2a-ctrl.c
> > > > > new file mode 100644
> > > > > index 000000000000..6bde4f64632d
> > > > > --- /dev/null
> > > > > +++ b/drivers/misc/aspeed-p2a-ctrl.c
> > > > > @@ -0,0 +1,456 @@
> > > > > +/*
> > > > > + * Copyright 2019 Google Inc
> > > > > + *
> > > > > + * This program is free software; you can redistribute it and/or
> > > > > + * modify it under the terms of the GNU General Public License
> > > > > + * as published by the Free Software Foundation; either version
> > > > > + * 2 of the License, or (at your option) any later version.
> > > >
> > > > Should be a SPDX header instead.
> > >
> > > Ok, so delete the above and drop in:
> > >
> > > """
> > > /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > > """
> >
> > No no no no no no!
> >
> > > Or just add that to the top above the Google GNU copyright line?  (I'm
> > > not a lawyer).
> >
> > Please go read Documentation/process/license-rules.txt, it should
> > explain everything.  And if not, go talk to your legal council, they
> > know all about this and what is needed.
>
> Roger that.

Quick and easy read.  Thanks.

>
> >
> > thanks,
> >
> > greg k-h
