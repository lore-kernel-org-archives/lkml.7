Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23959C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A75217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QfYzDCil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfDWSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 14:40:19 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:41769 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWSkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 14:40:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=se1yZbAiaRAEydO7GRf579Nsy4hT0JqoGRsn/rRSR4I=; b=QfYzDCilkMi5ax/jZpIn5zddoq
        nJc9ypah63NvowCrp0vZTob8aOTsuwIoObBbstGlPZfUKXQQZH/L8beZsRluCk6XKhkubYY51O2Y8
        p68Op5ukumaRs4zuo4U0hasZPlUhC/prYbJ9ezMXaKiX/a0/MSux6e5R9PF1vGcPRlC0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJ0L1-0001S6-FJ; Tue, 23 Apr 2019 20:40:15 +0200
Date:   Tue, 23 Apr 2019 20:40:15 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
Subject: Re: [PATCH net-next 05/19] net: ethernet: ti: cpsw: use local var
 dev in probe
Message-ID: <20190423184015.GD28405@lunn.ch>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-6-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556024950-20752-6-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Apr 23, 2019 at 04:08:56PM +0300, Grygorii Strashko wrote:
> Use local variable struct device *dev in probe to simplify code.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/cpsw.c | 65 +++++++++++++++++-----------------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 13a339c64892..0b8cc4e6d9cd 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -3458,6 +3458,7 @@ static const struct soc_device_attribute cpsw_soc_devices[] = {
>  
>  static int cpsw_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct clk			*clk;
>  	struct cpsw_platform_data	*data;
>  	struct net_device		*ndev;

It seems odd not to keep with the column layout?
Plus it would make it reverse Christmas tree.

     Andrew
