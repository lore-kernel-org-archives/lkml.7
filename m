Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CEBC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB63206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOz5T6yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732175AbfJIT1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:27:31 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35014 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730708AbfJIT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:27:31 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so7781744iop.2;
        Wed, 09 Oct 2019 12:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sBG3bzNJ4nIDX1Rgox6bQv5BCuW6Vs82TNv6y6/aj9o=;
        b=aOz5T6yJ2dx21E8QGDElj5FfpAJrRldZgmrQPrZiwGvDKUsCeBOSCGozlpvql2ibpy
         H6FcunpnT58lfeD1b4RfHL93Zsqzkvj2+6dNbhZkAXvSoSXog7HvEgNA+NyS3VQvLabx
         +yi3mCwHNAWDzc9dc/W0qxJd9tSY64ImoTmjtjSoxdnlocWmCTJULkY9/eFi4Ij/fhQe
         UwL5ychqf1cuK08H8GsIuVZoMtG+G8/qOtr8WTSMR/0BreYe9pogbsL4U8vqIU5yMbJg
         xPqfl++XrZK8tfQAShUqeri9OqLQiZsxSm6tDbFinygGFuarRbxMl3b2R6af5EJkPv6n
         jVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sBG3bzNJ4nIDX1Rgox6bQv5BCuW6Vs82TNv6y6/aj9o=;
        b=VlD+0P0P66+GIf6mXf45onI/hDe61b7MppJtpGIUNCMxZ0a7gaPF5Wws/1pk4ZzNTX
         0OrQI/XzYuOfKWcxQDaFYMTWjdET6rWvgYvxUS9DUWXIqwS/0BT/BU+8zeAFrgqEfh+g
         2V+kLBkNM3RQFYxfycSH5x/dyNeFXUYNSm2Y1rcRluSMUvtjqksY7N9O5I2nDx9+lxIh
         m8miSQJyqsxAUnknY38cIDb3CJn7K9oWu/TnTN+BzHrnZtDkg249sr8cfc2/dIcYbP2J
         hGFAmM4kpko970w2dSHe0eVLLbtJjrS6MhGGUhP+AkoQOBg4UYHhmhPZlmd4EEhCivpl
         xbXQ==
X-Gm-Message-State: APjAAAUQfiHKW/UGwUs33kF+f6eYd+E0rzFEQBGmtPH2Kp59PuU42KkJ
        xy2zsfHta/AevIjiOJVW13+oDAI8w/qWEm2bByw=
X-Google-Smtp-Source: APXvYqw9VUBNN5snuUVH+edAMsN/HpNmAh4GnV0DJaBapVld1ios5O4mjAlsTNRmtUdtapuaVTKk4ouCXXinhhz2izA=
X-Received: by 2002:a02:7741:: with SMTP id g62mr5003539jac.3.1570649249342;
 Wed, 09 Oct 2019 12:27:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
 <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com> <CAHCN7xJDS_NwT8VZbOQgsA6iHkeTLt4UrR2vFmzkCtWYCYzQrg@mail.gmail.com>
 <20191009173446.GL5610@atomide.com>
In-Reply-To: <20191009173446.GL5610@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 9 Oct 2019 14:27:18 -0500
Message-ID: <CAHCN7xJYJ7f3b9D+tMw=f4zda8H=NyNV4UdeT+65MJxrcu3bkg@mail.gmail.com>
Subject: Re: Serial 8250 DMA Broken on OMAP3630
To:     Tony Lindgren <tony@atomide.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 12:34 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [191009 14:09]:
> > On Wed, Oct 9, 2019 at 8:42 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
> > >
> > > Hi Adam,
> > >
> > > On 06/10/19 10:34 PM, Adam Ford wrote:
> > > > Has anyone else had any issues using the CONFIG_SERIAL_8250_DMA on the OMAP?
> > > >
> > > > I can use the DMA on the legacy, omap-serial driver, but when I enable
> > > > the DMA on the 8250-omap driver, I get missing frames in Bluetooth.
> > > >
> > > > The older driver seems to have an ISR that seems to address a variety
> > > > of items compared to the very tiny ISR for 8250-omap.c.
> > > >
> > > > I am not exactly sure where to start, but if someone has any
> > > > suggestions on how I can troubleshoot, please let me know.  As of now,
> > > > I have to disable CONFIG_SERIAL_8250_DMA to get the Bluetooth
> > > > connected to UART2 operational on a DM3730 at 3,000,000 baud, but it
> > > > appears to work just fine after some patches I just submitted for
> > > > handling RTS/CTS.  The legacy omap-serial driver works fine with DMA.
> > > >
> > >
> > > Mainline omap-serial does not support DMA (evident from lack of
> > > dmaengine API calls) and therefore is not a regression. So OMAP3 UART
> > > DMA was never tested at least with 8250 driver.
> > > I am not sure enabling UART DMA on OMAP3 would be a trivial job. We need
> > > analyse of whether all erratas workarounds are implemented and see if
> > > there any difference wrt DMA integration itself. Do we know if UART DMA
> > > ever worked on OMAP3 previously?
> >
> > Can we disable CONFIG_SERIAL_8250_DMA from omap2plus_defconfig?   As
> > of right now, it's the only way I can use the Bluetooth.  There are
> > #ifdef's in the 8250-omap driver, so it looks like some of the hooks
> > are there, but if it's incomplete, it seems like we shouldn't enable
> > this config option by default yet.
>
> From what I recall I tested that DMA on omap3 worked fine with runtime
> PM for console. Certainly there are issues still remaining though.
>
> If you want to disable dma for a specific port, just delete the
> add /delete-property/dma-names for the port in question in your
> board specific dts file.
>
> See 8250_omap.c for of_property_count_strings(np, "dma-names").

Thank you.  That seems to have worked.  I'll check the AM3517 when I
have some time to see if it needs the same patch.  For now, I pushed
the patch to the omap mailing list for the Logic PD Torpedo board.

Should we consider removing the OMAP_SERIAL from omap2plus_defconfig
in the 8250 is the preferred driver?  It seems odd to me that both
drivers are enabled.

adam
>
> Regards,
>
> Tony
>
>
