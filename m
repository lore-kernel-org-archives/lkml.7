Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DE6C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE542206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 07:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="K73oALg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbfDZHkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 03:40:46 -0400
Received: from first.geanix.com ([116.203.34.67]:59694 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbfDZHkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 03:40:10 -0400
Received: from localhost (unknown [193.163.1.7])
        by first.geanix.com (Postfix) with ESMTPSA id 61D72308E6C;
        Fri, 26 Apr 2019 07:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1556263924; bh=5313xtr+yNTDsmcuqCe32aXr10PBLG2AXuF4LR0QT74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=K73oALg9SpWLS7rqOazJrUv2DeyjYsvaG0bILbpx4xaHV/kTxrl3Mc7ubfubSANJC
         RJQIDdSfg9mzU4HbOmN75iZNcG8/89BbQG5YOrUJheFHKHXTSbwxP132jBQxYFtMDC
         DaeK3xdEpj6dI7tl+O1hAbq3mPTIkVsMbH/fMxVfVUWioJZJGzUVe5kTuRxe4mB74Y
         hcVqhoJphpZhOZor1G24eVt9hMFQgXFFG+x/Rw6WjCFJtnCbNRjGS0wXoUg7MOD8Gv
         CBwgUEtkEx48adEAEjFxsAUJVHbCrDLhc5wEdEQ4VkR4NR3JzP15f/HDotXIZ3A+km
         B/dNt6ecCRxjw==
From:   Esben Haabendal <esben@geanix.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Yang Wei <yang.wei9@zte.com.cn>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/12] net: ll_temac: Replace bad usage of msleep() with usleep_range()
Date:   Fri, 26 Apr 2019 09:32:29 +0200
Message-Id: <20190426073231.4008-11-esben@geanix.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190426073231.4008-1-esben@geanix.com>
References: <20190426073231.4008-1-esben@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use usleep_range() to avoid problems with msleep() actually sleeping
much longer than expected.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/net/ethernet/xilinx/ll_temac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/ll_temac_main.c b/drivers/net/ethernet/xilinx/ll_temac_main.c
index def3886..a5ec8ba 100644
--- a/drivers/net/ethernet/xilinx/ll_temac_main.c
+++ b/drivers/net/ethernet/xilinx/ll_temac_main.c
@@ -92,7 +92,7 @@ int temac_indirect_busywait(struct temac_local *lp)
 			WARN_ON(1);
 			return -ETIMEDOUT;
 		}
-		msleep(1);
+		usleep_range(500, 1000);
 	}
 	return 0;
 }
-- 
2.4.11

