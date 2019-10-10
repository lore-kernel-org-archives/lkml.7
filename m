Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4ADC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A29206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adXFfaIF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfJJOLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:11:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34644 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfJJOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:11:42 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so14045800ion.1;
        Thu, 10 Oct 2019 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5AjzdEMR2uX9IffrslAGRHldw07Vk/KpMV6d7cNBcc=;
        b=adXFfaIFex+Wi5JI5lSM18jwysADWzLbmw32GJ1/lEztZGVPg/oaz5m8/GBMvGeJKy
         kck6A1yQF6fewtlFfq2tI/At88ZWyzqyANwpZcCkSOwHzQf26opuRyeUSXnUjQwCF4F9
         f4BiAewcpJNC78L44zUGC/k7VHC6sMcJ8jRJIwxN0qocYOmVwmZ0C4zJeOCk58PfMo6O
         IFaOOmIYbBMpN4PgSrQD736IoHZvJqlolmJmZGxjGZSfU0tNIaIRViEutpb8UdtCoqeU
         5ZYNbtXQQlFSmOXMS/JshEZyKkqAunPWDzrbZYXSecZyfQjg/YxlS824xLTFF+pyblBu
         cHVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5AjzdEMR2uX9IffrslAGRHldw07Vk/KpMV6d7cNBcc=;
        b=Iek86mGTdjsMdcCfUyIw0HvxjP3yoLzSsxRUzjjNvmnfsIvpnDaF86MAH2DQpSoV3n
         xaRS6ngJEno8o/eg3xiaQUGxikj5ORaKfE1+yt77QQEUuwCVPcwMBkADWWssGZlu1Mmk
         tw71S81d+SBLyEA7VcpAoW59OhGPGb+wX9PYk+wHbwXqDPYxjtLmOZFMp9VZVoUoM/Er
         7hbHGuvNS6PAsKrc9iT3hE3yu+R8DqTPggDvss5dj8yS/YTG4kgEPJRN00/yToPsI+tk
         gU6dTB5AA33ViIyJA0FyDUCEYWlO4V6p3xMxLbIOqwOLqRnbpe+IaGskfnSFQRwkdVwk
         2o1A==
X-Gm-Message-State: APjAAAVNgPKz/0tZwti7bKj1bv52LOI3+byEzSKOleYKhE4RD8qOc3L4
        Ik1mwhMDx8u3Nbo27NdpquFLs/lCw//QsHB8pe4=
X-Google-Smtp-Source: APXvYqyCxFu1TpJ9N1IhtTD8amRwypvS6NHPgrJMr/GTya/NwdsSvYqbyu5N79xvud9pO9xVHqE5D3uAsuEH9+URIg0=
X-Received: by 2002:a5e:8414:: with SMTP id h20mr1876341ioj.276.1570716700816;
 Thu, 10 Oct 2019 07:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
 <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com> <CAHCN7xJDS_NwT8VZbOQgsA6iHkeTLt4UrR2vFmzkCtWYCYzQrg@mail.gmail.com>
 <20191009173446.GL5610@atomide.com> <CAHCN7xJYJ7f3b9D+tMw=f4zda8H=NyNV4UdeT+65MJxrcu3bkg@mail.gmail.com>
 <20191009201612.GQ5610@atomide.com>
In-Reply-To: <20191009201612.GQ5610@atomide.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 10 Oct 2019 09:11:29 -0500
Message-ID: <CAHCN7x+B5nw=muPPTXAv+Pwx69bJSmi2jZhC68fA=rtN7=ELoA@mail.gmail.com>
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

On Wed, Oct 9, 2019 at 3:16 PM Tony Lindgren <tony@atomide.com> wrote:
>
> * Adam Ford <aford173@gmail.com> [191009 19:28]:
> > On Wed, Oct 9, 2019 at 12:34 PM Tony Lindgren <tony@atomide.com> wrote:
> > > From what I recall I tested that DMA on omap3 worked fine with runtime
> > > PM for console. Certainly there are issues still remaining though.
> > >
> > > If you want to disable dma for a specific port, just delete the
> > > add /delete-property/dma-names for the port in question in your
> > > board specific dts file.
> > >
> > > See 8250_omap.c for of_property_count_strings(np, "dma-names").
> >
> > Thank you.  That seems to have worked.  I'll check the AM3517 when I
> > have some time to see if it needs the same patch.  For now, I pushed
> > the patch to the omap mailing list for the Logic PD Torpedo board.
> >
> > Should we consider removing the OMAP_SERIAL from omap2plus_defconfig
> > in the 8250 is the preferred driver?  It seems odd to me that both
> > drivers are enabled.
>
> We have CONFIG_SERIAL_8250_OMAP=y and by default also we have
> CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP=y. With those omap_serial
> won't probe.. So yeah I guess for v5.5 we could drop the
> option for CONFIG_SERIAL_OMAP for both omap2plus_defconfig and
> multi_v7_defconfig.

Do you want me to push a patch for that, or is that something you want to do?

adam
>
> Regards,
>
> Tony
