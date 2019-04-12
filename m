Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79AC1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3020850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XMdZ0wRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfDLNmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:42:52 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:59211 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726965AbfDLNmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Mk8JPVON+MDwG8aSBi8O+sVKIZFgjgGGzz6954NK8T4=; b=XMdZ0wRSfj70Q+DUVZ7Spk+bXn
        is3SXeEFPlvIKjg+1cfCbYj3WP1n53ilBSQiNB0T2itB5mhUqwIs3PXoJDFgHL5bEHBJvDaFdMP89
        7FdBYn59IgWnS5Fr/kHV6p+2TtXwIIyRHoMua0KJmnBkve0QtraOVXvEBXcvlloh860Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hEwS5-0005iY-0D; Fri, 12 Apr 2019 15:42:45 +0200
Date:   Fri, 12 Apr 2019 15:42:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] arm64: dts: fsl: librem5: Add a device tree for
 the Librem5 devkit
Message-ID: <20190412134244.GC324@lunn.ch>
References: <20190412130427.13418-1-angus@akkea.ca>
 <20190412130427.13418-2-angus@akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190412130427.13418-2-angus@akkea.ca>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		ethphy0: ethernet-phy@1 {
> +			compatible = "ethernet-phy-ieee802.3-c22";

Hi Angus

This compatible string is optional. It won't warm, but it is not
needed.

> +			reg = <1>;
> +			power-supply = <&reg_3V3_P>;

I don't remember seeing a power-supply property in an Ethernet PHY
node before. What is using it? The PHY driver? Or the driver core
code?

	Andrew
