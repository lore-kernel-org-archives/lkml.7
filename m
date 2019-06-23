Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B402C4646C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CF9208C3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 17:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHScT30I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFWRiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:38:02 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35844 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfFWRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 13:38:01 -0400
Received: by mail-qt1-f194.google.com with SMTP id p15so12177726qtl.3;
        Sun, 23 Jun 2019 10:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJTlfv60mIEZXwta292fwI2V+CViZ4EgWCofxKK0NGs=;
        b=iHScT30IUVlaqkLW9FzbhYmfsFdewA8sA9/jGO9fvv1CFkFaapyfjhYtPMDxpx7WzW
         peqA+Lbd+lGEDDlqc6bhpxo2vtxdqvAwXeMOqsDC2yrpiAkRZjv2rcfPUkk2fjeKgEty
         szZyXIM8vQcvDG6q7WfuEpa176sKGTPoGYenic5rMIk3Tgbw5tirSkXh0MgHcgK2gnfR
         yN6aB0oK2XUHb+7RdXbtjOaUTw1695sjBrVwyUu1wpwri23zr5KCh2FEwx+UmHNTrjxI
         u+lknBsrwiTYVIenkHVmcRK4yo1NQt5uk/PGhOZs00HokqYuB889l04tD33hRIM6SMh6
         LuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AJTlfv60mIEZXwta292fwI2V+CViZ4EgWCofxKK0NGs=;
        b=QXZK/tbjxQKvw5j7JDdH6xXpBYAx8Xjv1T4r/dDiVmaBQNiHJ8PKJDvsTxdMFE/xt/
         /jZ+D2CoVXgpIMeS2MVWO4weMZxNOlJrXzZhz9ZfRONr5k6Kj4bolmbwTPBS4A6/C2Aw
         LiexsjDcyZP/2JtDuRYewMSFpQNx7Bjb54hhJ648HOiqtLvPlUB4OjUq9IUqJPb4qmTg
         6/4RokGCxKeGRxvGymzpyUTi3A2IoFTfqBsDeUoitNuwarUYEqYlF7axtWACY3nw0f+B
         TlRke39QzCTT8+R0XRwfXfdkTxchh23Km9Eru7ltIUbj3XopCzGVNN5GZSNMc1DXJJAV
         2jDA==
X-Gm-Message-State: APjAAAXDxGIVjgvNF9fwHiJGi3AbmSiRa/kBZ57RPvDrevE0+XtW46cD
        uET1bN6ViDy8JUl/sqI3yCrCPXS9
X-Google-Smtp-Source: APXvYqwH+yYOfjzCW3mL/GB1bTYbCEj4p34EhH/Z+ZuKtywHkF9tf6qNfNiRq4tv8gn+Hit+u1OaYg==
X-Received: by 2002:a0c:8a26:: with SMTP id 35mr53756993qvt.158.1561311480668;
        Sun, 23 Jun 2019 10:38:00 -0700 (PDT)
Received: from localhost.localdomain (ppp91-79-162-197.pppoe.mtu-net.ru. [91.79.162.197])
        by smtp.gmail.com with ESMTPSA id c55sm5342498qtk.53.2019.06.23.10.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jun 2019 10:38:00 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/3] gpu: host1x: Remove implicit IOMMU backing on client's registration
Date:   Sun, 23 Jun 2019 20:37:41 +0300
Message-Id: <20190623173743.24088-1-digetx@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ARM32 we don't want any of the clients device to be backed by the
implicit domain, simply because we can't afford such a waste on older
Tegra SoCs that have very few domains available in total. The recent IOMMU
support addition for the Video Decoder hardware uncovered the problem
that an unfortunate drivers probe order results in the DRM driver probe
failure if CONFIG_ARM_DMA_USE_IOMMU=y due to a shortage of IOMMU domains
caused by the implicit backing. The host1x_client_register() is a common
function that is invoked by all of the relevant DRM drivers during theirs
probe and hence it is convenient to remove the implicit backing there,
resolving the problem.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/host1x/bus.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
index 742aa9ff21b8..559df3974afb 100644
--- a/drivers/gpu/host1x/bus.c
+++ b/drivers/gpu/host1x/bus.c
@@ -14,6 +14,10 @@
 #include "bus.h"
 #include "dev.h"
 
+#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#endif
+
 static DEFINE_MUTEX(clients_lock);
 static LIST_HEAD(clients);
 
@@ -710,6 +714,21 @@ int host1x_client_register(struct host1x_client *client)
 	struct host1x *host1x;
 	int err;
 
+#if IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)
+	/*
+	 * The client's driver could be backed by implicit IOMMU mapping
+	 * and we don't want to have that because all of current Tegra
+	 * drivers are managing IOMMU by themselves. This is a convenient
+	 * place for unmapping of the implicit mapping because this function
+	 * is called by all host1x drivers during theirs probe.
+	 */
+	if (client->dev->archdata.mapping) {
+		struct dma_iommu_mapping *mapping =
+			to_dma_iommu_mapping(client->dev);
+		arm_iommu_detach_device(client->dev);
+		arm_iommu_release_mapping(mapping);
+	}
+#endif
 	mutex_lock(&devices_lock);
 
 	list_for_each_entry(host1x, &devices, list) {
-- 
2.22.0

