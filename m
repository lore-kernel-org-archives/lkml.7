Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA2CC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF2121479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 10:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbfDRKAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 06:00:30 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35670 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733049AbfDRKAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 06:00:30 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0AF69772A36535CE5C0A;
        Thu, 18 Apr 2019 18:00:28 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Apr 2019 18:00:17 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <robert.jarzmik@free.fr>, <axboe@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH] lib: scatterlist: Fix to support no mapped sg
Date:   Thu, 18 Apr 2019 17:50:06 +0800
Message-ID: <1555581006-153458-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function sg_split, the second sg_calculate_split will return -EINVAL
when in_mapped_nents is 0.

Indeed there is no need to do second sg_calculate_split and sg_split_mapped
when in_mapped_nents is 0, as in_mapped_nents indicates no mapped entry in
original sgl.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 lib/sg_split.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/sg_split.c b/lib/sg_split.c
index b063410..d4181c8 100644
--- a/lib/sg_split.c
+++ b/lib/sg_split.c
@@ -178,11 +178,13 @@ int sg_split(struct scatterlist *in, const int in_mapped_nents,
 	 * The order of these 3 calls is important and should be kept.
 	 */
 	sg_split_phys(splitters, nb_splits);
-	ret = sg_calculate_split(in, in_mapped_nents, nb_splits, skip,
-				 split_sizes, splitters, true);
-	if (ret < 0)
-		goto err;
-	sg_split_mapped(splitters, nb_splits);
+	if (in_mapped_nents) {
+		ret = sg_calculate_split(in, in_mapped_nents, nb_splits, skip,
+					 split_sizes, splitters, true);
+		if (ret < 0)
+			goto err;
+		sg_split_mapped(splitters, nb_splits);
+	}
 
 	for (i = 0; i < nb_splits; i++) {
 		out[i] = splitters[i].out_sg;
-- 
2.8.1

