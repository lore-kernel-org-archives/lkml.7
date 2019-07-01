Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA55C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109F021721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562008290;
	bh=M69bW3LLjAy9GRa5kws2W/TLGTCeIxO8p9s0yzUQV6M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YDo7FpJHYA+RTGsrOK+d5d4ODzp2hSa91qxMSyIRxhUblVNVPVX3HnXF3oV3p6Yau
	 QlViVdCKNO8xvGvrKkESrpPnaCqDO7YUjojiqYqmDZAYJQIRC99x0+Y2K1IAuYZn5U
	 fD+GmN007rjRV0Dt//tDEUvHo+C3+GC9NZ1pzExA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfGATL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfGATL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:11:27 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D5E42183F;
        Mon,  1 Jul 2019 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562008286;
        bh=M69bW3LLjAy9GRa5kws2W/TLGTCeIxO8p9s0yzUQV6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fw2v6uirjEIwW3zfhLjQ35yRI+0y4ld/Oc50hhARgaTB5gb29LplirkzCi769nRHA
         9uDmkotdqbeKCANPmgKOYLaBXbwZdwU85hD/EcrSEJIPrcd8/oqmQdOtDhWp0nmhnW
         DtD6ncuuRgjRRw34Jgw6RuE8tYHlWmxJlaXEOH5s=
Received: by mail-qk1-f174.google.com with SMTP id r6so11975258qkc.0;
        Mon, 01 Jul 2019 12:11:26 -0700 (PDT)
X-Gm-Message-State: APjAAAUwtQGjijJizjwtPRmBhAvRiNY1jvlFi7Vlj90Awf6CKR23wMnv
        SWmXfJP6gVbiFpCRHClvDAHqbeI34JBuFIOhkg==
X-Google-Smtp-Source: APXvYqy7FNZ6+l5eVy5svcAAz6HHDiNQIVOJTM7lSZQktlB01iGiNfghocoJtgdl5EKMFj+EaLYQ+fikqa/RiR0JGWk=
X-Received: by 2002:a37:6357:: with SMTP id x84mr21600084qkb.393.1562008285770;
 Mon, 01 Jul 2019 12:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <20190630210019.26914-1-digetx@gmail.com> <20190630210019.26914-8-digetx@gmail.com>
In-Reply-To: <20190630210019.26914-8-digetx@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Jul 2019 13:11:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJq5iwQcbUixMWK819OTof8DzrZ3UMhByc1pTAFTdwnjg@mail.gmail.com>
Message-ID: <CAL_JsqJq5iwQcbUixMWK819OTof8DzrZ3UMhByc1pTAFTdwnjg@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2019 at 3:04 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>

"Convert" implies you delete the old binding doc.

> The Tegra30 binding will actually differ from the Tegra124 a tad, in
> particular the EMEM configuration description. Hence rename the binding
> to Tegra124 during of the conversion to YAML.
>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../nvidia,tegra124-mc.yaml                   | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
>
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> new file mode 100644
> index 000000000000..d18242510295
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-mc.yaml
> @@ -0,0 +1,149 @@
> +# SPDX-License-Identifier: (GPL-2.0)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/nvidia,tegra124-mc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title:
> +  NVIDIA Tegra124 SoC Memory Controller
> +
> +maintainers:
> +  - Jon Hunter <jonathanh@nvidia.com>
> +  - Thierry Reding <thierry.reding@gmail.com>
> +
> +description: |
> +  Tegra124 SoC features a hybrid 2x32-bit / 1x64-bit memory controller.
> +  These are interleaved to provide high performance with the load shared across
> +  two memory channels. The Tegra124 Memory Controller handles memory requests
> +  from internal clients and arbitrates among them to allocate memory bandwidth
> +  for DDR3L and LPDDR3 SDRAMs.
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra124-mc
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Physical base address.
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      Memory Controller clock.
> +
> +  clock-names:
> +    items:
> +      - const: mc
> +
> +  interrupts:
> +    maxItems: 1
> +    description:
> +      Memory Controller interrupt.
> +
> +  "#reset-cells":
> +    const: 1
> +
> +  "#iommu-cells":
> +    const: 1
> +
> +patternProperties:
> +  ".*":

Please define a node name or pattern for node names.

> +    properties:
> +      nvidia,ram-code:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          Value of RAM_CODE this timing set is used for.
> +
> +    patternProperties:
> +      ".*":

