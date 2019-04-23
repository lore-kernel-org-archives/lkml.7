Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2141C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5F121738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 07:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDWH3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 03:29:16 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36224 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfDWH3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 03:29:15 -0400
Received: by mail-vs1-f67.google.com with SMTP id n4so7689448vsm.3;
        Tue, 23 Apr 2019 00:29:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+MefNm+pecE/AsJnyB5Qfp/OpdWSmhI3wPLaKD4Ekwo=;
        b=rjXmiRn/RN8kjLnyRDDrbcE3DYkMQNa2IjjjK8MhlMR5hsujnNoEbBqAUbIauulvP4
         DT0HFMVq46je3TsstecsyIVPE5GoakLQCNLMW9HgPE3S6wIzBEAcc0LCKCSFptk8jlAU
         4xRIq9ojxWYGOZFw63BWM0e8VZ2UNBqq5tMCGb2atR7niLDXsJEKS8NeYNQn0619dKBs
         JUyS1AFTe6TPy2P2CI1UZqi9Y244gHimEIx3CkfjsBf/DXhWk7i5iNueA86pGtA3q8WF
         DlvirmRmBnpgHmia8gsvOcryBKOsXb/w94iEQRaEMP5bHAU+fzaxXp2qAVAJZJSToHa1
         0Yqg==
X-Gm-Message-State: APjAAAU6rVmsh+G1ZCuamrGwFa47Qa4KFT2s7ZksMsxGAtWqPhJikuNF
        k6diioAkZ5k1dNFnoNPNlmfvHrDNbPkW5wnsvsM=
X-Google-Smtp-Source: APXvYqwiUeznfCQCCiNvFMVuL3w0HOPR6mcVKhDTDDOoCREkGxDMyy+Kf8n3+h0s4g36eZbfboeDr2vTNSwlb+pr1R4=
X-Received: by 2002:a67:8e03:: with SMTP id q3mr1952785vsd.152.1556004553822;
 Tue, 23 Apr 2019 00:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com> <cdee3d53-6ee3-4435-117e-8ba4a58ca72b@cogentembedded.com>
 <OF82CE76E9.E6395EF7-ON482583DD.000E37D7-482583DD.000E5077@mxic.com.tw>
 <3d334751-8fd4-7db1-9deb-e6c94936df13@cogentembedded.com> <OF4ABCC306.B053BA23-ON482583E0.000F480C-482583E0.000FAD4A@mxic.com.tw>
 <3971c669-9095-9d18-d029-37f9663a54b2@cogentembedded.com> <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@mxic.com.tw>
In-Reply-To: <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 23 Apr 2019 09:29:02 +0200
Message-ID: <CAMuHMdX30QG6QzJt4c=Aq=4Jad4x7EZ1jwboXfBein20VBUpYg@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Fri, Apr 19, 2019 at 7:39 AM <masonccyang@mxic.com.tw> wrote:
> > Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
> > On 04/18/2019 05:51 AM, masonccyang@mxic.com.tw wrote:
> > >>    Still hangs for me. After I patches spi-mem.c and the driver to
> > >> call RPM for the MFD, it started working again. Perhaps, that clock
> > >> is still enabled on your target. What does the following print (for
> > >> the RPC clocks)?
> > >>
> > >> $ mount none -t debugfs /sys/kernel/debug/
> > >> $ cat /sys/kernel/debug/clk/clk_summary
> > >>
> > >
> > > root@draak:/# cat /sys/kernel/debug/clk/clk_summary
> > >                                  enable  prepare  protect              duty
> > >    clock                          count    count    count
> > rate   accuracy phase  cycle
> > >
> > ---------------------------------------------------------------------------------------------
> > >  audio_clkout1                        0        0        0     11289600          0     0  50000
> > >  x19_clk                              0        0        0    24576000          0     0  50000
> > >  dclkin-0                             0        0        0        0          0     0  50000
> > >  scif                                 1        1        0        0          0     0  50000
> > >  audio_clkb                           0        0        0    22579200          0     0  50000
> > >  msiof-ref-clock                      0        0        0    66666666          0     0  50000
> > >  extal                                2        3        0    48000000          0     0  50000
> > >     r                                 0        2        0      31250          0     0  50000
> > >        rpc-if                         0        1        0      31250          0     0  50000
> >
> >    This looks wrong, the RPC-IF module clock should have RPC or
> > RPCD2 (where ae they?)
> > as a source, not RLCK...
>
> I check the Ch8 CPG of R-Car datasheet, figure 8.1f(R-Car D3),
> the RPC/RPCD2 is derived from PLL1 -> PLL1CK
>
> I didn't patch it and it should be exposed afrer the .sdsrc
>
>     .main                                 2            2    48000000          0 0
>        .pll3                              0            0   928000000          0 0
>        .pll1                              4            4  1600000000          0 0
>           lv1                             0            0  1600000000          0 0
>           lv0                             1            1  1600000000          0 0
>              lvds                         1            1  1600000000          0 0
>           cl                              0            0    33333333          0 0
>           zx                              0            0   533333333          0 0
>           zt                              0            0   400000000          0 0
>           ztr                             0            0   266666666          0 0
>           .sdsrc                          1            1   800000000          0 0
>              sd0                          1            1   200000000          0 0
>                 emmc0
> ---> here !

Upstream drivers/clk/renesas/r8a77995-cpg-mssr.c does not have the "rpc-if"
clock, and we have not yet seen the patch to add it that you must be using
to make your driver work.  If the clock is defined wrongly, that might
explain why your driver is working for you, but not for Sergei.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
