Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08CFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B4E21773
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldpTZVeK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfC2Kqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:46:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44832 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbfC2Kqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:46:48 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so1026308pgj.11;
        Fri, 29 Mar 2019 03:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xpfYQxHDU3+HHf5MB4ZWhN9H0R8bKFIIM9eZ/+KxbUA=;
        b=ldpTZVeKH5AZaolrBVNH2z5OwZHCA6RVXI3xhFM+lXAleclIkInaDyFMYbhl6/HAV+
         +IzS/Jrm1n3Nv2sr1gvZjqi89IcaRW3XdHYJCTbpyavG7co9fgdS79PkqgsnYEYthJJw
         Kb/rntq24WVvegIVCpAxp52X/ry0JEf3pXQSBOj28gZlhxgSlz/qawY3IjoepnA1O9lK
         mluOfMboMDs54Xi2DHJv1H90HSt8tpZZslnuMwG41T+RntoYcDoYZiau9Ox48rNs+Yyb
         9R8NGJLUva/aE2JeceJyQE/uugpF603dbLlWoZRVth0bRT+rUspwOWszK8RwhzKX93pa
         82vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xpfYQxHDU3+HHf5MB4ZWhN9H0R8bKFIIM9eZ/+KxbUA=;
        b=BPXfBpdvo1IBE3gDk4udGkXkbThra6iKuzbA+VREB+eAcZfQ0hrcNg0Dj5nL3Y7y2N
         QIW/f8fznnwuftrirEFk/RX3LhzT/bszkl18A1Wx7ARR2TpiWDxoEWgbMsgnCDZ0icMT
         h/v6+IlAV1I1ETH31/npDcs15ztQ22Z90X+6Zr2smp0pDM3iZMkTQz9dpT/IVx0Hocir
         Q5ncqcsUoueFyeTk+8wTHIA9qd6zFVMyqnIDIBt98ux9GlWpyKL1pxYh/WxcSifl8wP+
         ZsYVqcIEjDLmBzZC3NGzmOKa+ZmT7ElyVVmJx7gQAdZFbNZ8EZA1RVJl8RK0zucFEOba
         zVhA==
X-Gm-Message-State: APjAAAWx8hKmIr9DkJEMbSlhV0Qp6/sUFytZPYaV6GcHOQlf4tIWfL02
        DMCws2PsPGSDkOFUbylaqfM=
X-Google-Smtp-Source: APXvYqzMuqt/89cWHETh0wTp+Eid/nn8A5zR+sNB9svHAD1LRB7y89gl/dI8SJufXVYV+c8ShsmRwg==
X-Received: by 2002:a62:1318:: with SMTP id b24mr43872477pfj.201.1553856408068;
        Fri, 29 Mar 2019 03:46:48 -0700 (PDT)
Received: from [192.168.42.180] (219x120x4x122.ap219.ftth.ucom.ne.jp. [219.120.4.122])
        by smtp.gmail.com with ESMTPSA id 4sm1987383pgx.68.2019.03.29.03.46.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:46:47 -0700 (PDT)
Subject: Re: [PATCH v9 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
To:     Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-4-git-send-email-masonccyang@mxic.com.tw>
From:   Marek Vasut <marek.vasut@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <7a2d3d45-76ec-611d-08cf-f63da17d12f0@gmail.com>
Date:   Fri, 29 Mar 2019 11:45:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553847606-18122-4-git-send-email-masonccyang@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/19 9:20 AM, Mason Yang wrote:
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
> +- #address-cells: should be 1
> +- #size-cells: should be 0
> +
> +Required nodes:
> +	spi:
> +	Node for configuring the SPI controller driver.
> +	Required properties:
> +		compatible = "renesas,rcar-rpc-spi";
> +
> +	hf:
> +	Node for configuring the hyperflash controller driver.
> +	Required properties:
> +		compatible = "renesas,rcar-rpc-hf";
> +
> +Example:
> +
> +	rpc_mfd: rpc-mfd@ee200000 {
> +		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
> +		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
> +		      <0 0xee208000 0 0x100>;
> +		reg-names = "regs", "dirmap", "wbuf";
> +		clocks = <&cpg CPG_MOD 917>;
> +		clock-names = "rpc";
> +		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> +		resets = <&cpg 917>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		spi {

Why is this subnode needed ?
The MFD driver core can just check whether the flash@0 is jedec,spi-nor
or cfi-flash and select mode of operation based on that.

> +			compatible = "renesas,rcar-rpc-spi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			flash@0 {
> +				compatible = "jedec,spi-nor";
> +				reg = <0>;
> +				spi-max-frequency = <40000000>;
> +				spi-tx-bus-width = <1>;
> +				spi-rx-bus-width = <1>;
> +			};
> +		};
> +	};
> 


-- 
Best regards,
Marek Vasut
