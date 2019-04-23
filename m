Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E37C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7452921738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 15:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nh7Ub0ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfDWP21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 11:28:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45110 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfDWP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 11:28:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so7650533pfi.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=swtXqd1CZ66H9d0M2Jk6YTTcRShibPML2KMeziFVStg=;
        b=Nh7Ub0ZZxsVr7G6NJgh9yPwmSJhDVbpJKEJU1P1AbaLTsZOjAMy4gEuVpFY3uyKo5C
         9YSxINIOhlqU2RmWjCAMFzWtGS941B9wAT8fWVdlClXPH4UxphpqeslCw+vZRmiFjTGa
         EA7QHc8iXyMqS0Y183YfxAol8nhL4eYB2xQ4edvSrUKY0ltcMsuWgA1dvL2qnAhNgNKH
         37jI5/TpB1x7H4xp6P2RXqAMnUZH+5dh0dKt0GZkylMa6rko/MS1R2qetdfxy+jyTA54
         u4EZk4LNP1FOrN8K/IX1DiEwpdIV+rihgKHtPI774Rc+7vGyWesRefZ/B0cF0FPaz0Nj
         E/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=swtXqd1CZ66H9d0M2Jk6YTTcRShibPML2KMeziFVStg=;
        b=LX7yJXmedzcunUL/65ywuRihFJRvwBIlhokt5+VksMQ2GclV8EN2sr7/bjhg7B+OR+
         bpXwujW4R5ph7Zn4uuAW3H+l8qMCKL3qSxhnggO3gZIlCGPamZVEpk+xhA9Px+9FwdXa
         u5JTqa2ktrAAcdSLQs490I6/ZwEuZrdK0kopE0PvolTSm7TtMvtlC9m8OP+qXiXd/F2k
         jtPsRaaodMRNd8xWHb+2oFY3qKLGTFLbGY6RESMDadnwTL09k5dM/YGrxLB1A1Oyty32
         GwVrccLAkOvgxitxVZdpusOdWfei5Ly1qarDcAfsyzN3joncUCFysCbVu2egRAxmkPyM
         0v2g==
X-Gm-Message-State: APjAAAUTkSp9roKaMNEoPRqsDacb+sIwUmW1Gx3JOYdI2wcTCwXJNDtQ
        BBqsa5fI6CIA6V/2tSfNniovcgkPZpPI8O4Msv4SFA==
X-Google-Smtp-Source: APXvYqyazN7ord652sPNl8xtrPDGAtDGNQxhHlVc3XKDsIM7asn9zWnZCgrPq8riFFM/ndn95cVar3hOatVZc7URSRM=
X-Received: by 2002:a63:5059:: with SMTP id q25mr18423170pgl.314.1556033305462;
 Tue, 23 Apr 2019 08:28:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190423142629.120717-1-venture@google.com> <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
In-Reply-To: <CAO=notzjzpt0WHfJEWXMGgkoJU8UiLnqZnrGrPs-dRH5GNdJyQ@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 23 Apr 2019 08:28:14 -0700
Message-ID: <CAO=notz9QVoqKLrhJ3kx9FHja5+Mh68f36O36+1ewLG+SanmOA@mail.gmail.com>
Subject: Re: [PATCH v2] soc: add aspeed folder and misc drivers
To:     Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>,
        soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 8:22 AM Patrick Venture <venture@google.com> wrote:
>
> On Tue, Apr 23, 2019 at 7:26 AM Patrick Venture <venture@google.com> wrote:
> >
> > Create a SoC folder for the ASPEED parts and place the misc drivers
> > currently present into this folder.  These drivers are not generic part
> > drivers, but rather only apply to the ASPEED SoCs.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
>
> Accidentally lost the Acked-by when re-sending this patchset as I
> didn't see it on v1 before re-sending v2 to the larger audience.

Since there was a change between v1 and v2, Arnd, I'd appreciate you
Ack this version of the patchset since it changes when the soc/aspeed
Makefile is followed.

