Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08508C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4CC021848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 14:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItHuOga3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbfJIOJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 10:09:10 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46898 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729883AbfJIOJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 10:09:10 -0400
Received: by mail-io1-f68.google.com with SMTP id c6so5148905ioo.13;
        Wed, 09 Oct 2019 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrZAk5gJkER1O1xn2TCucF4dEQP6LH4cuHnhethSJ8M=;
        b=ItHuOga3a0OFHONWEPlKRcF5GP+jCkkvEjryppl8BJ8T5PIdxFMrWrT5UTLk5uy83g
         5OCtgnfkD45s3QNWiV9VXifVJKgc4MVZk7OCN8YYk5+n/tO/GCZQOlbp07EjVaQTeJ7B
         l5K1vBtEaTyy/6aad+Fkc9HCzCa36sg5CZ8Cp6SeS69iQuVpkoSW9nyePKlQ/RvI/92n
         JtYgdXEDo0Ot8wEC28eYJGpgm2O+3YLxJVYMlMOe7MVuXg2O+08Q2PQdIiu8ZihNX/eJ
         Iu4oJlsa2gpQ7Dh9R3UEkO7684Ha862Hr66jV7E+E9zui0mE7uFLCMUHnb6uh4+ZQw/V
         W4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrZAk5gJkER1O1xn2TCucF4dEQP6LH4cuHnhethSJ8M=;
        b=PW3A0k51Zhf+uRAVAzI57KigqxmJ7UIiUTGvjBowua9tmGBEwCStU/iuVUwDu559xN
         /tAGSKd2x0iLp09/GdrFBCCI99i/TFh6O7+q0QkyJArI7VPaZhWpOKEfZEIvxBEVLD48
         lGCREr288CNnVLhvlaZ68A2M7OgPPAyt/d1E8HkHTbSHMYsC3YzA2UKM3a84EIf7EDmb
         i5a40fHO1Rb2RtcZ7aJiJeA81FNA5EC25AfZjHKLIgpBTqX/JMUy8drNCWqZrjnskRf+
         yDYWgTxh3d1vl9zgcS3ugYYBBw3PMnV2iJ547uOSACSrcDQsQABQXp/5+VDbO4XY7YdZ
         Yjrg==
X-Gm-Message-State: APjAAAVrhm3ZzmUo8vQqbSVJ+GfIKqVHYt1PHbKk/2fepvBOK8a23AjL
        iPOl5HAhGA2vyaZ2uVYlfVsgtC4ipfsRI6XzSJI=
X-Google-Smtp-Source: APXvYqydLUN9gXf0yzgt77Zbc8y4VKX5W7xoCP1U5BA0C169qM9cU6AyjGMeW1wmLxpllA1iM/VBGRA6ZSvHF9wowLw=
X-Received: by 2002:a02:a11e:: with SMTP id f30mr3223182jag.95.1570630148852;
 Wed, 09 Oct 2019 07:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
 <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com>
In-Reply-To: <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Wed, 9 Oct 2019 09:08:57 -0500
Message-ID: <CAHCN7xJDS_NwT8VZbOQgsA6iHkeTLt4UrR2vFmzkCtWYCYzQrg@mail.gmail.com>
Subject: Re: Serial 8250 DMA Broken on OMAP3630
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Douglas Anderson <dianders@chromium.org>,
        Tony Lindgren <tony@atomide.com>,
        Yegor Yefremov <yegorslists@googlemail.com>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 8:42 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:
>
> Hi Adam,
>
> On 06/10/19 10:34 PM, Adam Ford wrote:
> > Has anyone else had any issues using the CONFIG_SERIAL_8250_DMA on the OMAP?
> >
> > I can use the DMA on the legacy, omap-serial driver, but when I enable
> > the DMA on the 8250-omap driver, I get missing frames in Bluetooth.
> >
> > The older driver seems to have an ISR that seems to address a variety
> > of items compared to the very tiny ISR for 8250-omap.c.
> >
> > I am not exactly sure where to start, but if someone has any
> > suggestions on how I can troubleshoot, please let me know.  As of now,
> > I have to disable CONFIG_SERIAL_8250_DMA to get the Bluetooth
> > connected to UART2 operational on a DM3730 at 3,000,000 baud, but it
> > appears to work just fine after some patches I just submitted for
> > handling RTS/CTS.  The legacy omap-serial driver works fine with DMA.
> >
>
> Mainline omap-serial does not support DMA (evident from lack of
> dmaengine API calls) and therefore is not a regression. So OMAP3 UART
> DMA was never tested at least with 8250 driver.
> I am not sure enabling UART DMA on OMAP3 would be a trivial job. We need
> analyse of whether all erratas workarounds are implemented and see if
> there any difference wrt DMA integration itself. Do we know if UART DMA
> ever worked on OMAP3 previously?

Can we disable CONFIG_SERIAL_8250_DMA from omap2plus_defconfig?   As
of right now, it's the only way I can use the Bluetooth.  There are
#ifdef's in the 8250-omap driver, so it looks like some of the hooks
are there, but if it's incomplete, it seems like we shouldn't enable
this config option by default yet.

adam
>
> > adam
> >
>
> --
> Regards
> Vignesh
