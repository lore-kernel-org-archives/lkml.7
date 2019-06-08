Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E261C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10216214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 13:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkK7jUNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfFHNEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 09:04:55 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36966 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfFHNEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 09:04:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id 20so2606806pgr.4;
        Sat, 08 Jun 2019 06:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8Ya1o7hhHocdfUGkwSQa9Us1KpqtbBriW+VXdzuGQk=;
        b=YkK7jUNgGVVkZQu6CN2ro5kXiPOm55Koi65N+e63Nk1jeQHuB9FrgTxkFWU06/7kZ6
         rIFzAkGp/7pjO4FUbWrQmw6gnsKiLLk9kpFDOlwSblEcEZbQObVJGuO/EUFBMmfHpyJ1
         p3ZOEo4IGa9jac2tpr6iWIEemUI4K6X953EiM9qbEA6yV2y3TNmMzX7jVnFp08r37mYN
         K7/iza1lowAnvxxiM8Ygy1tqbznI3VtKBd2+zUrjzAp9kRKnlPm5vQ6lG5A8XtJiywvR
         WpVa2LrShvhacagMlJwhyR73FQuMRjB8svBHXIyTYhnoxwsJTTmQ2RjdEb7hXkghSilu
         CasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8Ya1o7hhHocdfUGkwSQa9Us1KpqtbBriW+VXdzuGQk=;
        b=f6j6+lgLVYRPQeGXtpef6yZQw6nxnENMngboPLFH78+/sv0PPqs3khoeqFWmREEYPT
         TlE55ld7e7+xheQxj6ac+6EeByJXOMRUd3NgM5j46PP3twHfoTkwnsFY1kpNg/V1Q5E8
         SlI2LuLgEXUpJhnRltDEUJ00GdxeKJ/jN8GVt/Wtdq0DqcFsgB1sAQKkTfB26Ho1+ln6
         TmcjZuaw9zm9VgzF4mWfAepXKfxDPE8/CR2xpen8oQZR3g72Nf5VDXarzz2oWdm3BUQB
         D5WQrbHYd74Gx+AzETkAPj9YVJjDgykdXtJnc2w+j9/1vzPKGIHh0PKM4KXKUBb8a3vb
         dD9Q==
X-Gm-Message-State: APjAAAV/r0UmasSXbGUqszzxmsvyD5bbw/BZLSE9bpolx1TosAFDXK4S
        z1shoy4NkxlgiaU/K0GyiZc=
X-Google-Smtp-Source: APXvYqzaSSwafnMqzsoKd0z9DI5JL4+Rdt6pOO14OK6m1H70Ndr0j/nT4mOEqzMp2/NOC7C37xtK0A==
X-Received: by 2002:a62:7d13:: with SMTP id y19mr6104431pfc.62.1559999094113;
        Sat, 08 Jun 2019 06:04:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q125sm8246038pfq.62.2019.06.08.06.04.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 06:04:53 -0700 (PDT)
Date:   Sat, 8 Jun 2019 06:04:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Anson.Huang@nxp.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        ulf.hansson@linaro.org, peng.fan@nxp.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4 RESEND 1/3] dt-bindings: watchdog: move i.MX system
 controller watchdog binding to SCU
Message-ID: <20190608130452.GA22130@roeck-us.net>
References: <20190527070317.16904-1-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527070317.16904-1-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 03:03:15PM +0800, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
> 
> i.MX system controller watchdog depends on SCU driver to support
> interrupt function, so it needs to be subnode of SCU node in DT,
> binding doc should be moved to fsl,scu.txt as well.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> No changes, just rebase the patch to top of linux-next.
> ---
>  .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 15 ++++++++++++++
>  .../bindings/watchdog/fsl-imx-sc-wdt.txt           | 24 ----------------------
>  2 files changed, 15 insertions(+), 24 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index f378922..a575e42 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -145,6 +145,16 @@ Optional Child nodes:
>  - Data cells of ocotp:
>    Detailed bindings are described in bindings/nvmem/nvmem.txt
>  
> +Watchdog bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be:
> +              "fsl,imx8qxp-sc-wdt"
> +              followed by "fsl,imx-sc-wdt";
> +Optional properties:
> +- timeout-sec: contains the watchdog timeout in seconds.
> +
>  Example (imx8qxp):
>  -------------
>  aliases {
> @@ -207,6 +217,11 @@ firmware {
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		watchdog {
> +			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> +			timeout-sec = <60>;
> +		};
>  	};
>  };
>  
> diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt b/Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt
> deleted file mode 100644
> index 02b87e9..0000000
> --- a/Documentation/devicetree/bindings/watchdog/fsl-imx-sc-wdt.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -* Freescale i.MX System Controller Watchdog
> -
> -i.MX system controller watchdog is for i.MX SoCs with system controller inside,
> -the watchdog is managed by system controller, users can ONLY communicate with
> -system controller from secure mode for watchdog operations, so Linux i.MX system
> -controller watchdog driver will call ARM SMC API and trap into ARM-Trusted-Firmware
> -for watchdog operations, ARM-Trusted-Firmware is running at secure EL3 mode and
> -it will request system controller to execute the watchdog operation passed from
> -Linux kernel.
> -
> -Required properties:
> -- compatible:	Should be :
> -		"fsl,imx8qxp-sc-wdt"
> -		followed by "fsl,imx-sc-wdt";
> -
> -Optional properties:
> -- timeout-sec : Contains the watchdog timeout in seconds.
> -
> -Examples:
> -
> -watchdog {
> -	compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> -	timeout-sec = <60>;
> -};
