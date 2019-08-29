Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E38C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C11F205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567103533;
	bh=ENnQuLStlcZZoMrEABGmkjS1ER3wIKINVJAynfvsm4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zMCM07f7Zw56c1UitmEycZQzP3r406311tZDxlPeglS+ISk2nj30o7v6t/6H2ekvu
	 8sHp+Kz5LNoMtubY1aO5ECV+488ZpCNHnzQerLeNmWwmJLdrKPEghBH1VOpJTdtMvJ
	 XMC5dkagULI5NbE97qLcav6KCeG+HbX2ElSyo54s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfH2SOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 14:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:56164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfH2SOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 14:14:31 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7ADB8233FF;
        Thu, 29 Aug 2019 18:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567102471;
        bh=ENnQuLStlcZZoMrEABGmkjS1ER3wIKINVJAynfvsm4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztvsSULnZYLgFrxMGhcVPnS/zw2lbvc4AwFZ/okL18zHtgKerG7qLCynqt4LqzTkd
         MeWXj4uWFxsz9RWL8tOH+sLOgpdI50IcfwDCUNgCHW5EBdjuKilhxzTd3KLgCDuML5
         ZCVda9+alnYoZeayljHC4pxkqqzHyVixLYKceRF4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wenwen Wang <wenwen@cs.uga.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 35/76] liquidio: add cleanup in octeon_setup_iq()
Date:   Thu, 29 Aug 2019 14:12:30 -0400
Message-Id: <20190829181311.7562-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190829181311.7562-1-sashal@kernel.org>
References: <20190829181311.7562-1-sashal@kernel.org>
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
index fcf20a8f92d94..6a823710987da 100644
--- a/drivers/net/ethernet/cavium/liquidio/request_manager.c
+++ b/drivers/net/ethernet/cavium/liquidio/request_manager.c
@@ -239,8 +239,10 @@ int octeon_setup_iq(struct octeon_device *oct,
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

