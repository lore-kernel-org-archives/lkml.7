Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8D5C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62FCA20870
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 21:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Vez0S7pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfHXVen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:34:43 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43211 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbfHXVen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 17:34:43 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so11904902otp.10;
        Sat, 24 Aug 2019 14:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=savXqhs2uu2xmuEzviZKveXuAb0IFd9jFNiOauijyzY=;
        b=Vez0S7pajWL6j3W9sv4ihT78Hv+L6CgTLaiEDc5PAUpRTdYrjtsii6vHCQ+sYoTaek
         VZ5TAQS0Gw14OskOgIRMxa9+9ZKvg094k/y2nwTFwScfsMWsYqM68sGFikZKnhSZzLBO
         L9S5ogu6GksQtl4Lv1Im6wSDHtUsB4GWzwy9PSF/Risf/g+Oh4hXbkwrbrwBytwfYz1Q
         qqsdNJNxDGej0xlOD0r7b749a+nS6RY0WA+MqVwH4PeCfoqn99n/QFvgkUPsRv6VGiiA
         4wwX21xVn5rlCJUtfGO+KBjb1eVtpuKQ8eAZ6a5BGLeKfSLG2hB7gUn9FgchTEya9YUa
         PJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=savXqhs2uu2xmuEzviZKveXuAb0IFd9jFNiOauijyzY=;
        b=VVkFekyLmefQAj63dQcf68BVcvZL9xgX5KmhQ9NWkSEsA+F8gMg4PLijDIH0D9xfbX
         SINDrmxdUZovImg5XEaLXWYLEF1x6jvBQbZOucvYXMHSxmH7/VTxrSQScpnzW6th659/
         QqMD7f+9QPNf9M+s22IhHZCK95S+bTzk91G5sAAepth7Ta3AFG0fv4+LQsQdpB9EhAfY
         OU9jHZw5Ze8GlEoMX+VE5bXuuYQTPwEr+4aAGLguSUgjU14Yf5cTWrZxZueENP5kgIO7
         VRQM8WLE27H9UbI/QwRz2b9iWYyKSpBTxmFqw0A0yTaawBJhPFnhFrGwq52fMmBYPFHj
         GTRw==
X-Gm-Message-State: APjAAAU3UJjFVtPUlrIZjTGBPmSt4d1eRcdswa0VTMI/Sjp9nS8+4ACI
        tlTbSLpBr434+QACG+jRW5Rhy/EfwAJKpbL4QBo=
X-Google-Smtp-Source: APXvYqz17aHOJPKFNLYxMYsQ/6MafCK5GmP9whUj0nEYsJX1zTyXwxzYqW+ciohIN2Uw7AQ+s8+mxRV7kvLWXdUsfpY=
X-Received: by 2002:a9d:7b44:: with SMTP id f4mr928724oto.42.1566682482002;
 Sat, 24 Aug 2019 14:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190708173330.13217-1-martin.blumenstingl@googlemail.com>
 <20190708173330.13217-3-martin.blumenstingl@googlemail.com> <CAPDyKFoFQ_QvHD-+Mg_VAR5rqs3CM_h7dw25p81JTzE1Yz7d1A@mail.gmail.com>
In-Reply-To: <CAPDyKFoFQ_QvHD-+Mg_VAR5rqs3CM_h7dw25p81JTzE1Yz7d1A@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sat, 24 Aug 2019 23:34:31 +0200
Message-ID: <CAFBinCBOhKezUQMJb4eRHTbzXOhucxuAJydDe4H5JyRFgOxS-w@mail.gmail.com>
Subject: Re: [PATCH RFC v1 2/2] mmc: host: meson-mx-sdhc: new driver for the
 Amlogic Meson SDHC host
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jianxin.pan@amlogic.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Thu, Aug 22, 2019 at 3:53 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 8 Jul 2019 at 19:33, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > WiP - only partially working - see performance numbers.
> >
> > Odroid-C1 eMMC (HS-200):
> > Amlogic's vendor driver @ Linux 3.10:
> >   7781351936 bytes (7.8 GB) copied, 134.714 s, 57.8 MB/s
> > This driver:
> >   7781351936 bytes (7.8 GB, 7.2 GiB) copied, 189.02 s, 41.2 MB/s
> >
> > EC-100 eMMC (HS MMC):
> > Amlogic's vendor driver @ Linux 3.10:
> >   15762194432 bytes (16 GB) copied, 422.967 s, 37.3 MB/s
> > This driver:
> >   15762194432 bytes (16 GB, 15 GiB) copied, 9232.65 s, 1.7 MB/s
> >
> > 1) Amlogic's vendor driver does some magic with the divider:
> >       clk_div = input_rate / clk_ios - !(input_rate%clk_ios);
> >       if (!(clk_div & 0x01)) // if even number, turn it to an odd one
> >          clk_div++;
> >    It's not clear to me whether what the reason behind this is, what is
> >    supposed to be achieved with this?
> >
> > 2) The hardcoded RX clock phases are taken from the vendor driver. It
> >    seems that these are only valid when fclk_div3 is used as input
> >    clock (however, there are four more inputs). It's not clear to me how
> >    to calculate the RX clock phases in set_ios based on the input clock
> >    and the ios rate.
> >
> > 3) The hardware supports a timeout IRQ but the max_busy_timeout is not
> >    documented anywhere.
> >
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>
> Martin, overall this looks good to me. Once you moved from RFC to a
> formal patch I will check again, of course.
OK, great

in the meantime I got answers to my questions (off-list) from Jianxin.

also someone asked me (just this week) for the .dts patches so he
could test on his own board (I have them ready but didn't send them
yet)
unfortunately he ran into some data corruption on writing
I can reproduce it but I didn't have time to debug this yet

I'll send an updated version once I have resolved that - as non-RFC

> There are a couple of calls to readl_poll_timeout(), for different
> reasons, that I have some questions about, but we can discuss those in
> the next step.
sure.
feel free to ask now since I still have to debug that data corruption
problem as stated above


Martin
