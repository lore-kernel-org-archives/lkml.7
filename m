Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D68C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5672546C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190381;
	bh=xTl7DyP7IZ2wKvEoH3w3lHCjyDnJbp8ZoM3fWE65GKY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XWJEC7yxICLN7jMxEnaYhvEV4QPdDIbvl6YpCzULSwrZi6qHl4NC9To/lQwjP1m9O
	 drnepVnAa2VMMxlyST2KBIztW+Ax5qIY4IRnvx/dj+eQC4EmIAM0WOckiHqvctewnj
	 8vWUigBNOQcjJpQoqrv1h5+GnUPfMLyNek7Qa4Ec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732622AbfE3E0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbfE3DOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:14:35 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E46AB24595;
        Thu, 30 May 2019 03:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186075;
        bh=xTl7DyP7IZ2wKvEoH3w3lHCjyDnJbp8ZoM3fWE65GKY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XUhb0vslaKE/ARWph1mku+kFuQCz8UfjxBnvzy6S4fRp1OkQiI7R2NVh2zu4DM7AJ
         DhZnRLqdgnvTqcLo2Tv1Fb8PT/cME5/9ZrCgvkBXIYhJeHdWke2LC9NASrc5OJJaGU
         frRbeqgiq6/vubQY295ZIiWTWe6tYMbUVyrLIla8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Li <lipeng321@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 191/346] net: hns3: free the pending skb when clean RX ring
Date:   Wed, 29 May 2019 20:04:24 -0700
Message-Id: <20190530030550.749358221@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cc5ff6e90f808f9a4c8229bf2f1de0dfe5d7931c ]

If there is pending skb in RX flow when close the port, and the
pending buffer is not cleaned, the new packet will be added to
the pending skb when the port opens again, and the first new
packet has error data.

This patch cleans the pending skb when clean RX ring.

Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index ecadd280ab28d..fb5cb15aea9ec 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3871,6 +3871,13 @@ static int hns3_clear_rx_ring(struct hns3_enet_ring *ring)
 		ring_ptr_move_fw(ring, next_to_use);
 	}
 
+	/* Free the pending skb in rx ring */
+	if (ring->skb) {
+		dev_kfree_skb_any(ring->skb);
+		ring->skb = NULL;
+		ring->pending_buf = 0;
+	}
+
 	return 0;
 }
 
-- 
2.20.1



