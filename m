Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B22BC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E37208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 18:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZWZUGjja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfEMSj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 14:39:28 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39323 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbfEMSj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 14:39:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id g9so6903964plm.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 11:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OHoX7oCDIxtnl3NxtTVvKViiqkZglgOas/g1Rubunpw=;
        b=ZWZUGjjawgSeblVhgOyDlCAGehMU/Z0twGz6rujUUg+RLiCUzlrAnTLFcPy3TgWvfU
         Fd0UT+okOXosraWP4hGiz8yB04ZmpU2BsxQRd46mO6PNoqx9TsGDiJEtV4lxbPJ36ex/
         undy3vtilTIBNn4Y4yuefGrOfxV+XQhh2dKnvDf9hnscJrHAnjVSeALFFT+AMWCW4Y9h
         Jhu6wF0JwP2e1KmW5KLrnrbFPn19cVSLTD1kKx3wOx8Ofp+KpQZsBdtHK9Ql00vuWihH
         LExnK/hNrae/YOtkyv7dzAx+3QR52XAF+I8RMbJoQndRs6tFofXaU4Z4yETkZJkd1BhX
         e9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OHoX7oCDIxtnl3NxtTVvKViiqkZglgOas/g1Rubunpw=;
        b=gurbGCvhB3GVoFM1hFPY/IYwKa7V7zTUrKAkcvIljyJxlmsRxKYawF8GTxEdYsfrnC
         wYG0P6u95paw3PuvOqam+ajFIOklHh10VBCUwqHw7HdjzC2GOnxYK4IK/9NQIcxDfYdg
         I/MBo4JG4X3lUWZbdnTORbGY2cUY9rcLcgEbpI27IppT0C7sUORWrYuXNSg2Qtd34bvL
         GxK14jE4x0WLw7Nb10xmzIf4uL3PgXHIOdlIKZMF8apokoo3NOCwp3S9JaQtFjxjoHtT
         FWQoFUs0GleZM2cwOh1vrn8CZH3HlwZQc2I+wPq8b9nGjSzobKLo3SSQQmmHXUEgXsdK
         yKKA==
X-Gm-Message-State: APjAAAWGPB1S7O+TC70OLBEAm/5oxR+6hBIPDoAY8nY+av0KXADBXErB
        iLPOP2sxhTQnSCf79Kj7C+WO1w==
X-Google-Smtp-Source: APXvYqynr2g6ljNTN5TU7b36goVbopwPwI4vVSq9IFQfsOzsCc5jpeiEx5UIY/EXqC5dgrtP7joR6w==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91mr16401267plb.300.1557772766932;
        Mon, 13 May 2019 11:39:26 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b23sm5116335pfi.6.2019.05.13.11.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 11:39:26 -0700 (PDT)
Date:   Mon, 13 May 2019 11:39:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        andy.gross@linaro.org, David Brown <david.brown@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv1 1/8] arm64: dts: Fix various entry-method properties to
 reflect documentation
Message-ID: <20190513183947.GJ2085@tuxbook-pro>
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

On Fri 10 May 04:29 PDT 2019, Amit Kucheria wrote:

Subject indicates pluralism, but this fixes a specific platform
(board?). I think you should update that.

> The idle-states binding documentation[1] mentions that the
> 'entry-method' property is required on 64-bit platforms and must be set
> to "psci".
> 
> We fixed up all uses of the entry-method property in
> commit e9880240e4f4 ("arm64: dts: Fix various entry-method properties to
> reflect documentation"). But a new one has appeared. Fix it up.
> 
> Cc: Sudeep Holla <sudeep.holla@arm.com>

The message looks good though, so with a new subject you have my:

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

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
