Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B494C76196
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 600352083B
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 19:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hFXuS3Uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGUTIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 15:08:44 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:47033 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfGUTIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 15:08:43 -0400
Received: by mail-pl1-f194.google.com with SMTP id c2so18032908plz.13
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2019 12:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ylc57dC3XkA6IHMlmIjnKW4Yzv6Mn8fQS/B+VYG3i7c=;
        b=hFXuS3UuB0qEeWg8hFp1mt5M/vafnnV/H39+mmEBKBMQ6xCuRKQgpfCFQQWhnF06iN
         7R5W7aXngTALP/5jdXOaeKtZsqrj7d5ZLrqbckNvTHKnRtqAAjvaukLNlEST2a+4/Ej7
         H80DYxPQ177ByL70x39ot2ehYPEiWZzh8ZPjrh/b5jnNElNiveC9S9/B3RN+3MgRNgb0
         SwDITHJRgl1p5rVxOijsGmXd0mkG6xZmiD1vCtxFMtcqfq47+v9otgdyUDxqHWMwiPWi
         GbypFKBSjKL/xj15JNauSeR082PcvoJkrl0+zrcM6g5JwIj5y8Tb16X1Rv08njf3KThY
         ZbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ylc57dC3XkA6IHMlmIjnKW4Yzv6Mn8fQS/B+VYG3i7c=;
        b=RofE1hwwdbIBjDQg5KE+DUh56UoxODKwOmlgj6hMiQAFQQ2udeePgRjskEItUi2iIr
         dUL5JyNnXXtDHc5hfuJFUuHorCRBBNOD1XDqhBlWxPRJDYBEz7oFm6TI7S4Rto5LZALV
         2CnG7TCSVBgHh6XloVIWXZuyh2j6g1Z1pEvYrhNLEviSWE0QBajcyXADa9XigPD0sLGt
         4QK1mmTXUJ/yselWNgZhh7iZ4gXSqH9eKnmKW2D37DoWRHGliyo7ldMEApNDkwuEx5XZ
         X7v6Px60xeybhzPByc95P/YU7lbeHYPPy/5sLW7o2b4u4Yv4PG/spCn+8btxjiVlTl8T
         wmgQ==
X-Gm-Message-State: APjAAAWlI2ygTaB1zpY7O4mGtW0LJlfsZFW1ekW+jsvhLiMAwzPysubs
        Z/nAkP3VlGeCJugjtF14dIJwaw==
X-Google-Smtp-Source: APXvYqzpOknbyvmRTmwYMUByzUAr778DaIFVqdKbNdR1vNVMvGgXL9ajPeFWDGgnS8HhUdoyyXXLIg==
X-Received: by 2002:a17:902:b109:: with SMTP id q9mr61064677plr.176.1563736122702;
        Sun, 21 Jul 2019 12:08:42 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h9sm34413137pgh.51.2019.07.21.12.08.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 12:08:42 -0700 (PDT)
Date:   Sun, 21 Jul 2019 12:10:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     David Dai <daidavid1@codeaurora.org>
Cc:     georgi.djakov@linaro.org, robh+dt@kernel.org, evgreen@google.com,
        ilina@codeaurora.org, seansw@qti.qualcomm.com, elder@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Update Qualcomm SDM845 DT
 bindings
Message-ID: <20190721191002.GH7234@tuxbook-pro>
References: <1563568344-1274-1-git-send-email-daidavid1@codeaurora.org>
 <1563568344-1274-2-git-send-email-daidavid1@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563568344-1274-2-git-send-email-daidavid1@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19 Jul 13:32 PDT 2019, David Dai wrote:

> Redefine the Network-on-Chip devices to more accurately describe
> the interconnect topology on Qualcomm's SDM845 platform. Each
> interconnect device can communicate with different instances of the
> RPMh hardware which are described as RSCs(Resource State Coordinators).
> 
> Signed-off-by: David Dai <daidavid1@codeaurora.org>

I like this and we don't have any consumers in DT yet, so I think this
is good.

