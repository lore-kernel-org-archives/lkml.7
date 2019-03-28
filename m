Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE0AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F8512075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 13:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553779784;
	bh=JFGx6fL7N4q7qQbDZ3nQuWMlMabjwD0gxdVOk0+N5O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=clJ3ZrLSn5PBOFQ2EF0PAQaXTxFplfLcBht1BQR9deQOiPIfDH8/R3Bo5QL/1j90O
	 00W2Q3fUhdNLrXlnbtg27ozLo6RlG9630osrINZIHjBBT5fUSe8PUiZas3gqEs/gZm
	 StKb/YbQNdYkSB/xmSeoeCg86Ut6hD0kL7OKSaqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfC1N3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 09:29:43 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42977 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfC1N3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 09:29:42 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so15747727oie.9;
        Thu, 28 Mar 2019 06:29:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MREodbzACfJGNnJ9L2RQGgclTJjV6ULvmeQxDNyf73Y=;
        b=HkB5zA+LZ6+iw/DJqcCxKlAP9JWQ1dsxPMCPbS4ciyD3PTmNAzxkHnR3il9OLY0Rgn
         HDYOYQvxOAawyILG5EJJBwxyip6i04tETnjLhc29DQFrUwRDUoYDR3rVKb4ZtPdTM7Js
         z7lbWZ6yt6bCXCWekHLEuvbdXiWENjEr/ngDirG1XswFuQ39f5Hj2ELbeLyvdm5GySmp
         2zlaH3cl+rLrQ7A5RwDyZ5oCzahB9zvXR46zgUZW4cx7J7rRP+V5LK3d0AHhtXOy2s8+
         L0GIQxaZK/m2w84HSMvHgIQnEIIVG6MspQFVejD0/n96ikF4h/Uhgw43XfKjfR2aTFgZ
         bQHA==
X-Gm-Message-State: APjAAAWmpaAXo+v4l+mWfRgNk6lTN9uGhBoujVdCejRwWZivIbqNIjwd
        /K0M6s+pQHhLO2kQ3m/bpg==
X-Google-Smtp-Source: APXvYqx7KSFoygOsDxKDhKSvdAcs9TVpUlCKdpslkErx6UlDXj0rauVnCzcHCMtdtE1sHQyCbRN3sA==
X-Received: by 2002:aca:a894:: with SMTP id r142mr10357oie.112.1553779780688;
        Thu, 28 Mar 2019 06:29:40 -0700 (PDT)
Received: from localhost ([70.231.7.113])
        by smtp.gmail.com with ESMTPSA id t24sm8081611otk.16.2019.03.28.06.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 06:29:39 -0700 (PDT)
Date:   Thu, 28 Mar 2019 08:29:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH 10/14] dt-bindings: arm: sunxi: add compatible string for
 V3/S3/S3L SoCs
Message-ID: <20190328132939.GA13841@bogus>
References: <20190312152256.35574-1-icenowy@aosc.io>
 <20190312152256.35574-11-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312152256.35574-11-icenowy@aosc.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 23:22:52 +0800, Icenowy Zheng wrote:
> Allwinner V3/V3s/S3L and SoChip S3 SoCs share the same die, but with
> different package (V3 is BGA, without co-packaged DRAM, V3s is QFP,
> with co-packaged DDR2, S3 is BGA, with co-packaged DDR3, S3L is BGA
> pin-compatible with S3, but with co-packaged DDR2).
> 
> Add compatible strings for Allwinner V3/S3L and SoChip S3 SoCs.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
