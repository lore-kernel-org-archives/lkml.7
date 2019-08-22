Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDCDC3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5549233FC
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566496510;
	bh=Dba+wxYuJBz7LPcJtDrR9XAQK7WxQ1BRyHz60fVP5Lw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WgQOOdMfw1Oui/TjtCBQY+O+ZT5WY5i3ETv0b21GDVXZCQSfxNuwnGFm2wiG1GqxX
	 uOeAcVKVO3yN/z4Pi1/WiIPnVKgJ1AF+ZnFahZAAUagOr41T/HxyF6p9MxfQJrp9/j
	 bUZk7irg2j5AAwdp7xEFt9tfUELBd8sf5SPZmvTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389386AbfHVRzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 13:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbfHVRzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 13:55:09 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DE0A233FC;
        Thu, 22 Aug 2019 17:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566496508;
        bh=Dba+wxYuJBz7LPcJtDrR9XAQK7WxQ1BRyHz60fVP5Lw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cxGM0Z3CfKrMhwXX6piCfNuGzP+gPEkP1SeCeiTcwxbOTObA7wJa83I1ng3RbMJU2
         zMqJUVNaiAtn145/ennLGUX+bGFFQWU+Whlrtzs4SH1QkiLWDnyar9iSfcd9VdNCPu
         8Ygc+sXQ03dYBr2fvN0V4+D/1yTfDDsXWvhUCxdY=
Received: by mail-qk1-f180.google.com with SMTP id r21so5941214qke.2;
        Thu, 22 Aug 2019 10:55:08 -0700 (PDT)
X-Gm-Message-State: APjAAAXPAH/wZnze6oHE3TpqoUvm4xE+yoohFBU5c02T6oFTpGaxxwjA
        3NK5wniDjypAl1TcIW/1EbLQpXYZGtlWK0Dkng==
X-Google-Smtp-Source: APXvYqzVSLwn1iMQWDheMUuxXC6gIYklEEylRv6O8vwxXX+Wjw38nhjFxXITQN2puSA/+s0dJP8NRKnNQLQ0rjISmkI=
X-Received: by 2002:a37:d8f:: with SMTP id 137mr172032qkn.254.1566496507376;
 Thu, 22 Aug 2019 10:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <c909a3a19a1c06ac3ed9e1c42da3193ff8e43b7a.1566454535.git.eswara.kota@linux.intel.com>
In-Reply-To: <c909a3a19a1c06ac3ed9e1c42da3193ff8e43b7a.1566454535.git.eswara.kota@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Aug 2019 12:54:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKpbXEw63PszfKX+DL-j1itfzpXNqwcJmijpo758dYZuw@mail.gmail.com>
Message-ID: <CAL_JsqKpbXEw63PszfKX+DL-j1itfzpXNqwcJmijpo758dYZuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: reset: Add YAML schemas for the Intel
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

On Thu, Aug 22, 2019 at 2:32 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
> Add YAML schemas for the reset controller on Intel
> Lightening Mountain (LGM) SoC.
>
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
>  .../bindings/reset/intel,syscon-reset.yaml         | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
>
> diff --git a/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
> new file mode 100644
> index 000000000000..298c60085486
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/intel,syscon-reset.yaml
> @@ -0,0 +1,50 @@
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
> +    allOf:
> +      - items:
> +          - enum:
> +              - intel,rcu-lgm
> +              - syscon

compatible:
  items:
    - const: intel,rcu-lgm
    - const: syscon

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

Add a description with what each cell contains.

> +
> +required:
> +  - compatible
> +  - reg
> +  - intel,global-reset
> +  - "#reset-cells"

Add a:

additionalProperties: false

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
> +        /* address offset: 0x10, bit offset: 12 */
> +        resets = <&rcu0 0x10 12>;
> +        ...
> +    };
> --
> 2.11.0
>
