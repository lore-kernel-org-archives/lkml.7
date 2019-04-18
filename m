Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB59FC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C675F214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387914AbfDRDuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 23:50:08 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:21821 "EHLO
        m9785.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732183AbfDRDuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 23:50:08 -0400
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Apr 2019 23:50:07 EDT
Received: from localhost (unknown [117.48.120.186])
        by m9785.mail.qiye.163.com (Hmail) with ESMTPA id EF8725C1604;
        Thu, 18 Apr 2019 11:41:17 +0800 (CST)
From:   WANG Chao <chao.wang@ucloud.cn>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: [PATCH 3/3] RAS/CEC: immediate soft-offline page when count_threshold == 1
Date:   Thu, 18 Apr 2019 11:41:15 +0800
Message-Id: <20190418034115.75954-3-chao.wang@ucloud.cn>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418034115.75954-1-chao.wang@ucloud.cn>
References: <20190418034115.75954-1-chao.wang@ucloud.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kIGBQJHllBS1VLV1koWUFJQjdXWS1ZQUlXWQkOFx4IWUFZMjUtOjcyP0
        FLVUtZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBw6FQw*SDgyLjBNHzQ9AwE3
        E00wCxRVSlVKTk5OTk5DQ0xDS0xKVTMWGhIXVRgTGhRVDBoVHDsOGBcUDh9VGBVFWVdZEgtZQVlK
        SkxVT0NVSklLVUpDTVlXWQgBWUFJQkhJNwY+
X-HM-Tid: 0a6a2e88cb252087kuqyef8725c1604
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

count_threshol == 1 isn't working as expected. CEC only does soft
offline the second time the same pfn is hit by a correctable error.

Signed-off-by: WANG Chao <chao.wang@ucloud.cn>
---
 drivers/ras/cec.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 702e4c02c713..ac879c45377c 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -272,7 +272,22 @@ static u64 __maybe_unused del_lru_elem(void)
 	return pfn;
 }
 
+static void cec_valid_soft_offline(u64 pfn)
+{
+	if (!pfn_valid(pfn)) {
+		pr_warn("CEC: Invalid pfn: 0x%llx\n", pfn);
+	} else {
+		/* We have reached max count for this page, soft-offline it. */
+		pr_err("Soft-offlining pfn: 0x%llx\n", pfn);
+		memory_failure_queue(pfn, MF_SOFT_OFFLINE, &cec_chain);
+		ce_arr.pfns_poisoned++;
+	}
+}
 
+/*
+ * Return a >0 value to denote that we've reached the offlining
+ * threshold.
+ */
 int cec_add_elem(u64 pfn)
 {
 	struct ce_array *ca = &ce_arr;
@@ -295,6 +310,11 @@ int cec_add_elem(u64 pfn)
 
 	ret = find_elem(ca, pfn, &to);
 	if (ret < 0) {
+		if (count_threshold == 1) {
+			cec_valid_soft_offline(pfn);
+			ret = 1;
+			goto unlock;
+		}
 		/*
 		 * Shift range [to-end] to make room for one more element.
 		 */
@@ -320,23 +340,9 @@ int cec_add_elem(u64 pfn)
 
 		ret = 0;
 	} else {
-		u64 pfn = ca->array[to] >> PAGE_SHIFT;
-
-		if (!pfn_valid(pfn)) {
-			pr_warn("CEC: Invalid pfn: 0x%llx\n", pfn);
-		} else {
-			/* We have reached max count for this page, soft-offline it. */
-			pr_err("Soft-offlining pfn: 0x%llx\n", pfn);
-			memory_failure_queue(pfn, MF_SOFT_OFFLINE);
-			ca->pfns_poisoned++;
-		}
-
+		cec_valid_soft_offline(pfn);
 		del_elem(ca, to);
 
-		/*
-		 * Return a >0 value to denote that we've reached the offlining
-		 * threshold.
-		 */
 		ret = 1;
 
 		goto unlock;
-- 
2.21.0

