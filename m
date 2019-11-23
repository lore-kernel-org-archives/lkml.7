Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495ADC43215
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 00:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20FDB2070E
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 00:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574469746;
	bh=9KW8a9M9T30sOIjoriIqt5WzCVaK8BDOnx8bIp0IRpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hodAf0KHUXJIveNYh9Y8Lb3NPgdcsgYSBhNf294X/g/xz5G2vMJ3O9KTCtNNLXNCT
	 ZFtVvrgIOBvN/+2X8r7HR70S4zANRdTYwRLRHVdaew3WW5Q/vF8qtypntcnGSueGkO
	 lu3BwFYQeve/Q/XCj3+/CrpaVEq/4MV9uLAEOWd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfKWAmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 19:42:25 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46462 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfKWAmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 19:42:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id n14so8114672oie.13;
        Fri, 22 Nov 2019 16:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oGJX/reKzsvlPl7LrdXxSVKM8Xki6sNrSQDjk1YDSBs=;
        b=GIW8BobwHWOhxHKQsPEQjyvePXeSZFihli0kC0qMGsSpl1aRuv16zq16Pslw5G4nuV
         TjglMlKOUWKHjzXxuiNOFYvScaqk4+zYgRkBzrUuGsuv2fiyqrmtibAsy//RoriE4/xO
         pOCyr3lefupvmZxMrXArGo8gVqJTbrcI5SsvSqXTnYjzTGFx7t7I2enS1akQCVB6NG8M
         +uiPYUmq3C32t0FT0h21XFI5IiB1lNsgyWndDn7Ebkw6z+QkyoOKPVlzTRSPv3qNSy1Y
         o0k0PaNYqCo1uXGSKBtcR0E3zvMNe9zDGD0eS2zFUCX6k/fTsW0F7Ubd2fiivK0WSP+t
         iyYw==
X-Gm-Message-State: APjAAAVMXo977D1sAFziD/A8Rkr6zXZ0B6LRzAd+EvTe6QVFNFU1syPz
        TLlVYy0wJ+aJCw6+Pq2RyA==
X-Google-Smtp-Source: APXvYqwsDotINaxgsn12/e8mFrQqRvrmOeyi4LbNLqU4REDWhKaPg5JyF5PmaeAU9FvzfzRLop8wig==
X-Received: by 2002:aca:5413:: with SMTP id i19mr14976577oib.121.1574469742474;
        Fri, 22 Nov 2019 16:42:22 -0800 (PST)
Received: from localhost (ip-70-5-93-147.ftwttx.spcsdns.net. [70.5.93.147])
        by smtp.gmail.com with ESMTPSA id 94sm2792513otx.3.2019.11.22.16.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2019 16:42:21 -0800 (PST)
Date:   Fri, 22 Nov 2019 18:42:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     p.zabel@pengutronix.de, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com
Subject: Re: [PATCH v3 1/2] dt-bindings: reset: Add YAML schemas for the
 Intel Reset controller
Message-ID: <20191123004219.GA14198@bogus>
References: <0c53fd1100e357f6793f792c1de218f7de013393.1574153939.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c53fd1100e357f6793f792c1de218f7de013393.1574153939.git.eswara.kota@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 02:10:23PM +0800, Dilip Kota wrote:
> Add YAML schemas for the reset controller on Intel
> Gateway SoC.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v3:
> 	Fix DTC warnings
> 	Add support to legacy xrx200 SoC
> 	Change file name to intel,rcu-gw.yaml
> 
>  .../devicetree/bindings/reset/intel,rcu-gw.yaml    | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> new file mode 100644
> index 000000000000..743be2c49fb8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/intel,rcu-gw.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/intel,rcu-gw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: System Reset Controller on Intel Gateway SoCs
> +
> +maintainers:
> +  - Dilip Kota <eswara.kota@linux.intel.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:

You can drop oneOf and items here.

> +          - enum:
> +              - intel,rcu-lgm
> +              - intel,rcu-xrx200
> +
> +  reg:
> +    description: Reset controller registers.

maxItems: 1

> +
> +  intel,global-reset:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: Global reset register offset and bit offset.

maxItems: 2

> +
> +  "#reset-cells":
> +    minimum: 2
> +    maximum: 3
> +    description: |
> +      First cell is reset request register offset.
> +      Second cell is bit offset in reset request register.
> +      Third cell is bit offset in reset status register.
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
> +    rcu0: reset-controller@e0000000 {
> +        compatible = "intel,rcu-lgm";
> +        reg = <0xe0000000 0x20000>;
> +        intel,global-reset = <0x10 30>;
> +        #reset-cells = <2>;
> +    };
> +
> +    pwm: pwm@e0d00000 {
> +        status = "disabled";
> +        compatible = "intel,lgm-pwm";
> +        reg = <0xe0d00000 0x30>;
> +        clocks = <&cgu0 1>;
> +        #pwm-cells = <2>;
> +        resets = <&rcu0 0x30 21>;
> +    };
> -- 
> 2.11.0
> 
