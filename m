Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADD8ECE59D
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9972064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 22:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HJg0uZss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbfJOWci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 18:32:38 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45312 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732040AbfJOWci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 18:32:38 -0400
Received: by mail-pl1-f196.google.com with SMTP id u12so10246470pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 15:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ZPGOSSx5giEEfL2NPx2gvww++Bfy7bq2OL0BsYfuuHg=;
        b=HJg0uZssgcrUSgxu4Yt6cBbovBjr3Wy8sfTsLZaJ5il4NS8LlLl+YXlQufsmAOhrUe
         EjPI+S9rdd9S0a0yFhE80R21vVioW+hNay9WseUk7tEudntZ+ZVUQW/eEvwAdWlj7R0J
         eL6TvUgJ4Wbp8ruzE7ttH23JwlHVYaonygjyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ZPGOSSx5giEEfL2NPx2gvww++Bfy7bq2OL0BsYfuuHg=;
        b=gcktiuFr8a9ttyNqfNiPdsIP2pK7acVkgB3G43SdIlHpAImifIt7z8Xiw6/BJoRu3+
         xNWlwKVyCvVSXSU7GT2TgZEbGGlQuQ1G3NJ1xmspCaFeqeIb8ThdunCrRTFpmCeRtNqS
         mCjSunOlUxtz9m7Kn5WtnRz8Iih1mK8INCx5FCrQUCc568mLtjN52wIv+UnLtaVMd5nZ
         hTwwL2FGZ1WTz4njl9/MtHhgy938h0hp5Tk68DZrystdLDJcvB1tqnSZZooQxi3WUBo5
         /QJszgXi7R3LbJivlMjmRSWPvnR0t+s1mJUU/coBJ7gxbqK2HSx9XLRC7kt5vDgj+IHN
         wG5Q==
X-Gm-Message-State: APjAAAU9axc5CMF0upOcPOXVthwsY2D3oKzRUmBKTh/uYvCeA2aoEG1i
        1OecxpyyY6wRgAPLrwn5fUzLfWcBBpWfVT6+ljxHXgOnZHePrFAexLm1eOw+iw5c3uBixFngzEI
        YjyzvVjWZtJxTjmDR9FOYIGK7TRvjz7GyoPeVhRQjJoRqhNk4N9zegd6jdPfFbAbMHYaQFQrtRM
        DcFx437p+QQaQ=
X-Google-Smtp-Source: APXvYqynowQLJijtXfqi2elhpB72G1vEHERM1q9vmxBCIR/fDTcnRQIGAZzcOq4IwAR76Jx3qQgNgQ==
X-Received: by 2002:a17:902:547:: with SMTP id 65mr26662481plf.239.1571178756804;
        Tue, 15 Oct 2019 15:32:36 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l62sm24419257pfl.167.2019.10.15.15.32.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 15:32:35 -0700 (PDT)
Subject: Re: [PATCH net-next v2] net: bcmgenet: Generate a random MAC if none
 is valid
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     phil@raspberrypi.org, jonathan@raspberrypi.org,
        matthias.bgg@kernel.org, linux-rpi-kernel@lists.infradead.org,
        wahrenst@gmx.net, nsaenzjulienne@suse.de,
        Doug Berger <opendmb@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:BROADCOM GENET ETHERNET DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20191014212000.27712-1-f.fainelli@gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <dda8587a-0734-d294-5b50-0f5f35c27918@broadcom.com>
Date:   Tue, 15 Oct 2019 15:32:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191014212000.27712-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On 2019-10-14 2:20 p.m., Florian Fainelli wrote:
> Instead of having a hard failure and stopping the driver's probe
> routine, generate a random Ethernet MAC address to keep going.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
> Changes in v2:
>
> - provide a message that a random MAC is used, the same message that
>    bcmsysport.c uses
>
>   drivers/net/ethernet/broadcom/genet/bcmgenet.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index 12cb77ef1081..dd4e4f1dd384 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -3461,16 +3461,10 @@ static int bcmgenet_probe(struct platform_device *pdev)
>   		goto err;
>   	}
>   
> -	if (dn) {
> +	if (dn)
>   		macaddr = of_get_mac_address(dn);
> -		if (IS_ERR(macaddr)) {
> -			dev_err(&pdev->dev, "can't find MAC address\n");
> -			err = -EINVAL;
> -			goto err;
> -		}
> -	} else {
> +	else
>   		macaddr = pd->mac_address;
> -	}
>   
>   	priv->base = devm_platform_ioremap_resource(pdev, 0);
>   	if (IS_ERR(priv->base)) {
> @@ -3482,7 +3476,12 @@ static int bcmgenet_probe(struct platform_device *pdev)
>   
>   	SET_NETDEV_DEV(dev, &pdev->dev);
>   	dev_set_drvdata(&pdev->dev, dev);
> -	ether_addr_copy(dev->dev_addr, macaddr);
> +	if (IS_ERR_OR_NULL(macaddr) || !is_valid_ether_addr(macaddr)) {
> +		dev_warn(&pdev->dev, "using random Ethernet MAC\n");
I would still consider this warrants a dev_err as you should not be 
using the device with a random MAC address assigned to it.  But I'll 
leave it to the "experts" to decide on the print level here.
> +		eth_hw_addr_random(dev);
> +	} else {
> +		ether_addr_copy(dev->dev_addr, macaddr);
> +	}
>   	dev->watchdog_timeo = 2 * HZ;
>   	dev->ethtool_ops = &bcmgenet_ethtool_ops;
>   	dev->netdev_ops = &bcmgenet_netdev_ops;

