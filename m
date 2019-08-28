Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB5AC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05395217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566992387;
	bh=zFX6K+sbahwAVHjk1v7Y0ynjPUeiaUDUZEEnuIPaDo8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zBtP9q1M7nZ4nMWsWpm3wpqthWWWE3Rc1D8bdORXKTk3tzSAVDfY0d3wQF3L2U9Tx
	 APk9rMQ4D8PU+fyE28Diw2u60UX1IEW/9UVhuSPIjLm2CINeIhxoIFy5TRgYaBs1T2
	 VqvrWE10FwwPNxHPsC8LeabJ5Yc5+DoGyd0szj6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfH1Ljq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726326AbfH1Ljp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:39:45 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77A5522CF8;
        Wed, 28 Aug 2019 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566992384;
        bh=zFX6K+sbahwAVHjk1v7Y0ynjPUeiaUDUZEEnuIPaDo8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z3/ECLQSL7wh6MTn4A6x8vrX9g0jEHKxPtPHd5PCTw3kwe/Fp9kW1Ac3KXrvyj9dd
         Tx3djCmBNmPpfRxvVo3+UzcdKLw85GTS1mFE41y7DB6G0mcvo/QGr0BBkl+ixXzzr5
         EnGmjCSAGTArW7nvFbEafw1P4Lu+wdh8o4SvAJzQ=
Received: by mail-qk1-f175.google.com with SMTP id w18so2093902qki.0;
        Wed, 28 Aug 2019 04:39:44 -0700 (PDT)
X-Gm-Message-State: APjAAAUozvkvtKAUd+Elz/fHMVMBdztl3NPW3YADG1QQcRb2Gdbei1f9
        NchL/PSxc/aA2xrWYaga6bNFB2Rk0bHv4xTzcQ==
X-Google-Smtp-Source: APXvYqydDnMJj3jUU3Wub3MN0mjmXdZW8HBVHZ2a6QgyavC3ZjOUxXUkCbX8LKAVCJZc9hkLGTCYIXvcb0nDHtiTO90=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr3443285qkn.254.1566992383614;
 Wed, 28 Aug 2019 04:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190827082652.43840-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190827082652.43840-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAL_JsqJsTDNR7FsdFouLetzhsRhmr3fVT_xzzhKbR7KuTwepuQ@mail.gmail.com> <2a915595-be5f-83f4-34e8-34d667875cc2@linux.intel.com>
In-Reply-To: <2a915595-be5f-83f4-34e8-34d667875cc2@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Aug 2019 06:39:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLSXCK9u0fC99mv=7Lwmiqg2Qtu7Kf_xFG0WHE3v3wE6w@mail.gmail.com>
Message-ID: <CAL_JsqLSXCK9u0fC99mv=7Lwmiqg2Qtu7Kf_xFG0WHE3v3wE6w@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: phy: intel-sdxc-phy: Add YAML schema
 for LGM SDXC PHY
To:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        peter.harliman.liem@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 10:47 PM Ramuthevar, Vadivel MuruganX
<vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
> Hi Rob,
>
> On 27/8/2019 8:39 PM, Rob Herring wrote:
> > On Tue, Aug 27, 2019 at 3:27 AM Ramuthevar,Vadivel MuruganX
> > <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
> >> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >>
> >> Add a YAML schema to use the host controller driver with the
> >> SDXC PHY on Intel's Lightning Mountain SoC.
> >>
> >> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >> ---
> >>   .../bindings/phy/intel,lgm-sdxc-phy.yaml           | 50 ++++++++++++++++++++++
> >>   1 file changed, 50 insertions(+)
> >>   create mode 100644 Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >> new file mode 100644
> >> index 000000000000..be05020880bf
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/phy/intel,lgm-sdxc-phy.yaml
> >> @@ -0,0 +1,50 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/phy/intel,lgm-sdxc-phy.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Intel Lightning Mountain(LGM) SDXC PHY Device Tree Bindings
> >> +
> >> +maintainers:
> >> +  - Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
> >> +
> >> +description: Binding for SDXC PHY
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: intel,lgm-sdxc-phy
> >> +
> >> +  intel,syscon:
> >> +    description: phandle to the sdxc through syscon
> >> +    $ref: '/schemas/types.yaml#/definitions/phandle'
> >> +
> >> +  clocks:
> >> +    maxItems: 1
> >> +
> >> +  clock-names:
> >> +    maxItems: 1
> >> +
> >> +  "#phy-cells":
> >> +    const: 0
> >> +
> >> +required:
> >> +  - "#phy-cells"
> >> +  - compatible
> >> +  - intel,syscon
> >> +  - clocks
> >> +  - clock-names
> >> +
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    sdxc_phy: sdxc_phy {
> >> +        compatible = "intel,lgm-sdxc-phy";
> >> +        intel,syscon = <&sysconf>;
> > Rather than a phandle, can this be a child node of sysconf? You need a
> > binding for sysconf first anyways.
> intel,syscon is phandle, emmc_phy is not child node of sysconf, access
> emmc_phy
> register over sysconf so made as reference here.

How do you access the emmc_phy registers? They are part of the sysconf
address space or the sysconf provides some sort of indirect register
access? In case of the former, then emmc_phy should be a child node.
That's actually fairly common.

Rob
