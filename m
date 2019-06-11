Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A976CC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 690D020896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 05:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f42nCiuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403991AbfFKFvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 01:51:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46297 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403879AbfFKFvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 01:51:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so11405477wrw.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 22:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v7Q5ai2QlrMRZ4GjVd3kT2jGMGvHdyMq9n3kQ5IZvPk=;
        b=f42nCiuHkhBlzZV1Au3f4vBCVBiRWWkfW72EMm00I4hTcmGUU3Dw3wphU5i5eAr8NI
         U7+f1U9Q01uCMyA8KjQI3BSSSF9hvAlgDk8c51bmf23CpID+s3f8uhKPA8ub/D6LeIk9
         yfqHsFhRYAJRLc6ngLrlGe3/l5L99utst0JB9c/ri3ufjvf7dTjJdnySyiHqfZb85cMb
         v+/IIeHns8Tg4b47K8aKs74e6rI6cfXKfAuAvzemmBB584j9PVYqYgy2hKZx2SnHmHqR
         J10EvxK0cSyNs3Vr/8A0BkLqoTLMYsUugkz6ujnFKn8B/00FHTv6RhPk8cUCTUzvqu+S
         IzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v7Q5ai2QlrMRZ4GjVd3kT2jGMGvHdyMq9n3kQ5IZvPk=;
        b=GhryZr26q1POzXRGNccH9iiyiDG/dKe9qqAdFVrVhium9lHuCvPoCBOxju46u78bH2
         foWle+SkX79KEtWQD8Ht0U6Bocz+M9mrwn0WvKhD9/74uUPKlr8iAiTRlj0tumNOjp0y
         +780KsbIFe6uDY2XEbPwFrt9j3XiqG32B+NTjZAY5i1xj/diyoMUSQ2atZlaR1LJ1vOs
         fcMYyMyS6M20RnA1lebZIOfVvguR50Amw80FgatQFHBYLl+4n5ztwGO5Hw4hnXK1oEgr
         p2kovstqtBVmfk6EvFB8MysnFY8E0+P3CX7y2Cuzu2/KK7ZQAMzRXF5SaUJj3AyE8+Y7
         a8ng==
X-Gm-Message-State: APjAAAUxuQ1hxDAhj5CoH0MZVO1byIS6vkRiuWuAmv3cDRdBzq/hnYJv
        J++/LxfgsEp1ny+qCv/xFAjLoCTnwNU=
X-Google-Smtp-Source: APXvYqyoOdx0H68WsFJz3D/UO5G/34J3SJaamHbSiFi66xQUCwzJQCAxOcq3ssS0ZLG4hyjX8wmnRQ==
X-Received: by 2002:adf:8183:: with SMTP id 3mr34326348wra.181.1560232257554;
        Mon, 10 Jun 2019 22:50:57 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id j8sm11968056wrr.64.2019.06.10.22.50.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 10 Jun 2019 22:50:56 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 8/8] habanalabs: enable 64-bit DMA mask in POWER9
Date:   Tue, 11 Jun 2019 08:50:45 +0300
Message-Id: <20190611055045.15945-9-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190611055045.15945-1-oded.gabbay@gmail.com>
References: <20190611055045.15945-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables support in the driver for 64-bit DMA mask when running
in a POWER9 machine.

POWER9 supports either 32-bit or 64-bit DMA mask. However, our ASICs
support 48-bit DMA mask. To support 64-bit, the driver needs to add a
special configuration to the ASIC's PCIe controller.

The activation of this special configuration is done via kernel module
parameter because:

1. It should affect all the habanalabs ASICs in the machine.

2. The pci_set_dma_mask() is a generic Linux kernel call, so the driver
   can't tell why it got an error when it tried to set the DMA mask to 48
   bits. And upon such failure, the driver must fall-back to set the mask
   to 32 bits.

3. There is no standard way to differentiate in runtime between POWER9 and
   other architectures.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c      | 6 +++++-
 drivers/misc/habanalabs/habanalabs.h     | 3 +++
 drivers/misc/habanalabs/habanalabs_drv.c | 7 +++++++
 drivers/misc/habanalabs/pci.c            | 7 ++++++-
 4 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index e8b3a31d211f..eb6cd1ee06f2 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -472,7 +472,11 @@ static int goya_early_init(struct hl_device *hdev)
 
 	prop->dram_pci_bar_size = pci_resource_len(pdev, DDR_BAR_ID);
 
