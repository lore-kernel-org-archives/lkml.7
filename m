Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D5CC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDF222084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 11:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbfFQLRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 07:17:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37082 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727599AbfFQLRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 07:17:16 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3F48C621E47ACC282D02;
        Mon, 17 Jun 2019 19:17:13 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 19:17:02 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>, <arm@kernel.org>,
        <linux-kernel@vger.kernel.org>, <joe@perches.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3] bus: hisi_lpc: Avoid use-after-free from probe failure
Date:   Mon, 17 Jun 2019 19:15:48 +0800
Message-ID: <1560770148-57960-1-git-send-email-john.garry@huawei.com>
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
and the released range memory may be later referenced.

As an interim fix, allocate the logical PIO range with kzalloc() to avoid
this memory being freed.

Further memory will not be leaked from later attempts to probe the
driver, as any attempts to allocate logical PIO ranges will fail, and we
would release the 'range' memory.

The correct fix for this problem would be to tear down what had been setup
during the probe, i.e. unregister the logical PIO range, but this is not
supported.

Support for unregistering logical PIO ranges will need be to added in
future.

Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
Signed-off-by: John Garry <john.garry@huawei.com>
---

Change in v2:
- update commit message

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

