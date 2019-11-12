Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57954C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1B821925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573599110;
	bh=Fvb/mXVl+l35yVh6GFoxh8HIEXMeuT21yKS6scDEvuE=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=rcRzn18ANE37svAvpxDm5VErfCxkUdxesFtFejQBT4wmtAhaeOXCL6BVdgL0ohdrk
	 Iam4Pxd7hMjBwYIf/HecgAkz8Nksy70Tt9k3sR7Mvak2PrVWnHHrT+8ag7lELH1uqN
	 U/k+N0Y+Kvifm4jpVJiUCVNmBvJXW+DXJcalOfv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfKLWvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:51:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbfKLWvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:51:49 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E59D21783;
        Tue, 12 Nov 2019 22:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573599107;
        bh=Fvb/mXVl+l35yVh6GFoxh8HIEXMeuT21yKS6scDEvuE=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=wutODIcyfTnTRJBX9L/1YSqE+K/nXW/S5xy8DlXaib2Uh8FHE9K0vxgEFR/AKAGVC
         YGgb6J7Od/oj3v9K44i5Q7SS4bHPVCTfvH7NhmO9PujmMoNOEm9C1DsclPQjSPdFnE
         2pivyDLHR97BdOIO0aLfJ1XD4Wr/LIyLhjpHQ3OQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1573564580-9006-2-git-send-email-rajan.vaja@xilinx.com>
References: <1573564580-9006-1-git-send-email-rajan.vaja@xilinx.com> <1573564580-9006-2-git-send-email-rajan.vaja@xilinx.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, dan.carpenter@oracle.com,
        gustavo@embeddedor.com, jolly.shah@xilinx.com,
        m.tretter@pengutronix.de, mark.rutland@arm.com,
        michal.simek@xilinx.com, mturquette@baylibre.com,
        nava.manne@xilinx.com, ravi.patel@xilinx.com, robh+dt@kernel.org,
        tejas.patel@xilinx.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
Subject: Re: [PATCH 1/7] dt-bindings: clock: Add bindings for versal clock driver
User-Agent: alot/0.8.1
Date:   Tue, 12 Nov 2019 14:51:46 -0800
Message-Id: <20191112225147.7E59D21783@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2019-11-12 05:16:14)
> diff --git a/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml=
 b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> new file mode 100644
> index 0000000..da82f6a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/xlnx,versal-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal clock controller
> +
> +maintainers:
> +  - Michal Simek <michal.simek@xilinx.com>
> +  - Jolly Shah <jolly.shah@xilinx.com>
> +  - Rajan Vaja <rajan.vaja@xilinx.com>
> +
> +description: |
> +  The clock controller is a h/w block of Xilinx versal clock tree. It re=
ads

hardware instead of h/w

> +  required input clock frequencies from the devicetree and acts as clock
> +  provider for all clock consumers of PS clocks. See clock_bindings.txt
> +  for more information on the generic clock bindings.

Please drop this last sentence about clock_bindings.txt

> +
> +properties:
> +  compatible:
> +    const: xlnx,versal-clk
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clocks:
> +    description: List of clock specifiers which are external input
> +      clocks to the given clock controller.
> +    minItems: 3
> +    maxItems: 3
> +    items:
> +      - description: ref clk
> +      - description: alternate ref clk
> +      - description: pl alternate ref clk

What is "pl"? Can you clarify?

> +
> +  clock-names:
> +    minItems: 3
> +    maxItems: 3
> +    items:
> +      - const: ref_clk
> +      - const: alt_ref_clk
> +      - const: pl_alt_ref_clk
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware {
> +      zynqmp_firmware: zynqmp-firmware {
> +        compatible =3D "xlnx,zynqmp-firmware";
> +        method =3D "smc";

Is there a way to say in the binding that this must be a child of a
xlnx,zynqmp-firmware node? That would be ideal so we can constrain this
to that location somehow.

> +        versal_clk: clock-controller {
> +          #clock-cells =3D <1>;
> +          compatible =3D "xlnx,versal-clk";
> +          clocks =3D <&ref_clk>, <&alt_ref_clk>, <&pl_alt_ref_clk>;
> +          clock-names =3D "ref_clk", "alt_ref_clk", "pl_alt_ref_clk";
> +        };
> +      };
> +    };
> +...

