Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F377C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C5B2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfHNVbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:31:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54211 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbfHNVbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:31:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id 10so474343wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JS9FDqsk2E6RQCD4HkMjbuys2g4pNRCG7WFODU185bI=;
        b=drBIw8tNKxJ/MUrA3DKpC6SF7EABqomZaDqcNG857ua9KX9lK+DpLCnT2sjk29oBIA
         rMEixQPdlKQ1d57bTHF9YV1zRKcKcUxqdeJxoCu+/vgMZhpD5MtMUYEO3Zgq0YmesbbS
         pQEMo20dZ8uP/I/CoHEv+QKfhV22OS+hSopJ0MBt63DAq2Cv6OsoEBbsorX+SDNl5NRh
         54MURSj5Ue+bnOLQ3F3YmTubl5QypvavPXqxMghus7X0AGNW9pSB0bNTeGQIM5Xg8NCh
         BmtHlSAR7GuM7NHzxRFiIvGifAV9FZ096H97WaU/PzEcih9yDobcLQw1CMaMfPwQ1inB
         j/JA==
X-Gm-Message-State: APjAAAUHXZcyJVCWQ8cloZz++dFiE8Hp7R8jl4v0no4r0+fd0N81LkYO
        laSILA+NCCLyWZhJwDB46aw8L/emY6Y=
X-Google-Smtp-Source: APXvYqzHDWQhfPJ6We27I1c01VEHmcH6AedqLJLeDfuYhTAnIpxtfMqyBLvyHd9LxsMu3eLuFy5VVA==
X-Received: by 2002:a7b:cf21:: with SMTP id m1mr949715wmg.150.1565818300170;
        Wed, 14 Aug 2019 14:31:40 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:39 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 7/7] drm/nouveau: abort runtime suspend if we hit an error
Date:   Wed, 14 Aug 2019 23:31:18 +0200
Message-Id: <20190814213118.28473-8-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814213118.28473-1-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Karol Herbst <kherbst@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_drm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 16441c5bf29c..b16157a9c736 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -910,6 +910,7 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct nouveau_drm *drm = nouveau_drm(drm_dev);
 	int ret;
 
 	if (!nouveau_pmops_runtime()) {
@@ -919,6 +920,10 @@ nouveau_pmops_runtime_suspend(struct device *dev)
 
 	nouveau_switcheroo_optimus_dsm();
 	ret = nouveau_do_suspend(drm_dev, true);
+	if (ret) {
+		NV_ERROR(drm, "suspend failed with: %d\n", ret);
+		return ret;
+	}
 	pci_save_state(pdev);
 	pci_disable_device(pdev);
 	pci_ignore_hotplug(pdev);
-- 
2.21.0

