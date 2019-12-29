Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F3C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 03:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC777206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 03:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrrMPzMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfL2DBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 22:01:43 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34832 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfL2DBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 22:01:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so16439949pgk.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Dec 2019 19:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=otzAHEuQRQz5JEZyg1vitpEwm2qVyYHjx2AMIYobrWU=;
        b=XrrMPzMcmtar6QgFnxMt39dWC1wTvsaWWRW+osd5EWKZdaaGDC8Dwv2mlKiQK/X6d7
         GOH6rW33UU+7iVy+U2wJ8AA7qCvFyR6jg1iC5Wg+6Xs52wUlm3bgvhrUXXa998pxzgaA
         t5/PONW0yAxoE6NI/uJbZvVFLHu7NnhYFOnCxmy5ulBYrQ3oaIOylK8MXclG8kfw0Byd
         wWtdEg5KEJRiqH+nqzIUfGTxCPmhuTt1Pr7hAxNeIx4nbLpgiYW8U+Zo0y7krpD5Qm7e
         zvodHOeMFH+nNmrG+psyB9IfUlC2rf/+TkV1QAfgYUU9Ndi4igWZoLY3tMCqHhOdg3iS
         n+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=otzAHEuQRQz5JEZyg1vitpEwm2qVyYHjx2AMIYobrWU=;
        b=f6o+tTB12XXqoGYzswV7QMAUCi9CvJOV3z00oDcHfzFZKI/rU9D3VKK3M4K9Acszd3
         AV+rz0YZFIRPmEXbGjKKoK1intVtZIei/sxGZl0GkQc5fGQV4060zSnhHN7uyEdIlMtM
         y4YQtj3nPg1oSzpTC+t/PAgvDxwG34fOcVEyjtv36OjdLDMvhi7wFLny2alrPwreLh2v
         z01Y/sQzER/LRjYtehevu2ay2LT7wR9/kUgqdh4tL/0otphZZIHsfwXdsnQDXgrLwGk3
         YRZQxdzuckmIoK37eWtYsir0QQ/7LSh8yLjTf9DMDkxpuFldD5PRNbBtCWpiDtqs3JlX
         PD9A==
X-Gm-Message-State: APjAAAVkuSCwRISLcDsq8asqIQc7RiW2EKsTQXo1j6thpDZ4dOZ3QmJS
        4lj4Vy2ohMtoafUlGaK4QN6Z2Cip8gE=
X-Google-Smtp-Source: APXvYqxCeS5pCH3BOi6UYjDt6eJVBUTzoCmAT6O9GOajpM3LoVIJRRcsZiFJcUkwJpxqQmlJXcv5Sw==
X-Received: by 2002:a63:5f45:: with SMTP id t66mr61831803pgb.198.1577588502803;
        Sat, 28 Dec 2019 19:01:42 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g19sm46419995pfh.134.2019.12.28.19.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Dec 2019 19:01:42 -0800 (PST)
Date:   Sat, 28 Dec 2019 19:01:40 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shyam Kumar Thella <sthella@codeaurora.org>
Cc:     agross@kernel.org, srinivas.kandagatla@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: nvmem: add binding for QTI SPMI SDAM
Message-ID: <20191229030140.GJ3755841@builder>
References: <1577165532-28772-1-git-send-email-sthella@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577165532-28772-1-git-send-email-sthella@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23 Dec 21:32 PST 2019, Shyam Kumar Thella wrote:

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
> +        maxItems: 1
> +        items:
> +          items:
> +            - minimum: 0
> +              maximum: 7
> +              description:
> +                Offset in bit within the address range specified by reg.
> +            - minimum: 1
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

So this register has moved out of the PON register set? What component
in the system is going to reference this? Should it have a compatible,
in the same way as "syscon-reboot-mode" does?

Regards,
Bjorn

> +              reg = <0x50 0x1>;
> +              bits = <7 2>;
> +          };
> +      };
> +...
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>  a Linux Foundation Collaborative Project
