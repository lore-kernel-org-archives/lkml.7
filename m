Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADFC33CA2
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 283C920692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 16:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578501588;
	bh=ruuzExV/WTi+BrYKewR74kS7+Oa/N/k38qdbcAPzcrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WE5fPDIKfS1HjeL+iFtMlObLZf4b7g2r+h8o1Npn1FvmFVwBeG/JvrZ7WBQ8QLRRm
	 J882xiWCqsyU2Xygh5mywohz50n+ALM96Qe2bwY1p7S2lWnReAknq9OsrAk5i1gpUg
	 qwZJOX1TGo6EK+hvbkMr9G3jhpdsIQc8fhu+c/mw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgAHQjr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 11:39:47 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43019 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728958AbgAHQjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 11:39:46 -0500
Received: by mail-oi1-f194.google.com with SMTP id p125so3145842oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 08:39:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7YuLu/5ssx5qi8ML+jSjpakNJXIUPRCs4C4ET7aw5Z8=;
        b=l/xPxWcFp5zq8vAv/oTzQGvrW3UCYjqORV7WUdnh4jqfMLAe8nymhhJU6za00dNhj4
         6UWo0k2kKasX7TY0Wq2SJ+hPsvVwiolbYfx8yU7joFPMT8ZxVfTly5f17pbwdQ5A4CtW
         mlU22QbEtZ+gAf7rJv0EPSFDWb3ogomCsWJXTVDAtFXovwNJWRARVshsSZVb5dae7ACS
         rBFsj6pT7YxKPG/zu2Vkavj86isB7uinb3a66D3amu9oDnCwtIRUhq9LmmBSB12Qhqjn
         aXr81gBrWN0NK3o6NOR+74VNgC56HTkEjj3EFK206QqEzVedZnJFeINNEIkndQHUOj1v
         KNvg==
X-Gm-Message-State: APjAAAXWuMdVmVmK6DJUS26SieaFIC7nHTc2UDUNRWndxVv5JywfRL5j
        IYioylKM4BNvRfsD+VAsxEUa34U=
X-Google-Smtp-Source: APXvYqyfDtA2DA5If70LZd3RMRCaoUumt1Se1DiKlFhbbq26An/QIEW9WzdPUdf1UaBfRv9WtNzFMA==
X-Received: by 2002:aca:50cd:: with SMTP id e196mr3783405oib.178.1578501585811;
        Wed, 08 Jan 2020 08:39:45 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 69sm1286199oth.17.2020.01.08.08.39.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 08:39:45 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22001a
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 08 Jan 2020 10:39:43 -0600
Date:   Wed, 8 Jan 2020 10:39:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Shyam Kumar Thella <sthella@codeaurora.org>
Cc:     agross@kernel.org, srinivas.kandagatla@linaro.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: add binding for QTI SPMI SDAM
Message-ID: <20200108163943.GA26863@bogus>
References: <1577165532-28772-1-git-send-email-sthella@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577165532-28772-1-git-send-email-sthella@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2019 at 11:02:12AM +0530, Shyam Kumar Thella wrote:
> QTI SDAM allows PMIC peripherals to access the shared memory that is
> available on QTI PMICs. Add documentation for it.
> 
> Signed-off-by: Shyam Kumar Thella <sthella@codeaurora.org>
> ---
>  .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> new file mode 100644
> index 0000000..8961a99
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/qcom,spmi-sdam.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

Please spread the word in QCom. 

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/qcom,spmi-sdam.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SPMI SDAM DT bindings
> +
> +maintainers:
> +  - Shyam Kumar Thella <sthella@codeaurora.org>
> +
> +description: |
> +  The SDAM provides scratch register space for the PMIC clients. This
> +  memory can be used by software to store information or communicate
> +  to/from the PBUS.
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,spmi-sdam
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1

ranges? The child addresses should be translateable I assume.

> +
> +required:
> +  - compatible
> +  - reg
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description:
> +          Offset and size in bytes within the storage device.
> +
> +      bits:

Needs a type reference. 

> +        maxItems: 1
> +        items:
> +          items:
> +            - minimum: 0
> +              maximum: 7
> +              description:
> +                Offset in bit within the address range specified by reg.
> +            - minimum: 1

max is 7?

> +              description:
> +                Size in bit within the address range specified by reg.
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +examples:
> +  - |
> +      sdam_1: nvram@b000 {
> +         #address-cells = <1>;
> +         #size-cells = <1>;
> +         compatible = "qcom,spmi-sdam";
> +          reg = <0xb000 0x100>;
> +
> +          /* Data cells */
> +          restart_reason: restart@50 {
> +              reg = <0x50 0x1>;
> +              bits = <7 2>;

How do you have bit 8 in a 1 byte register?

> +          };
> +      };
> +...
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
> 
