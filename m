Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E81C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664CB206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731787AbfFTMfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:35:43 -0400
Received: from retiisi.org.uk ([95.216.213.190]:38246 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726238AbfFTMfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:35:43 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 34C06634C7B;
        Thu, 20 Jun 2019 15:35:09 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hdwHV-0002Bx-7V; Thu, 20 Jun 2019 15:35:09 +0300
Date:   Thu, 20 Jun 2019 15:35:09 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: mt9m111: fix fw-node refactoring
Message-ID: <20190620123509.7pssbcqjqcnh3kmc@valkosipuli.retiisi.org.uk>
References: <20190603200155.24358-1-robert.jarzmik@free.fr>
 <20190620101717.7h2hczachuk2rjr6@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620101717.7h2hczachuk2rjr6@valkosipuli.retiisi.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 01:17:17PM +0300, Sakari Ailus wrote:
> diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> index bd3a51c3b081..9761a6105407 100644
> --- a/drivers/media/i2c/mt9m111.c
> +++ b/drivers/media/i2c/mt9m111.c
> @@ -1263,9 +1263,11 @@ static int mt9m111_probe(struct i2c_client *client,
>  	if (!mt9m111)
>  		return -ENOMEM;
>  
> -	ret = mt9m111_probe_fw(client, mt9m111);
> -	if (ret)
> -		return ret;
> +	if (dev_fwnode(client->dev)) {

&client->dev

> +		ret = mt9m111_probe_fw(client, mt9m111);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	mt9m111->clk = v4l2_clk_get(&client->dev, "mclk");
>  	if (IS_ERR(mt9m111->clk))

-- 
Sakari Ailus
