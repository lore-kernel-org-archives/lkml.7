Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B409C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6208B2086D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 02:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfHFCBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 22:01:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731359AbfHFCBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 22:01:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id AD00BD92B20D5C7FB7AE;
        Tue,  6 Aug 2019 10:00:58 +0800 (CST)
Received: from [127.0.0.1] (10.65.87.206) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 6 Aug 2019
 10:00:52 +0800
Subject: Re: [PATCH v1 1/3] net: hisilicon: make hip04_tx_reclaim
 non-reentrant
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
References: <1564835501-90257-1-git-send-email-xiaojiangfeng@huawei.com>
 <1564835501-90257-2-git-send-email-xiaojiangfeng@huawei.com>
 <20190805174618.2b3b551a@cakuba.netronome.com>
CC:     <davem@davemloft.net>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <leeyou.li@huawei.com>,
        <xiaowei774@huawei.com>, <nixiaoming@huawei.com>
From:   Jiangfeng Xiao <xiaojiangfeng@huawei.com>
Message-ID: <c150d41b-6f0e-ad49-e8c2-00896fc9cbe4@huawei.com>
Date:   Tue, 6 Aug 2019 10:00:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20190805174618.2b3b551a@cakuba.netronome.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.65.87.206]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/8/6 8:46, Jakub Kicinski wrote:
> On Sat, 3 Aug 2019 20:31:39 +0800, Jiangfeng Xiao wrote:
>> If hip04_tx_reclaim is interrupted while it is running
>> and then __napi_schedule continues to execute
>> hip04_rx_poll->hip04_tx_reclaim, reentrancy occurs
>> and oops is generated. So you need to mask the interrupt
>> during the hip04_tx_reclaim run.
> 
> Napi poll method for the same napi instance can't be run concurrently.
> Could you explain a little more what happens here?
> 
Because netif_napi_add(ndev, &priv->napi, hip04_rx_poll, NAPI_POLL_WEIGHT);
So hip04_rx_poll is a napi instance.
I did not say that hip04_rx_poll has reentered.
I am talking about the reentrant of hip04_tx_reclaim.


Pre-modification code:
static int hip04_rx_poll(struct napi_struct *napi, int budget)
{
	[...]
	/* enable rx interrupt */
	writel_relaxed(priv->reg_inten, priv->base + PPE_INTEN);

	napi_complete_done(napi, rx);
done:
	/* clean up tx descriptors and start a new timer if necessary */
	tx_remaining = hip04_tx_reclaim(ndev, false);
	[...]
}
hip04_tx_reclaim is executed after "enable rx interrupt" and napi_complete_done.

If hip04_tx_reclaim is interrupted while it is running, and then
__irq_svc->gic_handle_irq->hip04_mac_interrupt->__napi_schedule->hip04_rx_poll->hip04_tx_reclaim


Also looking at hip04_tx_reclaim

static int hip04_tx_reclaim(struct net_device *ndev, bool force)
{
[1]     struct hip04_priv *priv = netdev_priv(ndev);
[2]     unsigned tx_tail = priv->tx_tail;
[3]	[...]
[4]	bytes_compl += priv->tx_skb[tx_tail]->len;
[5]	dev_kfree_skb(priv->tx_skb[tx_tail]);
[6]	priv->tx_skb[tx_tail] = NULL;
[7]	tx_tail = TX_NEXT(tx_tail);
[8]	[...]
[9]	priv->tx_tail = tx_tail;
}

An interrupt occurs if hip04_tx_reclaim just executes to the line 6,
priv->tx_skb[tx_tail] is NULL, and then
__irq_svc->gic_handle_irq->hip04_mac_interrupt->__napi_schedule->hip04_rx_poll->hip04_tx_reclaim

Then hip04_tx_reclaim will handle kernel NULL pointer dereference on line 4.
A reentrant occurs in hip04_tx_reclaim and oops is generated.





My commit is to execute hip04_tx_reclaim before "enable rx interrupt" and napi_complete_done.
Then hip04_tx_reclaim can also be protected by the napi poll method so that no reentry occurs.

thanks.

