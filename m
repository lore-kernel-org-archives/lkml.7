Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E8C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8987F21841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563998811;
	bh=y5aMZuNFOBLZnnkx+88Nli9ZhgKfyb91ZWUVryMTH8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FSBPJVqyjdZvgmlO0HdauSgtmaav9zGw1HoUH5agPgKv/rX4PJERk6NhHziZ0SxTF
	 A4nntcbBGf3y25kmQLVrS0+vYn6eryZdOuvuaCbtU7cxF0UhXG1SgtFxDrGVr+t+eu
	 ZnOUQj5FpT0oqr5mOSRr+Ytvx3FJKnDnwm+OpgA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405410AbfGXUEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:04:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392585AbfGXUEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:04:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA06E214AF;
        Wed, 24 Jul 2019 20:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998682;
        bh=y5aMZuNFOBLZnnkx+88Nli9ZhgKfyb91ZWUVryMTH8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZe+9/yMNMEXV9zTso0c10zdBSJxi3VTEuIQucOggPrGYm5uNGP/GH0NsIlWCHGl9
         cvZYmOfE32quslyN+8aDQi7VRuK6aTo7OwUK82Tdh3SdI11PIBN0LOtX0MFTSKC5os
         fGyxmsfn9uq0m4vHPCW8rrj9OrpKXMlkW1/WYHE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Weihang Li <liweihang@hisilicon.com>,
        Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 041/271] net: hns3: set ops to null when unregister ad_dev
Date:   Wed, 24 Jul 2019 21:18:30 +0200
Message-Id: <20190724191658.702135535@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191655.268628197@linuxfoundation.org>
References: <20190724191655.268628197@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 594a81b39525f0a17e92c2e0b167ae1400650380 ]

The hclge/hclgevf and hns3 module can be unloaded independently,
when hclge/hclgevf unloaded firstly, the ops of ae_dev should
be set to NULL, otherwise it will cause an use-after-free problem.

Fixes: 38caee9d3ee8 ("net: hns3: Add support of the HNAE3 framework")
Signed-off-by: Weihang Li <liweihang@hisilicon.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.c b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
index fff5be8078ac..0594a6c3dccd 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.c
@@ -229,6 +229,7 @@ void hnae3_unregister_ae_algo(struct hnae3_ae_algo *ae_algo)
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
+		ae_dev->ops = NULL;
 	}
 
 	list_del(&ae_algo->node);
@@ -316,6 +317,7 @@ void hnae3_unregister_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 		ae_algo->ops->uninit_ae_dev(ae_dev);
 		hnae3_set_bit(ae_dev->flag, HNAE3_DEV_INITED_B, 0);
+		ae_dev->ops = NULL;
 	}
 
 	list_del(&ae_dev->node);
-- 
2.20.1



