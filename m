Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8A8C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 543A32073F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 19:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfLCT5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 14:57:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52050 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726955AbfLCT5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 14:57:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6FFF11510CE14;
        Tue,  3 Dec 2019 11:57:42 -0800 (PST)
Date:   Tue, 03 Dec 2019 11:57:41 -0800 (PST)
Message-Id: <20191203.115741.976811473066862969.davem@davemloft.net>
To:     linyunsheng@huawei.com
Cc:     tanhuazhong@huawei.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, salil.mehta@huawei.com,
        yisen.zhuang@huawei.com, linuxarm@huawei.com,
        jakub.kicinski@netronome.com
Subject: Re: [PATCH net 2/3] net: hns3: fix a use after free problem in
 hns3_nic_maybe_stop_tx()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <138d0858-7240-ff75-a38c-55e10eefc28d@huawei.com>
References: <1575342535-2981-3-git-send-email-tanhuazhong@huawei.com>
        <20191202.192840.1366675580449158510.davem@davemloft.net>
        <138d0858-7240-ff75-a38c-55e10eefc28d@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 03 Dec 2019 11:57:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunsheng Lin <linyunsheng@huawei.com>
Date: Tue, 3 Dec 2019 12:22:11 +0800

> 2. When skb_copy() returns success, the hns3_nic_maybe_stop_tx()
> returns -EBUSY when there are not no enough space in the ring to
> send the skb to hardware, and hns3_nic_net_xmit() will return
> NETDEV_TX_BUSY to the upper layer, the upper layer will resend the old
> skb later when driver wakes up the queue, but the old skb has been freed
> by the hns3_nic_maybe_stop_tx(). Because when using the skb_copy() to
> linearize a skb, it will return a new linearized skb, and the old skb is
> freed, the upper layer does not have a reference to the new skb and resend
> using the old skb, which casues a use after freed problem.
> 
> This patch is trying to fixes the case 2.
> 
> Maybe I should mention why hns3_nic_maybe_stop_tx() returns -EBUSY to
> better describe the problem?

I think it would help understand the code path you are fixing, yes.
