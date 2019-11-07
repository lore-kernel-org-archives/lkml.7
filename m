Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4138DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A09A2087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LR41t2IH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfKGU71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:59:27 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34679 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfKGU71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:59:27 -0500
Received: by mail-pl1-f194.google.com with SMTP id k7so2451353pll.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nkNlMQRicaTR1gGQNB/Yzp0pHtByBTKEE9yOjF2k1pw=;
        b=LR41t2IHZuly8gLcZ6UlBM3E62/6+qVvM+opJvCHaLiISAgNP1pKb7G2FH2kWI2CdE
         m62M/ay9xo1VTApVdsTieVrf/lBa9CdDoPvCGx72us0Kan781R71Tb6wUUK9XZMelN6m
         uvXvOhSrL0qouhPwru8vpSazs4yzxb8wNNg2mRWIp2IPGsAKMByVmRVg2ucbrM7kZosY
         /IlrpkSSvCmMqK1OpHQyccRlApStn67UsOa4rPX3E+WAo20IBFFz8E8S0/hHV7El00QF
         7AwSNyCipcN7xgYS1R2DLl/jqyKU6ADzOYVN9/jpJLW/HruToxlqjJg9Y1H+wGiownjt
         UvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nkNlMQRicaTR1gGQNB/Yzp0pHtByBTKEE9yOjF2k1pw=;
        b=h8vqwVTxXS83svKBvsEPqSEY7vjvh6FOz8AC5XK3isuAo7FWIqH+f046jdg1+g4b1X
         c/n67uG40g2u9m/JpNKJGEZYLeD/QAm1qilSVB+I9G7Oj+Kz0QzbkxPFgJ5sSrF1UrpJ
         aMW1DNrp918Ui0E/zAvT93KmeC8eco66lnktjwFXkH6IP5RzsQwLxBNNQ8KrEdyE8F9P
         YKVUUTTw96Ubs/Lned61pfawxeOUJmpwCZuJ1fE+WN8HN/ccKc0zy8pjukvHvTUGV2MF
         iuyrTUW7siNUd60+RY4NvdxDARisWyDzkUxenHvf/+MEjYKOc9Rvh3aiiFpwaS41Pkwk
         JfWg==
X-Gm-Message-State: APjAAAW//xVOEEIseRL4MzhCGfzvZvyWogCPDXDmctnjenEmeACqxjoi
        Nht9/H8iasic4KRJbQmxV9skwv4I
X-Google-Smtp-Source: APXvYqwzL/Wj+XAOZlYIn/t4S28COF7TlcVY2Id3cPe+aS2hzKfgJzYdRTLmSlib4FIOXFqqF6oyTw==
X-Received: by 2002:a17:90a:bf8d:: with SMTP id d13mr8239219pjs.89.1573160365293;
        Thu, 07 Nov 2019 12:59:25 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id r68sm3499652pfr.78.2019.11.07.12.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:59:24 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     joro@8bytes.org, linux-kernel@vger.kernel.org
Cc:     dwmw2@infradead.org, iommu@lists.linux-foundation.org
Subject: [PATCH] intel-iommu: Turn off translations at shutdown
Date:   Thu,  7 Nov 2019 12:59:14 -0800
Message-Id: <20191107205914.10611-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intel-iommu driver assumes that the iommu state is
cleaned up at the start of the new kernel.
But, when we try to kexec boot something other than the
Linux kernel, the cleanup cannot be relied upon.
Hence, cleanup before we go down for reboot.

Keeping the cleanup at initialization also, in case BIOS
leaves the IOMMU enabled.

I considered turning off iommu only during kexec reboot,
but a clean shutdown seems always a good idea. But if
someone wants to make it conditional, we can do that.

Tested that before, the info message
'DMAR: Translation was enabled for <iommu> but we are not in kdump mode'
would be reported for each iommu. The message will not appear when the
DMA-remapping is not enabled on entry to the kernel.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 drivers/iommu/intel-iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index fe8097078669..f0636b263722 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4764,6 +4764,26 @@ static void intel_disable_iommus(void)
 		iommu_disable_translation(iommu);
 }
 
+static void intel_iommu_shutdown(void)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu = NULL;
+
+	if (no_iommu || dmar_disabled)
+		return;
+
+	down_write(&dmar_global_lock);
+
+	/* Disable PMRs explicitly here. */
+	for_each_iommu(iommu, drhd)
+		iommu_disable_protect_mem_regions(iommu);
+
+	/* Make sure the IOMMUs are switched off */
+	intel_disable_iommus();
+
+	up_write(&dmar_global_lock);
+}
+
 static inline struct intel_iommu *dev_to_intel_iommu(struct device *dev)
 {
 	struct iommu_device *iommu_dev = dev_to_iommu_device(dev);
@@ -5013,6 +5033,8 @@ int __init intel_iommu_init(void)
 	}
 	up_write(&dmar_global_lock);
 
+	x86_platform.iommu_shutdown = intel_iommu_shutdown;
+
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
 	/*
 	 * If the system has no untrusted device or the user has decided
-- 
2.17.1

