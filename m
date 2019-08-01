Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E826C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50EE2206B8
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 18:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564682788;
	bh=VmvCWb7mfqIKc99hY4+HpoBTRUyH9cosex+SWHtBDh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OuynVD5uSH1jtRvKNr3nnBVOFRvWoAJYYeqjIqcCRQCpRcbQpEWB+2z2pNGjlFTVv
	 7LNieI19VX2yVBPq1D7+xrhu8WhMOfSVcpl+o8ZIbyN5OWXz9M+vwKZI+zZSyIEf02
	 NfhB9P3YFryOULY+rKdZDBYx46h7I+vh/+a2xHl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbfHASG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 14:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732904AbfHASG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 14:06:26 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EABC7205C9;
        Thu,  1 Aug 2019 18:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564682785;
        bh=VmvCWb7mfqIKc99hY4+HpoBTRUyH9cosex+SWHtBDh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d5WCHW3r8+3cju524szQc7WHidK+U7DLXfyGFi46dJSvGOD7t535VMr6+fmlZT1a0
         ZOADQ5PEa0JUKxdYnZzLM0Qs5OznRUvwE0+NzOTGARY4tIdIBRisZcZ7M1c6syK1zD
         oiMGkLGuMQVJcfBxfvnIHA+MYgoVUzigCfkWpMH0=
Received: by mail-qt1-f172.google.com with SMTP id h18so71202806qtm.9;
        Thu, 01 Aug 2019 11:06:24 -0700 (PDT)
X-Gm-Message-State: APjAAAXap4L1sJ8nANaUnrtmzuG04h2ApBkvRhWdE/AnQdII2HI+Ezxs
        Zxe2nZBdD2eEiOZ/YDB6KIjaTpz04iJkXF/tHw==
X-Google-Smtp-Source: APXvYqwNnqv0tF1obrjN4MP8PlG/HUUO6+Q0cjvIdPQtlTVARGH64UUmlrFCJ29XMPZ6fcPNbNwsBuLaIiLBTyI3IyA=
X-Received: by 2002:a0c:b627:: with SMTP id f39mr95237020qve.72.1564682784150;
 Thu, 01 Aug 2019 11:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190730165618.10122-1-digetx@gmail.com> <20190730165618.10122-10-digetx@gmail.com>
 <CAL_JsqL_LA+cW2GbCMdzRTFuv2oKE3pzyOm2UwdzLVLyVTnmNw@mail.gmail.com> <58e25c92-a61d-54f1-e784-ed85804236d7@gmail.com>
In-Reply-To: <58e25c92-a61d-54f1-e784-ed85804236d7@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 1 Aug 2019 12:06:11 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLuzxRZUD16ONke_yrYMgW6zc4hyjkRFCn=sHdnaOVO-g@mail.gmail.com>
Message-ID: <CAL_JsqLuzxRZUD16ONke_yrYMgW6zc4hyjkRFCn=sHdnaOVO-g@mail.gmail.com>
Subject: Re: [PATCH v9 09/15] dt-bindings: memory: tegra30: Convert to
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

On Thu, Aug 1, 2019 at 11:52 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.08.2019 19:25, Rob Herring =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Jul 30, 2019 at 10:58 AM Dmitry Osipenko <digetx@gmail.com> wro=
te:
> >>
> >> The Tegra30 binding will actually differ from the Tegra124 a tad, in
> >> particular the EMEM configuration description. Hence rename the bindin=
g
> >> to Tegra124 during of the conversion to YAML.
> >>
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >> ---
> >>  .../nvidia,tegra124-mc.yaml                   | 158 +++++++++++++++++=
+
> >>  .../memory-controllers/nvidia,tegra30-mc.txt  | 123 --------------
> >>  2 files changed, 158 insertions(+), 123 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/memory-controlle=
rs/nvidia,tegra124-mc.yaml
> >>  delete mode 100644 Documentation/devicetree/bindings/memory-controlle=
rs/nvidia,tegra30-mc.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvid=
ia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/=
nvidia,tegra124-mc.yaml
> >> new file mode 100644
> >> index 000000000000..2e2a116f1911
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegr=
a124-mc.yaml
> >> @@ -0,0 +1,158 @@
> >> +# SPDX-License-Identifier: (GPL-2.0)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124=
-mc.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: NVIDIA Tegra124 SoC Memory Controller
> >> +
> >> +maintainers:
> >> +  - Jon Hunter <jonathanh@nvidia.com>
> >> +  - Thierry Reding <thierry.reding@gmail.com>
> >> +
> >> +description: |
> >> +  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controlle=
r.
> >> +  These are interleaved to provide high performance with the load sha=
red across
> >> +  two memory channels. The Tegra124 Memory Controller handles memory =
requests
> >> +  from internal clients and arbitrates among them to allocate memory =
bandwidth
> >> +  for DDR3L and LPDDR3 SDRAMs.
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: nvidia,tegra124-mc
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +    description:
> >> +      Physical base address.
> >
> > You don't really need a description when there's only 1 item. Same on
> > the others below.
> >
> > With that,
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Okay, I'll change that in the next revision. I also assume that the r-b
> applies to all three patches, otherwise please let me know. Thanks!

No. I'm reviewing those.

Rob
