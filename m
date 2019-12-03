Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B52C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1904206DC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 03:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbfLCDZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 22:25:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44492 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfLCDZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 22:25:40 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D344614F2F769;
        Mon,  2 Dec 2019 19:25:39 -0800 (PST)
Date:   Mon, 02 Dec 2019 19:25:39 -0800 (PST)
Message-Id: <20191202.192539.1290120247243731738.davem@davemloft.net>
To:     tanhuazhong@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, jakub.kicinski@netronome.com,
        linyunsheng@huawei.com
Subject: Re: [PATCH net 1/3] net: hns3: fix for TX queue not restarted
 problem
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1575342535-2981-2-git-send-email-tanhuazhong@huawei.com>
References: <1575342535-2981-1-git-send-email-tanhuazhong@huawei.com>
        <1575342535-2981-2-git-send-email-tanhuazhong@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 02 Dec 2019 19:25:40 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>
Date: Tue, 3 Dec 2019 11:08:53 +0800

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> index ba05368..b2bb8e2 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> @@ -1286,13 +1286,16 @@ static bool hns3_skb_need_linearized(struct sk_buff *skb, unsigned int *bd_size,
>  	return false;
>  }
>  
> -static int hns3_nic_maybe_stop_tx(struct hns3_enet_ring *ring,
> +static int hns3_nic_maybe_stop_tx(struct net_device *netdev,
>  				  struct sk_buff **out_skb)
>  {
> +	struct hns3_nic_priv *priv = netdev_priv(netdev);
>  	unsigned int bd_size[HNS3_MAX_TSO_BD_NUM + 1U];
>  	struct sk_buff *skb = *out_skb;
> +	struct hns3_enet_ring *ring;
>  	unsigned int bd_num;
>  
> +	ring = &priv->ring[skb->queue_mapping];

Please just pass the ring pointer into hns3_nic_maybe_stop_tx() instead of
needlessly recalculating it.

Thank you.
