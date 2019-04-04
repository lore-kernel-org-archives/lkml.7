Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B1AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A409320882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 13:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554385792;
	bh=0OmPZ3CEhnZGMOsu7xMkJTD2oibPjoFXe1plm8iEv/4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=WEyHgouvABFF09Oaw40jdctLgtwq83CI15kcOsrUYU/DacowEBnuPsUMf9UUpcgQb
	 p1U1xHn7c5DRmY+JCjB7ucTE/LeFXgIThhwaA4KbWJzbJMVRbdu4v7BdYteMeaK/Hg
	 BX6ZOShXqTy9QTprloyj3+mHij/TJHZedJN3SQeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbfDDNtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 09:49:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbfDDNtv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 09:49:51 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2979920855;
        Thu,  4 Apr 2019 13:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554385790;
        bh=0OmPZ3CEhnZGMOsu7xMkJTD2oibPjoFXe1plm8iEv/4=;
        h=From:To:Cc:Subject:Date:From;
        b=R9R0Y9vd1+KAnpfk2u8WfIlfAxY2qDI2lO3JBzRihF/B6DNh/e9q5grSAfDzW3iBr
         rLeQB43YrLB8SyK+bUjGWI2YIYeyk42m0kpi46XS1g2oVCtyW8wgUfM+bJ3TW1uZRi
         KdJzGxCVha3PENqXJyPlLzLK2q+KO3/JkXX1jXZs=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] drm/nouveau: Remove duplicate ACPI_VIDEO_NOTIFY_PROBE definition
Date:   Thu,  4 Apr 2019 08:49:43 -0500
Message-Id: <20190404134943.149428-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Commit 3a6536c51d5d ("drm/nouveau: Intercept ACPI_VIDEO_NOTIFY_PROBE")
added a definition of ACPI_VIDEO_NOTIFY_PROBE because <acpi/video.h> didn't
supply one.  Later, commit eff4a751cce5 ("ACPI / video: Move
ACPI_VIDEO_NOTIFY_* defines to acpi/video.h") moved ACPI_VIDEO_NOTIFY_PROBE
and other definitions to <acpi/video.h>, so the copy in nouveau_display.c
is now unnecessary.

Remove the unnecessary definition from nouveau_display.c.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
CC: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/nouveau/nouveau_display.c
index 55c0fa451163..832da8e0020d 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -358,15 +358,6 @@ nouveau_display_hpd_work(struct work_struct *work)
 
 #ifdef CONFIG_ACPI
 
-/*
- * Hans de Goede: This define belongs in acpi/video.h, I've submitted a patch
- * to the acpi subsys to move it there from drivers/acpi/acpi_video.c .
- * This should be dropped once that is merged.
- */
-#ifndef ACPI_VIDEO_NOTIFY_PROBE
-#define ACPI_VIDEO_NOTIFY_PROBE			0x81
-#endif
-
 static int
 nouveau_display_acpi_ntfy(struct notifier_block *nb, unsigned long val,
 			  void *data)
-- 
2.21.0.392.gf8f6787159e-goog

