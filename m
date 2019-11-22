Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DABFC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4825F2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574403773;
	bh=jQ1iFzeS+vCtqt56Z82AOL2Hls9N2/gLhDuxtgK3EXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KuM5EPwk3LWYhR0NbVapy+OK/39EJ8Sm/RDQuZ7t07gxMN4DsB7K1Y3opt59PBtMp
	 Dc2X1MqTrFSWdz4GNDYSrmI4y0Jz5C5h6hrgs0s4shriZTLbepuAuexE3wUahMVWLK
	 wM+nmWnZrXm6Ta3hWk7frWFbSvGOsjYGeObg5i44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfKVGWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:22:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:57234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728320AbfKVFvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:51:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2330020726;
        Fri, 22 Nov 2019 05:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401914;
        bh=jQ1iFzeS+vCtqt56Z82AOL2Hls9N2/gLhDuxtgK3EXo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zZrKmttk3iE92veqOw7VTislUPHAzwHN1eYolHCvyeP/zcuxkjf+31X0L2pF1KBYw
         AxceKufmmvpjpMxvMkNLQ42Xe7N/pv6GP5mKyeRY9jVrFEu5ydNLRuGCHk4ZzD+xZU
         ze0QVfwWfg+iG7sfF4KIBQavoETJRtw2DYofAMFQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kangjie Lu <kjlu@umn.edu>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 145/219] net: (cpts) fix a missing check of clk_prepare
Date:   Fri, 22 Nov 2019 00:47:57 -0500
Message-Id: <20191122054911.1750-138-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kangjie Lu <kjlu@umn.edu>

[ Upstream commit 2d822f2dbab7f4c820f72eb8570aacf3f35855bd ]

clk_prepare() could fail, so let's check its status, and if it fails,
return its error code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ti/cpts.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpts.c b/drivers/net/ethernet/ti/cpts.c
index b96b93c686bf1..4f644ac314fe8 100644
--- a/drivers/net/ethernet/ti/cpts.c
+++ b/drivers/net/ethernet/ti/cpts.c
@@ -572,7 +572,9 @@ struct cpts *cpts_create(struct device *dev, void __iomem *regs,
 		return ERR_CAST(cpts->refclk);
 	}
 
-	clk_prepare(cpts->refclk);
+	ret = clk_prepare(cpts->refclk);
+	if (ret)
+		return ERR_PTR(ret);
 
 	cpts->cc.read = cpts_systim_read;
 	cpts->cc.mask = CLOCKSOURCE_MASK(32);
-- 
2.20.1

