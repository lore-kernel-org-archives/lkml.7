Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D60C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D5E2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCTwDsX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfGCQ0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:26:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46570 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:26:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id i8so1484487pgm.13;
        Wed, 03 Jul 2019 09:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=s0b5XZT6tp+i2qspylAac10TkUZD+4LoluubE9vfnLk=;
        b=iCTwDsX0bxLPZsASy9eBA8+h8On0/kUIIt6azHD+XqsOBkEEYt3KL4IYQ0ziXs+m+j
         X/9r5o/eY9dLc77RhoSzicsS7zam0KDeaM7v6ix3YtZaabaR/DlvBgskAJ9qBZ/ap2Km
         ctcgjUGAlnEPg1jhovJAY8wCcwnDR74jz1N/8cYSrmUInMYt+l18KeE7oUDHbIgHEoUh
         epmtow4UDafEWYro26IYXP2CLN8i3/bnzxcrbBoyDh6iIXpQ98JWXZ3nY5DXA34ZLmcU
         f6SYPa557ZaGh2cQGJb4c7K6F/Y/vveuioi1QhbafAcBHGAChUIapmxRkLHtkx9Eh9JV
         AVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=s0b5XZT6tp+i2qspylAac10TkUZD+4LoluubE9vfnLk=;
        b=lU6dsnLL2OtYxIZf/3jtuqiFuWz7HUtYtR3tYL9gWnitECP4Gj3V3Tv65oR0Vls2vJ
         RCbX7izB02D3pL+NEdy1OifVZm4QSoIdNnnatNdEnKEuUessy/1thddcaQULkQ/MY+61
         I8PSSx0xpTEdRSfItG1COX9ngkDylFfRzaw/xe89djdD/urOatv91e7TbQiB2/oKJiew
         UomGolp325oJz1aQqfLHTSzamlBJx5q6KQv5IHWt30a0NKG492VesqrfpqhAUU24bwbB
         ZAfiXWnMYhxQCJHLzUGpUvwuL+QMyTwT7qlsOyXkyqzWvuS6jIYbpNaT5nC3PEvGDfwc
         b8/Q==
X-Gm-Message-State: APjAAAUc7I1lZmS2FwDZN6r8aD+bb/3OpWk/Gx9KBDrG8zYXnQRHo9hB
        zTz2ZNWRvlWFtNl66O3yAwE=
X-Google-Smtp-Source: APXvYqwpRRor74pYLoRXzSoesuy0iF3B++ffD/nh2vOBFLXHUPm09omYc4bdDeELkr63mCKbRbvlyg==
X-Received: by 2002:a17:90a:bb94:: with SMTP id v20mr13977949pjr.88.1562171189805;
        Wed, 03 Jul 2019 09:26:29 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id j9sm2831600pff.88.2019.07.03.09.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 09:26:29 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 01/35] ia64/sn: Use kmemdup rather than duplicating its implementation
Date:   Thu,  4 Jul 2019 00:26:16 +0800
Message-Id: <20190703162616.31905-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 arch/ia64/sn/kernel/io_acpi_init.c | 8 +++-----
 arch/ia64/sn/pci/tioce_provider.c  | 3 +--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/sn/kernel/io_acpi_init.c b/arch/ia64/sn/kernel/io_acpi_init.c
index c31fe637b0b4..7f305a468b69 100644
--- a/arch/ia64/sn/kernel/io_acpi_init.c
+++ b/arch/ia64/sn/kernel/io_acpi_init.c
@@ -210,13 +210,11 @@ sn_extract_device_info(acpi_handle handle, struct pcidev_info **pcidev_info,
 		goto exit;
 	}
 
-	pcidev_ptr = kzalloc(sizeof(struct pcidev_info), GFP_KERNEL);
-	if (!pcidev_ptr)
-		panic("%s: Unable to alloc memory for pcidev_info", __func__);
-
 	memcpy(&addr, vendor->byte_data, sizeof(struct pcidev_info *));
 	pcidev_prom_ptr = __va(addr);
-	memcpy(pcidev_ptr, pcidev_prom_ptr, sizeof(struct pcidev_info));
+	pcidev_ptr = kmemdup(pcidev_prom_ptr, sizeof(struct pcidev_info), GFP_KERNEL);
+	if (!pcidev_ptr)
+		panic("%s: Unable to alloc memory for pcidev_info", __func__);
 
 	/* Get the IRQ info */
 	irq_info = kzalloc(sizeof(struct sn_irq_info), GFP_KERNEL);
diff --git a/arch/ia64/sn/pci/tioce_provider.c b/arch/ia64/sn/pci/tioce_provider.c
index 3bd9abc35485..20360a52ab4d 100644
--- a/arch/ia64/sn/pci/tioce_provider.c
+++ b/arch/ia64/sn/pci/tioce_provider.c
@@ -1000,11 +1000,10 @@ tioce_bus_fixup(struct pcibus_bussoft *prom_bussoft, struct pci_controller *cont
 	 * Allocate kernel bus soft and copy from prom.
 	 */
 
-	tioce_common = kzalloc(sizeof(struct tioce_common), GFP_KERNEL);
+	tioce_common = kmemdup(prom_bussoft, sizeof(struct tioce_common), GFP_KERNEL);
 	if (!tioce_common)
 		return NULL;
 
-	memcpy(tioce_common, prom_bussoft, sizeof(struct tioce_common));
 	tioce_common->ce_pcibus.bs_base = (unsigned long)
 		ioremap(REGION_OFFSET(tioce_common->ce_pcibus.bs_base),
 			sizeof(struct tioce_common));
-- 
2.11.0

