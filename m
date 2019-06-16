Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0064C31E54
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD85B205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 17:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6ypAV7a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfFPRm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 13:42:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44473 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFPRmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 13:42:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id n2so4426900pgp.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2019 10:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VO7zaCyhtYCv5/pYPEOpaqTuj9RzI+pPqxayb3u5KrQ=;
        b=E6ypAV7ah+6QPhVC+81/TmriH5kiwIW3yBefIT6/UZalvKxhpZ5qv33YYJG5Ha5pd9
         /+Bb5+4iaqzNqexvspAViIRLQ/2DjzNk17I9h9DaKbIHuN/Mb61q6wgdqPw7o0Oi23KQ
         XLYGKAhfheQYTmD7AWUEuNP219C/tfsBo4+IV9Yd0QzvQOzsXCgqWL4ApGonFglOW1gO
         uIfvQJkW+i4eWuHCQou9gMmjMukpCYUsy4bKOUyFjtnVpPDDiJtc9LKWyKTLnlzKLCvn
         +2/Drz9CSNCdfZLs7iQHwuYespDAW9ThxF56eaHQJp8tLxRDAcyNzWVbyhzc5IvXye2q
         mxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VO7zaCyhtYCv5/pYPEOpaqTuj9RzI+pPqxayb3u5KrQ=;
        b=OfAkz34yuD7ZgjV3GANqlZEacZm1+silDWUvjPbyI50sRvYxBqUq8ITN2TIe4m0hrg
         V1GNLsliWIj4aAc6QIsdFVqAIoibSVf/+4aVk9S/Fr74ULBDHDeTvLJpq3q2JcRxgYCK
         soU9Rtsk7ZTwtbE4EqDdIY3g13PhGtlDf8fof4x8fNhcG+lpojbnlW6LKaIFAaAwjphi
         Cc67IlkPs1pi0Jx94ZT4p9FGClL+c0Eb0VhUEwa6+c1jMpf1OXiH+i8F3wk8g6VDbTLx
         P1VE7xKg3IuhIOP3h2oIenP4UrSLbrC2y5jeUeOCk0a/xku2UO1XVk2tbKDG7aOj71SR
         LXlw==
X-Gm-Message-State: APjAAAVHgDJ26Yee3YrdAwO0jkoknEfrFUK9OEufj1HBWncme70con1i
        C0sZVpyarFZ1rj1o7i8UJR3SjQ==
X-Google-Smtp-Source: APXvYqyvq8iUKBGDlzVU0jxWwFc6QWJYExh3pNkXSN2atfAMzIvwO4vh8OKBBUYkG5sVg2kbv5VUcg==
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr7923991pjb.117.1560706975061;
        Sun, 16 Jun 2019 10:42:55 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 12sm8736073pfi.60.2019.06.16.10.42.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 16 Jun 2019 10:42:54 -0700 (PDT)
Date:   Sun, 16 Jun 2019 10:43:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     agross@kernel.org, david.brown@linaro.org, robdclark@gmail.com,
        sean@poorly.run, robh+dt@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch, mark.rutland@arm.com, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: soc: qcom: add On Chip MEMory (OCMEM)
 bindings
Message-ID: <20190616174341.GP22737@tuxbook-pro>
References: <20190616132930.6942-1-masneyb@onstation.org>
 <20190616132930.6942-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190616132930.6942-2-masneyb@onstation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 16 Jun 06:29 PDT 2019, Brian Masney wrote:

> Add device tree bindings for the On Chip Memory (OCMEM) that is present
> on some Qualcomm Snapdragon SoCs.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  .../bindings/soc/qcom/qcom,ocmem.yaml         | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ocmem.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,ocmem.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,ocmem.yaml
> new file mode 100644
> index 000000000000..5e3ae6311a16
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,ocmem.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/qcom/qcom,ocmem.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: On Chip Memory (OCMEM) that is present on some Qualcomm Snapdragon SoCs.
> +
> +maintainers:
> +  - Brian Masney <masneyb@onstation.org>
> +
> +description: |
> +  The On Chip Memory (OCMEM) allocator allows various clients to allocate memory
> +  from OCMEM based on performance, latency and power requirements. This is
> +  typically used by the GPU, camera/video, and audio components on some
> +  Snapdragon SoCs.
> +
> +properties:
> +  compatible:
> +    const: qcom,ocmem-msm8974

qcom,msm8974-ocmem

> +
> +  reg:
> +    items:
> +      - description: Control registers
> +      - description: OCMEM address range
> +
> +  reg-names:
> +    items:
> +      - const: ocmem_ctrl_physical
> +      - const: ocmem_physical

Drop the "_physical" part, it's given by this being "reg".

Regards,
Bjorn

> +
> +  clocks:
> +    items:
> +      - description: Core clock
> +      - description: Interface clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: iface
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +
> +examples:
> +  - |
> +      #include <dt-bindings/clock/qcom,rpmcc.h>
> +      #include <dt-bindings/clock/qcom,mmcc-msm8974.h>
> +
> +      ocmem: ocmem@fdd00000 {
> +        compatible = "qcom,ocmem-msm8974";
> +
> +        reg = <0xfdd00000 0x2000>,
> +               <0xfec00000 0x180000>;
> +        reg-names = "ocmem_ctrl_physical",
> +                    "ocmem_physical";
> +
> +        clocks = <&rpmcc RPM_SMD_OCMEMGX_CLK>,
> +                  <&mmcc OCMEMCX_OCMEMNOC_CLK>;
> +        clock-names = "core",
> +                      "iface";
> +      };
> -- 
> 2.20.1
> 
