Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACFEC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B599206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 14:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Fx5NJNjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfDZOPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 10:15:16 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:45522 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbfDZOPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 10:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yW5kv3I/idzumD0kD5brzMhB82n0REr+cs1o/i56S3M=; b=Fx5NJNjgKn5RAaQIvKMBSvlHlY
        FmxKMBq5k76zpXXlIJMsJUKAWDxSFGcFVZRIJYkL0aEeY7LEe5oxIhxe6DqFZ5nozTJXRXYeafnZV
        eiAY9TOXXOA7jev/MMeXzzsloeiJm19Zn9q9VKOC4RBAUdP+1lRwixCLlJCHNERbsWaU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1hK1cx-0001CF-0p; Fri, 26 Apr 2019 16:14:59 +0200
Date:   Fri, 26 Apr 2019 16:14:58 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Esben Haabendal <esben@geanix.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Yang Wei <yang.wei9@zte.com.cn>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] net: ll_temac: Support indirect_mutex share within
 TEMAC IP
Message-ID: <20190426141458.GH14432@lunn.ch>
References: <20190426073231.4008-1-esben@geanix.com>
 <20190426073231.4008-8-esben@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426073231.4008-8-esben@geanix.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 09:32:26AM +0200, Esben Haabendal wrote:
> @@ -1092,7 +1092,15 @@ static int temac_probe(struct platform_device *pdev)
>  	lp->dev = &pdev->dev;
>  	lp->options = XTE_OPTION_DEFAULTS;
>  	spin_lock_init(&lp->rx_lock);
> -	mutex_init(&lp->indirect_mutex);
> +
> +	/* Setup mutex for synchronization of indirect register access */
> +	if (pdata && pdata->indirect_mutex) {
> +		lp->indirect_mutex = pdata->indirect_mutex;
> +	} else {
> +		lp->indirect_mutex = devm_kmalloc(
> +			&pdev->dev, sizeof(*lp->indirect_mutex), GFP_KERNEL);
> +		mutex_init(lp->indirect_mutex);
> +	}

Hi Esben

I would make the mutex mandatory, not optional. I think there will be
less hard to debug errors that way. You want the developer to actually
think about this mutex, should it be shared, or individual. Forcing
them to provide it means they are more likely to read the
documentation, and more likely to over share it than under share
it. That is maybe not so good for performance, but safer.

    Andrew
