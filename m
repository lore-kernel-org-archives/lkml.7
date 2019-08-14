Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F89C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2E62064A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 21:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfHNVbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 17:31:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38456 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbfHNVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 17:31:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so455081wrr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 14:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+R7LV1MxNrT9xguc00MGuS05JmkrEhR9rX0ez6LOs84=;
        b=K8XUMxRYQUGYQ6hP1flAdj0YG6/izezd8fGLb5ecQ6jWKKSRtBNuZoO++hi0+7CzDf
         J6+Pi1vRUtd0p2FKrxtE5B86VfvPT3IGwRl1c5UzNzbN87AN2BZCS/jRX5wlAFhx6KK3
         YsFfIx+HnQyCYa3J1hp/KO2HRabkgvvLVTx4ZH/BPNrLzeyI938SmCvuRzGYlmRTAr30
         O1AO5A12UdSZHF7I7aaSfEWyRXXW+S39ps6jVjBqeSMmDnSc9Krw4tMi9B+aWIpF9ds9
         Zoj5D+YqWP7eNPSIThmS9hCKVbZ6ikUxHZLrVDECXbjUv4bJnWdkEFtEO9SxIIVa/rDK
         69mg==
X-Gm-Message-State: APjAAAWiuFSUcBlGgndXxiMWX6W8ldsmi1UBRg6WvaHul5tnWwR7Tu/9
        dPbYGEMRMXVap4MlhuME5WUCk8rf3Fg=
X-Google-Smtp-Source: APXvYqy6Bct927d1tcxDlG3Bau1plPbpmZhGaupy99LmABC4eq6mo/7HS+c9vx5OHhIXxUPcYDgtMQ==
X-Received: by 2002:adf:ed85:: with SMTP id c5mr1624418wro.268.1565818297742;
        Wed, 14 Aug 2019 14:31:37 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8108:453f:d1a0:28d1:9d88:57f6:f95b])
        by smtp.gmail.com with ESMTPSA id r17sm2095134wrg.93.2019.08.14.14.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 14:31:37 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Hung <alex.hung@canonical.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 5/7] drm/nouveau/pci: add nvkm_pcie_get_speed
Date:   Wed, 14 Aug 2019 23:31:16 +0200
Message-Id: <20190814213118.28473-6-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814213118.28473-1-kherbst@redhat.com>
References: <20190814213118.28473-1-kherbst@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: fixed compilation error

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
CC: Alex Hung <alex.hung@canonical.com>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Dave Airlie <airlied@redhat.com>
CC: Lyude Paul <lyude@redhat.com>
CC: Ben Skeggs <bskeggs@redhat.com>
---
 drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h | 1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c    | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
index 4803a4fad4a2..b29101e485f9 100644
--- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
+++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/pci.h
@@ -53,4 +53,5 @@ int gp100_pci_new(struct nvkm_device *, int, struct nvkm_pci **);
 
 /* pcie functions */
 int nvkm_pcie_set_link(struct nvkm_pci *, enum nvkm_pcie_speed, u8 width);
+enum nvkm_pcie_speed nvkm_pcie_get_speed(struct nvkm_pci *);
 #endif
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
index d71e5db5028a..03be24930c0e 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/pci/pcie.c
@@ -163,3 +163,11 @@ nvkm_pcie_set_link(struct nvkm_pci *pci, enum nvkm_pcie_speed speed, u8 width)
 
 	return ret;
 }
+
+enum nvkm_pcie_speed
+nvkm_pcie_get_speed(struct nvkm_pci *pci)
+{
+	if (!pci || !pci_is_pcie(pci->pdev) || !pci->func->pcie.cur_speed)
+		return -ENODEV;
+	return pci->func->pcie.cur_speed(pci);
+}
-- 
2.21.0