>
> > ---
> > v2:
> >  Added configuration option for ASPEED to soc/Makefile
> > ---
> >  drivers/misc/Kconfig                          | 16 ----------------
> >  drivers/misc/Makefile                         |  2 --
> >  drivers/soc/Kconfig                           |  1 +
> >  drivers/soc/Makefile                          |  1 +
> >  drivers/soc/aspeed/Kconfig                    | 19 +++++++++++++++++++
> >  drivers/soc/aspeed/Makefile                   |  2 ++
> >  .../{misc => soc/aspeed}/aspeed-lpc-ctrl.c    |  0
> >  .../{misc => soc/aspeed}/aspeed-lpc-snoop.c   |  0
> >  8 files changed, 23 insertions(+), 18 deletions(-)
> >  create mode 100644 drivers/soc/aspeed/Kconfig
> >  create mode 100644 drivers/soc/aspeed/Makefile
> >  rename drivers/{misc => soc/aspeed}/aspeed-lpc-ctrl.c (100%)
> >  rename drivers/{misc => soc/aspeed}/aspeed-lpc-snoop.c (100%)
> >
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > index 42ab8ec92a04..b80cb6af0cb4 100644
> > --- a/drivers/misc/Kconfig
> > +++ b/drivers/misc/Kconfig
> > @@ -496,22 +496,6 @@ config VEXPRESS_SYSCFG
> >           bus. System Configuration interface is one of the possible means
> >           of generating transactions on this bus.
> >
> > -config ASPEED_LPC_CTRL
> > -       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > -       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> > -       ---help---
> > -         Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
> > -         ioctl()s, the driver also provides a read/write interface to a BMC ram
> > -         region where the host LPC read/write region can be buffered.
> > -
> > -config ASPEED_LPC_SNOOP
> > -       tristate "Aspeed ast2500 HOST LPC snoop support"
> > -       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > -       help
> > -         Provides a driver to control the LPC snoop interface which
> > -         allows the BMC to listen on and save the data written by
> > -         the host to an arbitrary LPC I/O port.
> > -
> >  config PCI_ENDPOINT_TEST
> >         depends on PCI
> >         select CRC32
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index d5b7d3404dc7..b9affcdaa3d6 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -54,8 +54,6 @@ obj-$(CONFIG_GENWQE)          += genwqe/
> >  obj-$(CONFIG_ECHO)             += echo/
> >  obj-$(CONFIG_VEXPRESS_SYSCFG)  += vexpress-syscfg.o
> >  obj-$(CONFIG_CXL_BASE)         += cxl/
> > -obj-$(CONFIG_ASPEED_LPC_CTRL)  += aspeed-lpc-ctrl.o
> > -obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
> >  obj-$(CONFIG_PCI_ENDPOINT_TEST)        += pci_endpoint_test.o
> >  obj-$(CONFIG_OCXL)             += ocxl/
> >  obj-y                          += cardreader/
> > diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> > index c07b4a85253f..b750a88547c7 100644
> > --- a/drivers/soc/Kconfig
> > +++ b/drivers/soc/Kconfig
> > @@ -2,6 +2,7 @@ menu "SOC (System On Chip) specific Drivers"
> >
> >  source "drivers/soc/actions/Kconfig"
> >  source "drivers/soc/amlogic/Kconfig"
> > +source "drivers/soc/aspeed/Kconfig"
> >  source "drivers/soc/atmel/Kconfig"
> >  source "drivers/soc/bcm/Kconfig"
> >  source "drivers/soc/fsl/Kconfig"
> > diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> > index 90b686e586c6..814128fe479f 100644
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> >
> >  obj-$(CONFIG_ARCH_ACTIONS)     += actions/
> > +obj-$(CONFIG_ARCH_ASPEED)      += aspeed/
> >  obj-$(CONFIG_ARCH_AT91)                += atmel/
> >  obj-y                          += bcm/
> >  obj-$(CONFIG_ARCH_DOVE)                += dove/
> > diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> > new file mode 100644
> > index 000000000000..457282cd1da5
> > --- /dev/null
> > +++ b/drivers/soc/aspeed/Kconfig
> > @@ -0,0 +1,19 @@
> > +menu "Aspeed SoC drivers"
> > +
> > +config ASPEED_LPC_CTRL
> > +       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > +       tristate "Aspeed ast2400/2500 HOST LPC to BMC bridge control"
> > +       ---help---
> > +         Control Aspeed ast2400/2500 HOST LPC to BMC mappings through
> > +         ioctl()s, the driver also provides a read/write interface to a BMC ram
> > +         region where the host LPC read/write region can be buffered.
> > +
> > +config ASPEED_LPC_SNOOP
> > +       tristate "Aspeed ast2500 HOST LPC snoop support"
> > +       depends on (ARCH_ASPEED || COMPILE_TEST) && REGMAP && MFD_SYSCON
> > +       help
> > +         Provides a driver to control the LPC snoop interface which
> > +         allows the BMC to listen on and save the data written by
> > +         the host to an arbitrary LPC I/O port.
> > +
> > +
> > diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> > new file mode 100644
> > index 000000000000..cfaa9adc67b5
> > --- /dev/null
> > +++ b/drivers/soc/aspeed/Makefile
> > @@ -0,0 +1,2 @@
> > +obj-$(CONFIG_ASPEED_LPC_CTRL)  += aspeed-lpc-ctrl.o
> > +obj-$(CONFIG_ASPEED_LPC_SNOOP) += aspeed-lpc-snoop.o
> > diff --git a/drivers/misc/aspeed-lpc-ctrl.c b/drivers/soc/aspeed/aspeed-lpc-ctrl.c
> > similarity index 100%
> > rename from drivers/misc/aspeed-lpc-ctrl.c
> > rename to drivers/soc/aspeed/aspeed-lpc-ctrl.c
> > diff --git a/drivers/misc/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > similarity index 100%
> > rename from drivers/misc/aspeed-lpc-snoop.c
> > rename to drivers/soc/aspeed/aspeed-lpc-snoop.c
> > --
> > 2.21.0.593.g511ec345e18-goog
> >
