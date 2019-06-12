Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BE5C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01FF208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M+rmHiJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408480AbfFLMh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:37:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17558 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406351AbfFLMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:37:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d00f2240000>; Wed, 12 Jun 2019 05:37:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 12 Jun 2019 05:37:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 12 Jun 2019 05:37:55 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 12 Jun
 2019 12:37:53 +0000
Subject: Re: [PATCH v2 2/2] arm64: tegra: enable ACONNECT, ADMA and AGIC
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <mkumard@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1560243406-2535-1-git-send-email-spujar@nvidia.com>
 <1560243406-2535-2-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <4e017e97-8a05-c1fe-2cd9-b985e79d02a1@nvidia.com>
Date:   Wed, 12 Jun 2019 13:37:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560243406-2535-2-git-send-email-spujar@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560343076; bh=tl2brwe6ph735O/9Rbog0KrkLlApFWyoCosb3KRlAQA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=M+rmHiJXWuQpa2ipuzejQ1eDQjBiPo2lgkcty3/SPEDbaHHHIXT8zAY6b3Mwbxklp
         j72Fs3QJx2iW2x+pp52d3hM1Iwptfl5nPGe3+iOBH1gI1Aguk6I64ef55bs9I8Fr6M
         y0emDDq4vEQ0v/+A/9KuCWXAZx6Ls40ZQvHlHPB9Z9ZFsh2XYxUms0bMjt46U8hLT/
         havK1HZd5YyejRYvzBhgUjYvrA8x3uNzySwPc2msgagoK64NzrIabF8YbUaMu6iQOg
         6HGTXp2pecnqTtgVX3vUY23RD21rzAzJ3NwksJBumGSY7vszwKA+33u7IBkSjcrEtl
         UFBhrcInY+Bxw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2019 09:56, Sameer Pujar wrote:
> Enable ACONNECT, ADMA and AGIC devices for following platforms
>   * Jetson TX2
>   * Jetson Xavier
> 
> Verified driver probe path and devices get registered fine.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts | 12 ++++++++++++
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts | 12 ++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> index 5102de1..b818355 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> @@ -298,4 +298,16 @@
>  			vin-supply = <&vdd_5v0_sys>;
>  		};
>  	};
> +
> +	aconnect@2a41000 {
> +		status = "okay";
> +
> +		dma-controller@2930000 {
> +			status = "okay";
> +		};
> +
> +		agic@2a41000 {
> +			status = "okay";
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index 6e6df65..d1cc028 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -167,4 +167,16 @@
>  			};
>  		};
>  	};
> +
> +	aconnect@2a41000 {
> +		status = "okay";
> +
> +		dma-controller@2930000 {
> +			status = "okay";
> +		};
> +
> +		agic@2a41000 {
> +			status = "okay";
> +		};
> +	};
>  };
> 

I believe that I have already ACK'ed this, so please include for the
next revision.

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
