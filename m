Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD456C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88DB20640
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 16:10:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="0Cs2fQ+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfJOQK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 12:10:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34631 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfJOQK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 12:10:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id j8so6904067eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 09:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4wsH/H4/IvZbw1PBfApeIo2ldu5dbGC9/0sEtLu5BHw=;
        b=0Cs2fQ+11eH0QVgZsZWadHdiWihinDAvgb4Ioa7gYg4yiKnVsD04fCFg5y4sFuUKN7
         102tkBCNYur4z4uin78NLBgAn6ngTyCMIDplIkzTuA07sL+HHbwHG9+TN5zEoU84YMmP
         wqlTflVW7GYFjZBoch+//tLKDt6mdgJ3UHe/P7JCkaa21fZ3SIZngSBo8J6qU3AUDdLP
         SFXpoSqI1ldXa0sCrS9IDsB0ZUfWVWMIrB7iz6Fi9jQ05Pc/EMaYErfEeMKnO5Uw1knM
         aqmOfiwXL+5RtQn76aKnrUNVyh7xChRvYRzL8VVfSHP7sHtZC4zPwkSBtSoqh3syzD/1
         9bsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4wsH/H4/IvZbw1PBfApeIo2ldu5dbGC9/0sEtLu5BHw=;
        b=BUpVYQuD2C3vYNa+m4U5U3gmakvC+29zpCdgVmhfr8P5JQaxlBmZXlLvzhRbY5nNCu
         onZVaknP2SHl4Dur0++6R9p8LmLkM4Bj4Zj3fuId5Dn7DrQ7x4lVUCMfmQRe9+bcpZLu
         /oRBKOLb7VEAFOIeuQ7hrBl4NIHDJdKgrhespW2DVOoHjP7J8lTF4/trdSGCQv6fSgm8
         0BmhHM3DswYoacd5nfvgw+LIHzQV9lr+nFeb8nmyvqreQAZ4EDUHPRXO4UuY1+a/3E3W
         Pmdb/IVBMnIXUrAnqcOpJj3r9aOxplfg3h2hfm/HNk8ol4EOyAv88JdoO+5o4YpJjdSg
         ux6Q==
X-Gm-Message-State: APjAAAViwMB6QFNSa/N4WbFof553JnHTCY3EhHEyiZqF7IJBFMo4RmCV
        6l6bQnlSIoVtNDmnm/z56cK0dg==
X-Google-Smtp-Source: APXvYqxRdcnRI22r9M7UXPsBCBGbEnHT8bpl3u0lG8avm96l2X0z/fb7buBkQh5xPEYJUZLYEf060g==
X-Received: by 2002:a17:906:1cd8:: with SMTP id i24mr34165866ejh.149.1571155827144;
        Tue, 15 Oct 2019 09:10:27 -0700 (PDT)
Received: from netronome.com (penelope-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:c685:8ff:fe7c:9971])
        by smtp.gmail.com with ESMTPSA id dt4sm2793092ejb.45.2019.10.15.09.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:10:26 -0700 (PDT)
Date:   Tue, 15 Oct 2019 18:10:23 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] can: ifi: use devm_platform_ioremap_resource()
 to simplify code
Message-ID: <20191015161022.mtgohberdmhkbo46@netronome.com>
References: <20191015142046.24844-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015142046.24844-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:20:46PM +0800, YueHaibing wrote:
> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
>  drivers/net/can/ifi_canfd/ifi_canfd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
> index fedd927..04d59be 100644
> --- a/drivers/net/can/ifi_canfd/ifi_canfd.c
> +++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
> @@ -942,13 +942,11 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct net_device *ndev;
>  	struct ifi_canfd_priv *priv;
> -	struct resource *res;
>  	void __iomem *addr;
>  	int irq, ret;
>  	u32 id, rev;
>  
> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	addr = devm_ioremap_resource(dev, res);
> +	addr = devm_platform_ioremap_resource(pdev, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (IS_ERR(addr) || irq < 0)
>  		return -EINVAL;
> -- 
> 2.7.4
> 
> 
