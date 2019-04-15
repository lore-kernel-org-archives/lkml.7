Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B45C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26E12073F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355926;
	bh=oGBYUkNNf7fpE2xWdzjrvvpQ7UkLeAgqYEA6iaF5hyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=no1/tqS1dji1rV5yGGNb3TIyy/D9v8um7HgNyyBPGVk08KqEDBY+6WX/Rqtz8WEOG
	 utBXFqGnmT14/KC2LRGv3nmkwHCDkNGNrmADYHZzoFlkgHJxeAS8BIFQRYEzMPZrUN
	 IDupXWe5VkjRUTjWP6Z+cASJw70NezjYMpeh0lok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbfDOTSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:18:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbfDOTLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7342F218DA;
        Mon, 15 Apr 2019 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355477;
        bh=oGBYUkNNf7fpE2xWdzjrvvpQ7UkLeAgqYEA6iaF5hyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LN7T+oqnn1IRBleD1uKF3oPmKmQvDGGm5u2xafeHImMQHp4LVCLxhPN5B4HlDfPLw
         5E9hEsigcU4lhE7jQa6hG9nt+Ht/RMTFW+LK2lNLB8SfU0pdNFMMuDw0d/FxLP3+lO
         NK6mvaNANApeCCzEP3HybVeA67V/a56uEZiUEonQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 036/117] net: vrf: Fix ping failed when vrf mtu is set to 0
Date:   Mon, 15 Apr 2019 21:00:06 +0200
Message-Id: <20190415183746.867873290@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5055376a3b44c4021de8830c9157f086a97731df ]

When the mtu of a vrf device is set to 0, it would cause ping
failed. So I think we should limit vrf mtu in a reasonable range
to solve this problem. I set dev->min_mtu to IPV6_MIN_MTU, so it
will works for both ipv4 and ipv6. And if dev->max_mtu still be 0
can be confusing, so I set dev->max_mtu to ETH_MAX_MTU.

Here is the reproduce step:

1.Config vrf interface and set mtu to 0:
3: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
master vrf1 state UP mode DEFAULT group default qlen 1000
    link/ether 52:54:00:9e:dd:c1 brd ff:ff:ff:ff:ff:ff

2.Ping peer:
3: enp4s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
master vrf1 state UP group default qlen 1000
    link/ether 52:54:00:9e:dd:c1 brd ff:ff:ff:ff:ff:ff
    inet 10.0.0.1/16 scope global enp4s0
       valid_lft forever preferred_lft forever
connect: Network is unreachable

3.Set mtu to default value, ping works:
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=64 time=1.88 ms

Fixes: ad49bc6361ca2 ("net: vrf: remove MTU limits for vrf device")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/vrf.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 6d1a1abbed27..cd15c32b2e43 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1275,8 +1275,12 @@ static void vrf_setup(struct net_device *dev)
 	dev->priv_flags |= IFF_NO_QUEUE;
 	dev->priv_flags |= IFF_NO_RX_HANDLER;
 
-	dev->min_mtu = 0;
-	dev->max_mtu = 0;
+	/* VRF devices do not care about MTU, but if the MTU is set
+	 * too low then the ipv4 and ipv6 protocols are disabled
+	 * which breaks networking.
+	 */
+	dev->min_mtu = IPV6_MIN_MTU;
+	dev->max_mtu = ETH_MAX_MTU;
 }
 
 static int vrf_validate(struct nlattr *tb[], struct nlattr *data[],
-- 
2.19.1



