Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EDEC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA6C222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgACMR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:17:56 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8217 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727436AbgACMRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:17:55 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AFB2DA8D21AF44123234
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jan 2020 20:17:53 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 3 Jan 2020
 20:17:48 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <perex@perex.cz>, <rafael.j.wysocki@intel.com>
CC:     <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] PNP: isapnp: remove set but not used variable 'checksum'
Date:   Fri, 3 Jan 2020 20:17:10 +0800
Message-ID: <20200103121710.4761-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/pnp/isapnp/core.c: In function ‘isapnp_build_device_list’:
drivers/pnp/isapnp/core.c:777:27: warning: variable ‘checksum’ set
but not used [-Wunused-but-set-variable]

It is never used, and so can be removed.

Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/pnp/isapnp/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pnp/isapnp/core.c b/drivers/pnp/isapnp/core.c
index 179b737280e1..e39d49bceae0 100644
--- a/drivers/pnp/isapnp/core.c
+++ b/drivers/pnp/isapnp/core.c
@@ -774,7 +774,7 @@ static unsigned char __init isapnp_checksum(unsigned char *data)
 static int __init isapnp_build_device_list(void)
 {
 	int csn;
-	unsigned char header[9], checksum;
+	unsigned char header[9];
 	struct pnp_card *card;
 	u32 eisa_id;
 	char id[8];
@@ -784,7 +784,6 @@ static int __init isapnp_build_device_list(void)
 	for (csn = 1; csn <= isapnp_csn_count; csn++) {
 		isapnp_wake(csn);
 		isapnp_peek(header, 9);
-		checksum = isapnp_checksum(header);
 		eisa_id = header[0] | header[1] << 8 |
 			  header[2] << 16 | header[3] << 24;
 		pnp_eisa_id_to_string(eisa_id, id);
-- 
2.17.2

