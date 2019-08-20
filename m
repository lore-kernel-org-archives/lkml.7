Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84062C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562E9205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566317285;
	bh=9WiZS4Vb8Ltws2vpFt/lV9v4TuNFvLwVNuFhWS8JWWs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c8LpjaZop3t6CjpmM/mRezv9KCX/xL1xcJypPoVovfIeg+5VmF9xuNtqlmXsdRlcM
	 qmTBB4okt0s8MTZDlwqjfv4K6IeSh3B12UL0wi+ME8NUkGwTUK+aqkaC3tGUKPtphV
	 koTCpQLBFCxN6DtAFkJ3M4dnc34D1eZIgNB0A10c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbfHTQID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 12:08:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:40392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfHTQID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 12:08:03 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053612332B;
        Tue, 20 Aug 2019 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566317282;
        bh=9WiZS4Vb8Ltws2vpFt/lV9v4TuNFvLwVNuFhWS8JWWs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f0UI6Me//nMcbhpY/1VIE6yXpoOfj51QMxH5WYLwkmb78PLlzJKPOuBsOQ/cU6cz4
         JHR/Ufw/jK0MEpP9gt65qbqI1N9q1+AGZHz9UBfn7xH4T2OqMRASkP9fRq4L9ouyhH
         bLhBl9UzL21MQxE92yA+XgPgWFrKZR17jFcJDaG4=
Received: by mail-qt1-f170.google.com with SMTP id i4so6620210qtj.8;
        Tue, 20 Aug 2019 09:08:01 -0700 (PDT)
X-Gm-Message-State: APjAAAV3AQ5di5Ipd4I3hvH3Mnc4EwIHnwlpHQML41t54azEzqdAFQRO
        mpXHG56WyGjNM48a+rvOhH0hfz7sfq+Y8Pk2eA==
X-Google-Smtp-Source: APXvYqxi7X5KSPGWS1tX55hqWrzn1uK9qAR/aLHczfkXbFTdQfyUBOdUxk8O2lQB/mrEohl+2PCkQDlDTnSbCXv69k4=
X-Received: by 2002:a0c:eb92:: with SMTP id x18mr15040300qvo.39.1566317281129;
 Tue, 20 Aug 2019 09:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566288689.git.rahul.tanwar@linux.intel.com> <772527bd87da45eeef905d9b9d46a8d99915a116.1566288689.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <772527bd87da45eeef905d9b9d46a8d99915a116.1566288689.git.rahul.tanwar@linux.intel.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 20 Aug 2019 11:07:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKmyEn5iXuibmZGcvRpaiyUjVoi4-2e9NKY9eYnWLL7iQ@mail.gmail.com>
Message-ID: <CAL_JsqKmyEn5iXuibmZGcvRpaiyUjVoi4-2e9NKY9eYnWLL7iQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: serial: lantiq: Convert to YAML schema
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        qi-ming.wu@intel.com, cheol.yong.kim@intel.com,
        rahul.tanwar@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 3:29 AM Rahul Tanwar
<rahul.tanwar@linux.intel.com> wrote:
>
> Convert the existing DT binding document for Lantiq SoC ASC serial controller
> from txt format to YAML format.
>
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/serial/lantiq_asc.txt      | 31 ----------
>  .../devicetree/bindings/serial/lantiq_asc.yaml     | 70 ++++++++++++++++++++++

Use the compatible name: lantiq,asc.yaml

Don't forget the $id value too.

>  2 files changed, 70 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.yaml


> diff --git a/Documentation/devicetree/bindings/serial/lantiq_asc.yaml b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
> new file mode 100644
> index 000000000000..54b90490f4fb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/lantiq_asc.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/lantiq_asc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Lantiq SoC ASC serial controller
> +
> +maintainers:
> +  - Rahul Tanwar <rahul.tanwar@intel.com>
> +
> +allOf:
> +  - $ref: /schemas/serial.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      items:
> +        - const: lantiq,asc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1

Technically, 1 item is not allowed until patch 2 (or the old doc was wrong).

> +    maxItems: 3
> +    items:
> +      - description: tx or combined interrupt
> +      - description: rx interrupt
> +      - description: err interrupt
> +
> +  clocks:
> +    description:
> +      When present, first entry listed should contain phandle
> +      to the frequency clock and second entry should contain
> +      phandle to the gate clock.

Schema needs to define how many entries:

items:
  - description: ...
  - description: ...

> +
> +  clock-names:
> +    items:
> +      - const: freq
> +      - const: asc
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +
> +examples:
> +  - |
> +    asc0: serial@16600000 {
> +            compatible = "lantiq,asc";
> +            reg = <0x16600000 0x100000>;
> +            interrupt-parent = <&gic>;
> +            interrupts = <GIC_SHARED 103 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SHARED 105 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SHARED 106 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&cgu CLK_SSX4>, <&cgu GCLK_UART>;
> +            clock-names = "freq", "asc";
> +    };
> +
> +  - |
> +    asc1: serial@e100c00 {

I don't think this 2nd example adds anything.

> +            compatible = "lantiq,asc";
> +            reg = <0xE100C00 0x400>;
> +            interrupt-parent = <&icu0>;
> +            interrupts = <112 113 114>;
> +    };
> +
> +...
> --
> 2.11.0
>
