Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D715EC47E49
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB4F21D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 11:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572001498;
	bh=dTvtN9K5VEVzsh5mbQEjeAPvD4c+mAT/a6OOuXXWhuM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=RCRAWRl85/frst4b+JzUnpahA7NcefGbUuzxzA4Gybt/4BskGJmINMuJzTl8KX2oO
	 PmYb1xoa/uyCLTJKLxnlNHwH+t5tBubahxNAbGC3zlI1ufzCoNksu+75oGaWgIAOEJ
	 qNTttSLCanbURyyaBdGP59nBp/4k88gvxZRQyA/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393455AbfJYLE5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 07:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390097AbfJYLE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 07:04:57 -0400
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADAA22084C;
        Fri, 25 Oct 2019 11:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572001496;
        bh=dTvtN9K5VEVzsh5mbQEjeAPvD4c+mAT/a6OOuXXWhuM=;
        h=From:To:Cc:Subject:Date:From;
        b=BVV0Rmltbeu4aGw3zh74OGXjep5lC57B1P3op2QeC2oM1re3T+jy0T28GaFe2vliS
         QxCxb73SjIwdbUAoph5Yz+ty4KaXWOcibel5t3dvpZqYeiqPESBDJMk6cn7CLfWZRr
         EMKZ+2Bqgui5g+/0q7PW14MYUflLbl5wgPE4wVd0=
From:   Will Deacon <will@kernel.org>
To:     amd-gfx@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Waisman <nico@semmle.com>
Subject: [PATCH] drm/radeon: Handle workqueue allocation failure
Date:   Fri, 25 Oct 2019 12:04:50 +0100
Message-Id: <20191025110450.10474-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the highly unlikely event that we fail to allocate the "radeon-crtc"
workqueue, we should bail cleanly rather than blindly march on with a
NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
structure.

This was reported previously by Nicolas, but I don't think his fix was
correct:

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Reported-by: Nicolas Waisman <nico@semmle.com>
Link: https://lore.kernel.org/lkml/CADJ_3a8WFrs5NouXNqS5WYe7rebFP+_A5CheeqAyD_p7DFJJcg@mail.gmail.com/
Signed-off-by: Will Deacon <will@kernel.org>
---

Compile-tested only.

 drivers/gpu/drm/radeon/radeon_display.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index e81b01f8db90..3e4ef1380fca 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -672,17 +672,25 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
+	struct workqueue_struct *wq;
 	int i;
 
 	radeon_crtc = kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
 	if (radeon_crtc == NULL)
 		return;
 
+	wq = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (unlikely(!wq)) {
+		kfree(radeon_crtc);
+		return;
+	}
+
 	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	radeon_crtc->flip_queue = wq;
+
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
-- 
2.24.0.rc0.303.g954a862665-goog