Same here.

> +        properties:
> +          clock-frequency:
> +            description:
> +              Memory clock rate in Hz.

No constraints? Anything from 0 to 4GHz works?

> +
> +          nvidia,emem-configuration:
> +            $ref: /schemas/types.yaml#/definitions/uint32-array
> +            description: |
> +              Values to be written to the EMEM register block. See section
> +              "15.6.1 MC Registers" in the TRM.
> +            items:
> +              - description: MC_EMEM_ARB_CFG
> +              - description: MC_EMEM_ARB_OUTSTANDING_REQ
> +              - description: MC_EMEM_ARB_TIMING_RCD
> +              - description: MC_EMEM_ARB_TIMING_RP
> +              - description: MC_EMEM_ARB_TIMING_RC
> +              - description: MC_EMEM_ARB_TIMING_RAS
> +              - description: MC_EMEM_ARB_TIMING_FAW
> +              - description: MC_EMEM_ARB_TIMING_RRD
> +              - description: MC_EMEM_ARB_TIMING_RAP2PRE
> +              - description: MC_EMEM_ARB_TIMING_WAP2PRE
> +              - description: MC_EMEM_ARB_TIMING_R2R
> +              - description: MC_EMEM_ARB_TIMING_W2W
> +              - description: MC_EMEM_ARB_TIMING_R2W
> +              - description: MC_EMEM_ARB_TIMING_W2R
> +              - description: MC_EMEM_ARB_DA_TURNS
> +              - description: MC_EMEM_ARB_DA_COVERS
> +              - description: MC_EMEM_ARB_MISC0
> +              - description: MC_EMEM_ARB_MISC1
> +              - description: MC_EMEM_ARB_RING1_THROTTLE
> +
> +        required:
> +          - clock-frequency
> +          - nvidia,emem-configuration
> +
> +    required:
> +      - nvidia,ram-code
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - "#reset-cells"
> +  - "#iommu-cells"
> +
> +examples:
> +  - |
> +    memory-controller@70019000 {
> +        compatible = "nvidia,tegra124-mc";
> +        reg = <0x0 0x70019000 0x0 0x1000>;
> +        clocks = <&tegra_car 32>;
> +        clock-names = "mc";
> +
> +        interrupts = <0 77 4>;
> +
> +        #iommu-cells = <1>;
> +        #reset-cells = <1>;
> +
> +        emc-timings-3 {
> +            nvidia,ram-code = <3>;
> +
> +            timing-12750000 {
> +                clock-frequency = <12750000>;
> +
> +                nvidia,emem-configuration = <
> +                    0x40040001 /* MC_EMEM_ARB_CFG */
> +                    0x8000000a /* MC_EMEM_ARB_OUTSTANDING_REQ */
> +                    0x00000001 /* MC_EMEM_ARB_TIMING_RCD */
> +                    0x00000001 /* MC_EMEM_ARB_TIMING_RP */
> +                    0x00000002 /* MC_EMEM_ARB_TIMING_RC */
> +                    0x00000000 /* MC_EMEM_ARB_TIMING_RAS */
> +                    0x00000002 /* MC_EMEM_ARB_TIMING_FAW */
> +                    0x00000001 /* MC_EMEM_ARB_TIMING_RRD */
> +                    0x00000002 /* MC_EMEM_ARB_TIMING_RAP2PRE */
> +                    0x00000008 /* MC_EMEM_ARB_TIMING_WAP2PRE */
> +                    0x00000003 /* MC_EMEM_ARB_TIMING_R2R */
> +                    0x00000002 /* MC_EMEM_ARB_TIMING_W2W */
> +                    0x00000003 /* MC_EMEM_ARB_TIMING_R2W */
> +                    0x00000006 /* MC_EMEM_ARB_TIMING_W2R */
> +                    0x06030203 /* MC_EMEM_ARB_DA_TURNS */
> +                    0x000a0402 /* MC_EMEM_ARB_DA_COVERS */
> +                    0x77e30303 /* MC_EMEM_ARB_MISC0 */
> +                    0x70000f03 /* MC_EMEM_ARB_MISC1 */
> +                    0x001f0000 /* MC_EMEM_ARB_RING1_THROTTLE */
> +                >;
> +            };
> +        };
> +    };
> --
> 2.22.0
>
