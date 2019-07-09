Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F398EC606CF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78E62166E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 02:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562639600;
	bh=aHb8HbIx9bnQUhTCf3Q60wJVw5EVNfkupevALW0uaVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kJ53xIhtzILfDUUYug38W59OJQrPU0NCwHEfNJXgCaDerTuK+RziJuHdmiop9ZvRS
	 RwSF11EGrqRrnaGjuK8K/2/kneKehiJ287ET62EBh0X0cdWgb15DdzOyBf8xHM5iGF
	 VuQTpYDwTtZkUfNi5V2ixYo857bhByrIbNE2rREc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGICdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 22:33:19 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35864 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfGICdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 22:33:19 -0400
Received: by mail-io1-f65.google.com with SMTP id o9so24291397iom.3;
        Mon, 08 Jul 2019 19:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rmiNZbfd1KHmv8w/p95hp/bTVqLfrNkOq2EtR4rd7qE=;
        b=MXMM4czF09bPIrkpSDuZlHLOeNu9lF9wqSmp2KOKVkEw7ZQX0p2JKqaw9JwKh0JVUI
         h/hxjZl8qlIt5njiDSwGElGgRsZb1qlmyxhqNvD8mjYefpB1Hp7voH5PhySNE/sDWVPP
         3n7A3pBLWfedX3WEjFnS4Jd6K+jSgmIQQgCYSu76XK9LamEayyWP4rPUEVJncT2ISXyp
         q47m5OnOvPXNXgHnaXuoLkIuIb8iLUMiD/rU2+ISI4ZKpiffsop47Yj3ll3kNBVRf6HT
         lqlzIu4JD2Ls5YZW29+6UiKuvebdfr5NdeeRJdou9ZtGhvMRZwpn845vGv3u166R6Eno
         h+pw==
X-Gm-Message-State: APjAAAW44N8LNQv1Lemf82CVeZUwluVlZ5bWiXTfqc6u55FR7pf61an9
        sXBgjgVEQgYnrJxm0dOSDw==
X-Google-Smtp-Source: APXvYqxpasfFmebFdYjmqzNOABCQJM3SIkh/b8el1fm7lZGEZU9+E5iAG05xTRNXfGYdtO8PYKXzZQ==
X-Received: by 2002:a5d:8508:: with SMTP id q8mr1172231ion.31.1562639598437;
        Mon, 08 Jul 2019 19:33:18 -0700 (PDT)
Received: from localhost ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id c14sm17398191ioa.22.2019.07.08.19.33.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 19:33:17 -0700 (PDT)
Date:   Mon, 8 Jul 2019 20:33:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dehui Sun <dehui.sun@mediatek.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        erin.lo@mediatek.com, weiyi.lu@mediatek.com
Subject: Re: [PATCH v1 2/2] arm64: dts: mt8183: add systimer0 device node
Message-ID: <20190709023316.GA2962@bogus>
References: <1560252534-11412-1-git-send-email-dehui.sun@mediatek.com>
 <1560252534-11412-3-git-send-email-dehui.sun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560252534-11412-3-git-send-email-dehui.sun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 07:28:54PM +0800, Dehui Sun wrote:
> Add systimer0 device node for MT8183.
> 
> Signed-off-by: Dehui Sun <dehui.sun@mediatek.com>
> ---
> This patch is based on the following patches:
> https://patchwork.kernel.org/cover/10962385/
> https://patchwork.kernel.org/patch/10983939/
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index c2749c4..ac3f87d 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -254,6 +254,15 @@
>  			clock-names = "spi", "wrap";
>  		};
>  
> +		systimer: systimer@10017000 {

timer@...

> +			compatible = "mediatek,mt8183-timer",
> +				     "mediatek,mt6765-timer";
> +			reg = <0 0x10017000 0 0x1000>;
> +			interrupts = <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_CLK13M>;
> +			clock-names = "clk13m";
> +		};
> +
>  		auxadc: auxadc@11001000 {
>  			compatible = "mediatek,mt8183-auxadc",
>  				     "mediatek,mt8173-auxadc";
> -- 
> 2.1.0
> 
