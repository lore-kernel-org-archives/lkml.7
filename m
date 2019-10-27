Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78C5CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D92214E0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210703;
	bh=1RDTg+wxF9xff2h9l1hf3aHceFjA1bsXfc6B1h8PW0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sisQJT7WNmruqX8L+/K2+6lQGjSWgzSqKLXdXZfYon1xkThmYUGKLBL7YP+tB6/N+
	 KB3pu330+KrCiZwTEJacSIzkNJbFwCzdp7wKStBcTz3s2W9iPkXAp3r2BpjBAInLaH
	 wDW8b4RiscQHX8d0Mq0UDTn3VlWbQKa6VraLH+Iw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfJ0VLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729895AbfJ0VLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:11:35 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0044420873;
        Sun, 27 Oct 2019 21:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210694;
        bh=1RDTg+wxF9xff2h9l1hf3aHceFjA1bsXfc6B1h8PW0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1LELy4t2NmnZV9DLKv/XfERH9guPDhy/x4B0jCOAj0B5oOXEBDJCiR+fR8RTQjM28
         KMlXr+pYjtue9sHUMmItxNxKt4qhswiaAnX7gHE5pJPARQ7QhDcz88wzqC63p23zC1
         0lqQTTuxWn4dzJ/LDoHndlrFZrYYFg4xQNqGhsMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 097/119] drm/amdgpu: Bail earlier when amdgpu.cik_/si_support is not set to 1
Date:   Sun, 27 Oct 2019 22:01:14 +0100
Message-Id: <20191027203348.778364312@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 984d7a929ad68b7be9990fc9c5cfa5d5c9fc7942 upstream.

Bail from the pci_driver probe function instead of from the drm_driver
load function.

This avoid /dev/dri/card0 temporarily getting registered and then
unregistered again, sending unwanted add / remove udev events to
userspace.

Specifically this avoids triggering the (userspace) bug fixed by this
plymouth merge-request:
https://gitlab.freedesktop.org/plymouth/plymouth/merge_requests/59

Note that despite that being a userspace bug, not sending unnecessary
udev events is a good idea in general.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1490490
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |   35 ++++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |   35 --------------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -572,6 +572,41 @@ static int amdgpu_pci_probe(struct pci_d
 	if (ret == -EPROBE_DEFER)
 		return ret;
 
+#ifdef CONFIG_DRM_AMDGPU_SI
+	if (!amdgpu_si_support) {
+		switch (flags & AMD_ASIC_MASK) {
+		case CHIP_TAHITI:
+		case CHIP_PITCAIRN:
+		case CHIP_VERDE:
+		case CHIP_OLAND:
+		case CHIP_HAINAN:
+			dev_info(&pdev->dev,
+				 "SI support provided by radeon.\n");
+			dev_info(&pdev->dev,
+				 "Use radeon.si_support=0 amdgpu.si_support=1 to override.\n"
+				);
+			return -ENODEV;
+		}
+	}
+#endif
+#ifdef CONFIG_DRM_AMDGPU_CIK
+	if (!amdgpu_cik_support) {
+		switch (flags & AMD_ASIC_MASK) {
+		case CHIP_KAVERI:
+		case CHIP_BONAIRE:
+		case CHIP_HAWAII:
+		case CHIP_KABINI:
+		case CHIP_MULLINS:
+			dev_info(&pdev->dev,
+				 "CIK support provided by radeon.\n");
+			dev_info(&pdev->dev,
+				 "Use radeon.cik_support=0 amdgpu.cik_support=1 to override.\n"
+				);
+			return -ENODEV;
+		}
+	}
+#endif
+
 	/* Get rid of things like offb */
 	ret = amdgpu_kick_out_firmware_fb(pdev);
 	if (ret)
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -87,41 +87,6 @@ int amdgpu_driver_load_kms(struct drm_de
 	struct amdgpu_device *adev;
 	int r, acpi_status;
 
-#ifdef CONFIG_DRM_AMDGPU_SI
-	if (!amdgpu_si_support) {
-		switch (flags & AMD_ASIC_MASK) {
-		case CHIP_TAHITI:
-		case CHIP_PITCAIRN:
-		case CHIP_VERDE:
-		case CHIP_OLAND:
-		case CHIP_HAINAN:
-			dev_info(dev->dev,
-				 "SI support provided by radeon.\n");
-			dev_info(dev->dev,
-				 "Use radeon.si_support=0 amdgpu.si_support=1 to override.\n"
-				);
-			return -ENODEV;
-		}
-	}
-#endif
-#ifdef CONFIG_DRM_AMDGPU_CIK
-	if (!amdgpu_cik_support) {
-		switch (flags & AMD_ASIC_MASK) {
-		case CHIP_KAVERI:
-		case CHIP_BONAIRE:
-		case CHIP_HAWAII:
-		case CHIP_KABINI:
-		case CHIP_MULLINS:
-			dev_info(dev->dev,
-				 "CIK support provided by radeon.\n");
-			dev_info(dev->dev,
-				 "Use radeon.cik_support=0 amdgpu.cik_support=1 to override.\n"
-				);
-			return -ENODEV;
-		}
-	}
-#endif
-
 	adev = kzalloc(sizeof(struct amdgpu_device), GFP_KERNEL);
 	if (adev == NULL) {
 		return -ENOMEM;


