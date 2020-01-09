Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117F8C33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A5B20678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 05:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="L3c4NMVN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fEwkixlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgAIFGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 00:06:47 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54849 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725308AbgAIFGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 00:06:46 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 6018121BF9;
        Thu,  9 Jan 2020 00:06:45 -0500 (EST)
Received: from imap2 ([10.202.2.52])
  by compute4.internal (MEProxy); Thu, 09 Jan 2020 00:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=MF8c+sdns7iguGosmLN+yWRChH5HbQH
        EVoRuFYd3R88=; b=L3c4NMVNgbWCOOtr/APLZBN3ezi4IzeQfH9jOLv3qEDdjgH
        i2jznUAAc++h/cpuHDptk5D3bM+mnfokTiurIEyFhz0TCzoO0KnoT2D+6RJ9cVK/
        k8J5Bg1gz3AclF5liUl/z+6+JfauXv15tExiC0ZYdRYhesyheHzwmOUnMEELAsqO
        bWFComFbdj0vpzJyZ4abMWM0P19Rb+s00cp0j7wzB06FqJ5ZD1pOWPSIENLi3YgF
        6dsChMBe7vWqyetWyJgV5ZxarS+5vgSgsVSW02PpCBN/iotRWSmaiLl8LmtQn7DD
        4EHxLK5H08DJHufYDYrCb3mTBfrXTr4YR+RzD7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=MF8c+s
        dns7iguGosmLN+yWRChH5HbQHEVoRuFYd3R88=; b=fEwkixlkFKOerFt8LoBhLn
        aW2pyVTNpNZ6a9E7Y0NVAkFjwG11d9dkCGNDNlG+nVEdXR9Nb3xHLmg1egEI8i0U
        b1IKI01QCnXta+ZgubHVhYRRkP3WegkrdkNjXDCpI4DEuVxfEGzXTXZVah6VSAPd
        yrTXvb5up17dDtHYWtrTXbTMGeVkC1VVtLNwoLcz8ZxckT2zw66g/Pm3vX0QKUqt
        osN4oG363+e2lKlzknwqP09GpCox7cpT4xbvmSeCgJ14GJP5JVzq+MMv/x83pg5h
        5xdplFNqyNrOqVruJGKfX+vfFEZQF3k2Nh3S6IcV9Le5G8y4jzkQbNRtBYK+6Jsg
        ==
X-ME-Sender: <xms:5LQWXtDslOqEN2MlmzehoK1lmubcYDSSkWT1Kc5No_MvnVsqbX3W5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvdehledgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghunecuvehluhhsthgv
    rhfuihiivgeptd
X-ME-Proxy: <xmx:5LQWXuy8aZIvXShIeiG8FrIyBgCS2ys0DC8mdDP9HTQJ8SvxVmuHdA>
    <xmx:5LQWXiD8GxHWtmp_m5OtR7PzD33WH7vibT2nyX9Q1jEjRioz_DgDRA>
    <xmx:5LQWXjaVUAXR9tvXXlEj1gyc5B8x8r9yUlIIYPBFcImJ65cU7uZ_jA>
    <xmx:5bQWXrdi0ZYe-MuR_Kc2R9t9O1rb1IDJ9CMC2yN25KGFXlGLa3iu1w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E6FC6E00A5; Thu,  9 Jan 2020 00:06:43 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-740-g7d9d84e-fmstable-20200109v1
Mime-Version: 1.0
Message-Id: <3c44c745-d39a-4724-860d-a66537b2adbb@www.fastmail.com>
In-Reply-To: <1577993276-2184-7-git-send-email-eajames@linux.ibm.com>
References: <1577993276-2184-1-git-send-email-eajames@linux.ibm.com>
 <1577993276-2184-7-git-send-email-eajames@linux.ibm.com>
Date:   Thu, 09 Jan 2020 15:38:20 +1030
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Eddie James" <eajames@linux.ibm.com>,
        linux-aspeed@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mark.rutland@arm.com, "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>, tglx@linutronix.de,
        "Joel Stanley" <joel@jms.id.au>
Subject: Re: [PATCH v4 06/12] soc: aspeed: Add XDMA Engine Driver
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Jan 2020, at 05:57, Eddie James wrote:
> +static int aspeed_xdma_init_scu(struct aspeed_xdma *ctx, struct device *dev)
> +{
> +	struct regmap *scu = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							     "aspeed,scu");
> +
> +	if (!IS_ERR(scu)) {
> +		u32 selection;
> +		bool pcie_device_bmc = true;
> +		const u32 bmc = SCU_PCIE_CONF_BMC_EN |
> +			SCU_PCIE_CONF_BMC_EN_MSI | SCU_PCIE_CONF_BMC_EN_IRQ |
> +			SCU_PCIE_CONF_BMC_EN_DMA;
> +		const u32 vga = SCU_PCIE_CONF_VGA_EN |
> +			SCU_PCIE_CONF_VGA_EN_MSI | SCU_PCIE_CONF_VGA_EN_IRQ |
> +			SCU_PCIE_CONF_VGA_EN_DMA;
> +		const char *pcie = NULL;
> +
> +		if (!of_property_read_string(dev->of_node, "pcie-device",
> +					     &pcie)) {
> +			if (!strcmp(pcie, "vga")) {
> +				pcie_device_bmc = false;
> +			} else if (strcmp(pcie, "bmc")) {
> +				dev_err(dev,
> +					"Invalid pcie-device property %s.\n",
> +					pcie);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		if (pcie_device_bmc) {
> +			selection = bmc;
> +			regmap_write(scu, ctx->chip->scu_bmc_class,
> +				     SCU_BMC_CLASS_REV_XDMA);
> +		} else {
> +			selection = vga;
> +		}
> +
> +		regmap_update_bits(scu, ctx->chip->scu_pcie_conf, bmc | vga,
> +				   selection);
> +	} else {
> +		dev_warn(dev, "Unable to configure PCIe; continuing.\n");
> +	}

Not something you need to fix but generally I'd structure this as a early-return:

    if (IS_ERR(scu)) {
        dev_warn(dev, "Unable to configure PCIe; continuing.\n");
        return 0;
    }
    ...

Could probably also improve the warning message to say what caused the
failure, but again, something that can be changed later.
