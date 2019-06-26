Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7E7C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB64D2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfFZQXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:23:45 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:37948 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:23:45 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 155F72753CB;
        Wed, 26 Jun 2019 17:23:43 +0100 (BST)
Date:   Wed, 26 Jun 2019 18:23:39 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     <bbrezillon@kernel.org>, <matthias.bgg@gmail.com>,
        <linux-i3c@lists.infradead.org>, <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <leilk.liu@mediatek.com>,
        <liguo.zhang@mediatek.com>, <xinping.qian@mediatek.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: i3c: Document MediaTek I3C master
 bindings
Message-ID: <20190626182339.0c6301a2@collabora.com>
In-Reply-To: <1561527388-4829-2-git-send-email-qii.wang@mediatek.com>
References: <1561527388-4829-1-git-send-email-qii.wang@mediatek.com>
        <1561527388-4829-2-git-send-email-qii.wang@mediatek.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 13:36:27 +0800
Qii Wang <qii.wang@mediatek.com> wrote:

> Document MediaTek I3C master DT bindings.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>
> ---
>  .../devicetree/bindings/i3c/mtk,i3c-master.txt     |   47 ++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> 
> diff --git a/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> new file mode 100644
> index 0000000..3fd4f17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/mtk,i3c-master.txt
> @@ -0,0 +1,47 @@
> +Bindings for MediaTek I3C master block
> +=====================================
> +
> +Required properties:
> +--------------------
> +- compatible: shall be "mediatek,i3c-master"
> +- reg: physical base address of the controller and apdma base, length of
> +  memory mapped region.
> +- reg-names: should be "main" for controller and "dma" for apdma.
> +- interrupts: interrupt number to the cpu.

Depending on the interrupt controller, each interrupt cell might
contain more than just the interrupt number.

> +- clocks: clock name from clock manager.

This property does not contain clock names but clk references.

> +- clock-names: must include "main" and "dma".
> +
> +Mandatory properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- #address-cells: shall be set to 3
> +- #size-cells: shall be set to 0
> +
> +Optional properties defined by the generic binding (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details):
> +
> +- i2c-scl-hz
> +- i3c-scl-hz
> +
> +I3C device connected on the bus follow the generic description (see
> +Documentation/devicetree/bindings/i3c/i3c.txt for more details).
> +
> +Example:
> +
> +	i3c0: i3c@1100d000 {
> +		compatible = "mediatek,i3c-master";
> +		reg = <0x1100d000 0x100>,
> +		      <0x11000300 0x80>;
> +		reg-names = "main", "dma";
> +		interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&i3c0_ck>, <&ap_dma_ck>;
> +		clock-names = "main", "dma";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		i2c-scl-hz = <100000>;
> +
> +		nunchuk: nunchuk@52 {
> +			compatible = "nintendo,nunchuk";
> +			reg = <0x52 0x80000010 0>;

reg is wrong here, should be

			reg = <0x52 0x0 0x10>;

While at it, can you send a patch to fix the example in the cadence
binding doc?

> +		};
> +	};

