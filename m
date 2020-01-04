Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D743FC32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A87AE22B48
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578173889;
	bh=C0qle1HFxNQq4FdSx+/f7tXhPZ4F4pASUrtMdTKgyME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q0AoB7W4fd3Wl7HAz2qXhMxCwx4r4VuES/3HbjrNhDlXG3N8fph7BBIugDCbbweUg
	 1ijfcByIPHoEbLvWll3ZdHl2c2Eh/CFHpWlO2C5eM/IK0fmxy4uamsunTOq3CZtZxu
	 IinW+nN6WLhaRwZlhqzSZ898He05qA/wLjxzAiZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgADViI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:38:08 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36973 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:38:08 -0500
Received: by mail-il1-f195.google.com with SMTP id t8so39406231iln.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:38:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8pI5QObJXdfMTKTGYOW6wMFE3eyq81zBt90YlzThMeA=;
        b=IMWmx55KhGSA6qhGp1bhl3n20QU2vymCOK8Y7GR0EZhcY2U3KwM/K4M/fBNtTqA6YS
         6GSNL/+9SQinBxrU9dtNnCNpEyXLYwvDsjPKorAhpc+WL5/Pth4E19QQLIp+PkKSNf7v
         lWAN82Vmflupoq5NzrgtGaaxClvFcRYo2CSAhxlleXAoECPaimiv6FdLI520vYQ2jt5v
         1hDc4KPZBuDrzVK4FMzwhnXskk3WcpKyBxIcK17KiWxxVoOEMgA9Zu+HlrvTMfQrmLox
         i5e/TmmHmHgn6KTtanilS2iB0We6AD+7Q4qNcwMP0jBLV5JO74XFNLLKCoDus5WkT2X3
         7D7Q==
X-Gm-Message-State: APjAAAW8S1nd7fmJ7ezzTAkUKUwTcwZ9UMgj5ishmoBLoIOiEGksNchQ
        dbL46bMYe8XA/EhWtIOiHzww6qw=
X-Google-Smtp-Source: APXvYqzfBtpaT+IJZpl0f4v/1sbPSabgHx0G4kUAbrcrSSLH9JlyP0lL90QVOFwTcmPwpYCI3XxvmA==
X-Received: by 2002:a92:910b:: with SMTP id t11mr80339981ild.195.1578173887404;
        Sat, 04 Jan 2020 13:38:07 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i136sm20155878ild.23.2020.01.04.13.38.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:38:06 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:38:05 -0700
Date:   Sat, 4 Jan 2020 14:38:05 -0700
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: remoteproc: Add Qualcomm PIL info
 binding
Message-ID: <20200104213804.GA30385@bogus>
References: <20191227053215.423811-1-bjorn.andersson@linaro.org>
 <20191227053215.423811-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191227053215.423811-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 26, 2019 at 09:32:08PM -0800, Bjorn Andersson wrote:
> Add a devicetree binding for the Qualcomm periperal image loader
> relocation info region found in the IMEM.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - New patch
> 
>  .../bindings/remoteproc/qcom,pil-info.yaml    | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> new file mode 100644
> index 000000000000..715945c683ed
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,pil-info.yaml
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/remoteproc/qcom,pil-info.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm peripheral image loader relocation info binding
> +
> +description:
> +  This document defines the binding for describing the Qualcomm peripheral
> +  image loader relocation memory region, in IMEM, which is used for post mortem
> +  debugging of remoteprocs.
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +properties:
> +  compatible:
> +    const: qcom,pil-reloc-info
> +
> +  offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Offset in the register map for the memory region

Why not use 'reg' instead?

> +
> +examples:
> +  - |
> +    imem@146bf000 {
> +      compatible = "syscon", "simple-mfd";
> +      reg = <0 0x146bf000 0 0x1000>;
> +
> +      pil-reloc {
> +        compatible ="qcom,pil-reloc-info";
> +        offset = <0x94c>;
> +      };
> +    };
> -- 
> 2.24.0
> 
