Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA29C388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A841421850
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 14:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbfI0Oo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 10:44:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfI0Oo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 10:44:27 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EFD389AC5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:44:26 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id j2so1138268wre.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 07:44:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tKJlXVu+C+SUSWhFcHR/cVLK3eVfpegwLk/6ZeTU4Lw=;
        b=f9bGHlgFSUzCDq3j38rLyk3Y3sXq3fFnXt4cCAJqnF9sBG1ZdTrwNOz/snoQMBouHY
         Gq1yOSp/gRSLjTWytXn8EGqDPxZs4ugZj2W9HPEH0wG5HsKGfZsdEDz59d6gOGS6yRW4
         pzY9Cj8kbgVyfUNukzIB0m4PUHlYK/lZCjqG9JaQi2Ycy4zo40uNplsUahSWnlykij4s
         /KrZRcVYROIZTv79izwPNPIozf3l2k3wiADa6ot4lj9UdH0dusrMIM/Gwmq50t4R4gPZ
         3EcmNsbxbT9Gk59cN8Wii4bLJ/q5c/oYStoMzFFbIVW3JZsIuWabIJ0oVQCOJwbnqooL
         AMDg==
X-Gm-Message-State: APjAAAV6hBeC9iP5VZjCKX8tsBWXO7BxJpQNOahS5SG5DXyKHJy08uUx
        9i6L8HgKerRpUesB0Z5kphKnap0aVY2e5dFCmAdwPCYsW3rFdkdQEoeOFoMxyJaVf7JABdpTioK
        vCs/1N11ANybtkZKVZd01MPqm
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr395785wmb.23.1569595464977;
        Fri, 27 Sep 2019 07:44:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxC2IYP1DXa/fMg1u9ig7ZhBeyIkZ56QIfJYKHZiecxua/UDg6iVgqlCp0MKwat0LoPX/Jjxg==
X-Received: by 2002:a1c:1c7:: with SMTP id 190mr395767wmb.23.1569595464744;
        Fri, 27 Sep 2019 07:44:24 -0700 (PDT)
Received: from kherbst.pingu.com ([2a02:8308:b0be:6900:6174:20eb:3f66:382f])
        by smtp.gmail.com with ESMTPSA id e18sm4580926wrv.63.2019.09.27.07.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 07:44:23 -0700 (PDT)
From:   Karol Herbst <kherbst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Karol Herbst <kherbst@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lyude Paul <lyude@redhat.com>, linux-pci@vger.kernel.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [RFC PATCH] pci: prevent putting pcie devices into lower device states on certain intel bridges
Date:   Fri, 27 Sep 2019 16:44:21 +0200
Message-Id: <20190927144421.22608-1-kherbst@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes runpm breakage mainly on Nvidia GPUs as they are not able to resume.

Works perfectly with this workaround applied.

RFC comment:
We are quite sure that there is a higher amount of bridges affected by this,
but I was only testing it on my own machine for now.

I've stresstested runpm by doing 5000 runpm cycles with that patch applied
and never saw it fail.

I mainly wanted to get a discussion going on if that's a feasable workaround
indeed or if we need something better.

I am also sure, that the nouveau driver itself isn't at fault as I am able
to reproduce the same issue by poking into some PCI registers on the PCIe
bridge to put the GPU into D3cold as it's done in ACPI code.

I've written a little python script to reproduce this issue without the need
of loading nouveau:
https://raw.githubusercontent.com/karolherbst/pci-stub-runpm/master/nv_runpm_bug_test.py

Signed-off-by: Karol Herbst <kherbst@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: linux-pci@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org
---
 drivers/pci/pci.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 088fcdc8d2b4..9dbd29ced1ac 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -799,6 +799,42 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
 }
 
+/*
+ * some intel bridges cause serious issues with runpm if the client device
+ * is put into D1/D2/D3hot before putting the client into D3cold via
+ * platform means (generally ACPI).
+ *
+ * skipping this makes runpm work perfectly fine on such devices.
+ *
+ * As far as we know only skylake and kaby lake SoCs are affected.
+ */
+static unsigned short intel_broken_d3_bridges[] = {
+	/* kbl */
+	0x1901,
+};
+
+static inline bool intel_broken_pci_pm(struct pci_bus *bus)
+{
+	struct pci_dev *bridge;
+	int i;
+
+	if (!bus || !bus->self)
+		return false;
+
+	bridge = bus->self;
+	if (bridge->vendor != PCI_VENDOR_ID_INTEL)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(intel_broken_d3_bridges); i++) {
+		if (bridge->device == intel_broken_d3_bridges[i]) {
+			pci_err(bridge, "found broken intel bridge\n");
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *			     given PCI device
@@ -827,6 +863,9 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 	if (state < PCI_D0 || state > PCI_D3hot)
 		return -EINVAL;
 
+	if (state != PCI_D0 && intel_broken_pci_pm(dev->bus))
+		return 0;
+
 	/*
 	 * Validate current state:
 	 * Can enter D0 from any state, but if we can only go deeper
-- 
2.21.0

