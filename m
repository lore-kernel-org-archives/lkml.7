Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAC6C32771
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E7F924653
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578173810;
	bh=Gyd/bU7Y+tPiaitKzJdqAWHNM4gk6qITC6+roiF/TGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JXy8XC3dywUf03iYsW/y2Oj7UIRDoLShNNtYwWQ8UipgpOZujNe2+92RIkXycgUio
	 /uyKeMHX9sn1yg485ZBF7rVArpAXNulawBjecT5qFrJKuGg6Yoaa5i9Rs/K30VmOLF
	 FOjVHK8XizH/nAXDJyjC3BizVTHtgUGXi9Buxeow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgADVgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:36:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:40158 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgADVgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:36:48 -0500
Received: by mail-io1-f68.google.com with SMTP id x1so44756009iop.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:36:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6NIkJehX5PQPcR5AGeQlXeeI6cS9FMXt1VVPV226sY=;
        b=UNUS3jH6tZ9uI2Xwk0C8DpCdljluhHfMk/vBuKg/W3FYtytWH/QDoQpkkag6qm7bIF
         SSaU+AB7jrOV2/xwBLxtP+wg9V0nh1QlVJCDvH0XCXrj2KXIuw7jZOU6jp3Vf3O5RJOD
         HBMDUMVYA7x/MyVfUSZ18tgnkHVles6f7Wk2Y1ktkpIfl798ECe72aRW2Xxu29knLNU2
         iSIJaVA6BP18KcgcfDnWZUQhBmgqqMd8Bb9L+IimCot+G+eQ0tvVM6N2unbMedpuMs5w
         SyYXsIxc0aD86AmvIuD26Xp5xUnA8NMxqN91M8UbjJDJ0KnTnI7IcVsikKsWmMo6Di+7
         vk6A==
X-Gm-Message-State: APjAAAWNHS9EUeI7FlFFQ70YE6Rn9bLfNdrp7aJ3hBFAYQTbkOpkykvx
        ESOiw0jc5HRnvTWS4/pTtpQEVoE=
X-Google-Smtp-Source: APXvYqwvHhpuU5eH4JXXhWnj3Nyj3W9QKUknY1GPqQZbk4aU7p5P463Tms2iN3JOWJHn7QH83p5KxQ==
X-Received: by 2002:a02:966a:: with SMTP id c97mr76755771jai.7.1578173807384;
        Sat, 04 Jan 2020 13:36:47 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id c23sm11418668iod.62.2020.01.04.13.36.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:36:46 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a3
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:36:45 -0700
Date:   Sat, 4 Jan 2020 14:36:45 -0700
From:   Rob Herring <robh@kernel.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette =?iso-8859-1?Q?=A0?= 
        <mturquette@baylibre.com>, David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: Add YAML schemas for the QCOM
 MSS clock bindings
Message-ID: <20200104213645.GA25711@bogus>
References: <1577421760-1174-1-git-send-email-tdas@codeaurora.org>
 <1577421760-1174-2-git-send-email-tdas@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577421760-1174-2-git-send-email-tdas@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 27, 2019 at 10:12:38AM +0530, Taniya Das wrote:
> The MSS clock provider have a bunch of generic properties that
> are needed in a device tree. Add a YAML schemas for those.
> 
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---
>  .../devicetree/bindings/clock/qcom,mss.yaml        | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,mss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,mss.yaml b/Documentation/devicetree/bindings/clock/qcom,mss.yaml
> new file mode 100644
> index 0000000..05efe2b2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,mss.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/clock/qcom,mss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Modem Clock Controller Binding
> +
> +maintainers:
> +  - Taniya Das <tdas@codeaurora.org>
> +
> +description: |
> +  Qualcomm modem clock control module which supports the clocks.
> +
> +properties:
> +  compatible :

drop space     ^

> +    enum:
> +       - qcom,sc7180-mss
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  additionalItems: false

With the indentation here, you are defining a property. Should be no 
indent.

> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +examples:
> +  # Example of MSS with clock nodes properties for SC7180:
> +  - |
> +    clock-controller@41aa000 {
> +      compatible = "qcom,sc7180-mss";
> +      reg = <0x041aa000 0x100>;
> +      #clock-cells = <1>;
> +    };
> +...
> --
> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
> of the Code Aurora Forum, hosted by the  Linux Foundation.
> 
