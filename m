Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87C6C5AD68
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D04F20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 20:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="J6iZz4W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbfIWU4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 16:56:41 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39190 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388120AbfIWU4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 16:56:40 -0400
Received: by mail-ot1-f67.google.com with SMTP id s22so13423702otr.6;
        Mon, 23 Sep 2019 13:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCBVHzoVPJRdaVAQ/V0UNMxjnGUzoZBL++du/W+XNNU=;
        b=J6iZz4W8Ac0KBesx6BZtBfbxR7BQScJgoudoCWm4eqelCxtbb8CRR1OpkUlLJgnKMy
         uiw/NRW+0NW3vCN7M2fC1JsmjKmnH2LxLFkq7Vb68H/dFCwMXbRBJWQgo2oJFOHy9sx+
         +7OrBps8hEGSVo1mM/yqiENDR15b/8qkGabDROQaiYpnBOfnd7u9YAD9boIvjV9Bk67+
         Wo12mduo9QhmGcu39rq+MSbbfYh4YAVsQVzrQQx5d0Oehe2ivPKTcPC0CXJEus6t62pV
         5BhF1i61A7KsfXX4on3Vt/2KVsZREtoSJxwo5hZBPL/VNEIx3v6ifpCPFVmdVbj3MwXI
         Fwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCBVHzoVPJRdaVAQ/V0UNMxjnGUzoZBL++du/W+XNNU=;
        b=SpMSPIZ5QxT5AXZ2eDFZjSrEfxeuP2x/IEl3cTfuQXAja9kWt/CWfGBc/eZZVSWKvM
         J76smjD5+IMiT2liCIzfwNqrW1IWK/G/XuXC+JDd2x15JOlT8lKC+2TPQ7WGDl0b+QEi
         jdhtzoA7Hk/hkdMgy8m6KwTdUeKTQVWdeUPjBh4EdQnxmI2J9oYcUzPY09zyDEpeA0vS
         hZVbOhyG+eE81azwcfj0Paa4bzoCx9p/p84Fdk/nanbE92H7rwGmswun9I2BXXaNT/e8
         jNxXBFMKaq+UKGD2v/eZM4AJBprwWI7BzihXF6GseBAUna2S54Dtm+tdqHe0M8s7WcEz
         JobQ==
X-Gm-Message-State: APjAAAXX83Jv3XnFiknuGUUmFCgaBp4pZ6KpBnjPa59Hh66p3YB/QYih
        DGiQO5LRkjgkFpfsZo0DQ5YvxV+9UaJc5KZWyow=
X-Google-Smtp-Source: APXvYqyFuoyRlSXDjYvUjGpC3v15Fq1MINoED6Nm8UI7SCewQGRK7t4EFd08t605KjoTnJyFeyLibLTPt+LwwMFBvsY=
X-Received: by 2002:a9d:6084:: with SMTP id m4mr197808otj.6.1569272199532;
 Mon, 23 Sep 2019 13:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com> <1jzhivs6n6.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jzhivs6n6.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 23 Sep 2019 22:56:28 +0200
Message-ID: <CAFBinCA0NaCJEDfNEg+LRfW3wxfNFGbXmGS+z7D5792TsupVAA@mail.gmail.com>
Subject: Re: [PATCH 0/5] provide the XTAL clock via OF on Meson8/8b/8m2
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Mon, Sep 23, 2019 at 11:29 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Sat 21 Sep 2019 at 17:12, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:
>
> > So far the HHI clock controller has been providing the XTAL clock on
> > Amlogic Meson8/Meson8b/Meson8m2 SoCs.
> > This is not correct because the XTAL is actually a crystal on the
> > boards and the SoC has a dedicated input for it.
> >
> > This updates the dt-bindings of the HHI clock controller and defines
> > a fixed-clock in meson.dtsi (along with switching everything over to
> > use this clock).
> > The clock driver needs three updates to use this:
> > - patch #2 uses clk_hw_set_parent in the CPU clock notifier. This drops
> >   the explicit reference to CLKID_XTAL while at the same time making
> >   the code much easier (thanks to Neil for providing this new method
> >   as part of the G12A CPU clock bringup!)
> > - patch #3 ensures that the clock driver doesn't rely on it's internal
> >   XTAL clock while not losing support for older .dtbs that don't have
> >   the XTAL clock input yet
> > - with patch #4 the clock controller's own XTAL clock is not registered
> >   anymore when a clock input is provided via OF
> >
> > This series is a functional no-op. It's main goal is to better represent
> > how the actual hardware looks like.
>
> I'm a bit unsure about this series.
>
> On one hand, I totally agree with you ... having the xtal in DT is the
> right way to do it ... when done from the start
yep

> On the other hand, things have been this way for years, they are working
> and going for xtal in DT does not solve any pending issue. Doing this
> means adding complexity in the driver to support both methods. It is
> also quite a significant change in DT :/
my two main motivations were:
- keeping the 32-bit SoCs as similar as possible to the 64-bit ones in
terms of "how are the [clock] drivers implemented"
- with the DDR clock controller the .dts looked weird: &ddr_clkc took
CLKID_XTAL from &clkc as input and &clkc took DDR_CLKID_DDR_PLL as
input from &ddr_clkc

RE complexity in the driver to support both:
I still have a cleanup of the meson8b.c init code on my TODO-list
because we're still supporting .dtbs without parent syscon
my plan is to drop that code-path along with the newly added fallback
for "skip CLKID_XTAL" (assuming this is accepted) together for v5.6 or
v5.7


Martin
