Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FD1C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FD520863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 13:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfCCNTs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 08:19:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41222 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbfCCNTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 08:19:48 -0500
Received: from p54b26aa0.dip0.t-ipconnect.de ([84.178.106.160] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h0R1p-0004tT-Iw; Sun, 03 Mar 2019 14:19:41 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: decrease rising edge time of UART2
Date:   Sun, 03 Mar 2019 14:19:40 +0100
Message-ID: <1623469.Hy6pdcMFRX@phil>
In-Reply-To: <20190303122705.27094-1-katsuhiro@katsuster.net>
References: <20190303122705.27094-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Sonntag, 3. März 2019, 13:27:05 CET schrieb Katsuhiro Suzuki:
> This patch increases drive strength of UART2 from 3mA to 12mA for
> getting more faster rising edge.
> 
> RockPro64 is using a very high speed rate (1.5Mbps) for UART2. In
> this setting, a bit width of UART is about 667ns.
> 
> In my environment (RockPro64 UART2 with FTDI FT232RL UART-USB
> converter), falling time of RockPro64 UART2 is 40ns, but riging time
> is over 650ns. So UART receiver will get wrong data, because receiver
> read intermediate data of rising edge.
> 
> Rising time becomes 300ns from 650ns if apply this patch. This is not
> perfect solution but better than now.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

your changing a core rk3399 property here, so I'd really like to get
input from other board stakeholders on this before applying a core
change.

Could you either include the submitters of other rk3399-boards in the
recipient list so that they're aware or limit the change to rockpro64 for
the time being (aka overriding the property in the board-dts) please?

Thanks
Heiko



> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index beaa92744a64..e3c8f91ead50 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -2000,6 +2000,11 @@
>  			drive-strength = <8>;
>  		};
>  
> +		pcfg_pull_up_12ma: pcfg-pull-up-12ma {
> +			bias-pull-up;
> +			drive-strength = <12>;
> +		};
> +
>  		pcfg_pull_up_18ma: pcfg-pull-up-18ma {
>  			bias-pull-up;
>  			drive-strength = <18>;
> @@ -2521,8 +2526,8 @@
>  		uart2c {
>  			uart2c_xfer: uart2c-xfer {
>  				rockchip,pins =
> -					<4 RK_PC3 RK_FUNC_1 &pcfg_pull_up>,
> -					<4 RK_PC4 RK_FUNC_1 &pcfg_pull_none>;
> +					<4 RK_PC3 RK_FUNC_1 &pcfg_pull_up_12ma>,
> +					<4 RK_PC4 RK_FUNC_1 &pcfg_pull_none_12ma>;
>  			};
>  		};
>  
> 




