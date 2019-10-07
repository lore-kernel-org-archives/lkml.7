Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4770AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D8C20684
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 16:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbfJGQQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 12:16:39 -0400
Received: from muru.com ([72.249.23.125]:35650 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbfJGQQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 12:16:38 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5B2E580A5;
        Mon,  7 Oct 2019 16:17:11 +0000 (UTC)
Date:   Mon, 7 Oct 2019 09:16:34 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Emmanuel Vadot <manu@freebsd.org>
Cc:     bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: Set status to disable for MMC3
Message-ID: <20191007161634.GS5610@atomide.com>
References: <20191007080339.57209-1-manu@freebsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007080339.57209-1-manu@freebsd.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Emmanuel Vadot <manu@freebsd.org> [191007 08:04]:
> Commit 5b63fb90adb95 ("ARM: dts: Fix incomplete dts data for am3 and am4 mmc")
> fixed the mmc instances on the l3 interconnect but removed the disabled status.
> Fix this and let boards properly define it if it have it.

The dts default is "okay", and should be fine for all the
internal devices even if not pinned out on the board. This
way the devices get properly idled during boot, and we
avoid repeating status = "enabled" over and over again in
the board specific dts files.

Then the board specific dts files might want to configure
devices with status = "disabled" if really needed. But this
should be only done for devices that Linux must not use,
such as crypto acclerators on secure devices if claimed by
the secure mode.

So if this fixes something, it's almost certainly a sign
of something else being broken?

Regards,

Tony


> Fixes: 5b63fb90adb95 ("ARM: dts: Fix incomplete dts data for am3 and am4 mmc")
> Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index fb6b8aa12cc5..b3a1fd9e39fa 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -260,6 +260,7 @@
>  				ti,needs-special-reset;
>  				interrupts = <29>;
>  				reg = <0x0 0x1000>;
> +				status = "disabled";
>  			};
>  		};
>  
> -- 
> 2.22.0
> 
