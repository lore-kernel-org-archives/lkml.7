Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE00EC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B1F2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 03:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575863200;
	bh=4oeu8cyoVaTnaC9rYcfi4Uf0bow8pY1/IorMe2It3U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bjCnMozPWaEX7e0B5xx0fY4UuX1H7VjFWcarmpoxRo7O347gon1Ew+4NKtiGO1RW6
	 +r6VbQIBDEpGs5d0/eMh5qcBmck+oXDS/lRXZmee2mP39XqhythD8Ve/LtZuP9YQHk
	 l+caf61NbQhi6a6XSv7qFRumcJIyEup4EeXRbzx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbfLIDqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 22:46:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfLIDqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 22:46:39 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C21F720663;
        Mon,  9 Dec 2019 03:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575863199;
        bh=4oeu8cyoVaTnaC9rYcfi4Uf0bow8pY1/IorMe2It3U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mIHZZlNt+roCRKMRD6h+PUC5L6mZEPFDrPhIOzwMzI7PLb8PlIvESDxCHn9RTAr+E
         T77O33PHVBOOmyRMwdYxR3ArojpF0+ouVvT0ScSb4/vfUWSanTpS/osziVivoiVwv2
         m0pQBU+Oj04vTHVbSsMAaZ7p83BVqm/D+mlHXF2o=
Date:   Mon, 9 Dec 2019 11:46:25 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>, Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: dts: ls1028a: fix reboot node
Message-ID: <20191209034624.GY3365@dragon>
References: <20191123000709.13162-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191123000709.13162-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 23, 2019 at 01:07:09AM +0100, Michael Walle wrote:
> The reboot register isn't located inside the DCFG controller, but in its
> own RST controller. Fix it.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Do we need a Fixes tag?

@Leo, looks good to you?

Shawn

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 72b9a75976a1..dc75534a4754 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -102,7 +102,7 @@
>  
>  	reboot {
>  		compatible ="syscon-reboot";
> -		regmap = <&dcfg>;
> +		regmap = <&rst>;
>  		offset = <0xb0>;
>  		mask = <0x02>;
>  	};
> @@ -161,6 +161,12 @@
>  			big-endian;
>  		};
>  
> +		rst: syscon@1e60000 {
> +			compatible = "fsl,ls1028a-rst", "syscon";
> +			reg = <0x0 0x1e60000 0x0 0x10000>;
> +			little-endian;
> +		};
> +
>  		scfg: syscon@1fc0000 {
>  			compatible = "fsl,ls1028a-scfg", "syscon";
>  			reg = <0x0 0x1fc0000 0x0 0x10000>;
> -- 
> 2.20.1
> 
