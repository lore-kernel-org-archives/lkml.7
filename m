Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F121CA9EAB
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622D4222C2
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfJSHaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 03:30:22 -0400
Received: from h1.fbrelay.privateemail.com ([131.153.2.42]:47536 "EHLO
        h1.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbfJSHaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:30:22 -0400
Received: from MTA-05-3.privateemail.com (mta-05.privateemail.com [198.54.127.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id D4040800AA
        for <linux-kernel@vger.kernel.org>; Sat, 19 Oct 2019 03:18:48 -0400 (EDT)
Received: from MTA-05.privateemail.com (localhost [127.0.0.1])
        by MTA-05.privateemail.com (Postfix) with ESMTP id 1FE4E60049;
        Sat, 19 Oct 2019 03:18:47 -0400 (EDT)
Received: from wambui.zuku.co.ke (unknown [10.20.151.220])
        by MTA-05.privateemail.com (Postfix) with ESMTPA id 8E05560040;
        Sat, 19 Oct 2019 07:18:43 +0000 (UTC)
From:   Wambui Karuga <wambui@karuga.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        sean@poorly.run, mripard@kernel.org,
        maarten.lankhorst@linux.intel.com,
        outreachy-kernel@googlegroups.com,
        Wambui Karuga <wambui.karugax@gmail.com>
Subject: [PATCH] drm: remove unnecessary return variable
Date:   Sat, 19 Oct 2019 10:18:40 +0300
Message-Id: <20191019071840.16877-1-wambui@karuga.xyz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wambui Karuga <wambui.karugax@gmail.com>

Remove unnecessary variable `ret` in drm_dp_atomic_find_vcpi_slots()
only used to hold the function return value and have the function
return the value directly.
Issue found by coccinelle:
@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 9cccc5e63309..b854a422a523 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3540,7 +3540,7 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 {
 	struct drm_dp_mst_topology_state *topology_state;
 	struct drm_dp_vcpi_allocation *pos, *vcpi = NULL;
-	int prev_slots, req_slots, ret;
+	int prev_slots, req_slots;
 
 	topology_state = drm_atomic_get_mst_topology_state(state, mgr);
 	if (IS_ERR(topology_state))
@@ -3587,8 +3587,7 @@ int drm_dp_atomic_find_vcpi_slots(struct drm_atomic_state *state,
 	}
 	vcpi->vcpi = req_slots;
 
-	ret = req_slots;
-	return ret;
+	return req_slots;
 }
 EXPORT_SYMBOL(drm_dp_atomic_find_vcpi_slots);
 
-- 
2.23.0

