Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E14C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978C82173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 13:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbfDQNd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 09:33:28 -0400
Received: from mga02.intel.com ([134.134.136.20]:44407 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729395AbfDQNd2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 09:33:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 06:33:27 -0700
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="135118226"
Received: from jkrzyszt-desk.igk.intel.com ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 06:33:25 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, janusz.krzysztofik@intel.com,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH] drm/drv: Fix incorrect resolution of merge conflict
Date:   Wed, 17 Apr 2019 15:32:31 +0200
Message-Id: <20190417133232.16232-1-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f06ddb53096b ("BackMerge v5.1-rc5 into drm-next") incorrectly
resolved a merge conflict related to a patch having been merged twice:
- commit 3f04e0a6cfeb ("drm: Fix drm_release() and device unplug")
  introduced as a standalone fix via drm-fixes branch,
- commit 1ee57d4d75fb ("drm: Fix drm_release() and device unplug")
  applied as patch 1/2 of a series on drm-next branch.
That incorrect resolution of the conflict effectively reverted a change
introduced to drivers/gpu/drm/drm_drv.c by patch 2/2 of that series -
commit ba3bf37e150a ("drm/drv: drm_dev_unplug(): Move out drm_dev_put()
call").  Fix it.

Fixes: f06ddb53096b ("BackMerge v5.1-rc5 into drm-next")
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/drm_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
index e87799e3e7ff..50d849d1bc6e 100644
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -508,7 +508,6 @@ void drm_dev_unplug(struct drm_device *dev)
 	synchronize_srcu(&drm_unplug_srcu);
 
 	drm_dev_unregister(dev);
-	drm_dev_put(dev);
 }
 EXPORT_SYMBOL(drm_dev_unplug);
 
-- 
2.20.1

