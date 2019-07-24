Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1C4C76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DA722387
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 17:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563988255;
	bh=vdkk2/b0N62X+tTd6omCicQmUyxpTs+pH9nOGJLx+MA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X0uJT4GNEqSnCbekykg1PODoeuoCD4zecTuGazQKzLyqhC/i3VK2meh3eH92yqkI3
	 lxp2V+qiSA/bTjnJZmQU9FEYMbtc9o5CB9hmNqSDsdNGJ69/8NVOhFJ9/zUhpxfe8R
	 8RbR8s2yvjptxBLD1pYP4VQ69khrSyX1ZoLv4168=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbfGXRKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 13:10:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35967 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfGXRKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:10:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so47882748wrs.3;
        Wed, 24 Jul 2019 10:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WXZ1g7GkxFmyDSWuDgpIVN7PNvx6qdlx90diYuseAHM=;
        b=OxcpcrsB+Nh2xELyiA1Yv99FUMYEvIzlG+yG6yit/9f+ygFbVXl643sfdbjfTELuxq
         idsz3sFggjLg/Gg6NF+dJf2rjjIRxeqPZ5MDsKX1ZrRlC4uObhXX86heyKh95Wkodj1v
         U4WUJ7pn/cEGUy5B5uC2ApCHw4MAEq+lXuXA+rMOTNcVtDEAwKk6NUb1f1FN3r/AIsc8
         ydWZ8mnHClDLJXGMtD/8V6agsp4T0+iwtYvMAjPnf2irlIjEZitUM59y9ZDzfCsL2+Qn
         OPFMhSkgXvUBr7kctdng2R97yfAlcf3Qmp7mL9KGMN6Xx8w/c8vAMK5xFNQHkZNZVGJh
         eLWw==
X-Gm-Message-State: APjAAAVD+MFvB6sQcMX6EAM6DmggUnFOkh3csKTByiHJ7qYFVClzvfqa
        1NesBTuV8WdHIkf0Yv4Ae+k=
X-Google-Smtp-Source: APXvYqw3AXAnk2BJ//1eeyPDtP4kO0/8LrlqA6LpAN1k2ctyqioKAHYzmf7hgtsMo7drCGHj11qc2Q==
X-Received: by 2002:adf:da4d:: with SMTP id r13mr57744544wrl.281.1563988252192;
        Wed, 24 Jul 2019 10:10:52 -0700 (PDT)
Received: from kozik-lap ([194.230.155.239])
        by smtp.googlemail.com with ESMTPSA id n9sm88609422wrp.54.2019.07.24.10.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jul 2019 10:10:51 -0700 (PDT)
Date:   Wed, 24 Jul 2019 19:10:49 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lukasz Luba <l.luba@partner.samsung.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, b.zolnierkie@samsung.com, kgene@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, cw00.choi@samsung.com,
        kyungmin.park@samsung.com, m.szyprowski@samsung.com,
        s.nawrocki@samsung.com, myungjoo.ham@samsung.com,
        keescook@chromium.org, tony@atomide.com, jroedel@suse.de,
        treding@nvidia.com, digetx@gmail.com, gregkh@linuxfoundation.org,
        willy.mh.wolff.ml@gmail.com
Subject: Re: [PATCH v12 6/9] ARM: dts: exynos: add chipid label and syscon
 compatible
Message-ID: <20190724171049.GA11333@kozik-lap>
References: <20190722094646.13342-1-l.luba@partner.samsung.com>
 <CGME20190722094730eucas1p2f3f8298c43c8bf0d96135bca9a9e753b@eucas1p2.samsung.com>
 <20190722094646.13342-7-l.luba@partner.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190722094646.13342-7-l.luba@partner.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:46:43AM +0200, Lukasz Luba wrote:
> Add the chipid label which allows to use it in phandle from other device.
> Use syscon in compatible to get the regmap of the device register set.
> The chipid is used in DMC during initialization to compare compatibility.
> 

I cannot find its usage in DMC driver.

Best regards,
Krzysztof


> Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
> ---
>  arch/arm/boot/dts/exynos5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
> index 67f9b4504a42..4801ca759feb 100644
> --- a/arch/arm/boot/dts/exynos5.dtsi
> +++ b/arch/arm/boot/dts/exynos5.dtsi
> @@ -35,8 +35,8 @@
>  		#size-cells = <1>;
>  		ranges;
>  
> -		chipid@10000000 {
> -			compatible = "samsung,exynos4210-chipid";
> +		chipid: chipid@10000000 {
> +			compatible = "samsung,exynos4210-chipid", "syscon";
>  			reg = <0x10000000 0x100>;
>  		};
>  
> -- 
> 2.17.1
> 
