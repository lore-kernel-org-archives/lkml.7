Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09ABC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8C3214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 22:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="elrmXAK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbfDXWqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 18:46:13 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:43369 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbfDXWqN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 18:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=K5hkQIWpfD+IwBnIpQDIAdvKUwuaEo0g+ruUYXW4nSQ=; b=elrmXAK9cnr3ljv4IchuYKKujy
        E7hGddfA1VXVvHPisC7sbJrLAPR3rtLY6pE9WLcEJRFSyUPh2rCfJT1XXsBhLwsj0EctOoyAajHR5
        FzoBRIwKVs4xTLmRloTB7Hup76f7cH4cUdhLc5PbO3X6sW7r23M420gZnaTxKd7mqksM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hJQeV-0006Ru-HF; Thu, 25 Apr 2019 00:46:07 +0200
Date:   Thu, 25 Apr 2019 00:46:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     netdev@vger.kernel.org,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        Jiri Pirko <jiri@resnulli.us>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>,
        Ivan Vecera <ivecera@redhat.com>
Subject: Re: [RFC PATCH v3 net-next 01/11] net: ethernet: ti: cpts: use
 devm_get_clk_from_child
Message-ID: <20190424224607.GB23779@lunn.ch>
References: <1556144667-27997-1-git-send-email-grygorii.strashko@ti.com>
 <1556144667-27997-2-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556144667-27997-2-git-send-email-grygorii.strashko@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 01:24:17AM +0300, Grygorii Strashko wrote:
> Use devm_get_clk_from_child() instead of devm_clk_get() and this way allow
> to group CPTS DT properties in sub-node for better code readability and
> maintenance.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  drivers/net/ethernet/ti/cpts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
> index 499806ce4cd5..aad118e71b61 100644
> --- a/drivers/net/ethernet/ti/cpts.c
> +++ b/drivers/net/ethernet/ti/cpts.c
> @@ -572,7 +572,7 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> -	cpts->refclk = devm_clk_get(dev, "cpts");
> +	cpts->refclk = devm_get_clk_from_child(dev, node, "cpts");
>  	if (IS_ERR(cpts->refclk)) {
>  		dev_err(dev, "Failed to get cpts refclk\n");
>  		return ERR_CAST(cpts->refclk);

Hi Grygorii

Does this break backwards compatibility for existing DT blobs?
Maybe you need to look in both the old and new locations?

      Andrew
