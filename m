Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9800BC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6271121726
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567102957;
	bh=6rbCs0O8jH27lscYy6i4w8qwoKLjukmNyygFe4z4EQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D8GMrwpWHM+FqVNpAawz3mDJophTDUk/eA3ySnLrJkOGI4xKTCEKMSSWTO1HTTIVW
	 z6PrcaUnzkrUI9G/PZHiOiC9WRA5uk3mz0L74Afdd1UcHOjRvQSuwBiopm41sTbgcX
	 EG4J+sfvXRBU4oXNZUXxposR14+/pkU+3J68iN+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfH2SWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:22:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbfH2SRL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:17:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5710F23404;
        Thu, 29 Aug 2019 18:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102631;
        bh=6rbCs0O8jH27lscYy6i4w8qwoKLjukmNyygFe4z4EQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UcPIw19jO98z5z4P16CnHYqZsOfiDh6dEFB5PPfBRqyIcUYORQAuhkG9BrnYwDNcF
         VG0ooqUJ34wi1Bx+xmUCkgqGhZ98hFDNWdeabgfe7bbbc6WzdQ0JMxtSVM6ne6dN06
         UttS+zjMhPYI4u65yio1L2p1fg9sCglwc/20r9XI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/27] liquidio: add cleanup in octeon_setup_iq()
Date:   Thu, 29 Aug 2019 14:16:37 -0400
Message-Id: <20190829181655.8741-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181655.8741-1-sashal@kernel.org>
References: <20190829181655.8741-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wenwen Wang <wenwen@cs.uga.edu>

[ Upstream commit 6f967f8b1be7001b31c46429f2ee7d275af2190f ]

If oct->fn_list.enable_io_queues() fails, no cleanup is executed, leading
to memory/resource leaks. To fix this issue, invoke
octeon_delete_instr_queue() before returning from the function.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/liquidio/request_manager.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/request_manager.c b/drivers/net/ethernet/cavium/liquidio/request_manager.c
index 1e0fbce86d608..55e8731264634 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -232,8 +232,10 @@ int octeon_setup_iq(struct octeon_device *oct,
 	}
 
 	oct->num_iqs++;
-	if (oct->fn_list.enable_io_queues(oct))
+	if (oct->fn_list.enable_io_queues(oct)) {
+		octeon_delete_instr_queue(oct, iq_no);
 		return 1;
+	}
 
 	return 0;
 }
-- 
2.20.1

