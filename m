Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB158C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C1F522CE3
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566563144;
	bh=g5FCobcLXbFWD1bY0xj5Ltqc0DHt00eTk6b7TbAqkL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pRNLqr8dmAQop5CAn3TrJO16GIxwAw49eklHMQy0Cwun7189cGBcnoeYJEvz03lmU
	 tFGgcFMJ9VdFTM9l335v4nqIiaFwUe9whcY1WgGAUHxuEmHfXP/QwBT71krR/kJXdA
	 7tZYgDYEFaMdbT4UNzJaF442BcZ1fhAiJe1nxuY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394667AbfHWMZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 08:25:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732221AbfHWMZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 08:25:43 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF53B22CE3;
        Fri, 23 Aug 2019 12:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566563142;
        bh=g5FCobcLXbFWD1bY0xj5Ltqc0DHt00eTk6b7TbAqkL4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tDsKSTc7Pq6mv0Fb5A+C8soRQPOrS/jACL/AZ63MamUPdYVDbbqyGeMiv7oo1j90v
         AkJffzmtTA4Oj01DMNU6GQOCTNHbwh3eUQ3oj3wh8JRPbwHeI/NOcOYdGMsKDutVYj
         GzBy8i+0rvmVcGpLKahhtGQgaBphnre2iYLa2Xkw=
Received: by mail-qt1-f170.google.com with SMTP id x4so10957940qts.5;
        Fri, 23 Aug 2019 05:25:41 -0700 (PDT)
X-Gm-Message-State: APjAAAUEwfkqi9ZWTYcJZMZLF3KVPOdWHkmWbbyUOAeKZZk+BgdDnMCQ
        Y1x8KpxGnlu7ym+4hh5mSGnvxpx1skvE3+TVmQ==
X-Google-Smtp-Source: APXvYqxLswLc9PpByiXyjVxzZM7JQ3UDwxGAU368M52WiLNV2vB5VtvPU7Z7PlObbR0c5TNfj59zF550VG6Tq9MNMcs=
X-Received: by 2002:ac8:44c4:: with SMTP id b4mr4355900qto.224.1566563141086;
 Fri, 23 Aug 2019 05:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <42039170811f798b8edc66bf85166aefe7dbc903.1566531960.git.eswara.kota@linux.intel.com>
In-Reply-To: <42039170811f798b8edc66bf85166aefe7dbc903.1566531960.git.eswara.kota@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 23 Aug 2019 07:25:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJxh5TzDb8kOFm+F5Gs4WXF6BP5uaNPLcyx+srtaDisMw@mail.gmail.com>
Message-ID: <CAL_JsqJxh5TzDb8kOFm+F5Gs4WXF6BP5uaNPLcyx+srtaDisMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Add YAML schemas for the Intel
 Reset controller
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 12:28 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
> Add YAML schemas for the reset controller on Intel
> Lightening Mountain (LGM) SoC.
>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v2:
>     Address review comments
>       Update the compatible property definition
>       Add description for reset-cells
>       Add 'additionalProperties: false' property
>
>  .../bindings/reset/intel,syscon-reset.yaml         | 53 ++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
>
> diff --git a/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
> new file mode 100644
> index 000000000000..3403a967190a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/intel,syscon-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Intel Lightening Mountain SoC System Reset Controller
> +
> +maintainers:
> +  - Dilip Kota <eswara.kota@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: intel,rcu-lgm
> +      - const: syscon
> +
> +  reg:
> +    description: Reset controller register base address and size
> +
> +  intel,global-reset:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Global reset register offset and bit offset.
> +
> +  "#reset-cells":
> +    const: 2
> +    description: |
> +      The 1st cell is the register offset.
> +      The 2nd cell is the bit offset in the register.
> +
> +required:
> +  - compatible
> +  - reg
> +  - intel,global-reset
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rcu0: reset-controller@00000000 {
> +        compatible = "intel,rcu-lgm", "syscon";
> +        reg = <0x000000 0x80000>;
> +        intel,global-reset = <0x10 30>;
> +        #reset-cells = <2>;
> +    };
> +
> +    pcie_phy0: pciephy@... {
> +        ...

You need to run 'make dt_binding_check' and fix the warnings. The
example has to be buildable and it is not.

> +        /* address offset: 0x10, bit offset: 12 */
> +        resets = <&rcu0 0x10 12>;
> +        ...
> +    };
> --
> 2.11.0
>
