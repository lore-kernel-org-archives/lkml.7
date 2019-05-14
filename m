Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F6DC04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAC520863
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEV45d52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbfENQLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:11:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37366 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfENQLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:11:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id q17so1833688lfo.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=79OCTNk458byBS2H3Xt0sE1+KJDhnYCsFyQ7h5W7n7w=;
        b=rEV45d52FtweB9bt6szB4ocHbp9e/OFDripRbyALASst+32ezBZgc9ZQa9pOVQkL1A
         L0DxpCJVbFC36R+TXLsFNjOX0MARBsJcPrC9gDqBL70Gy2LQ5PThRWGt5k1jFqLg8tfz
         xL1Pu2dxruYOFf1S1pjMiPx3P9gZzs7jKL70DZdRMFqwtxoAhmCrmYmE5+za2E4YjjyR
         SwYld9BX/B0E6O8aQmBaemGdb3gFJ7wKTT5rYm6hDogI81VKNyZcp5c4pFgFLtXKUY9o
         BRjOYI72AtYR/DFo3zNXYrJmGPZ7bq0lJWhylHd6EEok0J8IIOGhmoefLXWUbj5a69d4
         Ygwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=79OCTNk458byBS2H3Xt0sE1+KJDhnYCsFyQ7h5W7n7w=;
        b=CDhwUMJDocnlFRFZ8zR1dwXHSy2354cxFz1T2laZz7g/BTNS3LFEdbHx+4XoQBILQU
         MNLI9f5TFGgvrTRwnH4GGco9/vq9ymDueJoDY/L6vTNgiHbYzZ/R11ts91Q1oYD5m9fO
         HSz7X4fSYgLCxGyYblmrA8QwDQ2WvxRPEKR3mvP5KcftySzU1pEiqz5Mc860ULhNe9eT
         buKu24irxp9ww588kmd6J1clOWcgWNKZrFzi8jK1pnozySoQW3A8e8App+9c/rF8c3Sl
         HG12uDu0qd1i06vCK9es2sSJckMLIoXD7olzXCsQOi9Duw5JSahTbN6uZEzpsApHIU9T
         NZZA==
X-Gm-Message-State: APjAAAUD0LtqqbnmIpkIy5++O1psSvvRT/bvycFs7O+IglKcLlRhn4N1
        z5yDYWSuLfvj7363lPXpxGMMSA==
X-Google-Smtp-Source: APXvYqyi7e9TjI8XPxrwpktl3EJ2JyOz0p4Se1vjd3AUZyBeZPecL5wHHXSzDB/JwQyEV0EZ41oNRA==
X-Received: by 2002:ac2:4479:: with SMTP id y25mr17316963lfl.95.1557850298941;
        Tue, 14 May 2019 09:11:38 -0700 (PDT)
Received: from centauri.ideon.se ([85.235.10.227])
        by smtp.gmail.com with ESMTPSA id l14sm3850033lfc.61.2019.05.14.09.11.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 14 May 2019 09:11:37 -0700 (PDT)
Date:   Tue, 14 May 2019 18:11:35 +0200
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, andy.gross@linaro.org,
        David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv1 1/8] arm64: dts: Fix various entry-method properties to
 reflect documentation
Message-ID: <20190514161135.GA1824@centauri.ideon.se>
References: <cover.1557486950.git.amit.kucheria@linaro.org>
 <ab5bad0258e455ef84059b749ca9e79f311b5e3c.1557486950.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab5bad0258e455ef84059b749ca9e79f311b5e3c.1557486950.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 04:59:39PM +0530, Amit Kucheria wrote:
> The idle-states binding documentation[1] mentions that the

This [1] reference is a null pointer ;)

Other than that:
Reviewed-by: Niklas Cassel <niklas.cassel@linaro.org>

> 'entry-method' property is required on 64-bit platforms and must be set
> to "psci".
> 
> We fixed up all uses of the entry-method property in
> commit e9880240e4f4 ("arm64: dts: Fix various entry-method properties to
> reflect documentation"). But a new one has appeared. Fix it up.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 2896bbcfa3bb..42e7822a0227 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -51,7 +51,7 @@
>  		 * PSCI node is not added default, U-boot will add missing
>  		 * parts if it determines to use PSCI.
>  		 */
> -		entry-method = "arm,psci";
> +		entry-method = "psci";
>  
>  		CPU_PH20: cpu-ph20 {
>  			compatible = "arm,idle-state";
> -- 
> 2.17.1
> 
