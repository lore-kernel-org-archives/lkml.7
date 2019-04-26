Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1271DC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3860206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556287831;
	bh=oBsX2N2WmFcQsLkCusFeRGkG4jUYmTL6DDFe9NP949w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RhAAlhbXTss4ygPp2q0N4DD7/EPU9lvgY5UMrNHa98DF9upEF6p77dMlCelEmR8ld
	 sg5CeOM3bmeq8y1AWsCg7hpq59LLJk6lyJV+gLOpOrtEwR7yM7WeZSlM1p5pIwL5Tl
	 SrEhP0CHGemuydmH8TgTIFfZVJKiNuDrM1UbECec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDZOKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:10:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34203 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfDZOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:10:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id v10so3052145oib.1;
        Fri, 26 Apr 2019 07:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8v9DH79LZGkh+kC4t48ObZxoaexvFW5xWdyB9L1ZiiY=;
        b=r6FSPcYzjheO764C3o5pX+HQoA+W7ATX827TH/c4u4XMIizSFq0r6ll6HQ62BZAd8t
         Kl9ec41Lo21UIDTE5I/acziMn0ZJmrCZe53ivWacQ0tYnBbfIzhuoxhBam7ks6jxoRjH
         OgHTMh4otj6lQEzJc7QVc3xF3Q2Ggx5FqDzKWALcqAJs44dppjPJuwvugMN9zvmvL29Z
         JakWtCr7sPsG94bYg82SKyKjnbwMeeujMAUN5qoFzYOCeMZ5ZR8YPriGxC0JoOodr+49
         8CPEyuWcRaTgNzzgXqkMAAidaD5XPUoJ3rgqJ6yOlfETmyLhZi6bORXGt6rO0OLQTu7B
         qHGg==
X-Gm-Message-State: APjAAAVpL56oQVKmLOTV1E1HHDbHvq9m5mGfqjnR+YFJgCoQnP9rwicw
        IRxAzZXeGg9OSTsvBr4aOA==
X-Google-Smtp-Source: APXvYqzep6Kpkuzni+CTxXftgX5vn9rtgx9vdMLHNbJl/akS2tn94vZEcsdpiJMSmV5sSqC7U+UubQ==
X-Received: by 2002:aca:dcc4:: with SMTP id t187mr7488561oig.3.1556287828943;
        Fri, 26 Apr 2019 07:10:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p205sm10213668oia.49.2019.04.26.07.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 07:10:28 -0700 (PDT)
Date:   Fri, 26 Apr 2019 09:10:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, akpm@linux-foundation.org,
        david@lechnology.com, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        thierry.reding@gmail.com, esben@haabendal.dk,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        patrick.havelange@essensium.com
Subject: Re: [PATCH v10 15/18] dt-bindings: counter: ftm-quaddec
Message-ID: <20190426141027.GA27110@bogus>
References: <cover.1554184734.git.vilhelm.gray@gmail.com>
 <c852a16f5828a7e651e710dc95b66a5622a454d0.1554184734.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c852a16f5828a7e651e710dc95b66a5622a454d0.1554184734.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 03:30:50PM +0900, William Breathitt Gray wrote:
> From: Patrick Havelange <patrick.havelange@essensium.com>
> 
> FlexTimer quadrature decoder driver.
> 
> Reviewed-by: Esben Haabendal <esben@haabendal.dk>
> Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../bindings/counter/ftm-quaddec.txt           | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> 
> diff --git a/Documentation/devicetree/bindings/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> new file mode 100644
> index 000000000000..4d18cd722074
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/counter/ftm-quaddec.txt
> @@ -0,0 +1,18 @@
> +FlexTimer Quadrature decoder counter
> +
> +This driver exposes a simple counter for the quadrature decoder mode.
> +
> +Required properties:
> +- compatible:		Must be "fsl,ftm-quaddec".

This needs an SoC specific compatible.

> +- reg:			Must be set to the memory region of the flextimer.
> +
> +Optional property:
> +- big-endian:		Access the device registers in big-endian mode.
> +
> +Example:
> +		counter0: counter@29d0000 {
> +			compatible = "fsl,ftm-quaddec";
> +			reg = <0x0 0x29d0000 0x0 0x10000>;
> +			big-endian;
> +			status = "disabled";

Don't show status in examples.

> +		};
> -- 
> 2.21.0
> 
