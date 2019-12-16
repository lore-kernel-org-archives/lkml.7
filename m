Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8815CC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61ED920725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 10:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfLPKEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 05:04:14 -0500
Received: from gloria.sntech.de ([185.11.138.130]:55064 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727132AbfLPKEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 05:04:14 -0500
Received: from wf0651.dip.tu-dresden.de ([141.76.182.139] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1ignEW-0007L8-VS; Mon, 16 Dec 2019 11:04:08 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hugh Cole-Baker <sigmaris@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH v3] arm64: dts: rockchip: split rk3399-rockpro64 for v2 and v2.1 boards
Date:   Mon, 16 Dec 2019 11:04:08 +0100
Message-ID: <6656576.A7zHEAv81k@phil>
In-Reply-To: <20191202055929.26540-1-katsuhiro@katsuster.net>
References: <20191202055929.26540-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Katsuhiro,

Am Montag, 2. Dezember 2019, 06:59:29 CET schrieb Katsuhiro Suzuki:
> This patch splits rk3399-rockpro64 dts file to 2 files for v2 and
> v2.1 boards.
> 
> Both v2 and v2.1 boards can use almost same settings but we find a
> difference in I2C address of audio CODEC ES8136.
> 
> Reported-by: Vasily Khoruzhick <anarsoul@gmail.com>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> ---
> 
> Changes in v3:
>   - Add compatible strings for v2.0 and v2.1 boards
> 
> Changes in v2:
>   - Use rk3399-rockpro64.dts for for v2.1 instead of creating
>     rk3399-rockpro64-v2.1.dts
> ---
>  .../devicetree/bindings/arm/rockchip.yaml     |   2 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3399-rockpro64-v2.dts |  30 +
>  .../boot/dts/rockchip/rk3399-rockpro64.dts    | 759 +----------------
>  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 763 ++++++++++++++++++
>  5 files changed, 800 insertions(+), 755 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64-v2.dts
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index d9847b306b83..8d8658613c57 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -409,6 +409,8 @@ properties:
>  
>        - description: Pine64 RockPro64
>          items:
> +          - const: pine64,rockpro64-v2.1
> +          - const: pine64,rockpro64-v2.0
>            - const: pine64,rockpro64
>            - const: rockchip,rk3399
>  

applied for 5.6 with a changed binding. If you need a
"one-of-many" element it should use an enum ... see the rk3399-firefly
and other boards for example. So I've adapted the patch accordingly:

@@ -409,6 +409,9 @@ properties:
 
       - description: Pine64 RockPro64
         items:
+          - enum:
+              - pine64,rockpro64-v2.1
+              - pine64,rockpro64-v2.0
           - const: pine64,rockpro64
           - const: rockchip,rk3399
 

Heiko


