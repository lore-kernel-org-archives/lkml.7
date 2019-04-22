Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747D6C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E04120693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 11:46:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Zue6KRCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfDVLqD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 07:46:03 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37052 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfDVLqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 07:46:03 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so10075797ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UgYLsmpnDFM4RVyGe7H5GZdblKu/p94GiLSjqV7S1BU=;
        b=Zue6KRCDmUG/jNMIo/sNNTfjQxsHtD4Le7mRxOlqmo0bDTgPkj57YegO9CE2f6TQb5
         gC69rnbcuT0ahNN5dD6hkyjtG4atVJSJTgldJbftnP0EjVn/N3otoSTco85dQiYL7BTA
         OpBxXV4VEAIutoe0VsMR8VXZrPNEFrTo2hja3fhh3JDGXKRBPxM3Ma462IWsHoMdtlvV
         SHSt7CrVtqCK7BJ7MtgWEP0aUcV79ZPxYDjDksIqOh3ccx/TvN/Dx1u7/GTFlDqlQg4v
         G5JqC62pIHc8+/0S7FFMA5Xk9ZiJriKyj7EvpmUG7CfGx7hK7pZkRap54Iy0RLsw+/YK
         SIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UgYLsmpnDFM4RVyGe7H5GZdblKu/p94GiLSjqV7S1BU=;
        b=Jwc2nmpXMKN9VIIpYW4XLuhIRQRGnHRINtmjMVQOMLQa3I3wTQLxMFqWZJDFnMx3Aw
         bq8Dfn7LGycRI9xU4tZoExgyZ16AMxFpvqQcs2EN4mzd2vQdge8eho3+Qq+BB5NdcWfG
         RAZ6VJgCyAxE+eks88r9h6/MUgPhKDKAxxuf44jaNFHW7HNGeUgQyY4vb+ORC38JB+WP
         rUpgON5Ohmo0rfbiRZSKAM6qnV4ujTTVqX/HW1P5LgBdsSkFRzfB4e1lwC9DYH/tqnSc
         vMSAwYS7JWOPMpJWCf6diOVFaF64E0twD+OpbakJSXeBkM4b+f0Sfa1j3WObB6W4grjf
         JxxA==
X-Gm-Message-State: APjAAAXodsjZ+R+HKYGXLRYQiv6H0wLLD0G3K6vv3jglk7qpxK4Sti/E
        LFrUsSIVqH3qvhoUwAgGocXUqw==
X-Google-Smtp-Source: APXvYqytiaHFC/wvzugjsifq4Tv/MnPgnoOH8ylInaLkTvQBmr2IYo5zkkIXLbhg2EAgAcVw4gkVAQ==
X-Received: by 2002:a2e:8648:: with SMTP id i8mr10450308ljj.166.1555933561062;
        Mon, 22 Apr 2019 04:46:01 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.103])
        by smtp.gmail.com with ESMTPSA id a26sm2901519lfo.3.2019.04.22.04.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 04:46:00 -0700 (PDT)
Subject: Re: [PATCH v11 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1555903925-15292-1-git-send-email-masonccyang@mxic.com.tw>
 <1555903925-15292-4-git-send-email-masonccyang@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <2714b406-1038-c3e2-be6b-326c073497ea@cogentembedded.com>
Date:   Mon, 22 Apr 2019 14:45:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1555903925-15292-4-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 04/22/2019 06:32 AM, Mason Yang wrote:

> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> ---
>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> new file mode 100644
> index 0000000..ee3bad8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> @@ -0,0 +1,39 @@
> +Renesas R-Car Gen3 RPC-IF MFD controller Device Tree Bindings
> +-------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be an SoC-specific compatible value, followed by
> +		"renesas,rcar-gen3-rpc" as a fallback.
> +		supported SoC-specific values are:
> +		"renesas,r8a77995-rpc"	(R-Car D3)
> +- reg: should contain three register areas:
> +	first for the base address of rpc-if registers,

   RPC-IF.

> +	second for the direct mapping read mode and
> +	third for the write buffer area.
> +- reg-names: should contain "regs", "dirmap" and "wbuf"
> +- clocks: should contain 1 entries for the module's clock
> +- clock-names: should contain "rpc"
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Example:
> +
> +	rpc: rpc-if@ee200000 {
> +		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>;
> +		reg-names = "regs", "dirmap";

  You forgot to add back the "wbuf" entrees above.

> +		clocks = <&cpg CPG_MOD 917>;
> +		clock-names = "rpc";
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		flash@0 {
> +			compatible = "jedec,spi-nor";
> +			reg = <0>;
> +			spi-max-frequency = <40000000>;
> +			spi-tx-bus-width = <1>;
> +			spi-rx-bus-width = <1>;
> +		};
> +	};
> 

MBR, Sergei
