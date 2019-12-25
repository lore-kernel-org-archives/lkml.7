Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC118C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCABD20722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfLYNQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 08:16:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39600 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726353AbfLYNQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 08:16:08 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 64C181EDCB8BF8285E13;
        Wed, 25 Dec 2019 21:16:02 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 21:15:54 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <john@phrozen.org>, <ralf@linux-mips.org>, <paulburton@kernel.org>,
        <jhogan@kernel.org>
CC:     <linux-mips@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yukuai3@huawei.com>, <zhengbin13@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] MIPS: ralink: add missing put_device in ill_acc_of_setup
Date:   Wed, 25 Dec 2019 21:15:20 +0800
Message-ID: <20191225131520.2505-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If of_find_device_by_node return 0 and ill_acc_of_setup return error,
pdev don't have a corresponding object release.

Fix it by adding put_device.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 arch/mips/ralink/ill_acc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/ralink/ill_acc.c b/arch/mips/ralink/ill_acc.c
index 0ddeb31afa93..bdf53807d7c2 100644
--- a/arch/mips/ralink/ill_acc.c
+++ b/arch/mips/ralink/ill_acc.c
@@ -67,11 +67,13 @@ static int __init ill_acc_of_setup(void)
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		dev_err(&pdev->dev, "failed to get irq\n");
+		put_device(&pdev->dev);
 		return -EINVAL;
 	}
 
 	if (request_irq(irq, ill_acc_irq_handler, 0, "ill_acc", &pdev->dev)) {
 		dev_err(&pdev->dev, "failed to request irq\n");
+		put_device(&pdev->dev);
 		return -EINVAL;
 	}
 
-- 
2.17.2

