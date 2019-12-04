Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0AC8C3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 911C420409
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 19:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575487963;
	bh=ne28C0RDZjeeVfqTsFNAVxvyneTG7Ah8xDOfsTR36pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sol75BUn3DFTEbZtpfP9UQbtHyrvu3Caw76uJtKflSwnSAryRCXKGjebzDPObt19d
	 Ax919+UkhCv942cAEsQrtR2Hc2S2tO/WrN8Ad7slgnbHkWXSa6STixd340eDhHpvHj
	 EVVWYL5p9AJ/CkKXC4YnU5E/4/PCLZ8V82lM9lV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbfLDTcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 14:32:42 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46207 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbfLDTcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 14:32:42 -0500
Received: by mail-oi1-f195.google.com with SMTP id a124so304849oii.13;
        Wed, 04 Dec 2019 11:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VIykNz8gTrjJYYcuHvCZ7rZIZIyIF9AyyoN6mQ8XTak=;
        b=Wx+Pthfb7oeHeq89StbB3kh4fgVgIAhdfUvZRN8RlQ3nSFp3e+i4CYA+yLzreDVrBa
         IoO/NP7PzWMxo2eZcIHE3jo+zDzh73XBgPVi+ZQBRy2I7DkK7tGLesVJgmOkCX0Fqzka
         d5BYSJ996yway/Ekb6mhyvDidYHlVjwfqcG33gAU7zK1wnC8q2kz2ryLn16LWbKjeLad
         m2zL/CDnByg4GIyLL6z13JRz6EXy6CjBYZGx7wq0NOeg5qFdFjSVazlT0WnRcM6s3wW1
         ag18iT6mAAF+5+b2xU1jjetGryiThx922mLrlGm+tjoZ0IFeRT8uI6/4YL2rJ50OO2Eq
         nzjA==
X-Gm-Message-State: APjAAAWbNIOb3JPCvd0Jv+UFQXD3DUHsQ6QRPZj3jrtfoiKfDpUoHPDN
        sj3GmOMt5e8pLpiOnQPGYw==
X-Google-Smtp-Source: APXvYqyL9rITgSoXHv8RFYgfyg9XG3viSLqSKUMigSf5Mv7C3OVPAyHFxBK3gRgkRj3Xsvy21/dcQw==
X-Received: by 2002:a54:4781:: with SMTP id o1mr3877662oic.117.1575487961356;
        Wed, 04 Dec 2019 11:32:41 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j25sm2483560otl.71.2019.12.04.11.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 11:32:40 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:32:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Akash Gajjar <akash@openedev.com>, Tom Cubie <tom@radxa.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: rockchip: Add VMARC RK3399Pro
 SOM binding
Message-ID: <20191204193240.GA6772@bogus>
References: <20191121141445.28712-1-jagan@amarulasolutions.com>
 <20191121141445.28712-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121141445.28712-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 07:44:41PM +0530, Jagan Teki wrote:
> VMARC RK3399Pro SOM is a standard SMARC SOM design with
> Rockchip RK3399Pro SoC, which is designed by Vamrs.
> 
> Since it is a standard SMARC design, it can be easily
> mounted on the supporting Carrier board. Radxa has
> suitable carrier board to mount and use it as a final
> version board.
> 
> Add dt-bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v2:
> - none
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 45728fd22af8..51aa458833a9 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -526,4 +526,9 @@ properties:
>          items:
>            - const: tronsmart,orion-r68-meta
>            - const: rockchip,rk3368
> +
> +      - description: Vamrs VMARC RK3399Pro SOM
> +        items:
> +          - const: vamrs,rk3399pro-vmarc-som

Why do you need this? You just override it in your dts files, so it is 
not really used. Perhaps the top-level should have all 3 compatibles? If 
so, then the schemas are wrong.

> +          - const: rockchip,rk3399pro
>  ...
> -- 
> 2.18.0.321.gffc6fa0e3
> 
