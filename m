Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF5CC4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AB42067B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 20:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403810AbfIPU3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 16:29:41 -0400
Received: from smtp11.smtpout.orange.fr ([80.12.242.133]:20781 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbfIPU3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 16:29:41 -0400
Received: from localhost.localdomain ([90.126.97.183])
        by mwinf5d90 with ME
        id 2LVe2100A3xPcdm03LVfSU; Mon, 16 Sep 2019 22:29:39 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 16 Sep 2019 22:29:39 +0200
X-ME-IP: 90.126.97.183
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     agross@kernel.org, robdclark@gmail.com, joro@8bytes.org
Cc:     linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iommu/qcom: Simplify a test in 'qcom_iommu_add_device()'
Date:   Mon, 16 Sep 2019 22:29:36 +0200
Message-Id: <20190916202936.30403-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'iommu_group_get_for_dev()' never returns NULL, so this test can be
simplified a bit.

This way, the test is consistent with all other calls to
'iommu_group_get_for_dev()'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iommu/qcom_iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index c31e7bc4ccbe..3d99ec868892 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -539,8 +539,8 @@ static int qcom_iommu_add_device(struct device *dev)
 	}
 
 	group = iommu_group_get_for_dev(dev);
-	if (IS_ERR_OR_NULL(group))
-		return PTR_ERR_OR_ZERO(group);
+	if (IS_ERR(group))
+		return PTR_ERR(group);
 
 	iommu_group_put(group);
 	iommu_device_link(&qcom_iommu->iommu, dev);
-- 
2.20.1

