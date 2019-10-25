Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2262CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C8621D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 01:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbfJYB3L convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 21:29:11 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:11970 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388881AbfJYB3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 21:29:11 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id B64D5B3BFB9EFD4D77AD;
        Fri, 25 Oct 2019 09:29:09 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x9P1Stav098679;
        Fri, 25 Oct 2019 09:28:55 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019102509284555-119942 ;
          Fri, 25 Oct 2019 09:28:45 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     steven.price@arm.com, robh@kernel.org
Cc:     tomeu.vizoso@collabora.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, up2wing@gmail.com,
        wang.liang82@zte.com.cn
Subject: [PATCH v3] drm/panfrost: fix -Wmissing-prototypes warnings
Date:   Fri, 25 Oct 2019 09:30:15 +0800
Message-Id: <1571967015-42854-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-10-25 09:28:45,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-10-25 09:29:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl2.zte.com.cn x9P1Stav098679
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We get these warnings when build kernel W=1:
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:35:6: warning: no previous prototype for ‘panfrost_perfcnt_clean_cache_done’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:40:6: warning: no previous prototype for ‘panfrost_perfcnt_sample_done’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:190:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_enable’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:218:5: warning: no previous prototype for ‘panfrost_ioctl_perfcnt_dump’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:250:6: warning: no previous prototype for ‘panfrost_perfcnt_close’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:264:5: warning: no previous prototype for ‘panfrost_perfcnt_init’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_perfcnt.c:320:6: warning: no previous prototype for ‘panfrost_perfcnt_fini’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_mmu.c:227:6: warning: no previous prototype for ‘panfrost_mmu_flush_range’ [-Wmissing-prototypes]
drivers/gpu/drm/panfrost/panfrost_mmu.c:435:5: warning: no previous prototype for ‘panfrost_mmu_map_fault_addr’ [-Wmissing-prototypes]

For file panfrost_mmu.c, make functions static to fix this.
For file panfrost_perfcnt.c, include header file can fix this.

Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
Reviewed-by: Steven Price <steven.price@arm.com>
---

v3: using tab size of 8 other than 4.

v2: align parameter line and modify comment. Thanks to Steve.
---
 drivers/gpu/drm/panfrost/panfrost_mmu.c     | 9 +++++----
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_mmu.c b/drivers/gpu/drm/panfrost/panfrost_mmu.c
index bdd9905..871574c 100644
--- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
+++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
@@ -224,9 +224,9 @@ static size_t get_pgsize(u64 addr, size_t size)
 	return SZ_2M;
 }
 
-void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
-			      struct panfrost_mmu *mmu,
-			      u64 iova, size_t size)
+static void panfrost_mmu_flush_range(struct panfrost_device *pfdev,
+				    struct panfrost_mmu *mmu,
+				    u64 iova, size_t size)
 {
 	if (mmu->as < 0)
 		return;
@@ -432,7 +432,8 @@ void panfrost_mmu_pgtable_free(struct panfrost_file_priv *priv)
 
 #define NUM_FAULT_PAGES (SZ_2M / PAGE_SIZE)
 
-int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as, u64 addr)
+static int panfrost_mmu_map_fault_addr(struct panfrost_device *pfdev, int as,
+					u64 addr)
 {
 	int ret, i;
 	struct panfrost_gem_object *bo;
diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index 83c57d3..2dba192 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -16,6 +16,7 @@
 #include "panfrost_issues.h"
 #include "panfrost_job.h"
 #include "panfrost_mmu.h"
+#include "panfrost_perfcnt.h"
 #include "panfrost_regs.h"
 
 #define COUNTERS_PER_BLOCK		64
-- 
1.8.3.1

