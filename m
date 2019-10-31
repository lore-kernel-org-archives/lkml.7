Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24466CA9EC3
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA78120873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 09:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfJaJgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 05:36:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5659 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbfJaJgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 05:36:41 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A1E09484ACD35FA8B583;
        Thu, 31 Oct 2019 17:36:38 +0800 (CST)
Received: from localhost.localdomain (10.90.53.225) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 17:36:29 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <chenwandun@huawei.com>
Subject: [PATCH] drm/dp_mst :fix gcc compile error
Date:   Thu, 31 Oct 2019 17:43:49 +0800
Message-ID: <1572515029-42087-1-git-send-email-chenwandun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chenwandun <chenwandun@huawei.com>

drivers/gpu/drm/drm_dp_mst_topology.c: In function __topology_ref_save:
drivers/gpu/drm/drm_dp_mst_topology.c:1424:6: error: implicit declaration of function stack_trace_save; did you mean stack_depot_save? [-Werror=implicit-function-declaration]
  n = stack_trace_save(stack_entries, ARRAY_SIZE(stack_entries), 1);
      ^~~~~~~~~~~~~~~~
      stack_depot_save
drivers/gpu/drm/drm_dp_mst_topology.c: In function __dump_topology_ref_history:
drivers/gpu/drm/drm_dp_mst_topology.c:1513:3: error: implicit declaration of function stack_trace_snprint; did you mean acpi_trace_point? [-Werror=implicit-function-declaration]
   stack_trace_snprint(buf, PAGE_SIZE, entries, nr_entries, 4);
   ^~~~~~~~~~~~~~~~~~~
   acpi_trace_point

stack_trace_save and stack_trace_snprint are declared in <linux/stacktrace.h>,
so there is need to include it, and <linux/stackdepot.h> is already included
by practices, so just replace <linux/stackdepot.h> by <linux/stacktrace.h>.

Signed-off-by: Chenwandun <chenwandun@huawei.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 85bef73..11adc4b 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -29,7 +29,7 @@
 #include <linux/seq_file.h>
 
 #if IS_ENABLED(CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS)
-#include <linux/stackdepot.h>
+#include <linux/stacktrace.h>
 #include <linux/sort.h>
 #include <linux/timekeeping.h>
 #include <linux/math64.h>
-- 
2.7.4

