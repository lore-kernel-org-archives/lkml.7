Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE29C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934372177E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfFNJs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:48:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34378 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfFNJs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:48:26 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B4271B86F5AD6BE50AD7;
        Fri, 14 Jun 2019 17:48:23 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 17:48:13 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, John Garry <john.garry@huawei.com>
Subject: [PATCH] bus: hisi_lpc: Don't use devm_kzalloc() to allocate logical PIO range
Date:   Fri, 14 Jun 2019 17:47:04 +0800
Message-ID: <1560505624-39955-1-git-send-email-john.garry@huawei.com>
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

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 19d7b6ff2f17..d9ab4e76010d 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -599,7 +599,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	if (IS_ERR(lpcdev->membase))
 		return PTR_ERR(lpcdev->membase);
 
-	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
 	if (!range)
 		return -ENOMEM;
 
@@ -610,6 +610,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	ret = logic_pio_register_range(range);
 	if (ret) {
 		dev_err(dev, "register IO range failed (%d)!\n", ret);
+		kfree(range);
 		return ret;
 	}
 	lpcdev->io_host = range;
-- 
2.17.1

