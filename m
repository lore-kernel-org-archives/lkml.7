Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88ACEC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54BB020659
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563996584;
	bh=2DEC+ycr/wGnBPp1D0XeMMkcHq/HhgHmZ/lIM1SAbgM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vyNrQYwXHdmqzlb8gWmmyEEtR9pTvUqVslq9ed2TbHetjQJMMlA9SO3APgXVT/rTj
	 dZkr8o+e0Kh8l+mig+ab+1gj46yGYzdO3c3PJrXaicWwl4VqHFgp6sMOQZLvbPt24X
	 uc/XU/wCTYNApNuXR2n8rA28V0mMZGuv7A4V86+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfGXT3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:29:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729350AbfGXT3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:29:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FDDA21951;
        Wed, 24 Jul 2019 19:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563996578;
        bh=2DEC+ycr/wGnBPp1D0XeMMkcHq/HhgHmZ/lIM1SAbgM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dU3Oop7AgJJsQkWPNYTEGOTbBl1xlNtN3HwATFElSU+JUe9TltWUDIOX98tO6TVGl
         4E6hBAsZaMliYWUt4OAbSjQvwMsO7dr5Cwp3qxu+h6zUA6+ZuL1pFMSoO5suv5Cflf
         nI3coegF6U4+NNvxyJCAts32jO/N+6ABJGc3IL98=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 145/413] media: mt9m111: fix fw-node refactoring
Date:   Wed, 24 Jul 2019 21:17:16 +0200
Message-Id: <20190724191745.325875442@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 8d4e29a51a954b43e06d916772fa4f50b7e5bbd6 ]

In the patch refactoring the fw-node, the mt9m111 was broken for all
platform_data based platforms, which were the first aim of this
driver. Only the devicetree platform are still functional, probably
because the testing was done on these.

The result is that -EINVAL is systematically return for such platforms,
what this patch fixes.

[Sakari Ailus: Rework this to resolve a merge conflict and use dev_fwnode]

Fixes: 98480d65c48c ("media: mt9m111: allow to setup pixclk polarity")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/mt9m111.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
index 362c3b93636e..5a642b5ad076 100644
--- a/drivers/media/i2c/mt9m111.c
+++ b/drivers/media/i2c/mt9m111.c
@@ -1245,9 +1245,11 @@ static int mt9m111_probe(struct i2c_client *client,
 	if (!mt9m111)
 		return -ENOMEM;
 
-	ret = mt9m111_probe_fw(client, mt9m111);
-	if (ret)
-		return ret;
+	if (dev_fwnode(&client->dev)) {
+		ret = mt9m111_probe_fw(client, mt9m111);
+		if (ret)
+			return ret;
+	}
 
 	mt9m111->clk = v4l2_clk_get(&client->dev, "mclk");
 	if (IS_ERR(mt9m111->clk))
-- 
2.20.1



