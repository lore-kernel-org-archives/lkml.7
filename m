Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E91C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C7D21773
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfFNK0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:26:21 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726884AbfFNK0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:26:21 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2E17F8C56086200B960B;
        Fri, 14 Jun 2019 18:26:17 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 18:26:08 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <joe@perches.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2] bus: hisi_lpc: Don't use devm_kzalloc() to allocate logical PIO range
Date:   Fri, 14 Jun 2019 18:24:53 +0800
Message-ID: <1560507893-42553-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If, after registering a logical PIO range, the driver probe later fails,
the logical PIO range memory will be released automatically.

This causes an issue, in that the logical PIO range is not unregistered
(that is not supported) and the released range memory may be later
referenced

Allocate the logical PIO range with kzalloc() to avoid this potential
issue.

Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
Signed-off-by: John Garry <john.garry@huawei.com>
---

Change to v1:
- add comment, as advised by Joe Perches

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 19d7b6ff2f17..5f0130a693fe 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -599,7 +599,8 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	if (IS_ERR(lpcdev->membase))
 		return PTR_ERR(lpcdev->membase);
 
-	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
+	/* Logical PIO may reference 'range' memory even if the probe fails */
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
 	if (!range)
 		return -ENOMEM;
 
@@ -610,6 +611,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	ret = logic_pio_register_range(range);
 	if (ret) {
 		dev_err(dev, "register IO range failed (%d)!\n", ret);
+		kfree(range);
 		return ret;
 	}
 	lpcdev->io_host = range;
-- 
2.17.1

