Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547C3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A9321872
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 01:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfJZBdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 21:33:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725899AbfJZBdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 21:33:32 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 30EA4AA6608D48243F4E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2019 09:33:30 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sat, 26 Oct 2019
 09:33:21 +0800
From:   Hewenliang <hewenliang4@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <hewenliang4@huawei.com>
Subject: [PATCH] tools: PCI: Fix fd leakage
Date:   Fri, 25 Oct 2019 21:33:21 -0400
Message-ID: <20191026013321.59035-1-hewenliang4@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should close fd before the return of run_test.

Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
---
 tools/pci/pcitest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index cb1e51fcc84e..32b7c6f9043d 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -129,6 +129,7 @@ static int run_test(struct pci_test *test)
 	}
 
 	fflush(stdout);
+	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
 }
 
-- 
2.19.1

