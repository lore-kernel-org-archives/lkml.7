Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4EBCA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E95C520867
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 18:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfJZSWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 14:22:37 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47836 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfJZSWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 14:22:36 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EA13614DE9796;
        Sat, 26 Oct 2019 11:22:35 -0700 (PDT)
Date:   Sat, 26 Oct 2019 11:22:35 -0700 (PDT)
Message-Id: <20191026.112235.711416398803098524.davem@davemloft.net>
To:     xiaojiangfeng@huawei.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        leeyou.li@huawei.com, zhanghan23@huawei.com, nixiaoming@huawei.com,
        zhangqiang.cn@hisilicon.com, dingjingcheng@hisilicon.com
Subject: Re: [PATCH] net: hisilicon: Fix ping latency when deal with high
 throughput
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1572079779-76449-1-git-send-email-xiaojiangfeng@huawei.com>
References: <1572079779-76449-1-git-send-email-xiaojiangfeng@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 26 Oct 2019 11:22:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Date: Sat, 26 Oct 2019 16:49:39 +0800

> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
> index ad6d912..78f338a 100644
> --- a/drivers/net/ethernet/hisilicon/hip04_eth.c
> +++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
> @@ -575,7 +575,7 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
>  	struct hip04_priv *priv = container_of(napi, struct hip04_priv, napi);
>  	struct net_device *ndev = priv->ndev;
>  	struct net_device_stats *stats = &ndev->stats;
> -	unsigned int cnt = hip04_recv_cnt(priv);
> +	static unsigned int cnt_remaining;

There is no way a piece of software state should be system wide, this is
a per device instance value.
