Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D244BC282CE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F26206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 01:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="boT0MTed";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHnOcozc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfFEBbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 21:31:36 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36559 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726530AbfFEBbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 21:31:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 42D9B2210C;
        Tue,  4 Jun 2019 21:31:35 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Tue, 04 Jun 2019 21:31:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=/EWPTD+qPhbo26yslb0jEUCcDXDMMu1
        NnNiOXIfrmYs=; b=boT0MTedmWfzg2/ZwHtHcIzKC88eMJIH1TBFvYMWGGyp2k7
        LWPB/f+rs4b64hobSCMp0hEKoxurYgVnn2tDiBoAyDx0lGX3k3ifyBjmw83Sjc7H
        XC69+6x+vNq0sAWcOjiITwhfJmD07+oM7uktT6iKtt1Edbi6H3/vuzwFL8KqsZIB
        EoBUuEnKzQelyDOy+QTQQyWju7pG3xnnfGgifn+sWohI820PQnO7e8A0AuFKIiz8
        gkxrOCAzxj1C+U9ZPF4Gug29Vdsn/TWj5s+Esv1LZ7AtC96omHcFiMkI3+EVt4kc
        Ef+CzW4BlVYoeHjTZZSupK1yUEXPD06O55eSqOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/EWPTD
        +qPhbo26yslb0jEUCcDXDMMu1NnNiOXIfrmYs=; b=nHnOcozcPFEf9vG5q6SnWj
        YZSn4aKnrJxEFBYwWWSoegyN1r1P0tSrIBxpNXo28A8B2AvD3sMQKNjlBHvXE0vF
        0yaM+RaFdqp2a9GFDOrgjQe629+RihqbMQhPdZA+fzjooUgBKicz64A3wa1S4MHE
        2cWzsyZXOxbsJV4AV4kh4qlDQTLweAQOxQ/q4U225hek9hQcSFHGvhiUafzwQz1a
        Lgvvlx4OxyEavLvDnh5YGHHD8s8BIQSkHcW+cwhC1+1RDCPMDDz1SVVzaKgA6QpR
        vHuwgWmrvnjiVbI0iGw0QVTBuhUiz1V0tgvD94kL7OpBQrH00Y4FCSlbZjbI/n0w
        ==
X-ME-Sender: <xms:dxv3XLLTDJYG3VKEMWs3peYBBm4nBR81-bZeQS_uXgUtFJ5tXL6luA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeguddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:dxv3XLxaXCrBaekgEdwOU76V4Zn0iJNmAf4JDTx1ZRCtYPhAFHRJNg>
    <xmx:dxv3XKHvR1RCQT7lVHvqiwUW6YHZLrIf0WzfTZ-shuF0ga7uLRfzYQ>
    <xmx:dxv3XORD5ecn5hP5-2ugGVLfahXiDZNTKxvLFGAeW2jIj2661VTP2g>
    <xmx:dxv3XFsOw_IZvKkPJO-NMnMhaSk6iYiiGCLnzzVNGu1TiWFxg70lOg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EDB92E00A1; Tue,  4 Jun 2019 21:31:34 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-650-g74f8db0-fmstable-20190604v3
Mime-Version: 1.0
Message-Id: <b899d98e-6f13-4728-9a62-3228ae7a2021@www.fastmail.com>
In-Reply-To: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
References: <1559684524-15583-1-git-send-email-hongweiz@ami.com>
Date:   Wed, 05 Jun 2019 11:01:34 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Hongwei Zhang" <hongweiz@ami.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_1/3_linux_dev-5.1_arm/soc_v2]_ARM:_dts:_aspeed:_Add?=
 =?UTF-8?Q?_SGPM_pinmux?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 5 Jun 2019, at 07:12, Hongwei Zhang wrote:
> Add SGPM pinmux to ast2500-pinctrl function and group, to prepare for
> supporting SGPIO in AST2500 SoC.
> 
> Signed-off-by: Hongwei Zhang <hongweiz@ami.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  arch/arm/boot/dts/aspeed-g5.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
> index 85ed9db..8d30818 100644
> --- a/arch/arm/boot/dts/aspeed-g5.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g5.dtsi
> @@ -1321,6 +1321,11 @@
>  		groups = "SDA2";
>  	};
>  
> +	pinctrl_sgpm_default: sgpm_default {
> +		function = "SGPM";
> +		groups = "SGPM";
> +	};
> +
>  	pinctrl_sgps1_default: sgps1_default {
>  		function = "SGPS1";
>  		groups = "SGPS1";
> -- 
> 2.7.4
> 
>
