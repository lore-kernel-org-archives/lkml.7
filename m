Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225CEC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010E821842
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 14:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390557AbfGWORL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 10:17:11 -0400
Received: from smtprelay0150.hostedemail.com ([216.40.44.150]:41924 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726201AbfGWORL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 10:17:11 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E2DB98368F00;
        Tue, 23 Jul 2019 14:17:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: laugh64_3e612aa95d800
X-Filterd-Recvd-Size: 2461
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 14:17:08 +0000 (UTC)
Message-ID: <282e6918adc670dc5667006f646664342c8bdef8.camel@perches.com>
Subject: Re: [PATCH] net: atheros: Use dev_get_drvdata
From:   Joe Perches <joe@perches.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Jay Cliburn <jcliburn@gmail.com>,
        Chris Snook <chris.snook@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 23 Jul 2019 07:17:07 -0700
In-Reply-To: <20190723131856.31932-1-hslester96@gmail.com>
References: <20190723131856.31932-1-hslester96@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 21:18 +0800, Chuhong Yuan wrote:
> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.

unrelated trivia:

> diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
[]
> @@ -2422,8 +2422,7 @@ static int atl1c_close(struct net_device *netdev)
>  
>  static int atl1c_suspend(struct device *dev)
>  {
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct net_device *netdev = pci_get_drvdata(pdev);
> +	struct net_device *netdev = dev_get_drvdata(dev);
>  	struct atl1c_adapter *adapter = netdev_priv(netdev);
>  	struct atl1c_hw *hw = &adapter->hw;
>  	u32 wufc = adapter->wol;
> @@ -2437,7 +2436,7 @@ static int atl1c_suspend(struct device *dev)
>  
>  	if (wufc)
>  		if (atl1c_phy_to_ps_link(hw) != 0)
> -			dev_dbg(&pdev->dev, "phy power saving failed");
> +			dev_dbg(dev, "phy power saving failed");

These and similar uses could/should use netdev_dbg

			netdev_dbg(netdev, "phy power saving failed\n");

with the terminating newline too

> diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
[]
> @@ -2780,7 +2779,7 @@ static int atl1_suspend(struct device *dev)
>  		val = atl1_get_speed_and_duplex(hw, &speed, &duplex);
>  		if (val) {
>  			if (netif_msg_ifdown(adapter))
> -				dev_printk(KERN_DEBUG, &pdev->dev,
> +				dev_printk(KERN_DEBUG, dev,
>  					"error getting speed/duplex\n");

netdev_printk(KERN_DEBUG, netdev, etc...);


