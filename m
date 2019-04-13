Return-Path: <SRS0=NhyN=SP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D9DC10F0E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5138218AF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Apr 2019 00:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfDMAOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 20:14:50 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51116 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbfDMAOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 20:14:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7F51014077A2F;
        Fri, 12 Apr 2019 17:14:49 -0700 (PDT)
Date:   Fri, 12 Apr 2019 17:14:48 -0700 (PDT)
Message-Id: <20190412.171448.1969143158873595750.davem@davemloft.net>
To:     m-karicheri2@ti.com
Cc:     arvid.brodin@alten.se, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 3/3] net: hsr: add tx stats for master
 interface
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190412201325.29001-4-m-karicheri2@ti.com>
References: <20190412201325.29001-1-m-karicheri2@ti.com>
        <20190412201325.29001-4-m-karicheri2@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Apr 2019 17:14:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Fri, 12 Apr 2019 16:13:25 -0400

> Add tx stats to hsr interface. Without this
> ifconfig for hsr interface doesn't show tx packet stats.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>  net/hsr/hsr_device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 15c72065df79..f22902eac083 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -229,6 +229,8 @@ static int hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
>  	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
>  	skb->dev = master->dev;
>  	hsr_forward_skb(skb, master);
> +	master->dev->stats.tx_packets++;
> +	master->dev->stats.tx_bytes += skb->len;
>  

This introduced a use after free of 'skb' as hsr_forward_skb() can free it.

Also, why are there so many changes in your "internal" tree and why are
they not all upstream already?
