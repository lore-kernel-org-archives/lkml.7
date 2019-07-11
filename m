Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F09FC74A35
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6214221670
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 13:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbfGKN0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 09:26:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50518 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728107AbfGKN0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 09:26:54 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 542459F46BCE5531996B;
        Thu, 11 Jul 2019 21:26:51 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 11 Jul 2019 21:26:41 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     <wangkefeng.wang@huawei.com>
Subject: [PATCH] hpet: Drop unused variable 'm' in hpet_interrupt()
Date:   Thu, 11 Jul 2019 21:32:38 +0800
Message-ID: <20190711133238.131602-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

../drivers/char/hpet.c:159:17: warning: variable ‘m’ set but not used
[-Wunused-but-set-variable]
   unsigned long m, t, mc, base, k;
                 ^
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/char/hpet.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index 9ac6671bb514..039398cb14aa 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -156,12 +156,11 @@ static irqreturn_t hpet_interrupt(int irq, void *data)
 	 * This has the effect of treating non-periodic like periodic.
 	 */
 	if ((devp->hd_flags & (HPET_IE | HPET_PERIODIC)) == HPET_IE) {
-		unsigned long m, t, mc, base, k;
+		unsigned long t, mc, base, k;
 		struct hpet __iomem *hpet = devp->hd_hpet;
 		struct hpets *hpetp = devp->hd_hpets;
 
 		t = devp->hd_ireqfreq;
-		m = read_counter(&devp->hd_timer->hpet_compare);
 		mc = read_counter(&hpet->hpet_mc);
 		/* The time for the next interrupt would logically be t + m,
 		 * however, if we are very unlucky and the interrupt is delayed
-- 
2.20.1

