Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F69CC2D0C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C49A2077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576050768;
	bh=yWpjNHnkidZj4XaFsdjcIZ5feaM3cE6pCFefziQeG0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M5zdq+QLOyc81NxDdrIiMKnIPA1Z1HQH7NECOGQef57hV2ro6HrQUPrhDtDrl8+rU
	 FESVu1hrNmcFr+mOnL90PClFEwFpyLmFj35NPBwDaPiHsy9pX8aW3m/MZa87AlVsqo
	 4T1kxVE+wKyo9oKoKKBBhDMtpeIP569d1IcyxQaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbfLKHwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 02:52:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLKHwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 02:52:45 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1ECC2077B;
        Wed, 11 Dec 2019 07:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576050765;
        bh=yWpjNHnkidZj4XaFsdjcIZ5feaM3cE6pCFefziQeG0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUZnEGVh5u/iue73k01w3n3v5Q9rLhXNFvIyOJ/roliTtfKaGRZrG8lOYjNmx2CUU
         8z+36AV72iM9C80RlQRAoAceH8b4viEOu0iNCWRRF0M3Sj68LVW4qvO3ZaOaqVK05z
         9dfdON/89bttS1TGysLwHmGomURmPj1jMOsYlLZw=
Date:   Wed, 11 Dec 2019 15:52:36 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] arm64: dts: ls1028a: fix reboot node
Message-ID: <20191211075235.GR15858@dragon>
References: <20191209184644.14057-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209184644.14057-1-michael@walle.cc>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 09, 2019 at 07:46:44PM +0100, Michael Walle wrote:
> The reboot register isn't located inside the DCFG controller, but in its
> own RST controller. Fix it.
> 
> Fixes: 8897f3255c9c ("arm64: dts: Add support for NXP LS1028A SoC")
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> 
> changes since v1:
>  - add fixes tag
>  - remove "ls1028a-rst" compatible string, because there is no actual
>    driver for it. It just use the syscon driver.
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 8b28fda2ca20..7825550b7cef 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -88,7 +88,7 @@
>  
>  	reboot {
>  		compatible ="syscon-reboot";
> -		regmap = <&dcfg>;
> +		regmap = <&rst>;
>  		offset = <0xb0>;
>  		mask = <0x02>;
>  	};
> @@ -178,6 +178,12 @@
>  			little-endian;
>  		};
>  
> +		rst: syscon@1e60000 {
> +			compatible = "syscon";
> +			reg = <0x0 0x1e60000 0x0 0x10000>;
> +			little-endian;
> +		};
> +
>  		scfg: syscon@1fc0000 {

Hmm, what is your base?  It doesn't apply to my branch.

Shawn

>  			compatible = "fsl,ls1028a-scfg", "syscon";
>  			reg = <0x0 0x1fc0000 0x0 0x10000>;
> -- 
> 2.20.1
> 
