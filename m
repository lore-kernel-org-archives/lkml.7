Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A39C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5069E20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014554;
	bh=/qYu4ke0Ufy8nAZ/6w7rQQ4J1h4QSMp6yNjw4/jOJ+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zpL4mFIUAH/iJkprr76CoKyCAgalJa10Q2zwhVY1si46FkD3GroPWuK4aybRcaDsK
	 IU6TiYoJzlszP0zay+OxQ2PFjZB0TlyghF74yuSs6y7bQNlYYUa8aFE5VzT8tTk4Y7
	 gWUU8cBOL/TGiCTi/O8Vj9V24lGhFuoN7Ot1w2uM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731501AbfCaGmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:33 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46960 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731480AbfCaGmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id y6so2922650pll.13;
        Sat, 30 Mar 2019 23:42:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=6oOAYgYtzPk0QpjliWGYPy3dmhV52PrxzaNtGHozpe4=;
        b=THyXxz1Y1K1OfCTXaHvec7SHILsyt2aJrD/N2GO1cQFdkJcyRdwdVZfbXJ6fcUJc/g
         G6XCSfAyf8h7zuBeJ2FWKBPQDI14vbdASpNx8n8aTQ4TgXWo4F6CRsOGBS517YcC5+Qk
         AAUBAJMxMWQOS1Ip9lbXEixuXl/14ksuVyO3Tpm/PugEswH4fJR0YDmnEAbjrfLZg7ey
         xzgGRqwFjoLPmhJW8xJgFNZIUq3uAcrEHBjnb4lQRxXYAzk9CCks45DozhxImFfd476q
         wkqXCYCLD8V0e1t+cZgD6akl8XfAMG42Sz7ssLJxZvIBpwnP/JteEv6G3DzK+H1/VAhQ
         4xmg==
X-Gm-Message-State: APjAAAXgm4+U7MVTGvK4nxsKYzFHaMzGva6FbMapjaoNCwc/SbmgBc2b
        kbKB2j96UZhcKepdio5/mw==
X-Google-Smtp-Source: APXvYqx9d9NcJ29fMms2O9ATknMwO+EYe60pnxt9RDAbM6tXSjWKSTqbMTvfbLrLLmJ/6GfjVQgRZw==
X-Received: by 2002:a17:902:2947:: with SMTP id g65mr57597123plb.258.1554014550178;
        Sat, 30 Mar 2019 23:42:30 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id d129sm4074365pfa.142.2019.03.30.23.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:29 -0700 (PDT)
Message-ID: <5ca06155.1c69fb81.60281.9b59@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        broonie@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V1 21/26] DT bindings: spi: add tx/rx clock delay SPI
 client properties
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-21-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553666207-11414-21-git-send-email-skomatineni@nvidia.com>
X-Mutt-References: <1553666207-11414-21-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 10:56:42PM -0700, Sowjanya Komatineni wrote:
> This patch adds Tegra SPI master tx and rx clock delay properties.
> 
> TX/RX clock delays may vary depending on the platform design trace lengths
> for each client on the Tegra SPI bus. These properties helps to tune the
> clock delays.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../devicetree/bindings/spi/nvidia,tegra114-spi.txt      | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Just combine this with patch 19.

> diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> index 6167c5234b64..2b84b7b726ce 100644
> --- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> @@ -29,6 +29,12 @@ spi-client device controller properties:
>  - nvidia,cs-hold-clk-count: CS hold timing parameter.
>  - nvidia,cs-inactive-cycles: CS inactive delay in terms of clock between
>    transfers.
> +- nvidia,tx-clk-tap-delay: Delays the clock going out to the external device
> +  with this tap value. This property is used to tune the outgoing data from
> +  Tegra SPI master with respect to outgoing Tegra SPI master clock.
> +- nvidia,rx-clk-tap-delay: Delays the clock coming in from the external device
> +  with this tap value. This property is used to adjust the Tegra SPI master
> +  clock with respect to the data from the SPI slave device.

Are there units? What's the range of values.

>  
>  Example:
>  
> @@ -45,4 +51,14 @@ spi@7000d600 {
>  	reset-names = "spi";
>  	dmas = <&apbdma 16>, <&apbdma 16>;
>  	dma-names = "rx", "tx";
> +
> +	<spi-client>@<bus_num> {
> +		...
> +		...
> +		nvidia,cs-setup-clk-count = <10>;
> +		nvidia,cs-hold-clk-count = <10>;
> +		nvidia,rx-clk-tap-delay = <0>;
> +		nvidia,tx-clk-tap-delay = <16>;
> +		...
> +	};
>  };
> -- 
> 2.7.4
> 


