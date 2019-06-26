Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5EEC48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FB920665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 16:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFZQ2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 12:28:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50382 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbfFZQ2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 12:28:43 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6CE17EF3578678A11DCB;
        Thu, 27 Jun 2019 00:28:36 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Jun 2019 00:28:25 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>
CC:     <bhelgaas@google.com>, <linuxarm@huawei.com>,
        <linux-kernel@vger.kernel.org>, <arnd@arndb.de>, <olof@lixom.net>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v3 4/6] bus: hisi_lpc: Unregister logical PIO range to avoid potential use-after-free
Date:   Thu, 27 Jun 2019 00:26:56 +0800
Message-ID: <1561566418-22714-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1561566418-22714-1-git-send-email-john.garry@huawei.com>
References: <1561566418-22714-1-git-send-email-john.garry@huawei.com>
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

Fix by unregistering the logical PIO range.

And since we now unregister the logical PIO range for probe failure, avoid
the special ordering of setting logical PIO range ops, which was the
previous (poor) attempt at a safeguard against this.

Fixes: adf38bb0b595 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/bus/hisi_lpc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
index 19d7b6ff2f17..6d301aafcad2 100644
--- a/drivers/bus/hisi_lpc.c
+++ b/drivers/bus/hisi_lpc.c
@@ -606,24 +606,25 @@ static int hisi_lpc_probe(struct platform_device *pdev)
 	range->fwnode = dev->fwnode;
 	range->flags = LOGIC_PIO_INDIRECT;
 	range->size = PIO_INDIRECT_SIZE;
+	range->hostdata = lpcdev;
+	range->ops = &hisi_lpc_ops;
+	lpcdev->io_host = range;
 
 	ret = logic_pio_register_range(range);
 	if (ret) {
 		dev_err(dev, "register IO range failed (%d)!\n", ret);
 		return ret;
 	}
-	lpcdev->io_host = range;
 
 	/* register the LPC host PIO resources */
 	if (acpi_device)
 		ret = hisi_lpc_acpi_probe(dev);
 	else
 		ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
-	if (ret)
+	if (ret) {
+		logic_pio_unregister_range(range);
 		return ret;
-
-	lpcdev->io_host->hostdata = lpcdev;
-	lpcdev->io_host->ops = &hisi_lpc_ops;
+	}
 
 	io_end = lpcdev->io_host->io_start + lpcdev->io_host->size;
 	dev_info(dev, "registered range [%pa - %pa]\n",
-- 
2.17.1

