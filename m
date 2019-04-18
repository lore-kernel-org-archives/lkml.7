Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9D2C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E362184B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:41:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387970AbfDRDlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 23:41:20 -0400
Received: from m97188.mail.qiye.163.com ([220.181.97.188]:9916 "EHLO
        m97188.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732325AbfDRDlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 23:41:20 -0400
Received: from localhost (unknown [117.48.120.186])
        by m97188.mail.qiye.163.com (Hmail) with ESMTPA id 3903F962848;
        Thu, 18 Apr 2019 11:41:17 +0800 (CST)
From:   WANG Chao <chao.wang@ucloud.cn>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: [PATCH 1/3] RAS/CEC: fix __find_elem
Date:   Thu, 18 Apr 2019 11:41:13 +0800
Message-Id: <20190418034115.75954-1-chao.wang@ucloud.cn>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kIGBQJHllBS1VLV1koWUFJQjdXWS1ZQUlXWQkOFx4IWUFZMjUtOjcyP0
        FLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MD46Nww*Qjg3CDAiHyovCUhL
        LxYaFChVSlVKTk5OTk5DQ0xMT0tJVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZEgtZQVlK
        SkxVT0NVSklLVUpDTVlXWQgBWUFKSE1JNwY+
X-HM-Tid: 0a6a2e88c83c20bckuqy3903f962848
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A left over pfn (because we don't clear) at ca->array[n] can be a match
in __find_elem. Later it'd cause a memmove size overflow in del_elem.

Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 2d9ec378a8bc..2e0bf1269c31 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -206,7 +206,7 @@ static int __find_elem(struct ce_array *ca, u64 pfn, unsigned int *to)
 
 	this_pfn = PFN(ca->array[min]);
 
-	if (this_pfn == pfn)
+	if (this_pfn == pfn && ca->n > min)
 		return min;
 
 	return -ENOKEY;
-- 
2.21.0

