Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC00DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9993224CE7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZarS4JaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfFDJI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:08:57 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10699 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbfFDJI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:08:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf635270000>; Tue, 04 Jun 2019 02:08:55 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 04 Jun 2019 02:08:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 04 Jun 2019 02:08:55 -0700
Received: from [10.26.11.158] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 4 Jun
 2019 09:08:53 +0000
Subject: Re: [PATCH 2/2] arm64: tegra: enable ACONNECT, ADMA and AGIC
To:     Sameer Pujar <spujar@nvidia.com>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1557143908-5850-1-git-send-email-spujar@nvidia.com>
 <1557143908-5850-2-git-send-email-spujar@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d503728b-e689-f3bf-c620-f911bef31339@nvidia.com>
Date:   Tue, 4 Jun 2019 10:08:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1557143908-5850-2-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559639335; bh=XJ9GGX4x6JbOACeYCqBh7B/qBxUQCNT/wafeU/9X04A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=ZarS4JaOLon6rCEsN2iL4jq8pFgLd/VQr0mCuAWicN1nX7BG8SxnszcIv011tSIOh
         vHEJV8SRUieG+zWjxem7hh+xJVi9pxj9jMT6sU5meN4A/Ve0ciX4vRAEBI4BzC7yfy
         iouDdpXlGqXyova1XrWNx4EtKuFtccgdYfyxjwPZtY7Burmrige0ZbhpRFu4HTxkY1
         Y0HD4IsfS1Y9qSSg8y7cLr1WzGsmybMTLk3POGAUJKEFsNicjK0ls5A5vKbLU+BH8U
         7uH226feSf4NzIrs4pwciGWAH/yeiaDXYDTv0Ue7rkRR2wCqMMPupMyZkvLK7x69bY
         pKGmPLM/8WggQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/05/2019 12:58, Sameer Pujar wrote:
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
> index 31457f3..21e73db 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts
> @@ -183,4 +183,16 @@
>  			vin-supply = <&vdd_5v0_sys>;
>  		};
>  	};
> +
> +	aconnect@2a41000 {
> +		status = "okay";
> +
> +		dma@2930000 {
> +			status = "okay";
> +		};
> +
> +		agic@2a41000 {
> +			status = "okay";
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index b62e969..bca28fc 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -169,4 +169,16 @@
>  			};
>  		};
>  	};
> +
> +	aconnect@2a41000 {
> +		status = "okay";
> +
> +		dma@2930000 {
> +			status = "okay";
> +		};
> +
> +		agic@2a41000 {
> +			status = "okay";
> +		};
> +	};
>  };

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
