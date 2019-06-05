Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D420C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38234206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfFEORA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:17:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:34576 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728382AbfFEOQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:16:55 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D6C3D9CA05EE12061804;
        Wed,  5 Jun 2019 22:16:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 5 Jun 2019 22:16:38 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>
Subject: [PATCH] Input: alps: Drop unlikely before IS_ERR(_OR_NULL)
Date:   Wed, 5 Jun 2019 22:24:28 +0800
Message-ID: <20190605142428.84784-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
so no need to do that again from its callers. Drop it.

Cc: "Pali Rohár" <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/input/mouse/alps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 0a6f7ca883e7..791ef0f826c5 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1478,7 +1478,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 		/* On V2 devices the DualPoint Stick reports bare packets */
 		dev = priv->dev2;
 		dev2 = psmouse->dev;
-	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
+	} else if (IS_ERR_OR_NULL(priv->dev3)) {
 		/* Register dev3 mouse if we received PS/2 packet first time */
 		if (!IS_ERR(priv->dev3))
 			psmouse_queue_work(psmouse, &priv->dev3_register_work,
-- 
2.20.1

