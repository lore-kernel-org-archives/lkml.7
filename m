Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5ACC4740C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693EF208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 06:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393070AbfIWGWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 02:22:16 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44452 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387519AbfIWGWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 02:22:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 907DFC4EDB6F576A4DD9;
        Mon, 23 Sep 2019 14:22:14 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 23 Sep 2019 14:22:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <zajec5@gmail.com>
CC:     <linux-mips@vger.kernel.org>, <zhongjiang@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] broadcom: Fix an compile warning in nvram_init
Date:   Mon, 23 Sep 2019 14:18:57 +0800
Message-ID: <1569219537-30204-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I hit the following error when compile the kernel.

drivers/firmware/broadcom/bcm47xx_nvram.c: In function ‘nvram_init’:
./include/linux/kern_levels.h:5:18: warning: format ‘%zu’ expects argument of type ‘size_t’, but argument 2 has type ‘u32 {aka unsigned int}’ [-Wformat=]
 #define KERN_SOH "\001"  /* ASCII Start Of Header */
                  ^
./include/linux/kern_levels.h:11:18: note: in expansion of macro ‘KERN_SOH’
 #define KERN_ERR KERN_SOH "3" /* error conditions */
                  ^~~~~~~~
./include/linux/printk.h:304:9: note: in expansion of macro ‘KERN_ERR’
  printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         ^~~~~~~~
drivers/firmware/broadcom/bcm47xx_nvram.c:151:4: note: in expansion of macro ‘pr_err’
    pr_err("nvram on flash (%zu bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
    ^~~~~~
  CC      sound/soc/sof/debug.o
drivers/firmware/broadcom/bcm47xx_nvram.c:151:30: note: format string is defined here
    pr_err("nvram on flash (%zu bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/firmware/broadcom/bcm47xx_nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/broadcom/bcm47xx_nvram.c b/drivers/firmware/broadcom/bcm47xx_nvram.c
index 6d2820f..75a3240 100644
--- a/drivers/firmware/broadcom/bcm47xx_nvram.c
+++ b/drivers/firmware/broadcom/bcm47xx_nvram.c
@@ -148,7 +148,7 @@ static int nvram_init(void)
 	    header.len > sizeof(header)) {
 		nvram_len = header.len;
 		if (nvram_len >= NVRAM_SPACE) {
-			pr_err("nvram on flash (%zu bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
+			pr_err("nvram on flash (%u bytes) is bigger than the reserved space in memory, will just copy the first %i bytes\n",
 				header.len, NVRAM_SPACE);
 			nvram_len = NVRAM_SPACE - 1;
 		}
-- 
1.7.12.4

