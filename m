Return-Path: <SRS0=/uHP=YM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A4DCA9EAC
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96EBA222BD
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Oct 2019 07:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfJSHcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Oct 2019 03:32:55 -0400
Received: from mta-08-4.privateemail.com ([198.54.122.58]:26312 "EHLO
        MTA-08-4.privateemail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfJSHcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Oct 2019 03:32:54 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Oct 2019 03:32:54 EDT
Received: from MTA-08.privateemail.com (localhost [127.0.0.1])
        by MTA-08.privateemail.com (Postfix) with ESMTP id 7DB0760046;
        Sat, 19 Oct 2019 03:32:54 -0400 (EDT)
Received: from wambui.zuku.co.ke (unknown [10.20.151.218])
        by MTA-08.privateemail.com (Postfix) with ESMTPA id 038DC60033;
        Sat, 19 Oct 2019 07:32:50 +0000 (UTC)
From:   Wambui Karuga <wambui@karuga.xyz>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, alexander.deucher@amd.com,
        christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH] drm/radeon: remove assignment for return value
Date:   Sat, 19 Oct 2019 10:32:42 +0300
Message-Id: <20191019073242.21652-1-wambui@karuga.xyz>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary assignment for return value and have the
function return the required value directly.
Issue found by coccinelle:
@@
local idexpression ret;
expression e;
@@

-ret =
+return
     e;
-return ret;

Signed-off-by: Wambui Karuga <wambui@karuga.xyz>
---
 drivers/gpu/drm/radeon/cik.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 62eab82a64f9..daff9a2af3be 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -221,9 +221,7 @@ int ci_get_temp(struct radeon_device *rdev)
 	else
 		actual_temp = temp & 0x1ff;
 
-	actual_temp = actual_temp * 1000;
-
-	return actual_temp;
+	return actual_temp * 1000;
 }
 
 /* get temperature in millidegrees */
@@ -239,9 +237,7 @@ int kv_get_temp(struct radeon_device *rdev)
 	else
 		actual_temp = 0;
 
-	actual_temp = actual_temp * 1000;
-
-	return actual_temp;
+	return actual_temp * 1000;
 }
 
 /*
-- 
2.23.0

