Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DCCC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92BB02146F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 19:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbfDKTDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 15:03:13 -0400
Received: from gloria.sntech.de ([185.11.138.130]:60928 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726588AbfDKTDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 15:03:13 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEeyZ-0001DH-Pa; Thu, 11 Apr 2019 21:03:07 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: Re: [PATCH] clk: rockchip: rk3288: Limit use of USB PHY clock to USB
Date:   Thu, 11 Apr 2019 21:03:07 +0200
Message-ID: <3787637.WUkDPpUsF8@diego>
In-Reply-To: <20190411175917.173566-1-mka@chromium.org>
References: <20190411175917.173566-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Am Donnerstag, 11. April 2019, 19:59:17 CEST schrieb Matthias Kaehlcke:
> The USB PHY clock can be configured as (grand) parent of uart0_sclk and
> sclk_gpu. It has been observed that UART0 doesn't work reliably in high
> speed mode with the PHY clock as input when certain USB devices are
> plugged to the USB HOST1 port (see https://crrev.com/c/320543).
> 
> Prefix the name of the PHY clock with a '.' in the non-USB muxes to
> effectively remove the clock as input from these muxes.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/clk/rockchip/clk-rk3288.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3288.c b/drivers/clk/rockchip/clk-rk3288.c
> index 5a67b7869960..677bc5485201 100644
> --- a/drivers/clk/rockchip/clk-rk3288.c
> +++ b/drivers/clk/rockchip/clk-rk3288.c
> @@ -200,8 +200,8 @@ PNAME(mux_aclk_cpu_src_p)	= { "cpll_aclk_cpu", "gpll_aclk_cpu" };
>  PNAME(mux_pll_src_cpll_gpll_p)		= { "cpll", "gpll" };
>  PNAME(mux_pll_src_npll_cpll_gpll_p)	= { "npll", "cpll", "gpll" };
>  PNAME(mux_pll_src_cpll_gpll_npll_p)	= { "cpll", "gpll", "npll" };
> -PNAME(mux_pll_src_cpll_gpll_usb480m_p)	= { "cpll", "gpll", "usbphy480m_src" };
> -PNAME(mux_pll_src_cpll_gll_usb_npll_p)	= { "cpll", "gpll", "usbphy480m_src", "npll" };
> +PNAME(mux_pll_src_cpll_gpll_usb480m_p)	= { "cpll", "gpll", ".usbphy480m_src" };
> +PNAME(mux_pll_src_cpll_gll_usb_npll_p)	= { "cpll", "gpll", ".usbphy480m_src", "npll" };

In general I like to have things like the clock-tree described fully
and let the kernel handle correct sourcing ... but:

As you write this seems like a systemic problem when just connecting
random peripherals can create unstable clock source frequencies,
so I tend to agree here ... but:

Can we please find a more "talking" name for this ... because as with the
above someone will find the "." and submit a fix for it ;-) .

So just name it "unstable_dummy" or so?


Heiko


