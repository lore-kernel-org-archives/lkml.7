Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91261C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC22084F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 12:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbfCAMY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 07:24:58 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:48190 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbfCAMY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 07:24:57 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92-RC5)
        (envelope-from <johannes@sipsolutions.net>)
        id 1gzhDi-0004Ox-St; Fri, 01 Mar 2019 13:24:55 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] driver core: platform: remove misleading err_alloc label
Date:   Fri,  1 Mar 2019 13:24:47 +0100
Message-Id: <20190301122447.3503-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In platform_device_register_full() the err_alloc label is
misleading, we only ever jump to it if the pdev is NULL,
but it then proceeds to free it, which is a no-op.

Remove the label and simply exit the function immediately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/base/platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 1c958eb33ef4..75fccb7dc908 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -508,7 +508,7 @@ struct platform_device *platform_device_register_full(
 
 	pdev = platform_device_alloc(pdevinfo->name, pdevinfo->id);
 	if (!pdev)
-		goto err_alloc;
+		return ERR_PTR(-ENOMEM);
 
 	pdev->dev.parent = pdevinfo->parent;
 	pdev->dev.fwnode = pdevinfo->fwnode;
@@ -553,8 +553,6 @@ struct platform_device *platform_device_register_full(
 err:
 		ACPI_COMPANION_SET(&pdev->dev, NULL);
 		kfree(pdev->dev.dma_mask);
-
-err_alloc:
 		platform_device_put(pdev);
 		return ERR_PTR(ret);
 	}
-- 
2.17.2

