Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B985AC32774
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916B8217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 08:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569574456;
	bh=m7xRihjqmTbUYotke/BMvoBlp2gj5PP0jUiuRNmbWoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DYHj9v7C6ryWwEgKoqi4hNNqQ/vXt1kOKpq5uEei2s7t8pixSLCjeIVapbjrsf1CX
	 dKcjdrfRIPA2hiivqVjfQk8XaC6uxP1vwkAV+jSBgn1uH6G1Yd/UBoIBljxqkfJjg2
	 6bLkDFFpXzhfsJ7AffGEiQIKluaHQZXYAzthopMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfI0IyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 04:54:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39745 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfI0IyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 04:54:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so1774019wrj.6;
        Fri, 27 Sep 2019 01:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YW69Gs/nZumApetQocA64F9f6OkcL5o8Z3LcVdigjvc=;
        b=rCJ9PS1DXGNWZMIOYIPNeGsw2OIqoxdHgSWa3nN1Y4lHXBpaPz7aljO3XtKFfklxXs
         UZTjfzAuW/jOqBoHZy0PlPHbemU3Zmaj2nprs0Wi80JMsxC/9PREHW50naRMJq3lWj99
         mdsjwKaFXgFhPD/9OjjzMTQHmqKsvUPWahRmbgHSui3jS0YW0pYqg+E+hLLTuMpetxNZ
         MIy7liK2yISmzbNtVkaXZzPIqP8b4qPA3p92h11FZmY/iHzR7wlX4H7ZeQypsrGN0MjV
         DmPudK47p+cD448LfyxzALCLkrGvbl9sZfZaIpQDRnSmqdL45sHVzZnAg/cKB1gEcQdz
         o3IA==
X-Gm-Message-State: APjAAAU+d2F1lTU3wYIpA7FHsjpmo7tjX8JOeDWlSVPWuK0cgvh0Abjc
        /0GhZ4JuH8TdKDNCulOH3sQ=
X-Google-Smtp-Source: APXvYqw32zeeQTuvXuVsep+HUirogNC0QVZEqwyQa06udnJ+HOwPMSz7jgPC+e9bId+phk4DAB4dwg==
X-Received: by 2002:adf:f2cd:: with SMTP id d13mr2169788wrp.143.1569574452936;
        Fri, 27 Sep 2019 01:54:12 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id l6sm4346315wmg.2.2019.09.27.01.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 01:54:12 -0700 (PDT)
Date:   Fri, 27 Sep 2019 10:53:59 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, b.zolnierkie@samsung.com,
        kgene@kernel.org, mark.rutland@arm.com, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        robh+dt@kernel.org, willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH 1/3] ARM: dts: exynos: Add interrupt to DMC controller in
 Exynos5422
Message-ID: <20190927085359.GA19131@pi3>
References: <20190925161813.21117-1-l.luba@partner.samsung.com>
 <CGME20190925161842eucas1p271a9cf4f62b3d7af02c0a5d0d1eb9c4f@eucas1p2.samsung.com>
 <20190925161813.21117-2-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190925161813.21117-2-l.luba@partner.samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2019 at 06:18:11PM +0200, Lukasz Luba wrote:
> Add interrupt to Dynamic Memory Controller in Exynos5422 and Odroid
> XU3-family boards. It will be used instead of devfreq polling mode
> governor. The interrupt is connected to performance counters private
> for DMC, which might track utilisation of the memory channels.
> 
> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index ac49373baae7..72738e620d11 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -240,6 +240,8 @@
>  		dmc: memory-controller@10c20000 {
>  			compatible = "samsung,exynos5422-dmc";
>  			reg = <0x10c20000 0x100>, <0x10c30000 0x100>;
> +			interrupt-parent = <&combiner>;
> +			interrupts = <16 0>;

You register DMC for DREX0 and DREX1 but take only DREX0 interrupt. Why
skipping second?

Best regards,
Krzysztof


>  			clocks = <&clock CLK_FOUT_SPLL>,
>  				 <&clock CLK_MOUT_SCLK_SPLL>,
>  				 <&clock CLK_FF_DOUT_SPLL2>,
> -- 
> 2.17.1
> 
