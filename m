Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A2F2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 10:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbfCKK0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 06:26:04 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47721 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfCKK0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 06:26:04 -0400
X-Originating-IP: 176.184.11.245
Received: from localhost (aul93-h02-176-184-11-245.dsl.sta.abo.bbox.fr [176.184.11.245])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0F1641BF20B;
        Mon, 11 Mar 2019 10:26:00 +0000 (UTC)
Date:   Mon, 11 Mar 2019 11:26:00 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ocelot_board: fix a NULL pointer dereference
Message-ID: <20190311102600.GB1637@piout.net>
References: <20190311063632.21111-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311063632.21111-1-kjlu@umn.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2019 01:36:32-0500, Kangjie Lu wrote:
> In case devm_kcalloc fails, the fix returns -ENOMEM to avoid
> NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/net/ethernet/mscc/ocelot_board.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mscc/ocelot_board.c b/drivers/net/ethernet/mscc/ocelot_board.c
> index e7f90101d2e0..af68abf1632a 100644
> --- a/drivers/net/ethernet/mscc/ocelot_board.c
> +++ b/drivers/net/ethernet/mscc/ocelot_board.c
> @@ -256,6 +256,8 @@ static int mscc_ocelot_probe(struct platform_device *pdev)
>  
>  	ocelot->ports = devm_kcalloc(&pdev->dev, ocelot->num_phys_ports,
>  				     sizeof(struct ocelot_port *), GFP_KERNEL);
> +	if (!ocelot->ports)
> +		return -ENOMEM;
>  
>  	INIT_LIST_HEAD(&ocelot->multicast);
>  	ocelot_init(ocelot);
> -- 
> 2.17.1
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
