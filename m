Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BA1CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 15:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C60220863
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 15:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfJZPoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 11:44:54 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:48922 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbfJZPoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 11:44:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A39D8181D341E;
        Sat, 26 Oct 2019 15:44:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cakes35_6487dd8c3ac06
X-Filterd-Recvd-Size: 1961
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 26 Oct 2019 15:44:50 +0000 (UTC)
Message-ID: <cfde329c7ee3c9bb5610bd9b040f95214cc4d9e8.camel@perches.com>
Subject: Re: [PATCH] net: hisilicon: Fix ping latency when deal with high
 throughput
From:   Joe Perches <joe@perches.com>
To:     Jiangfeng Xiao <xiaojiangfeng@huawei.com>, davem@davemloft.net,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        leeyou.li@huawei.com, zhanghan23@huawei.com, nixiaoming@huawei.com,
        zhangqiang.cn@hisilicon.com, dingjingcheng@hisilicon.com
Date:   Sat, 26 Oct 2019 08:44:47 -0700
In-Reply-To: <1572079779-76449-1-git-send-email-xiaojiangfeng@huawei.com>
References: <1572079779-76449-1-git-send-email-xiaojiangfeng@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-26 at 16:49 +0800, Jiangfeng Xiao wrote:
> This is due to error in over budget processing.
> When dealing with high throughput, the used buffers
> that exceeds the budget is not cleaned up. In addition,
> it takes a lot of cycles to clean up the used buffer,
> and then the buffer where the valid data is located can take effect.
[]
> diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
[]
> @@ -575,7 +575,7 @@ static int hip04_rx_poll(struct napi_struct *napi, int budget)
>  	struct hip04_priv *priv = container_of(napi, struct hip04_priv, napi);
>  	struct net_device *ndev = priv->ndev;
>  	struct net_device_stats *stats = &ndev->stats;
> -	unsigned int cnt = hip04_recv_cnt(priv);
> +	static unsigned int cnt_remaining;

static doesn't seem a great idea here as it's for just a single
driver instance.  Maybe make this part of struct hip04_priv?


