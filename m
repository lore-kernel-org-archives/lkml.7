Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40425C43215
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F5C206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfLDBdN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:33:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6744 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfLDBdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:33:12 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 318A2BB3A126AFFCA833;
        Wed,  4 Dec 2019 09:33:11 +0800 (CST)
Received: from [127.0.0.1] (10.74.191.121) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 09:33:05 +0800
Subject: Re: [PATCH net 2/3] net: hns3: fix a use after free problem in
 hns3_nic_maybe_stop_tx()
To:     David Miller <davem@davemloft.net>
CC:     <tanhuazhong@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <salil.mehta@huawei.com>,
        <yisen.zhuang@huawei.com>, <linuxarm@huawei.com>,
        <jakub.kicinski@netronome.com>
References: <1575342535-2981-3-git-send-email-tanhuazhong@huawei.com>
 <20191202.192840.1366675580449158510.davem@davemloft.net>
 <138d0858-7240-ff75-a38c-55e10eefc28d@huawei.com>
 <20191203.115741.976811473066862969.davem@davemloft.net>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <8901eba5-17a1-bd16-841c-3858475cfb71@huawei.com>
Date:   Wed, 4 Dec 2019 09:33:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <20191203.115741.976811473066862969.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.191.121]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/4 3:57, David Miller wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Tue, 3 Dec 2019 12:22:11 +0800
> 
>> 2. When skb_copy() returns success, the hns3_nic_maybe_stop_tx()
>> returns -EBUSY when there are not no enough space in the ring to
>> send the skb to hardware, and hns3_nic_net_xmit() will return
>> NETDEV_TX_BUSY to the upper layer, the upper layer will resend the old
>> skb later when driver wakes up the queue, but the old skb has been freed
>> by the hns3_nic_maybe_stop_tx(). Because when using the skb_copy() to
>> linearize a skb, it will return a new linearized skb, and the old skb is
>> freed, the upper layer does not have a reference to the new skb and resend
>> using the old skb, which casues a use after freed problem.
>>
>> This patch is trying to fixes the case 2.
>>
>> Maybe I should mention why hns3_nic_maybe_stop_tx() returns -EBUSY to
>> better describe the problem?
> 
> I think it would help understand the code path you are fixing, yes.

Will mention that in the next version, thanks.

> 
> .
> 

