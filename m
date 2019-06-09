Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEBDC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D2B20652
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 17:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560100463;
	bh=VFkskKXuTveck6cdC4o/VJ39pmBGxftl8/8VX5gn+EA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foIrESW5rlr2FD0r7hYx6gfMC2Ktp/dtbhDFUhcpuFHtX7A7Tpo37eWvRva4sxAaZ
	 YDAFHzpzxR4LdL9cthIJndP0k5yzGHqadMJhRMPc7hb3s1aie6noGmhA70IIRziH/v
	 syUxkzJ95ranpjhu0lpA8avs+YNHyuTIt/qwamxU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfFIQ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 12:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733073AbfFIQ47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 12:56:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D20C9205ED;
        Sun,  9 Jun 2019 16:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560099419;
        bh=VFkskKXuTveck6cdC4o/VJ39pmBGxftl8/8VX5gn+EA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HGCoYdAHgoRvJuvFwaMCPjmMmxtC3+aYhbjIMgZpZV8AQNgji3omtIGmZAxq0uk5A
         jWgNnRI1Z68UT1D6ejIZFrBygdcx3FPxdPG68JatX0UUGVvbG9S6x1/G5hPYF5MWne
         zUrFyuLB3vPKtqd2A/dpLQKh2PLnnnOz4BHm56go=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunjian Wang <wangyunjian@huawei.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 033/241] net/mlx4_core: Change the error print to info print
Date:   Sun,  9 Jun 2019 18:39:35 +0200
Message-Id: <20190609164148.734357532@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190609164147.729157653@linuxfoundation.org>
References: <20190609164147.729157653@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yunjian Wang <wangyunjian@huawei.com>

[ Upstream commit 00f9fec48157f3734e52130a119846e67a12314b ]

The error print within mlx4_flow_steer_promisc_add() should
be a info print.

Fixes: 592e49dda812 ('net/mlx4: Implement promiscuous mode with device managed flow-steering')
Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
Reviewed-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx4/mcg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx4/mcg.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mcg.c
@@ -1485,7 +1485,7 @@ int mlx4_flow_steer_promisc_add(struct m
 	rule.port = port;
 	rule.qpn = qpn;
 	INIT_LIST_HEAD(&rule.list);
-	mlx4_err(dev, "going promisc on %x\n", port);
+	mlx4_info(dev, "going promisc on %x\n", port);
 
 	return  mlx4_flow_attach(dev, &rule, regid_p);
 }


