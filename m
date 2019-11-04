Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53267CA9ED4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23722214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 23:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572909273;
	bh=4VsPKI7/xxr2Z7oFZlaFT4/tuBZteZZMBvKkMvme+2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dDM8W64/lphCbPLlTLLu79DWlRuAZfpeqrwkG1ZJvPLvnSoqVibLEAi8bscOl/San
	 y3lEbejf7X/0RDudTnMTaZwWkmM4ARlKWKfO+qjyT7MkB7GiNKp+xmYaQ0dv+Ig04w
	 IEmX14nPspktg8LTdyHXvYOKsC/fOTDsGc2PiZ10=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfKDXOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 18:14:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37069 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfKDXOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:14:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id y194so15806481oie.4;
        Mon, 04 Nov 2019 15:14:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0s5eHuTsunlw8bqFz+rzViXBrMYpKgr6RnCJYn4WElg=;
        b=czJ3ZF17rrmNIRqIv5LGRrgYzeRotpPSNKw8uaabIgEaRrMauy6kQj7WCBqrxRXBvQ
         cmhW+NXMWhhdCDdszMypflg2K6vPwdV2wpcLNov9GPKk9q5SZ0jkHVXdwLFC1Xuy1Xto
         7mhHaKuPrbgfgCw65My/u65NjKCVaBNCn0Lalb1NbwSQN4UAJDvYlsI2LLxdunGJ/Kyf
         ojI6sCX51hPEpIS6gOIO4n+K19+vigTsHsEFkEguj6/Cvb+XwRcNFgi+YWsIwrer5CPm
         EcLUdtH7MZdryHoT4O+2+O38btIcGz/6DNnkX1wGV/PCvn0FR3MHynqjRL/x2sWfTWKP
         O/cg==
X-Gm-Message-State: APjAAAWTGx74q/shWWOFLuwuU2jM+r0DUe3jPZ/S8GJsZl86tLmVy7Ld
        ITnYxgD8wa2nptOaZi84UQ==
X-Google-Smtp-Source: APXvYqx+ynBSlgqnWKE4r7VqCKzMalb5FPZcpp7PVoYmQGaUXm4gN7FKLPzlCpmpR3QcYqmpPcjtKQ==
X-Received: by 2002:aca:1e14:: with SMTP id m20mr1388093oic.20.1572909268626;
        Mon, 04 Nov 2019 15:14:28 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e93sm5785180otb.60.2019.11.04.15.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 15:14:28 -0800 (PST)
Date:   Mon, 4 Nov 2019 17:14:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     ulf.hansson@linaro.org, mark.rutland@arm.com,
        adrian.hunter@intel.com, michal.simek@xilinx.com,
        jolly.shah@xilinx.com, nava.manne@xilinx.com,
        rajan.vaja@xilinx.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com
Subject: Re: [PATCH v5 4/8] dt-bindings: mmc: Add optional generic properties
 for mmc
Message-ID: <20191104231427.GA7606@bogus>
References: <1572588353-110682-1-git-send-email-manish.narani@xilinx.com>
 <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572588353-110682-5-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 11:35:49AM +0530, Manish Narani wrote:
> Add optional properties for mmc hosts which are used to set clk delays
> for different speed modes in the controller.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../bindings/mmc/mmc-controller.yaml          | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 080754e0ef35..87a83d966851 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -212,6 +212,98 @@ properties:
>      description:
>        eMMC HS400 enhanced strobe mode is supported
>  
> +  # Below mentioned are the clock (phase) delays which are to be configured
> +  # in the controller while switching to particular speed mode. The range
> +  # of values are 0 to 359 degrees.
> +
> +  clk-phase-legacy:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for Legacy Mode.
> +
> +  clk-phase-mmc-hs:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair degrees for MMC HS.
> +
> +  clk-phase-sd-hs:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SD HS.
> +
> +  clk-phase-uhs-sdr12:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SDR12.
> +
> +  clk-phase-uhs-sdr25:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SDR25.
> +
> +  clk-phase-uhs-sdr50:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SDR50.
> +
> +  clk-phase-uhs-sdr104:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SDR104.
> +
> +  clk-phase-uhs-ddr50:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for SD DDR50.
> +
> +  clk-phase-mmc-ddr52:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for MMC DDR52.
> +
> +  clk-phase-mmc-hs200:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for MMC HS200.
> +
> +  clk-phase-mmc-hs400:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - minimum: 0
> +      - maximum: 359
> +    description:
> +      Input/Output Clock Delay pair in degrees for MMC HS400.

This can be condensed into:

patternProperties:
  
"^clk-phase-(legacy|sd-hs|mmc-(hs|hs[24]00|ddr52)|uhs-(sdr(12|25|50|104)|ddr50))$":

Or if you want to divide them between SD and MMC ones, that would be 
fine for me.

Rob
