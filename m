Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F86BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389D4206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570663772;
	bh=QYNkCVUZajG7ErfxwWO1t+RTgPkD5p3BPS8SxAH+hnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lxDSzPmhdXAVRfBtAN7oj20lXwbC9MArENTjnr14AdPsR+CYf6ByoA2A09ek4aeOt
	 lUo/2bgpUaJ+UReY0jXX+a4Do8EVcxkUE0LbDw3BdZjHl3TTez6apj2CiosdttSFvx
	 Ns0FAAxpzH/fRk62KQ+vVc2touEaeCnlH+luiJ1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbfJIX3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:29:31 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34348 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730815AbfJIX3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 19:29:30 -0400
Received: by mail-ot1-f67.google.com with SMTP id m19so3279320otp.1;
        Wed, 09 Oct 2019 16:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2Apio31LtMmOqrZCrxF+YnIGQznM4DxO5yGCDFPVfSQ=;
        b=ceZRNeM3HUb60rHibV80/QeWMksa3nkUe98OCy7aTSXtmYCTeVJGs6rfcUi1GtFLMo
         QVZknOhK8ON2yUU/dedS1Kj2NbEYyx04RIQtp8fHXYuXcjkn2VR/5yDPjqSXIzVArRs2
         qJONuoGC+M7QZ7u69h2DhcDt64OK1oNRpLNz1HrtJ4hg9/j7a9pAySLDHkO7+E9wOkZN
         A1KWd32Pp54AQauuPz3SXiZnFgGQm+ABvDBYmi0CBL6Tmi3wy/UMtJEs+2tuAcX0ucGs
         VLSsX7NAzhFpspnEVyfE9TfytutFAwP2/rPxEWErVcr866Uypo8u2Y6sMlTaY/Ut5DdA
         YR3g==
X-Gm-Message-State: APjAAAVO4tVZpdRkVQPuKAngG8mhAkZ3QyP1w1Eerxye8qfWMWeoLXrN
        W8UZOZ8Cov7cABOS53ochw==
X-Google-Smtp-Source: APXvYqzwOLQBtOxYRSLP+WcrCacVbVqWK09AEHEGea2IcVnP3ebdC+rmHbXia0ZPF4btsO+bUl6BDw==
X-Received: by 2002:a05:6830:1d8a:: with SMTP id y10mr5544092oti.48.1570663768399;
        Wed, 09 Oct 2019 16:29:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i47sm1159341ota.1.2019.10.09.16.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 16:29:27 -0700 (PDT)
Date:   Wed, 9 Oct 2019 18:29:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     maz@kernel.org, mark.rutland@arm.com, arnd@arndb.de, bp@alien8.de,
        mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, paulmck@linux.ibm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, hhhawa@amazon.com, ronenk@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, amirkl@amazon.com,
        barakw@amazon.com
Subject: Re: [PATCH v5 1/2] dt-bindings: soc: al-pos: Amazon's Annapurna Labs
 POS
Message-ID: <20191009232927.GA23987@bogus>
References: <1570452435-8505-1-git-send-email-talel@amazon.com>
 <1570452435-8505-2-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1570452435-8505-2-git-send-email-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 03:47:14PM +0300, Talel Shenhar wrote:
> Document Amazon's Annapurna Labs POS SoC binding.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> ---
>  .../bindings/edac/amazon,al-pos-edac.yaml          | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml

Please fix errors with 'make dt_binding_check' and resubmit.

Error: Documentation/devicetree/bindings/edac/amazon,al-pos-edac.example.dts:21.28-29 syntax error
FATAL ERROR: Unable to parse input tree

Hint: You need an include.

> 
> diff --git a/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
> new file mode 100644
> index 00000000..048c2e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/amazon,al-pos-edac.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/amazon,al-pos-edac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amazon's Annapurna Labs POS
> +
> +maintainers:
> +  - Talel Shenhar <talel@amazon.com>
> +  - Talel Shenhar <talelshenhar@gmail.com>
> +
> +description: |
> +  POS node is defined to describe the Point Of Serialization (POS) error
> +  detection capability.
> +
> +properties:
> +
> +  compatible:
> +    const: "amazon,al-pos-edac"
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: Interrupt for the error event.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    edac@f0070084 {
> +      compatible = "amazon,al-pos-edac";
> +      reg = <0x0 0xf0070084 0x0 0x00000008>;
> +      interrupt-parent = <&amazon_system_fabric>;
> +      interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
> +    };
> -- 
> 2.7.4
> 
