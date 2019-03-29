Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4695C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D7C20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="BERLBaWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbfC2KuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:50:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45632 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfC2KuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:50:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id 5so1106460lft.12
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 03:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UyaLyfKCh/8+yGarYKysqxWvWj6HsjNnMDWd9jRPbjI=;
        b=BERLBaWoBAWy09JXSHLG2LC0a6riP65CkchwpU3WY05jPESMgnf1afU9TSPdZpKvP8
         WSMaCbWJNONb+BxohIBP2pg4OiNtdRyz13AYiElOZA9R1949ALL8jJZnah5tEf5qGinP
         tU8EM3Rmk0GgkqWsmfdgCNIdHYgHPWB2DgDNlQ02U7dMeNaU7nXmARZUu03sKsd/9Ua6
         TfxV6Z0ooqb8l54b7n6A2Zx0KUwzbQh7A9U/1T2bw3rVWE7NhbU6xaC4kY4XY0cRQiVE
         20eYhcCYaQ49qRMDCUr1CK+Z3JAvRUJ5ZPrf28D8xRPbsjLOKbSoSMzejLsBCmehAjRa
         q3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UyaLyfKCh/8+yGarYKysqxWvWj6HsjNnMDWd9jRPbjI=;
        b=TgKBXbDkxFkLpZxQtdWF/sBUsjSuUUj7hq8jbXfOIVADWYIljyJElNNMCy+r4Nhg8f
         f8OFuBAq7rjhNKm0PR4rf7DgyyXJ3vayuzlbfTpLGIl4Z3Fpw4rqps1XQSOr+ge8EjZI
         WVB2vEq4txGU/ql+qMHsknObmojQrVSaV3RrdRPN2koE6tU4tURTrmx+c5wWSdeE5jpN
         6qQB9SRwyoXJVr4Jtg4AD2QCrliF/81VF+N810na452QZMiFjAzuJgC5XqYlQWi+/Mg7
         bVUghudGoSpmRGWLg5y23IPPdgWcBVzOxhEryLHqArRKkHDqfWOe194MFhtD6CKudSkQ
         FAAg==
X-Gm-Message-State: APjAAAWoG9Z4rsd68D7ubrGJjJ1b+Sd4U0s1Z6V4ZR2fM45N4sq1nYCo
        OEUZ9am8FK/zDNqfxed1/vob5w==
X-Google-Smtp-Source: APXvYqxfKCnGnEYwgQtzauvdWeP4k66FI6q19DHWJq67shOtYNMTdbGf7aYV19R5cjiYepKYXM0EtQ==
X-Received: by 2002:a19:f81a:: with SMTP id a26mr13987566lff.34.1553856600582;
        Fri, 29 Mar 2019 03:50:00 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.84.183])
        by smtp.gmail.com with ESMTPSA id r77sm293335ljb.29.2019.03.29.03.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:49:59 -0700 (PDT)
Subject: Re: [PATCH v9 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-4-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <5e841334-7cd7-3b5f-77d2-bb39bf8ec8b7@cogentembedded.com>
Date:   Fri, 29 Mar 2019 13:49:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1553847606-18122-4-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 03/29/2019 11:20 AM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD controller.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> new file mode 100644
> index 0000000..577986b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> @@ -0,0 +1,57 @@
> +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
> +---------------------------------------------------------------------

   Too many dashes. :-)

> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77995-rpc"	(R-Car D3)
> +- reg: should contain three register areas:
> +	first for the base address of rpc-if registers,
> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"

   What about the "power-domains" and "resets" props?

> +- #address-cells: should be 1
> +- #size-cells: should be 0

   Why? You don't have the "reg" props in the sub-devices...

> +
> +Required nodes:
> +	spi:
> +	Node for configuring the SPI controller driver.
> +	Required properties:
> +		compatible = "renesas,rcar-rpc-spi";

   Sigh... you were supposed to only place the flash device sub-nodes
under the "main" device node, we don't add the virtual devices to DT,
there's no matching sub-device in the hardware. You don't have to
describe these sub-devices in DT, you can register the simple platform
devices. 

> +
> +	hf:
> +	Node for configuring the hyperflash controller driver.
> +	Required properties:
> +		compatible = "renesas,rcar-rpc-hf";
> +
> +Example:
> +
> +	rpc_mfd: rpc-mfd@ee200000 {

   Just "rpc: rpc-if@ee200000, please.

[...]

MBR, Sergei