But we need a patch to the implementation as well, to have the
provider(s) registered with the new compatibles.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  .../bindings/interconnect/qcom,bcm-voter.txt       | 32 +++++++++++++++++
>  .../bindings/interconnect/qcom,sdm845.txt          | 40 +++++++++++++++++-----
>  2 files changed, 63 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
> new file mode 100644
> index 0000000..2cf7da2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.txt
> @@ -0,0 +1,32 @@
> +Qualcomm BCM-Voter interconnect driver binding
> +-----------------------------------------------------------
> +
> +The Bus Clock Manager (BCM) is a dedicated hardware accelerator
> +that manages shared system resources by aggregating requests
> +from multiple Resource State Coordinators (RSC). Interconnect
> +providers are able to vote for aggregated thresholds values from
> +consumers by communicating through their respective RSCs.
> +
> +Required properties :
> +- compatible : shall contain only one of the following:
> +			"qcom,sdm845-bcm-voter",
> +
> +Examples:
> +
> +apps_rsc: rsc@179c0000 {
> +	label = "apps_rsc";
> +	compatible = "qcom,rpmh-rsc";
> +
> +	apps_bcm_voter: bcm_voter {
> +		compatible = "qcom,sdm845-bcm-voter";
> +	};
> +}
> +
> +disp_rsc: rsc@179d0000 {
> +	label = "disp_rsc";
> +	compatible = "qcom,rpmh-rsc";
> +
> +	disp_bcm_voter: bcm_voter {
> +		compatible = "qcom,sdm845-bcm-voter";
> +	};
> +}
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> index 5c4f1d9..27f9ed9 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845.txt
> @@ -4,21 +4,43 @@ Qualcomm SDM845 Network-On-Chip interconnect driver binding
>  SDM845 interconnect providers support system bandwidth requirements through
>  RPMh hardware accelerators known as Bus Clock Manager (BCM). The provider is
>  able to communicate with the BCM through the Resource State Coordinator (RSC)
> -associated with each execution environment. Provider nodes must reside within
> -an RPMh device node pertaining to their RSC and each provider maps to a single
> -RPMh resource.
> +associated with each execution environment. Provider nodes must point to at
> +least one RPMh device child node pertaining to their RSC and each provider
> +can map to multiple RPMh resources.
>  
>  Required properties :
>  - compatible : shall contain only one of the following:
> -			"qcom,sdm845-rsc-hlos"
> +			"qcom,sdm845-aggre1_noc",
> +			"qcom,sdm845-aggre2_noc",
> +			"qcom,sdm845-config_noc",
> +			"qcom,sdm845-dc_noc",
> +			"qcom,sdm845-gladiator_noc",
> +			"qcom,sdm845-mem_noc",
> +			"qcom,sdm845-mmss_noc",
> +			"qcom,sdm845-system_noc",
>  - #interconnect-cells : should contain 1
> +- reg : shall contain base register location and length
> +- qcom,bcm-voter : shall contain phandles to bcm voters
>  
>  Examples:
>  
> -apps_rsc: rsc {
> -	rsc_hlos: interconnect {
> -		compatible = "qcom,sdm845-rsc-hlos";
> -		#interconnect-cells = <1>;
> -	};
> +aggre1_noc: interconnect@16e0000 {
> +	compatible = "qcom,sdm845-aggre1_noc";
> +	reg = <0x16e0000 0xd080>;
> +	interconnect-cells = <1>;
> +	qcom,bcm-voter = <&apps_bcm_voter>;
>  };
>  
> +mmss_noc: interconnect@1740000 {
> +	compatible = "qcom,sdm845-mmss_noc";
> +	reg = <0x1740000 0x1c1000>;
> +	interconnect-cells = <1>;
> +	qcom,bcm-voter = <&apps_bcm_voter>, <&disp_bcm_voter>;
> +};
> +
> +mem_noc: interconnect@1380000 {
> +	compatible = "qcom,sdm845-mem_noc";
> +	reg = <0 0x1380000 0 0x27200>;
> +	#interconnect-cells = <1>;
> +	qcom,bcm-voter = <&apps_bcm_voter>, <&disp_bcm_voter>;
> +};
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
