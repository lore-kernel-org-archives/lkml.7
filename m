Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D520FC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4FCC20684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 11:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJoVZWIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbfLTL7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 06:59:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53829 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727177AbfLTL7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 06:59:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576843182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=EimEcwtT13iZd2BQPB2j/TIU/TkI66KaW5WQSgBY8gg=;
        b=OJoVZWIczmRY13vzDkktQbKnVFIA1/Y0v4r4OlXk0A9nMOT7mjIqhNBWffOmgHD5+lU5v+
        ZIV9+m8csHHes4Nfn4DePj960LmHTk62QgmEqifDbxGhvjtjexIyvTuQKFir50wHN1B3NP
        BWHokEmxMw+cEsr9tn2F4y1UdfPRpEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-41aUINrDOjGjBE6Dq_5GEQ-1; Fri, 20 Dec 2019 06:59:40 -0500
X-MC-Unique: 41aUINrDOjGjBE6Dq_5GEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 117C5800053;
        Fri, 20 Dec 2019 11:59:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com [10.36.116.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F0166046B;
        Fri, 20 Dec 2019 11:59:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 917633F13E; Fri, 20 Dec 2019 12:59:35 +0100 (CET)
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org (open list:DRM DRIVER FOR
        QEMU'S CIRRUS DEVICE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/4] drm/cirrus: add drm_driver.release callback.
Date:   Fri, 20 Dec 2019 12:59:33 +0100
Message-Id: <20191220115935.15152-3-kraxel@redhat.com>
In-Reply-To: <20191220115935.15152-1-kraxel@redhat.com>
References: <20191220115935.15152-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move final cleanups from cirrus_pci_remove() to the new callback.
Add drm_atomic_helper_shutdown() call to cirrus_pci_remove().

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/cirrus/cirrus.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/cirrus/cirrus.c b/drivers/gpu/drm/cirrus/cirrus.c
index 248c9f765c45..a4ca66f9a423 100644
--- a/drivers/gpu/drm/cirrus/cirrus.c
+++ b/drivers/gpu/drm/cirrus/cirrus.c
@@ -510,6 +510,16 @@ static void cirrus_mode_config_init(struct cirrus_device *cirrus)
 
 /* ------------------------------------------------------------------ */
 
+static void cirrus_release(struct drm_device *dev)
+{
+	struct cirrus_device *cirrus = dev->dev_private;
+
+	drm_mode_config_cleanup(dev);
+	iounmap(cirrus->mmio);
+	iounmap(cirrus->vram);
+	kfree(cirrus);
+}
+
 DEFINE_DRM_GEM_FOPS(cirrus_fops);
 
 static struct drm_driver cirrus_driver = {
@@ -523,6 +533,7 @@ static struct drm_driver cirrus_driver = {
 
 	.fops		 = &cirrus_fops,
 	DRM_GEM_SHMEM_DRIVER_OPS,
+	.release         = cirrus_release,
 };
 
 static int cirrus_pci_probe(struct pci_dev *pdev,
@@ -604,14 +615,10 @@ static int cirrus_pci_probe(struct pci_dev *pdev,
 static void cirrus_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
-	struct cirrus_device *cirrus = dev->dev_private;
 
 	drm_dev_unregister(dev);
-	drm_mode_config_cleanup(dev);
-	iounmap(cirrus->mmio);
-	iounmap(cirrus->vram);
+	drm_atomic_helper_shutdown(dev);
 	drm_dev_put(dev);
-	kfree(cirrus);
 	pci_release_regions(pdev);
 }
 
-- 
2.18.1