-	rc = hl_pci_init(hdev, 48);
+	if (hdev->power9_64bit_dma_enable)
+		rc = hl_pci_init(hdev, 64);
+	else
+		rc = hl_pci_init(hdev, 48);
+
 	if (rc)
 		return rc;
 
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 5e4a631b3d88..b6fa2df0b2d6 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1208,6 +1208,8 @@ struct hl_device_reset_work {
  * @dma_mask: the dma mask that was set for this device
  * @in_debug: is device under debug. This, together with fd_open_cnt, enforces
  *            that only a single user is configuring the debug infrastructure.
+ * @power9_64bit_dma_enable: true to enable 64-bit DMA mask support. Relevant
+ *                           only to POWER9 machines.
  */
 struct hl_device {
 	struct pci_dev			*pdev;
@@ -1281,6 +1283,7 @@ struct hl_device {
 	u8				device_cpu_disabled;
 	u8				dma_mask;
 	u8				in_debug;
+	u8				power9_64bit_dma_enable;
 
 	/* Parameters for bring-up */
 	u8				mmu_enable;
diff --git a/drivers/misc/habanalabs/habanalabs_drv.c b/drivers/misc/habanalabs/habanalabs_drv.c
index 6f6dbe93f1df..9ca2d9d4f3fe 100644
--- a/drivers/misc/habanalabs/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/habanalabs_drv.c
@@ -28,6 +28,7 @@ static DEFINE_MUTEX(hl_devs_idr_lock);
 
 static int timeout_locked = 5;
 static int reset_on_lockup = 1;
+static int power9_64bit_dma_enable;
 
 module_param(timeout_locked, int, 0444);
 MODULE_PARM_DESC(timeout_locked,
@@ -37,6 +38,10 @@ module_param(reset_on_lockup, int, 0444);
 MODULE_PARM_DESC(reset_on_lockup,
 	"Do device reset on lockup (0 = no, 1 = yes, default yes)");
 
+module_param(power9_64bit_dma_enable, int, 0444);
+MODULE_PARM_DESC(power9_64bit_dma_enable,
+	"Enable 64-bit DMA mask. Should be set only in POWER9 machine (0 = no, 1 = yes, default no)");
+
 #define PCI_VENDOR_ID_HABANALABS	0x1da3
 
 #define PCI_IDS_GOYA			0x0001
@@ -223,6 +228,8 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 
 	hdev->major = hl_major;
 	hdev->reset_on_lockup = reset_on_lockup;
+	hdev->power9_64bit_dma_enable = power9_64bit_dma_enable;
+
 	hdev->pldm = 0;
 
 	set_driver_behavior_per_device(hdev);
diff --git a/drivers/misc/habanalabs/pci.c b/drivers/misc/habanalabs/pci.c
index c98d88c7a5c6..15954bf419fa 100644
--- a/drivers/misc/habanalabs/pci.c
+++ b/drivers/misc/habanalabs/pci.c
@@ -283,7 +283,12 @@ int hl_pci_init_iatu(struct hl_device *hdev, u64 sram_base_address,
 				upper_32_bits(host_phys_base_address));
 	rc |= hl_pci_iatu_write(hdev, 0x010, lower_32_bits(host_phys_end_addr));
 	rc |= hl_pci_iatu_write(hdev, 0x014, 0);
-	rc |= hl_pci_iatu_write(hdev, 0x018, 0);
+
+	if ((hdev->power9_64bit_dma_enable) && (hdev->dma_mask == 64))
+		rc |= hl_pci_iatu_write(hdev, 0x018, 0x08000000);
+	else
+		rc |= hl_pci_iatu_write(hdev, 0x018, 0);
+
 	rc |= hl_pci_iatu_write(hdev, 0x020, upper_32_bits(host_phys_end_addr));
 	/* Increase region size */
 	rc |= hl_pci_iatu_write(hdev, 0x000, 0x00002000);
-- 
2.17.1

