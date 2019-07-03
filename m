Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED474C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8EA02187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562160169;
	bh=i7lxqt67ElBXTpssGl7R88bbn7Biqfy6vIxKqyDJOHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vdf9lLH4AhVHM7AMqO6iy/YGmTB4G+j93qjPCyQMyaIJQP9cccVnH+d235RPxE4qN
	 lFvHoc8tgT+MLnrPSiMdfdKpDfavO0qY2QVMieNo40E8ycOAiTPNO9dXhj61/8ldlO
	 kSqqUEbG2eJYIaJuW2h6N4ZaGQ9s3ON8tBFHvDXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGCNWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:22:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbfGCNWr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:22:47 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14FF4218A6;
        Wed,  3 Jul 2019 13:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562160167;
        bh=i7lxqt67ElBXTpssGl7R88bbn7Biqfy6vIxKqyDJOHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KAbnBP7UXB/7O4RstOzuf5CUNfxuETmGPlIWQiajkxeLhKPXbtmjbFQfw1BMeqsgl
         famkTXEGQrpqt1dsH8EfY2fhrUFrW5lHp00N3VdJ82BwiKoKw1rJa6X8p7lnbdjuCU
         9wqKDHGAAK4Rn6zaZxJZ6Nb/UVBVS36jaiL3k3hU=
Received: by mail-qt1-f171.google.com with SMTP id h24so3062844qto.0;
        Wed, 03 Jul 2019 06:22:47 -0700 (PDT)
X-Gm-Message-State: APjAAAVQo7LiG8n5AzdomyfkoqByG+ELRRGkyyFyICk3Y+sIKqngF2en
        R/6qJ89eF7yiWsMlBkusyPiWx9RUlrf4kbh96Q==
X-Google-Smtp-Source: APXvYqxLP+VzxHa5XqG7WxyNN/AtKHhHZs5r8FKiUdKHAMFXYxIBBIsL+O5ozKT1zKRhIMJCtzDzPOLRYD9XFQsU8Kk=
X-Received: by 2002:a0c:baa1:: with SMTP id x33mr32576504qvf.200.1562160166281;
 Wed, 03 Jul 2019 06:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190630210019.26914-1-digetx@gmail.com> <20190630210019.26914-8-digetx@gmail.com>
 <CAL_JsqJq5iwQcbUixMWK819OTof8DzrZ3UMhByc1pTAFTdwnjg@mail.gmail.com>
 <ba299725-b65b-ce7d-6376-a26918cc985b@gmail.com> <d98f16ee-ac43-8f1e-d324-d6e2cfccf3c8@gmail.com>
In-Reply-To: <d98f16ee-ac43-8f1e-d324-d6e2cfccf3c8@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 3 Jul 2019 07:22:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+-cuqVf60MbaNTz3jCUQkEpU8EgUe1xyOzHLsM5zjjEg@mail.gmail.com>
Message-ID: <CAL_Jsq+-cuqVf60MbaNTz3jCUQkEpU8EgUe1xyOzHLsM5zjjEg@mail.gmail.com>
Subject: Re: [PATCH v6 07/15] dt-bindings: memory: tegra30: Convert to
 Tegra124 YAML
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 6:48 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.07.2019 22:30, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > 01.07.2019 22:11, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >> On Sun, Jun 30, 2019 at 3:04 PM Dmitry Osipenko <digetx@gmail.com> wro=
te:
> >>>
> >>
> >> "Convert" implies you delete the old binding doc.
> >
> > Yes, unfortunately the deletion got lost by accident after rebase and i=
t was already
> > too late when I noticed that. Will be fixed in the next revision.
> >
> >>> The Tegra30 binding will actually differ from the Tegra124 a tad, in
> >>> particular the EMEM configuration description. Hence rename the bindi=
ng
> >>> to Tegra124 during of the conversion to YAML.
> >>>
> >>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>> ---
> >>>  .../nvidia,tegra124-mc.yaml                   | 149 ++++++++++++++++=
++
> >>>  1 file changed, 149 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/memory-controll=
ers/nvidia,tegra124-mc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvi=
dia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers=
/nvidia,tegra124-mc.yaml
> >>> new file mode 100644
> >>> index 000000000000..d18242510295
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,teg=
ra124-mc.yaml
> >>> @@ -0,0 +1,149 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra12=
4-mc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title:
> >>> +  NVIDIA Tegra124 SoC Memory Controller
> >>> +
> >>> +maintainers:
> >>> +  - Jon Hunter <jonathanh@nvidia.com>
> >>> +  - Thierry Reding <thierry.reding@gmail.com>
> >>> +
> >>> +description: |
> >>> +  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controll=
er.
> >>> +  These are interleaved to provide high performance with the load sh=
ared across
> >>> +  two memory channels. The Tegra124 Memory Controller handles memory=
 requests
> >>> +  from internal clients and arbitrates among them to allocate memory=
 bandwidth
> >>> +  for DDR3L and LPDDR3 SDRAMs.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: nvidia,tegra124-mc
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +    description:
> >>> +      Physical base address.
> >>> +
> >>> +  clocks:
> >>> +    maxItems: 1
> >>> +    description:
> >>> +      Memory Controller clock.
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: mc
> >>> +
> >>> +  interrupts:
> >>> +    maxItems: 1
> >>> +    description:
> >>> +      Memory Controller interrupt.
> >>> +
> >>> +  "#reset-cells":
> >>> +    const: 1
> >>> +
> >>> +  "#iommu-cells":
> >>> +    const: 1
> >>> +
> >>> +patternProperties:
> >>> +  ".*":
> >>
> >> Please define a node name or pattern for node names.
> >
> > There was no pattern specified in the original binding. But I guess the=
 existing
> > upstream device-trees could be used as the source for the pattern.
>
> Actually it looks like the use of explicit pattern is not really a good i=
dea because
> device-tree could have node named in a way that it doesn't match the patt=
ern and hence
> dtbs_check silently skips the non-matching nodes. Is there any way to exp=
ress that
> non-matching nodes shall be rejected?

additionalProperties: false

It's not ideal because you have to list all properties and can't
combine multiple schema, but that's getting addressed in json-schema
draft8. That shouldn't matter for you in this case though.

Rob
