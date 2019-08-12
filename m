Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420FCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 082A920679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 14:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wrh663s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfHLOdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 10:33:20 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53634 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbfHLOdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 10:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cS4Ld514SiHUW9K6Pk51Cu+MFxAuM3V0tn0DaDG4ls0=; b=wrh663s4j55+n376acWIuKqnLG
        wWQKsYLzexCM61a1hb402pXWXeY+VjoViwhPw24JyKA3OlwSj0qjAIGVgRYAmUWABnLbSZ5SMEZtW
        seNGb83wemRS7rKCH+3fNSSEThjBxTfrijoOVd+OeL6UhQ4ZmSy6hYJwBBlLBG6rww44=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hxBNr-0000vx-8f; Mon, 12 Aug 2019 16:33:15 +0200
Date:   Mon, 12 Aug 2019 16:33:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com,
        hkallweit1@gmail.com
Subject: Re: [PATCH v4 13/14] net: phy: adin: add ethtool get_stats support
Message-ID: <20190812143315.GS14290@lunn.ch>
References: <20190812112350.15242-1-alexandru.ardelean@analog.com>
 <20190812112350.15242-14-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812112350.15242-14-alexandru.ardelean@analog.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int adin_read_mmd_stat_regs(struct phy_device *phydev,
> +				   struct adin_hw_stat *stat,
> +				   u32 *val)
> +{
> +	int ret;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, stat->reg1);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = (ret & 0xffff);
> +
> +	if (stat->reg2 == 0)
> +		return 0;
> +
> +	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, stat->reg2);
> +	if (ret < 0)
> +		return ret;
> +
> +	*val <<= 16;
> +	*val |= (ret & 0xffff);
> +
> +	return 0;
> +}

It still looks like you have not dealt with overflow from the LSB into
the MSB between the two reads.

	do {
		hi1 = phy_read_mmd(phydev, MDIO_MMD_VEND1, stat->reg2);
		if (hi1 < 0)
			return hi1;
		
		low = phy_read_mmd(phydev, MDIO_MMD_VEND1, stat->reg1);
		if (low < 0)
			return low;

		hi2 = phy_read_mmd(phydev, MDIO_MMD_VEND1, stat->reg2);
		if (hi2 < 0)
			return hi1;
	} while (hi1 != hi2)

	return low | (hi << 16);

	Andrew
