Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DACEC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D9E2133D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 12:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kta6kvEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfFNMfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 08:35:44 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18914 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbfFNMfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 08:35:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d03949d0000>; Fri, 14 Jun 2019 05:35:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 14 Jun 2019 05:35:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 14 Jun 2019 05:35:41 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 12:35:41 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 14 Jun
 2019 12:35:41 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 14 Jun 2019 12:35:41 +0000
Received: from dhcp-10-19-65-14.client.nvidia.com (Not Verified[10.19.65.14]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d03949b0005>; Fri, 14 Jun 2019 05:35:41 -0700
From:   Bitan Biswas <bbiswas@nvidia.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC:     Bitan Biswas <bbiswas@nvidia.com>
Subject: [PATCH V1 2/2] mailbox: tegra: avoid resume NULL mailboxes
Date:   Fri, 14 Jun 2019 05:35:34 -0700
Message-ID: <1560515734-2085-2-git-send-email-bbiswas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560515734-2085-1-git-send-email-bbiswas@nvidia.com>
References: <1560515734-2085-1-git-send-email-bbiswas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560515741; bh=W0vodVafNnZ9SVYrkOcPCGni/aGjg0Pc6LT5sGuXzWY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=kta6kvEga9Ppkn3G3zREviAkmVh8jYdDmzK1qMkmRBVpzNO0SLhigs4uh52QzaTQo
         51bkA+JhkpUYw38oFmlmJYCqIV1zf+jQ+1y0x9XYgE3BbbnzfMfjj4dRyVYNFaurfT
         PcgaKzpY0G71r3qDB71vRkif4/xu5DShFG+95HakLQ+AuUhfRZ9rp+BKtg0ae73HAD
         wtxJEd0SGd6iUx5HK06pDqEChChB/QxfiNFEdY2ORr49rZUYcaUzpdAGlttIIlxcoU
         ElF8NlBljgmhlGLXQL7ccxppjTubds2pJavnb3hLXpfg42tDCsBXZLug8LLunoG4bm
         SW9eYpfl/Q7Aw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If Tegra hsp device tree does not have 'shared irqs',
mailboxes pointer is NULL. Add non-NULL HSP mailboxes
check in resume callback before tegra_hsp_mailbox_startup()
call and prevent NULL pointer exception.

Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index f147374..a11fb1c 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -782,11 +782,13 @@ static int __maybe_unused tegra_hsp_noirq_resume(struct device *dev)
 			tegra_hsp_doorbell_startup(db->channel.chan);
 	}
 
-	for (i = 0; i < hsp->num_sm; i++) {
-		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
+	if (hsp->mailboxes) {
+		for (i = 0; i < hsp->num_sm; i++) {
+			struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
 
-		if (mb->channel.chan->cl)
-			tegra_hsp_mailbox_startup(mb->channel.chan);
+			if (mb->channel.chan->cl)
+				tegra_hsp_mailbox_startup(mb->channel.chan);
+		}
 	}
 
 	return 0;
-- 
2.7.4

