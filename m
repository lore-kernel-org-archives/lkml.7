Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82360C32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E60520830
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570123291;
	bh=4TiQxJJfR3qDJTi4w87i1jLrhWKWJHCVRA0qnfV3P2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2cq6qT35J6PiPYUS4UL69hnKVE3FH3rujzy2DS1q5GpuMyaSqpYZwgIEiG5bYXhY
	 jG/ERAFj2DljQKzhAZV8Xiyu62IoKU3mSXn+eqUvCX7NLiP0MnyPHZNto8PYK1H7Dj
	 hoLD174w7+bV1i6eDhXvLtIkewd5aRGS6Np+7uUI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbfJCQRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389272AbfJCQRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:17:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B74A120865;
        Thu,  3 Oct 2019 16:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570119455;
        bh=4TiQxJJfR3qDJTi4w87i1jLrhWKWJHCVRA0qnfV3P2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xd/6doLMQLqeHyGtWyxTGjyMa9VnzUmkgRftVaIHD3fK9GD3KMFuVz95Egk3kKA9i
         cwlwLW4JlUfdOERTArvwL728TudiCH4PzMiNosKacAAC4qar6wwwFOrgZq0XgHL2d1
         ZsGSzTEI1O+Ig9SOQHJIWKZb7g57IXc9N/cfmnao=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 069/211] media: mtk-mdp: fix reference count on old device tree
Date:   Thu,  3 Oct 2019 17:52:15 +0200
Message-Id: <20191003154504.095569430@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154447.010950442@linuxfoundation.org>
References: <20191003154447.010950442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



