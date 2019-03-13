Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523D0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2787C2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 09:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfCMJJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 05:09:37 -0400
Received: from proxima.lasnet.de ([78.47.171.185]:38488 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfCMJJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 05:09:37 -0400
Received: from localhost.localdomain (p200300E9D721079FBEBF6D7FF071FCD2.dip0.t-ipconnect.de [IPv6:2003:e9:d721:79f:bebf:6d7f:f071:fcd2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 2E4F9CA735;
        Wed, 13 Mar 2019 10:09:35 +0100 (CET)
Subject: Re: [PATCH] net: ieee802154: fix a potential NULL pointer dereference
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Michael Hennerich <michael.hennerich@analog.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190311072517.29740-1-kjlu@umn.edu>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <3e612944-e54c-a694-405e-f73582a690c5@datenfreihafen.org>
Date:   Wed, 13 Mar 2019 10:09:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190311072517.29740-1-kjlu@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

[please ignore the first mail, hit send to early]

On 11.03.19 08:25, Kangjie Lu wrote:
> In case alloc_ordered_workqueue fails, the fix releases
> sources and returns -ENOMEM to avoid NULL pointer dereference.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/net/ieee802154/adf7242.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
> index cd1d8faccca5..cd6b95e673a5 100644
> --- a/drivers/net/ieee802154/adf7242.c
> +++ b/drivers/net/ieee802154/adf7242.c
> @@ -1268,6 +1268,10 @@ static int adf7242_probe(struct spi_device *spi)
>  	INIT_DELAYED_WORK(&lp->work, adf7242_rx_cal_work);
>  	lp->wqueue = alloc_ordered_workqueue(dev_name(&spi->dev),
>  					     WQ_MEM_RECLAIM);
> +	if (unlikely(!lp->wqueue)) {
> +		ret = -ENOMEM;
> +		goto err_hw_init;
> +	}
>  
>  	ret = adf7242_hw_init(lp);
>  	if (ret)
> 


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
