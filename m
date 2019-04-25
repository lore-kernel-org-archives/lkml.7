Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B554BC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CEDF214AE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729569AbfDYG1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:27:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:24717 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfDYG1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:27:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 23:27:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,392,1549958400"; 
   d="scan'208";a="294379939"
Received: from junxiaochang.bj.intel.com ([10.238.135.157])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2019 23:27:21 -0700
From:   junxiao.chang@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        junxiao.chang@intel.com, lili.li@intel.com
Subject: [PATCH] platform: release resource itself instead of resource tree
Date:   Thu, 25 Apr 2019 14:24:18 +0800
Message-Id: <1556173458-9318-1-git-send-email-junxiao.chang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Junxiao Chang <junxiao.chang@intel.com>

When platform device is deleted or there is error in adding
device, platform device resources should be released. Currently
API release_resource is used to release platform device resources.
However, this API releases not only platform resource itself but
also its child resources. It might release resources which are
still in use. Calling remove_resource only releases current
resource itself, not resource tree, it moves its child resources
to up level.

For example, platform device 1 and device 2 are registered, then only
device 1 is unregistered in below code:

  ...
  // Register platform test device 1, resource 0xfed1a000 ~ 0xfed1afff
  pdev1 = platform_device_register_full(&pdevinfo1);

  // Register platform test device 2, resource 0xfed1a200 ~ 0xfed1a2ff
  pdev2 = platform_device_register_full(&pdevinfo2);

  // Now platform device 2 resource should be device 1 resource's child

  // Unregister device 1 only
  platform_device_unregister(pdev1);
  ...

Platform device 2 resource will be released as well because its
parent resource(device 1's resource) is released, this is not expected.
If using API remove_resource, device 2 resource will not be released.

This change fixed an intel pmc platform device resource issue when
intel pmc ipc kernel module is inserted/removed for twice.

Signed-off-by: Junxiao Chang <junxiao.chang@intel.com>
---
 drivers/base/platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dab0a5a..5fd1a41 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -461,7 +461,7 @@ int platform_device_add(struct platform_device *pdev)
 	while (--i >= 0) {
 		struct resource *r = &pdev->resource[i];
 		if (r->parent)
-			release_resource(r);
+			remove_resource(r);
 	}
 
  err_out:
@@ -492,7 +492,7 @@ void platform_device_del(struct platform_device *pdev)
 		for (i = 0; i < pdev->num_resources; i++) {
 			struct resource *r = &pdev->resource[i];
 			if (r->parent)
-				release_resource(r);
+				remove_resource(r);
 		}
 	}
 }
-- 
2.7.4

