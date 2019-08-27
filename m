Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99762C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCFE2189D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfH0O2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:28:39 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35112 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfH0O2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:28:39 -0400
Received: from c-73-71-116-68.hsd1.ca.comcast.net ([73.71.116.68] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i2cSP-0002Ds-GB; Tue, 27 Aug 2019 16:28:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Elon Zhang <zhangzj@rock-chips.com>
Cc:     mark.rutland@arm.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v1 1/1] ARM: dts: rockchip: set crypto default disabled on rk3288
Date:   Tue, 27 Aug 2019 16:28:21 +0200
Message-ID: <4806912.UyKsYhR33o@phil>
In-Reply-To: <20190827071439.14767-1-zhangzj@rock-chips.com>
References: <20190827071439.14767-1-zhangzj@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 27. August 2019, 09:14:39 CEST schrieb Elon Zhang:
> Not every board needs to enable crypto node, so the node should
> be set default disabled in rk3288.dtsi and enabled in specific
> board dts file.

Can you give a bit more rationale here? There would need to be a very
specific reason because of the following:

The crypto module is not wired to some board-specific components,
so its usability does not depend on the specific board at all.
Instead every board can just use it out of the box and the devicetree
is supposed to describe the hardware and is _not_ meant as a space
for user configuration.

So in fact the status property should probably go away completely from
the crypto node, as it's usable out of the box in all cases.


Heiko



> Signed-off-by: Elon Zhang <zhangzj@rock-chips.com>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index cc893e154fe5..d509aa24177c 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -984,7 +984,7 @@
>  		clock-names = "aclk", "hclk", "sclk", "apb_pclk";
>  		resets = <&cru SRST_CRYPTO>;
>  		reset-names = "crypto-rst";
> -		status = "okay";
> +		status = "disabled";
>  	};
>  
>  	iep_mmu: iommu@ff900800 {
> 




