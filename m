Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5971EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378AE2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbfHNVbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:31:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35053 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729982AbfHNVbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:31:37 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so470106wrq.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TzjYpMy9+0zUnyIhGVp0XLreAg3cbu7k5uuH85z42Y=;
        b=jsINmhTIdx8UqMGRsqsQ3Nfk7Mi3cxH5qBunfBZiLIkLDB46bkBVVRTVDF6JNvynom
         9rEQtfV3Mz6LZxOPo3TcZFkJc9gMNWQ4Y1xFOvK7ZW09Lbysb0lj8VxWUrwCp0wnPuRC
         K/aCf9rECdrp2aKLM17NsmSqvSxwc9v25BimR1zfeOUZvyh4Wzmcp7WkbltSYUZ+N4u5
         SeRppD8rRxAn9KAYsLxWqoWwrygPJIOHd0FFEFEE6inlzIVDRYC+qYunnlT8q+6tENe3
         YM9jQbRlHx4R9BD3N1L7555DaLykHg+xhZkj23moFCG4YPhQUI7EhbCmsaDc4tAsBHAv
         xpNg==
X-Gm-Message-State: APjAAAWOGvPwK6tMM75QpcW70poOaeyRIliXKdQPZj/pwTMUms02m4KC
        IU3hPanfTF/hmzJBaEHRHBrk8hmNbcc=
X-Google-Smtp-Source: APXvYqzZayfXMMmK+XvZtOaSr4FuQVJXXrQ0d8j9SpvLi3XGme93Isve666keCnmVjrWEvMt/EDx6g==
X-Received: by 2002:a5d:4284:: with SMTP id k4mr1733516wrq.6.1565818296138;
        Wed, 14 Aug 2019 14:31:36 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:26 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 4/7] drm/nouveau/pci: enable pcie link changes for pascal
Date:   Wed, 14 Aug 2019 23:31:15 +0200
Message-Id: <20190814213118.28473-5-kherbst@redhat.com>
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
Reviewed-by: Lyude Paul <lyude@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c |  8 ++++----
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c | 10 ++++++++++
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h  |  5 +++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
index e68030507d88..664890185e15 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gk104.c
@@ -23,7 +23,7 @@
  */
 #include "priv.h"
 
-static int
+int
 gk104_pcie_version_supported(struct nvkm_pci *pci)
 {
 	return (nvkm_rd32(pci->subdev.device, 0x8c1c0) & 0x4) == 0x4 ? 2 : 1;
@@ -108,7 +108,7 @@ gk104_pcie_lnkctl_speed(struct nvkm_pci *pci)
 	return -1;
 }
 
-static enum nvkm_pcie_speed
+enum nvkm_pcie_speed
 gk104_pcie_max_speed(struct nvkm_pci *pci)
 {
 	u32 max_speed = nvkm_rd32(pci->subdev.device, 0x8c1c0) & 0x300000;
@@ -146,7 +146,7 @@ gk104_pcie_set_link_speed(struct nvkm_pci *pci, enum nvkm_pcie_speed speed)
 	nvkm_mask(device, 0x8c040, 0x1, 0x1);
 }
 
-static int
+int
 gk104_pcie_init(struct nvkm_pci * pci)
 {
 	enum nvkm_pcie_speed lnkctl_speed, max_speed, cap_speed;
@@ -178,7 +178,7 @@ gk104_pcie_init(struct nvkm_pci * pci)
 	return 0;
 }
 
-static int
+int
 gk104_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
 {
 	struct nvkm_subdev *subdev = &pci->subdev;
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c
index 82c5234a06ff..eb19c7a44561 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/gp100.c
@@ -35,6 +35,16 @@ gp100_pci_func = {
 	.wr08 = nv40_pci_wr08,
 	.wr32 = nv40_pci_wr32,
 	.msi_rearm = gp100_pci_msi_rearm,
+
+	.pcie.init = gk104_pcie_init,
+	.pcie.set_link = gk104_pcie_set_link,
+
+	.pcie.max_speed = gk104_pcie_max_speed,
+	.pcie.cur_speed = g84_pcie_cur_speed,
+
+	.pcie.set_version = gf100_pcie_set_version,
+	.pcie.version = gf100_pcie_version,
+	.pcie.version_supported = gk104_pcie_version_supported,
 };
 
 int
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
index 7009aad86b6e..162ed5dc6fc3 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/priv.h
@@ -54,6 +54,11 @@ int gf100_pcie_cap_speed(struct nvkm_pci *);
 int gf100_pcie_init(struct nvkm_pci *);
 int gf100_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8);
 
+int gk104_pcie_init(struct nvkm_pci *);
+int gk104_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8 width);
+enum nvkm_pcie_speed gk104_pcie_max_speed(struct nvkm_pci *);
+int gk104_pcie_version_supported(struct nvkm_pci *);
+
 int nvkm_pcie_oneinit(struct nvkm_pci *);
 int nvkm_pcie_init(struct nvkm_pci *);
 #endif
-- 
2.21.0

