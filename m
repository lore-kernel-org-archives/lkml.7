Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1B1C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9863A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="EVoil5Ak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387765AbfIJODR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:03:17 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:38026 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbfIJODR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:03:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FqKfQsiBOTyZitqzXjJVEKWxZ/2yB1mlJyy6Xco5aA4=; b=EVoil5AkVpuXllPLDdeqTzo5Lb
        f/N1jzf74Y1+whpcnUaski9yXT9ZydIZ2AZaSb2lXz7uiuATX2ZhC4SYhgI2UwqoDTndjPpsmRnj1
        zlWSy5nwH1bpyYvESKm08uHPWiebWUaDCIrxYWIrkFwxcwJNiC0hUZ4C6HqUwUv/0qgk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i7gjY-0001NC-MR; Tue, 10 Sep 2019 16:03:04 +0200
Date:   Tue, 10 Sep 2019 16:03:04 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     George McCollister <george.mccollister@gmail.com>
Cc:     netdev@vger.kernel.org, Woojung Huh <woojung.huh@microchip.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tristram Ha <Tristram.Ha@microchip.com>,
        "David S. Miller" <davem@davemloft.net>,
        Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/3] net: dsa: microchip: add KSZ9477 I2C
 driver
Message-ID: <20190910140304.GA4683@lunn.ch>
References: <20190910131836.114058-1-george.mccollister@gmail.com>
 <20190910131836.114058-2-george.mccollister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910131836.114058-2-george.mccollister@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi George

> +KSZ_REGMAP_TABLE(ksz9477, not_used, 16, 0, 0);
> +
> @@ -294,6 +294,8 @@ static inline void ksz_pwrite32(struct ksz_device *dev, int port, int offset,
>  #define KSZ_SPI_OP_RD		3
>  #define KSZ_SPI_OP_WR		2
>  
> +#define swabnot_used(x)		0

> +
>  #define KSZ_SPI_OP_FLAG_MASK(opcode, swp, regbits, regpad)		\
>  	swab##swp((opcode) << ((regbits) + (regpad)))

There seems to be quite a lot of macro magic here which is not
obvious. Can this be simplified or made more obvious?

	 Andrew
