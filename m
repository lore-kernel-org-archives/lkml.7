Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E989421916
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 21:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WhUpmVgf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfCUVIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:08:16 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40809 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCUVIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 17:08:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so5101552pfc.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 14:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZnKuQfZQljoLtW9rs4KMzPRbkPbxMYCi7CKnZlGcHJY=;
        b=WhUpmVgfokORW6/xnBblt0bjzLF2F84Voxbl2zslX/vU31wnJ8XbSCviDac1wBAVfX
         5w0BLKED1fPNk97NflzBit6jfoKzmOzlKscRiFqkWVLKasqpiblxFUT3v5FiOY3CuLLb
         L1oueeO0gNvhjlXKnS0d461yttkXNtH/XQeLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZnKuQfZQljoLtW9rs4KMzPRbkPbxMYCi7CKnZlGcHJY=;
        b=V4gXHFTKw0orIHHUoiqr/aF0SqO65bkaphg55Srnc040APMW2nqQBMego3+otSoigm
         EcT/I/sMeKgDDa+u1yvQePkn77risCTYs858x429dpfvS2UcCT9l1ZcKIFpFJuEoQYYS
         HfCELMGxAqVFk82ZYT/ZKYsJmcp77YxFIJUGuR+KRWZePOWgWruIwjMWnyKJem+jSKd/
         jZkithQILr5yEyN3/6TaLNx6Ko/YB64Zv0HQejDGffx8PNYVps3W42R5tNQvG9T+jKoT
         RzQ9ZZjJmRuSd/otL+13RWly2eW5i+VLlLLGd+GzYmarhRaNmg43cBd5QisqDKoQRxgb
         tI+Q==
X-Gm-Message-State: APjAAAXdmjE1m9DGCPvFrdMo2gLMwP1eQpUbtoaoCSAjgCkwxBoUjyn8
        g4SFDBX8EBVBMwjdNopodhmyZQ==
X-Google-Smtp-Source: APXvYqz/QN6zPYLl+E/1Q80lNqkbF9UNWuowfMxnnJr43njPaxr3KU1yIxQ0vXbzoot616vig/7iow==
X-Received: by 2002:a62:788e:: with SMTP id t136mr5271536pfc.249.1553202495053;
        Thu, 21 Mar 2019 14:08:15 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id y37sm9001827pgk.78.2019.03.21.14.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 14:08:14 -0700 (PDT)
Date:   Thu, 21 Mar 2019 14:08:13 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] ARM: dts: rockchip: Fix gpu opp node names for rk3288
Message-ID: <20190321210813.GR112750@google.com>
References: <20190320201402.114309-1-dianders@chromium.org>
 <20190320201402.114309-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190320201402.114309-2-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 01:14:00PM -0700, Douglas Anderson wrote:
> The device tree compiler yells like this:
>   Warning (unit_address_vs_reg):
>   /gpu-opp-table/opp@100000000:
>   node has a unit name, but no reg property
> 
> Let's match the cpu opp node names and use a dash.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  arch/arm/boot/dts/rk3288.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index e9f454248398..79cd3c53e737 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -1282,27 +1282,27 @@
>  	gpu_opp_table: gpu-opp-table {
>  		compatible = "operating-points-v2";
>  
> -		opp@100000000 {
> +		opp-100000000 {
>  			opp-hz = /bits/ 64 <100000000>;
>  			opp-microvolt = <950000>;
>  		};
> -		opp@200000000 {
> +		opp-200000000 {
>  			opp-hz = /bits/ 64 <200000000>;
>  			opp-microvolt = <950000>;
>  		};
> -		opp@300000000 {
> +		opp-300000000 {
>  			opp-hz = /bits/ 64 <300000000>;
>  			opp-microvolt = <1000000>;
>  		};
> -		opp@400000000 {
> +		opp-400000000 {
>  			opp-hz = /bits/ 64 <400000000>;
>  			opp-microvolt = <1100000>;
>  		};
> -		opp@500000000 {
> +		opp-500000000 {
>  			opp-hz = /bits/ 64 <500000000>;
>  			opp-microvolt = <1200000>;
>  		};
> -		opp@600000000 {
> +		opp-600000000 {
>  			opp-hz = /bits/ 64 <600000000>;
>  			opp-microvolt = <1250000>;
>  		};

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
