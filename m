Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5FBC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FC620881
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 19:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558640970;
	bh=12OvtLJ+C7mV68x8yhIzFoFCz/QlQ+RzX5Rhw8VAU6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SRvvCo95A4EyOW/ge7513CTz70RQF8sNUk6snFO811A3Xod9rhZszlyXprM+nQahH
	 1Px3DL6mvhFi9RAUr+5ZFGim+WqbeOY7Ski/8ElISyTmveEmsuMiHu3eMnVPOhqiLa
	 a5TR4szE2jDkfLaoxMoUUkKYqIr9UXZkNQA6/T/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbfEWTt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 15:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388010AbfEWTK5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 15:10:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110AB217D9;
        Thu, 23 May 2019 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558638656;
        bh=12OvtLJ+C7mV68x8yhIzFoFCz/QlQ+RzX5Rhw8VAU6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xhnyFM1fD0e7YUvqj6k+3Yy9POlb8JjYuRk7HXRC2ELhxAs05ix7DaOcPyduBvAYx
         WGOAHrbPJZIwAXJYZUNlZdeUvxkI/RZblSDhEY0d/9A476QCRpcoGgXiML2axu2Cpj
         JrUxzUERVAgnZhQkq8tAwlVmxLot5UdVPq7T5ilw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yunjian Wang <wangyunjian@huawei.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 02/77] net/mlx4_core: Change the error print to info print
Date:   Thu, 23 May 2019 21:05:20 +0200
Message-Id: <20190523181720.327324775@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190523181719.982121681@linuxfoundation.org>
References: <20190523181719.982121681@linuxfoundation.org>
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
@@ -1490,7 +1490,7 @@ int mlx4_flow_steer_promisc_add(struct m
 	rule.port = port;
 	rule.qpn = qpn;
 	INIT_LIST_HEAD(&rule.list);
-	mlx4_err(dev, "going promisc on %x\n", port);
+	mlx4_info(dev, "going promisc on %x\n", port);
 
 	return  mlx4_flow_attach(dev, &rule, regid_p);
 }


