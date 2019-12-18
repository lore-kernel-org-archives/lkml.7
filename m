Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC9C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEB7218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 21:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfLRV0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 16:26:06 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56644 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfLRV0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 16:26:05 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D3114153DBDAA;
        Wed, 18 Dec 2019 13:26:03 -0800 (PST)
Date:   Wed, 18 Dec 2019 13:26:01 -0800 (PST)
Message-Id: <20191218.132601.160360469201947283.davem@davemloft.net>
To:     baijiaju1990@gmail.com
Cc:     thomas.lendacky@amd.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: amd: xgbe: fix possible sleep-in-atomic-context
 bugs in xgbe_powerdown()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191218140102.11579-1-baijiaju1990@gmail.com>
References: <20191218140102.11579-1-baijiaju1990@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 18 Dec 2019 13:26:04 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Date: Wed, 18 Dec 2019 22:01:02 +0800

> @@ -1257,17 +1257,18 @@ int xgbe_powerdown(struct net_device *netdev, unsigned int caller)
>  	netif_tx_stop_all_queues(netdev);
>  
>  	xgbe_stop_timers(pdata);
> -	flush_workqueue(pdata->dev_workqueue);
>  
>  	hw_if->powerdown_tx(pdata);
>  	hw_if->powerdown_rx(pdata);
>  
> -	xgbe_napi_disable(pdata, 0);
> -
>  	pdata->power_down = 1;
>  
>  	spin_unlock_irqrestore(&pdata->lock, flags);
>  
> +	flush_workqueue(pdata->dev_workqueue);
> +
> +	xgbe_napi_disable(pdata, 0);
> +

Nope, this doesn't work at all.

You can't leave NAPI enabled, and thus packet processing, after the TX
and RX units of the chip have been powered down.
