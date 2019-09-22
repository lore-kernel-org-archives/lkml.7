Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702E7C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDE2208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178699;
	bh=4TiQxJJfR3qDJTi4w87i1jLrhWKWJHCVRA0qnfV3P2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IQi3ngrQXcFtT24Pfy1/HuvNezG/Sh/JkilfmPlsD5VkxbZDg9/KyNA5JGU3rJY2Z
	 ZfxnrBO8x1o9zO4DWt/tCJ6JC4NmMrGcmxfIYGJDVw0KOKlmV9g6xl1LNHpp+qO7ay
	 9WiRjCOt10AIpo4tQac/dvRXx+sRiAReNxTGt4Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405417AbfIVS6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:58:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393667AbfIVS6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:58:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B53321907;
        Sun, 22 Sep 2019 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178694;
        bh=4TiQxJJfR3qDJTi4w87i1jLrhWKWJHCVRA0qnfV3P2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLVJroTNdTFwSBZjKUo8ig2bLBZQ1Pxr/50RSiwmyGyTQtGTEugSlBIlOjoaHCKyd
         PszMCxs670zW0uD6T2cOjiVlqA47CEdTUln73iLHdYBQ3Uh6HmfRIlaBheJgb7wLNu
         syAP2KfGW85hYUosvlOh7org9g37lZ6q4xIjoFFc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 34/89] media: mtk-mdp: fix reference count on old device tree
Date:   Sun, 22 Sep 2019 14:56:22 -0400
Message-Id: <20190922185717.3412-34-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

[ Upstream commit 864919ea0380e62adb2503b89825fe358acb8216 ]

of_get_next_child() increments the reference count of the returning
device_node. Decrement it in the check if we are using the old or the
new DTB.

Fixes: ba1f1f70c2c0 ("[media] media: mtk-mdp: Fix mdp device tree")
Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Acked-by: Houlong Wei <houlong.wei@mediatek.com>
[hverkuil-cisco@xs4all.nl: use node instead of parent as temp variable]
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
index bbb24fb95b951..3deb0549b1a13 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_core.c
@@ -118,7 +118,9 @@ static int mtk_mdp_probe(struct platform_device *pdev)
 	mutex_init(&mdp->vpulock);
 
 	/* Old dts had the components as child nodes */
-	if (of_get_next_child(dev->of_node, NULL)) {
+	node = of_get_next_child(dev->of_node, NULL);
+	if (node) {
+		of_node_put(node);
 		parent = dev->of_node;
 		dev_warn(dev, "device tree is out of date\n");
 	} else {
-- 
2.20.1

