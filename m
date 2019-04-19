Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E79C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB5D21736
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfDSVfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:35:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35570 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfDSVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:35:21 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 53DD414DAB89C;
        Fri, 19 Apr 2019 14:35:20 -0700 (PDT)
Date:   Fri, 19 Apr 2019 14:35:19 -0700 (PDT)
Message-Id: <20190419.143519.94034508850689697.davem@davemloft.net>
To:     o.rempel@pengutronix.de
Cc:     paul.burton@mips.com, ralf@linux-mips.org, jhogan@kernel.org,
        robh+dt@kernel.org, jcliburn@gmail.com, chris.snook@gmail.com,
        mark.rutland@arm.com, kernel@pengutronix.de,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, john@phrozen.org, nbd@nbd.name,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2 3/3] net: ethernet: add ag71xx driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190418052620.20835-4-o.rempel@pengutronix.de>
References: <20190418052620.20835-1-o.rempel@pengutronix.de>
        <20190418052620.20835-4-o.rempel@pengutronix.de>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 19 Apr 2019 14:35:20 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>
Date: Thu, 18 Apr 2019 07:26:20 +0200

> +static int ag71xx_remove(struct platform_device *pdev)
> +{
> +	struct net_device *ndev = platform_get_drvdata(pdev);
> +	struct ag71xx *ag;
> +
> +	if (!ndev)
> +		return 0;
> +
> +	ag = netdev_priv(ndev);
> +	ag71xx_phy_disconnect(ag);
> +	ag71xx_mdio_remove(ag);
> +	unregister_netdev(ndev);
> +	platform_set_drvdata(pdev, NULL);
> +
> +	return 0;
> +}

You should unregister the netdev before you disconnect the PHY and remove
the MDIO.

Also you need to call free_netdev() afterwards otherwise you will leak it.
