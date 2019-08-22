Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D04C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF54D23404
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 12:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566477775;
	bh=u1d+yxJsT1RUvhBvbQpkk+Lf5Hdd3NIZBjhPGRaoLq0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0xrYCP72G5i4CiP/k3+adHLUBwdfGHvRGQImbHYXlWG7FmllAoIkbKa6wsRwnkQs1
	 tNvaJfy/QqQbshl5xSUKLiEl4IkUUVI5MBlCa+XCFbmzmD8E8isDJRBY66fytQmY6G
	 9vzs34b+UFDd0zNUyymnbR4YcexwXUUxop81PSz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387928AbfHVMmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 08:42:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:35042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731964AbfHVMmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 08:42:54 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB8E23400;
        Thu, 22 Aug 2019 12:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566477774;
        bh=u1d+yxJsT1RUvhBvbQpkk+Lf5Hdd3NIZBjhPGRaoLq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=edR3/F8kHjufAIzXmL5EPLQL9s+FkyXsTgFLD3pGhyRokP1bjNEbtCpYRTsZQWFxU
         hhpHuv5/XDfytUXLzvVwVR2im285sPfm3Nmu0StCVp6XXQrXbuEoGXtcgLHeoikLEN
         o6Gey1aefucRSEdl8XNh3eBlPk+tmGJn6uhnA4Kk=
Received: by mail-qt1-f182.google.com with SMTP id l9so7440883qtu.6;
        Thu, 22 Aug 2019 05:42:54 -0700 (PDT)
X-Gm-Message-State: APjAAAUy99qFIC7z+vEZfsWu5VrH2RuAhoJZaFBCQFCiI51pn9K28vpF
        RITe/li0VM89eKwxlVct7mGk7C/I8Y4ujfzF3g==
X-Google-Smtp-Source: APXvYqxC0xb53h6O4RvVMfpbGb5MhrE12k/FG4k5FZrxkO1CLd25XOg+b1pujVZE4NJPmG2GhguxmB+9CL3m/MBOJiI=
X-Received: by 2002:ac8:386f:: with SMTP id r44mr37134933qtb.300.1566477773293;
 Thu, 22 Aug 2019 05:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190809093158.7969-1-lkundrak@v3.sk> <20190809093158.7969-3-lkundrak@v3.sk>
 <20190821210349.GA29732@bogus> <c859d12167d18c21dda13b30c2dd3256f407d1d9.camel@v3.sk>
In-Reply-To: <c859d12167d18c21dda13b30c2dd3256f407d1d9.camel@v3.sk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Aug 2019 07:42:42 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+BVUX3MMjsjK+hhjgDzdiqoo8dwEMD_98OrkGMOQf8GA@mail.gmail.com>
Message-ID: <CAL_Jsq+BVUX3MMjsjK+hhjgDzdiqoo8dwEMD_98OrkGMOQf8GA@mail.gmail.com>
Subject: Re: [PATCH 02/19] dt-bindings: arm: mrvl: Document MMP3 compatible string
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Olof Johansson <olof@lixom.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 3:12 AM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> On Wed, 2019-08-21 at 16:03 -0500, Rob Herring wrote:
> > On Fri, Aug 09, 2019 at 11:31:41AM +0200, Lubomir Rintel wrote:
> > > Marvel MMP3 is a successor to MMP2, containing similar peripherals with two
> > > PJ4B cores.
> > >
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > ---
> > >  Documentation/devicetree/bindings/arm/mrvl/mrvl.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > > index 951687528efb0..66e1e1414245b 100644
> > > --- a/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > > +++ b/Documentation/devicetree/bindings/arm/mrvl/mrvl.txt
> > > @@ -12,3 +12,7 @@ Required root node properties:
> > >  MMP2 Brownstone Board
> > >  Required root node properties:
> > >     - compatible = "mrvl,mmp2-brownstone", "mrvl,mmp2";
> > > +
> > > +MMP3 SoC
> > > +Required root node properties:
> > > +   - compatible = "marvell,mmp3";
> >
> > Please convert this file to DT schema before adding new SoCs.
>
> Is this something that should generally be done for all new or changed
> DT bindings?

Preferred, but not quite yet required everywhere. It depends on the
maintainer/subsystem still. But for board level bindings, you'll
notice most of them are converted. Marvell, Broadcom, and TI are the
main ones left.

Rob
