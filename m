Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7421CC76194
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9C72190F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="B2IYRqLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbfGYOuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:50:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33442 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388220AbfGYOuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:50:00 -0400
Received: by mail-lj1-f195.google.com with SMTP id h10so48305169ljg.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 07:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6wnAGGabQ71U78o4knoiSKA6pj8ghCt55D9V1wo+T0U=;
        b=B2IYRqLxUH1+yV5JsUcKz1/ZA+iccTO0ufD34R4byQxZe7CXU3NbtHo9tyPuLSiW87
         /jfTp7pPZqqDJkeWd7NyZU0KqqbvGv12Qr+Nb9kyskTiZuABrjsxV9cKcmjF0e72KdSm
         MssRnvOCrLO36PJWr1KlgMV24aABKeJpQy0F7bW9yGhdrOwRAVhl/oeVFZ1SMIa1hpVr
         kvMyCUIgqACnih1DZJmdmeCYCDSKcrIfvcmSb+yusMcEKryJ4A3mSswtgNW/useWALsE
         owKKVrwkAuaR26qlCtSEa6R2rjFuZUqYzF0Azr5MdIJgXbtKRAwEu2UBb7m5rSvJ9ibc
         vxQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=6wnAGGabQ71U78o4knoiSKA6pj8ghCt55D9V1wo+T0U=;
        b=Jz3LlkdaTy7X0knFERvCd65twz5MaCzXRqDzLcf6WSBUOkoRWKTc0MLV0ombB10vcJ
         r/XVC1XzAsrRZn0aYLuXaDd4Uw1CUF1tZI2Ynn+/y1zi8OetXd44378slBPaBDN0K3fS
         D0S9MMTBXjQPtME/PmC1OMp923t3kl5lgZmfM8a/cCHVg2fdzxSNr1npn7+QQRMplGEy
         E/+nVdCUa4Zncj464SsQH8N3NGOzPjTdtT++GNOB7KrmXGEQCXW5G2DlrrMmtT817cO8
         QI/6mOxTIBmbG9p5+/L1VPnYPFeJwnKVl/VbH8Srh1ljYdn3aDR4UQcFgN+bJxXmUpTn
         /WpQ==
X-Gm-Message-State: APjAAAUDJhYBVO50i2kPpgwdGcTmLabJi28dL7g1DsABpqjxLOv2fUr0
        Rza75HHdu1E9iksle1TahpQUPOYnCxaChQ==
X-Google-Smtp-Source: APXvYqwrCKqf4m+8KV0D4fmENaffy3HRKJJq6mh6Y4FyQ1BPvI6qdmY0bGVRwsAXaiGfVrkPGRJQrw==
X-Received: by 2002:a2e:a415:: with SMTP id p21mr46282699ljn.111.1564066197927;
        Thu, 25 Jul 2019 07:49:57 -0700 (PDT)
Received: from wasted.cogentembedded.com ([2a00:1fa0:669:e7fc:391:1b4e:d17c:23d6])
        by smtp.gmail.com with ESMTPSA id z25sm7546587lfi.51.2019.07.25.07.49.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 07:49:57 -0700 (PDT)
Subject: Re: [PATCH net-next v2 3/4] dt-bindings: net: fsl: enetc: Add
 bindings for the central MDIO PCIe endpoint
To:     Claudiu Manoil <claudiu.manoil@nxp.com>,
        "David S . Miller" <davem@davemloft.net>
Cc:     andrew@lunn.ch, Rob Herring <robh+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, alexandru.marginean@nxp.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1564053568-20522-1-git-send-email-claudiu.manoil@nxp.com>
 <1564053568-20522-4-git-send-email-claudiu.manoil@nxp.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <927717df-1a74-3253-f905-6a2f742fda63@cogentembedded.com>
Date:   Thu, 25 Jul 2019 17:49:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1564053568-20522-4-git-send-email-claudiu.manoil@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 07/25/2019 02:19 PM, Claudiu Manoil wrote:

> The on-chip PCIe root complex that integrates the ENETC ethernet
> controllers also integrates a PCIe enpoint for the MDIO controller
> provinding for cetralized control of the ENETC mdio bus.

   Providing, centralized.

> Add bindings for this "central" MDIO Integrated PCIe Endpoit.
> 
> Signed-off-by: Claudiu Manoil <claudiu.manoil@nxp.com>
> ---
> v1 - none
> v2 - none
> 
>  .../devicetree/bindings/net/fsl-enetc.txt     | 42 +++++++++++++++++--
>  1 file changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/fsl-enetc.txt b/Documentation/devicetree/bindings/net/fsl-enetc.txt
> index 25fc687419db..c090f6df7a39 100644
> --- a/Documentation/devicetree/bindings/net/fsl-enetc.txt
> +++ b/Documentation/devicetree/bindings/net/fsl-enetc.txt
[...]
> @@ -47,8 +49,42 @@ Example:
>  		};
>  	};
>  
> -2) The ENETC port is an internal port or has a fixed-link external
> -connection:
> +1.2. Using the central MDIO PCIe enpoint device

   Endpoint. -ETOOMANYTYPOS. :-)

[...]

MBR, Sergei
