Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F49C28CC3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 03:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9085C20717
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 03:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfFEDBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 23:01:34 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56264 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfFEDBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 23:01:34 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7DE4114FA9CC2;
        Tue,  4 Jun 2019 20:01:33 -0700 (PDT)
Date:   Tue, 04 Jun 2019 20:01:32 -0700 (PDT)
Message-Id: <20190604.200132.328184377847137118.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     idosch@mellanox.com, daniel@iogearbox.net, petrm@mellanox.com,
        jiri@mellanox.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingfangsen@huawei.com,
        wangxiaogang3@huawei.com
Subject: Re: [PATCH] net: ipvlan: Fix ipvlan device tso disabled while
 NETIF_F_IP_CSUM is set
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1559628454-138692-1-git-send-email-linmiaohe@huawei.com>
References: <1559628454-138692-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 04 Jun 2019 20:01:33 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>
Date: Tue, 4 Jun 2019 06:07:34 +0000

> There's some NICs, such as hinic, with NETIF_F_IP_CSUM and NETIF_F_TSO
> on but NETIF_F_HW_CSUM off. And ipvlan device features will be
> NETIF_F_TSO on with NETIF_F_IP_CSUM and NETIF_F_IP_CSUM both off as
> IPVLAN_FEATURES only care about NETIF_F_HW_CSUM. So TSO will be
> disabled in netdev_fix_features.
> For example:
> Features for enp129s0f0:
> rx-checksumming: on
> tx-checksumming: on
>         tx-checksum-ipv4: on
>         tx-checksum-ip-generic: off [fixed]
>         tx-checksum-ipv6: on
> 
> Fixes: a188222b6ed2 ("net: Rename NETIF_F_ALL_CSUM to NETIF_F_CSUM_MASK")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Applied.
