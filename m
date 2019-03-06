Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EFAC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FBE20684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 03:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="FYYSfh5g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bQRa1PTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfCFDjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 22:39:33 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:40333 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726430AbfCFDjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 22:39:32 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1F281248BE;
        Tue,  5 Mar 2019 22:39:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 05 Mar 2019 22:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=G
        YjBNwrDW72oFe3J/5T54p44LhDgXjwnG4cdTnCHyB8=; b=FYYSfh5gWTrL96YkZ
        mo+pj0LHU/vspEBNhvR0H18eMHWksgR5lUTU6Al5b+OkFCwXn2S5mcXSsK92+lVi
        RG2zWHFbJkrleEZCFLNYXWX1wwgv4u+Yfk7/DDwO/L8e6cZiE/k471CbtvgdgwzP
        ERbB3Bugb0sI74C3/+sicQhgIKR12ev22ZAsLqtzrPwBfn7wMPLfEclD8Xiu1OVX
        5QYA2uk1MOt+nbvZJNOwW/tHw2b12ojP40ErLimu8+d4eWnOZAh7jI357yL2fmXX
        W9hmjCGMEF/6mRhVkjqGseJG0jbOPOcOV1O2cegk2kjs63tpFJfP0IXL6bjYQlat
        pzqgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=GYjBNwrDW72oFe3J/5T54p44LhDgXjwnG4cdTnCHy
        B8=; b=bQRa1PTtmvGLy+aREpjGEHoCwuR6ThgxqeN/R+DGL+CM3qX8lkGzlnR0W
        bOcGhVJBk5rOvDH9DJM6v3GASojWUPJ8p3O+QAaojJO7ai3gCG2ZkxULvajDIkBk
        jwzX359GXeYLf0s/tjYhsfctlRpLqFY2qdrprzbtFocjMlcTSEBmHArPzliRfdg3
        tAQE71DfKGxaUBO9qFkVCFjGN8vOuqqs04wnaN0bBMqTFevg/qs9Led/OOEcsZbm
        K+l3U4sqF8MrK0nydVlXWVN5uGvCeG7x6gjTjYzsENzfI6LjNR3idQPbqLQK1Noh
        WM+qQxCKeyyIFKKH9hAHdgMm/Ae7Q==
X-ME-Sender: <xms:70B_XHFVBHdAs-ZyoY8SDaCeWDFjMQXEHvW2MaAC5MJDPJQMC5POFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrfeeggdeifecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:70B_XOv7_NpAg2J9ZeEeZzjdVueRWCKswryQOmYCZhG9lMJetSYECQ>
    <xmx:70B_XPQEdzt8qgZbIvSxDqXz6AIHF2Oho0CK7kp8jWYmLJ40ZxE0bQ>
    <xmx:70B_XAN4d4SlsteSJ4K-BaEBVtbjcZXVaZ6rS-cSuF91tnGHGnWFog>
    <xmx:80B_XLh-9WJaZwFEhoAy5GBSNPUDLwEpZKNtwqnYdmpsqCm8Svip0A>
Received: from [192.168.50.162] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id EDBB71033F;
        Tue,  5 Mar 2019 22:39:26 -0500 (EST)
Subject: Re: [PATCH v3 07/15] ARM: dts: sunxi: h3/h5: Add msgbox node
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20190302042951.53671-1-samuel@sholland.org>
 <20190302042951.53671-8-samuel@sholland.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <f1e7b836-412f-0d6c-c7cf-2c41c871758e@sholland.org>
Date:   Tue, 5 Mar 2019 21:39:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190302042951.53671-8-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/19 22:29, Samuel Holland wrote:
> The H3 and H5 SoCs contain a message box that can be used to send
> messages and interrupts back and forth between the ARM application CPUs
> and the ARISC coprocessor. Add a device tree node for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index a4c757c0b741..a42fd3f9739e 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -227,6 +227,16 @@
>  			#size-cells = <0>;
>  		};
>  
> +		msgbox: mailbox@1c17000 {
> +			compatible = "allwinner,sun8i-h3-msgbox",
> +				     "allwinner,sun6i-a31-msgbox";
> +			reg = <0x01c17000 0x1000>;
> +			clocks = <&ccu CLK_BUS_MSGBOX>;
> +			resets = <&ccu RST_BUS_MSGBOX>;
> +			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells = <2>;

This should be 1. And it was caught by the new DTB schema validation :)

> +		};
> +
>  		usb_otg: usb@1c19000 {
>  			compatible = "allwinner,sun8i-h3-musb";
>  			reg = <0x01c19000 0x400>;
> 

