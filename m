Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CFBCA9ED1
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4810D2086D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572605642;
	bh=Qq5uDUh2NAo8fqV6wNGVGEMgX1RTvNFGVvP2NZoDCJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wCskYLhmeZ+R+jKKnMnEZfdQnSH6EZyJ3KIadWTIpbwDTMjNRLUrO/1JnfQCurmho
	 SQQRo4TvA/nX32XYBWzqV+3sytACrS+mJbhQCgYf3RDlcHh1YHg/e4Lx7uG5m3JhCU
	 HHAu/G2/CZ1Up4LYux4pahh6s3xxLBy8ExS5fq6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbfKAKyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 06:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbfKAKyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 06:54:00 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EA6521897;
        Fri,  1 Nov 2019 10:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572605639;
        bh=Qq5uDUh2NAo8fqV6wNGVGEMgX1RTvNFGVvP2NZoDCJs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dJssP0BubNF96U27YGA25BF4L03OtdVguBaTCc00FUo0WFtULEicmT4wttke4p4Pt
         2O2Rw0nW5apd0QaniBP3+m0ewuiu6nlWqaooJT7vgZVV01uND28whgkmCp5XzM9yX4
         WTfayBWyWoyWkUOz9uP+o3u6Hr7XkXfFoIsMlAOU=
Received: by mail-lf1-f43.google.com with SMTP id f5so6939601lfp.1;
        Fri, 01 Nov 2019 03:53:58 -0700 (PDT)
X-Gm-Message-State: APjAAAWxF9PR4eYb+vv8K2OcTuGSEDQZoX7EFmMnWV+PkkvjSvxk0sJZ
        PibPxBFgV4fpv/dgJYsGtyq3A4N/VBb/Q5B7NAk=
X-Google-Smtp-Source: APXvYqzPNO+lSp1NGMQoEFqECmKTS1sJUS58FFxOWntNonCUIVnUCLRCXSqjn52p8zPDEzb3zy9Uf2v1Rt6VLAnp19Y=
X-Received: by 2002:a19:ad4a:: with SMTP id s10mr6726882lfd.159.1572605637145;
 Fri, 01 Nov 2019 03:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191021161351.20789-1-krzk@kernel.org> <20191021161351.20789-4-krzk@kernel.org>
 <CAMuHMdXr7_HP5NUQ_0D76N-eBuootQqyPusqmf6nyDnLN__ORA@mail.gmail.com>
In-Reply-To: <CAMuHMdXr7_HP5NUQ_0D76N-eBuootQqyPusqmf6nyDnLN__ORA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 1 Nov 2019 11:53:45 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcZGhC1+-tOwL6N_ohWzXEqJ3T6=HWefNzXsa3eeQN1fg@mail.gmail.com>
Message-ID: <CAJKOXPcZGhC1+-tOwL6N_ohWzXEqJ3T6=HWefNzXsa3eeQN1fg@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] dt-bindings: sram: Merge Renesas SRAM bindings
 into generic
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Heiko Stuebner <heiko@sntech.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2019 at 11:08, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Krzysztof,
>
> On Mon, Oct 21, 2019 at 6:15 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > The Renesas SRAM bindings list only compatible so integrate them into
> > generic SRAM bindings schema.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Thanks for your patch, whcih is now commit 0759b09eadd0d9a1 ("dt-bindings:
> sram: Merge Renesas SRAM bindings into generic") in Rob's for-next branch.
>
> > --- a/Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
> > +++ /dev/null
> > @@ -1,27 +0,0 @@
> > -* Renesas SMP SRAM
> > -
> > -Renesas R-Car Gen2 and RZ/G1 SoCs need a small piece of SRAM for the jump stub
> > -for secondary CPU bringup and CPU hotplug.
> > -This memory is reserved by adding a child node to a "mmio-sram" node, cfr.
> > -Documentation/devicetree/bindings/sram/sram.txt.
> > -
> > -Required child node properties:
> > -  - compatible: Must be "renesas,smp-sram",
> > -  - reg: Address and length of the reserved SRAM.
> > -    The full physical (bus) address must be aligned to a 256 KiB boundary.
> > -
> > -
> > -Example:
> > -
> > -       icram1: sram@e63c0000 {
> > -               compatible = "mmio-sram";
> > -               reg = <0 0xe63c0000 0 0x1000>;
> > -               #address-cells = <1>;
> > -               #size-cells = <1>;
> > -               ranges = <0 0 0xe63c0000 0x1000>;
> > -
> > -               smp-sram@0 {
> > -                       compatible = "renesas,smp-sram";
> > -                       reg = <0 0x10>;
> > -               };
>
> > --- a/Documentation/devicetree/bindings/sram/sram.yaml
> > +++ b/Documentation/devicetree/bindings/sram/sram.yaml
>
> > @@ -186,3 +187,17 @@ examples:
> >              reg = <0x1ff80 0x8>;
> >          };
> >      };
> > +
> > +  - |
> > +    sram@e63c0000 {
> > +        compatible = "mmio-sram";
> > +        reg = <0xe63c0000 0x1000>;
>
> Is there any specific reason you converted the example from 64-bit to
> 32-bit addressing?
> All Renesas SoCs using this have #address-cells and #size-cells = <2>.

I should mention it in commit msg. The reason is because examples are
compiled inside a {} with address/size cells of 1. Instead of
conversion maybe it would be reasonable to put it inside additional
node adjusting the address/size cells.

Best regards,
Krzysztof
