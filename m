Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA89C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7EF521874
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102843;
	bh=RLhCdPwpxOSNvXfN2xwUqJLR4K4EQHH731oqg9XXn7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t3A3fdCdWNdLwXRJ1Onv/TRHszZjC7kWN3+EcgmFFEdKHXZmhfsP1FlSOtvzo/I2j
	 S/ZCfevGD6osCJcVZBu/uJyNN3wYyDSrf4+Q6Gq1Ov5joRZ4I/d8GTCH//cDEhEt94
	 EZd8fTTP8nymaOIYucXu98SNUp032xAmOahpGMnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbfH2SUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:20:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:59988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730192AbfH2SRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:17:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 573F12189D;
        Thu, 29 Aug 2019 18:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102666;
        bh=RLhCdPwpxOSNvXfN2xwUqJLR4K4EQHH731oqg9XXn7k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PvFQrlUvY2d2dM3rOwjjEEieiOP2SfY35ZTBtlUu0kSrNCj+djUgKHgZTj5BnswWL
         uvDHlGuBJjJe9MAYcgD22GMzm0XEoahyxmPW6cZ6wo/KWu93i7EjGktpZYXBLejm7y
         Ikc63gHk+8Ld7jAQmKapv5hVeDHxy76hTW+TNFu8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 06/16] cxgb4: fix a memory leak bug
Date:   Thu, 29 Aug 2019 14:17:24 -0400
Message-Id: <20190829181736.9040-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181736.9040-1-sashal@kernel.org>
References: <20190829181736.9040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit c554336efa9bbc28d6ec14efbee3c7d63c61a34f ]

In blocked_fl_write(), 't' is not deallocated if bitmap_parse_user() fails,
leading to a memory leak bug. To fix this issue, free t before returning
the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index 20455d082cb80..61c55621b9589 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -2781,8 +2781,10 @@ static ssize_t blocked_fl_write(struct file *filp, const char __user *ubuf,
 		return -ENOMEM;
 
 	err = bitmap_parse_user(ubuf, count, t, adap->sge.egr_sz);
-	if (err)
+	if (err) {
+		kvfree(t);
 		return err;
+	}
 
 	bitmap_copy(adap->sge.blocked_fl, t, adap->sge.egr_sz);
 	t4_free_mem(t);
-- 
2.20.1

