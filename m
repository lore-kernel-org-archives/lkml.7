Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5895C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 790F321852
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkgZVDtz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfDWOYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:24:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46109 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfDWOYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:24:42 -0400
Received: by mail-pl1-f195.google.com with SMTP id o7so5368235pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 07:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lmmh70OfKzbjydOYZ2w+hgBFg5MLh0o81P5DKFNfyBU=;
        b=tkgZVDtz/6iDYPoez1Jdlyit1pIomXhOWc6DtgUvJ2mIp+ik5Ti7gT/nvlGoP+2tBU
         851nRlaRYT8cAkgkfzYhGF5ShAZvyqVhPmL+GP8qUgc2D6RcswPicyVQtEGzm/ExN+YC
         q7rtdBTp8lZwoX6ALtlQXV45DC9qZen3WpxxmTSDUioGvDdhzxTJX1WtUBTaehxov9s7
         GTIEL1PkXL/DhUOsHMXZLBtUvUJeQBtuG+ApJvmJxMhi/UaBts5HmoCGlBPAtWD8BuUA
         E1knrf56qxE/B5p9zDMuhwpROCY/UUrpp15K4k308b60JxQmsFE3UAjo5/ZJcod6gzEh
         uiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lmmh70OfKzbjydOYZ2w+hgBFg5MLh0o81P5DKFNfyBU=;
        b=OPimlukE2WxV/AW5mckPbK2Ey8mlVLm3Cj3UR/DhjL3Z2MeDDNrRtLm9TwlSeMxDXF
         J2cmsXMCDMnLGAyK8UbM7ua2SXLzVyRshPtCDMhUiNaygMS9hwNABYM5VLbt6a+KyPV8
         vnYB8LyOdCVqpTCVw1uNO0VLQYF1gg8Jvwy3MqDQfrEw4875DJsAP3z8qtVpaCZPGJON
         +g2m6LY+bpVHKzifTHI6wWh6wB4rtzBPeggpnmrcFkPl7QiD7e+LQN0zNzG0S+B1QyEy
         uLsJSoMbsPUqr/V1iY4D8gP5Ja+ln+eHMYCzdsaOiq4ciL28kq5ixOEjkIgphX2vuuF0
         pODA==
X-Gm-Message-State: APjAAAWOii9eFiZfgtFfRXhNPgG/DHgOtm9hnhADj6UFGSyfSRfnazR0
        uoN/fJXYl7lkxt1jhREg3LBpevK9mR3AvneLWjOO/Q==
X-Google-Smtp-Source: APXvYqy53i9k8lMzZq9895xmu2e4VGBDisBLb8z6B4VfxOOXsS1tKmxD0saR6VxDg7Ibq3QPzios+tMmvUPgoVUCLG0=
X-Received: by 2002:a17:902:864b:: with SMTP id y11mr25011287plt.1.1556029481344;
 Tue, 23 Apr 2019 07:24:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190422173838.182736-1-venture@google.com> <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
In-Reply-To: <CAK8P3a0k_8+R9FeyZsL6Egvi1Z-G0VrvR0TWXzGHryqxTr6thg@mail.gmail.com>
From:   Patrick Venture <venture@google.com>
Date:   Tue, 23 Apr 2019 07:24:29 -0700
Message-ID: <CAO=notxuYsBzWBnNran5jH0RujSBeti6-HsjasCRP6Sq0MwGNA@mail.gmail.com>
Subject: Re: [PATCH] soc: add aspeed folder and misc drivers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org, arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 1:08 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Apr 22, 2019 at 7:38 PM Patrick Venture <venture@google.com> wrote:
> >
> > Create a SoC folder for the ASPEED parts and place the misc drivers
> > currently present into this folder.  These drivers are not generic part
> > drivers, but rather only apply to the ASPEED SoCs.
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
>
> Looks ok, but please resend to arm@kernel.org or soc@kernel.org
> so we can track the submission and make sure it gets applied if
> you want this to go through the arm-soc tree.

Thanks, I didn't see those come up in the get_maintainers output.

I had a longer question related to this patch progression -- if I am
moving the aspeed gpio driver to the soc folder, the soc tree may have
the soc/aspeed folder in their next, but the gpio tree wouldn't
necessarily.  I know the branches sync up when things are merged at
the top, but I wasn't sure if there was another mechanism for this?

>
> If Greg wants to pick it up, that's fine too.
>
> Either way,
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
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
> > index 90b686e586c6..83a032db3e44 100644
> > --- a/drivers/soc/Makefile
> > +++ b/drivers/soc/Makefile
> > @@ -4,6 +4,7 @@
> >  #
> >
> >  obj-$(CONFIG_ARCH_ACTIONS)     += actions/
> > +obj-y                          += aspeed/
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
