Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE00CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A11C20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 14:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfJaONp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 10:13:45 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbfJaONo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 10:13:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AA2AC92789834D879914;
        Thu, 31 Oct 2019 22:13:40 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 22:13:31 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <mripard@kernel.org>,
        <zhongjiang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: sun4i: Use PTR_ERR_OR_ZERO to simplify the code
Date:   Thu, 31 Oct 2019 22:09:39 +0800
Message-ID: <1572530979-27595-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d58..72012a6 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1174,10 +1174,8 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	i2s->field_fmt_sr =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_fmt_sr);
-	if (IS_ERR(i2s->field_fmt_sr))
-		return PTR_ERR(i2s->field_fmt_sr);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);
 }
 
 static int sun4i_i2s_probe(struct platform_device *pdev)
-- 
1.7.12.4

