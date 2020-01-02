Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84706C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA36217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578004973;
	bh=X1sDydLqSX2i4y9/WNq55HXF+1lcahFGVi3B3JmDeCE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oM5QJceB0FaqTyApfsUe3n3hszDtbZYDU+CVDbwmyspUqm7tfCLkn+l5nIY7n+YFu
	 7xMqocSA42cLaOgV/Hed5sCI9KE+RQ0x66vL41kdD6HpwO/0PBc5IVh2glVxtKhy0k
	 5ZsVeEfcM1uBGOUJmz0RUFbbHeDPGYVm83gZjmGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgABWmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:42:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbgABWmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:42:45 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75157222C3;
        Thu,  2 Jan 2020 22:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578004964;
        bh=X1sDydLqSX2i4y9/WNq55HXF+1lcahFGVi3B3JmDeCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u7Tl+fXnDkklH/8QPf1heNJVzkOJ3TaUcSY9VoqunoijYHfPC40fXtDmCAIEZOfGH
         UT7ccdfQEQrCPns7STxeE3O8NMhJKJCAwsVBVtihW0+DDjp0SXo4+UCEX0O2kWb04S
         pP2xETmMH+P+54UFb0Ws5HkduJ1Ewrss6SqZuZNs=
Received: by mail-qk1-f169.google.com with SMTP id t129so32487319qke.10;
        Thu, 02 Jan 2020 14:42:44 -0800 (PST)
X-Gm-Message-State: APjAAAWwKL+VUZ+/7s7nOTVBO0lvFQ/eKPWTJmy2MBeIXFum9bpf1l+X
        4OVEtcj6Yai7JTqRPXmipBDXq/KEQHQREM9boA==
X-Google-Smtp-Source: APXvYqwHjJixw+g5oo7LgzM37cf5twPti8tRxdrwCGh+tDfV93Rz9uc+7Jw8lKgm9/CqOO54nJLkoJK64EKW6TgtHaM=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr63515899qkl.119.1578004963560;
 Thu, 02 Jan 2020 14:42:43 -0800 (PST)
MIME-Version: 1.0
References: <20191216121932.22967-1-zhang.lyra@gmail.com> <20191216121932.22967-4-zhang.lyra@gmail.com>
 <20191226185623.GA4463@bogus> <CAAfSe-vL4S-w4JVzevPYxb=LNqGQEn6quM54AjPHZUe6Gw3WTg@mail.gmail.com>
In-Reply-To: <CAAfSe-vL4S-w4JVzevPYxb=LNqGQEn6quM54AjPHZUe6Gw3WTg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 2 Jan 2020 15:42:23 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKu5KwogNzr2wjtDFjWLH1cLOLBi0FK5ZZipdKS-MWVMQ@mail.gmail.com>
Message-ID: <CAL_JsqKu5KwogNzr2wjtDFjWLH1cLOLBi0FK5ZZipdKS-MWVMQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/6] dt-bindings: clk: sprd: add bindings for sc9863a
 clock controller
To:     Chunyan Zhang <zhang.lyra@gmail.com>
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

On Mon, Dec 30, 2019 at 8:07 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Fri, 27 Dec 2019 at 02:56, Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, Dec 16, 2019 at 08:19:29PM +0800, Chunyan Zhang wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > add a new bindings to describe sc9863a clock compatible string.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  .../bindings/clock/sprd,sc9863a-clk.yaml      | 77 +++++++++++++++++++
> > >  1 file changed, 77 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> > > new file mode 100644
> > > index 000000000000..881f0a0287e5
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml
> > > @@ -0,0 +1,77 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2019 Unisoc Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/clock/sprd,sc9863a-clk.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: SC9863A Clock Control Unit Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Orson Zhai <orsonzhai@gmail.com>
> > > +  - Baolin Wang <baolin.wang7@gmail.com>
> > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > +
> > > +properties:
> > > +  "#clock-cells":
> > > +    const: 1
> > > +
> > > +  compatible :
> > > +    enum:
> > > +      - sprd,sc9863a-ap-clk
> > > +      - sprd,sc9863a-pmu-gate
> > > +      - sprd,sc9863a-pll
> > > +      - sprd,sc9863a-mpll
> > > +      - sprd,sc9863a-rpll
> > > +      - sprd,sc9863a-dpll
> > > +      - sprd,sc9863a-aon-clk
> > > +      - sprd,sc9863a-apahb-gate
> > > +      - sprd,sc9863a-aonapb-gate
> > > +      - sprd,sc9863a-mm-gate
> > > +      - sprd,sc9863a-mm-clk
> > > +      - sprd,sc9863a-vspahb-gate
> > > +      - sprd,sc9863a-apapb-gate
> >
> > These will probably need to be split to separate schemas for the reasons
> > below...
> >
> > > +
> > > +  clocks:
> > > +    description: |
> > > +      The input parent clock(s) phandle for this clock, only list fixed
> > > +      clocks which are decleared in devicetree.
> >
> > typo.
> >
> > You need to define how many clocks.
>
> Ok, will add a define of maxItems.
>
> >
> > > +
> > > +  clock-names:
> > > +    description: |
> > > +      Clock name strings used for driver to reference.
> >
> > You need to list out the names.
> >
> > > +
> > > +  reg:
> > > +    description: |
> > > +      Contain the registers base address and length. It must be configured
> > > +      only if no 'sprd,syscon' under the node.
> > > +
> > > +  sprd,syscon:
> > > +    $ref: '/schemas/types.yaml#/definitions/phandle'
> > > +    description: |
> > > +      The phandle to the syscon which is in the same address area with
> > > +      the clock, and so we can get regmap for the clocks from the
> > > +      syscon device.
> >
> > It is preferred to make the clock node a child of the syscon and then
> > you don't need this property.
>
> According to the hardware topology, any clocks are not belonged to
> syscon, like described here, this phandle is only used to get virtual
> map address for clocks which have the same phsical address base with
> one syscon.
>
> In the past, clocks were defined like below:
>     apahb_gate: apahb-gate {
>       compatible = "sprd,sc9863a-apahb-gate";
>       reg = <0 0x20e00000 0 0x1000>;
>       #clock-cells = <1>;
>     };
>
> And there was also a syscon which had the same base address like below:
> ap_ahb_regs: syscon@20e00000 {
> compatible = "sprd,sc9863a-glbregs", "syscon";
> reg = <0 0x20e00000 0 0x4000>;
> };
>
> To avoid one phsical address was remapped more than one time, I think
> using the mapped address by syscon directly would be better.
> Any other suggestions are very appreciated.

I'm only suggesting you change the location of the node and get the
syscon by getting the parent node. IOW, do this:

ap_ahb_regs: syscon@20e00000 {
    compatible = "sprd,sc9863a-glbregs", "syscon";
    reg = <0 0x20e00000 0 0x4000>;

    apahb_gate: apahb-gate {
        compatible = "sprd,sc9863a-apahb-gate";
        #clock-cells = <1>;
    };
};

Now, if there is a sub range of registers for the clocks that are
contiguous, then apahb-gate should have a 'reg' property too (and
ranges in the parent). Linux will not use that, but it's a more
complete description of the h/w.

Rob
