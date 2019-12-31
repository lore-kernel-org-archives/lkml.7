Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3ABC2D0D3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 03:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E79A2077B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 03:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+5X4jgH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfLaDHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 22:07:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33449 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfLaDHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 22:07:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id d139so1025845wmd.0;
        Mon, 30 Dec 2019 19:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZ0VS0hhU2Vvdywzz5wNCAdkQKdrdnQbQ4w6BurVpwQ=;
        b=h+5X4jgHpLK5FZvMfDyI9vkbxSu9GLdeWW5Mo6g2xR7CDYmdux7e9+KX092C19gm2L
         7HbQuwshg9KK2AZm//GhUxUYf/KixNNgz0a5Jf6Yxit6fCxR/BD+tm+AVjMj6n0mvREY
         x94AnCE9RO8CU9yDOD12qTYg1UbvqjuhtKB0PqjtR0Gc3OXfALB1XNwWCgvKRcfoQ9Xc
         yTbBQCGmoUxhCWK5/BVciN/13tKMozSoBdaaeZmpK6p+WG00hW5xsfHd2NyYS9NeZTDU
         8UMJkiLV8/eKvOsxRXVkRdOkx+vFhZpHwcOZwQWUDgIPTPP5qoA8BVbhOjOIW0yk/wcs
         FZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZ0VS0hhU2Vvdywzz5wNCAdkQKdrdnQbQ4w6BurVpwQ=;
        b=ouDwTaZZAVp+m21VBTt9Dy5kag/kR4Cw/o3MJREy3+TaF7EpSObMTGIk0hYtGtrVkq
         OrAk1bXsWBZG+fjxG4DCfWuH6L1tw4FMb6JTJm081RPuWXejH7BmNzxF5gkJllFjCDBK
         yNW7I2sSK+lVGNDGo+VtE+Zu/y/4pCRqiGHr5X+UOcBg8PSyAiPfW+9y/dHvZJAMC5oG
         RRHDtrD9LYto5W8joOL913M0uOkFy/feBMZMfChUMIurnsOgU+9HJk3C8AOt4R1K9Vi3
         ofj6I1LTA2cZzZr3N96hUN4hStS2CWGJcJ2Jp0d6csWSd38RNu/rH1gcIO7ZboF5X0Up
         TlYg==
X-Gm-Message-State: APjAAAU1XtkX5YQANw65keG2U4kREp9QfTZC0qWEmHRDAFsFR6I04hTo
        YCoa2qDXhJSTwbEMN9jn5DXf7AsCFnzCE0SmcCc=
X-Google-Smtp-Source: APXvYqyAU8QpgcwQV5VZ250qmL5iw27RREeLpKMeKHWBHOiqllsZ75v5UqFZF7O1AS7iokOPdu0imlT+PeKSQz2RYV0=
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr1989297wmj.68.1577761625988;
 Mon, 30 Dec 2019 19:07:05 -0800 (PST)
MIME-Version: 1.0
References: <20191216121932.22967-1-zhang.lyra@gmail.com> <20191216121932.22967-4-zhang.lyra@gmail.com>
 <20191226185623.GA4463@bogus>
In-Reply-To: <20191226185623.GA4463@bogus>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 31 Dec 2019 11:06:29 +0800
Message-ID: <CAAfSe-vL4S-w4JVzevPYxb=LNqGQEn6quM54AjPHZUe6Gw3WTg@mail.gmail.com>
Subject: Re: [PATCH V2 3/6] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
To:     Rob Herring <robh@kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Dec 2019 at 02:56, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Dec 16, 2019 at 08:19:29PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > add a new bindings to describe sc9863a clock compatible string.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../bindings/clock/sprd,sc9863a-clk.yaml      | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> > new file mode 100644
> > index 000000000000..881f0a0287e5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> > @@ -0,0 +1,77 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2019 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: SC9863A Clock Control Unit Device Tree Bindings
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  compatible :
> > +    enum:
> > +      - sprd,sc9863a-ap-clk
> > +      - sprd,sc9863a-pmu-gate
> > +      - sprd,sc9863a-pll
> > +      - sprd,sc9863a-mpll
> > +      - sprd,sc9863a-rpll
> > +      - sprd,sc9863a-dpll
> > +      - sprd,sc9863a-aon-clk
> > +      - sprd,sc9863a-apahb-gate
> > +      - sprd,sc9863a-aonapb-gate
> > +      - sprd,sc9863a-mm-gate
> > +      - sprd,sc9863a-mm-clk
> > +      - sprd,sc9863a-vspahb-gate
> > +      - sprd,sc9863a-apapb-gate
>
> These will probably need to be split to separate schemas for the reasons
> below...
>
> > +
> > +  clocks:
> > +    description: |
> > +      The input parent clock(s) phandle for this clock, only list fixed
> > +      clocks which are decleared in devicetree.
>
> typo.
>
> You need to define how many clocks.

Ok, will add a define of maxItems.

>
> > +
> > +  clock-names:
> > +    description: |
> > +      Clock name strings used for driver to reference.
>
> You need to list out the names.
>
> > +
> > +  reg:
> > +    description: |
> > +      Contain the registers base address and length. It must be configured
> > +      only if no 'sprd,syscon' under the node.
> > +
> > +  sprd,syscon:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > +    description: |
> > +      The phandle to the syscon which is in the same address area with
> > +      the clock, and so we can get regmap for the clocks from the
> > +      syscon device.
>
> It is preferred to make the clock node a child of the syscon and then
> you don't need this property.

According to the hardware topology, any clocks are not belonged to
syscon, like described here, this phandle is only used to get virtual
map address for clocks which have the same phsical address base with
one syscon.

In the past, clocks were defined like below:
    apahb_gate: apahb-gate {
      compatible = "sprd,sc9863a-apahb-gate";
      reg = <0 0x20e00000 0 0x1000>;
      #clock-cells = <1>;
    };

And there was also a syscon which had the same base address like below:
ap_ahb_regs: syscon@20e00000 {
compatible = "sprd,sc9863a-glbregs", "syscon";
reg = <0 0x20e00000 0 0x4000>;
};

To avoid one phsical address was remapped more than one time, I think
using the mapped address by syscon directly would be better.
Any other suggestions are very appreciated.

Thanks,
Chunyan

>
> > +
> > +required:
> > +  - compatible
> > +  - '#clock-cells'
> > +
> > +examples:
> > +  - |
> > +    ap_clk: clock-controller@21500000 {
> > +      compatible = "sprd,sc9863a-ap-clk";
> > +      reg = <0 0x21500000 0 0x1000>;
> > +      clocks = <&ext_32k>, <&ext_26m>;
> > +      clock-names = "ext-32k", "ext-26m";
> > +      #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    apahb_gate: apahb-gate {
> > +      compatible = "sprd,sc9863a-apahb-gate";
> > +      sprd,syscon = <&ap_ahb_regs>;
> > +      #clock-cells = <1>;
> > +    };
> > +
> > +...
> > --
> > 2.20.1
> >
