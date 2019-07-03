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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032EFC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF47F218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQ+IjdN6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbfGCNM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:12:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42254 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:12:55 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so1224070plb.9;
        Wed, 03 Jul 2019 06:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fVoZN2N/gGy1uHO1cYmpHsdxlI2S2OOVmSuRyJWF31I=;
        b=WQ+IjdN6by7xkNz2KpwWw8IqR7X5AvsDUlDmgF0b4Gq4uwtmhIYhMVTJZM2HxgCnA1
         6mXYncQqrDl+nmOAUzJQHnfWtRWJip1exe/zGpv1X/kax+aa1Jx3JvOmO7CsZSR2YLTW
         URoPjpj4MuO9NWSq1IN/UfA0GVJG7IzKrQnjxWdGqxGvg9sBAbk2pPA0aiQ9O+ExJOsh
         M2a2JrvkyxqquWKCIsbgIB54ibHO8+TPFekQF0k7WgZGDEIn5lGbjTH5cHreE2wa73H6
         SS5jhiXUtLX8K4Lrw/xGUoMaND/lh9aTvwL7u1heyHSMklc4jiBLYPMTWyVSyup2NrI4
         tdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fVoZN2N/gGy1uHO1cYmpHsdxlI2S2OOVmSuRyJWF31I=;
        b=aokxpsVh18UKQS5c6glwHebUOPFpsmDPFqlZyaMLKeM/6NfzxozRdLYwkrYRNd7eox
         Q6bAXh8bNQVyznNiFjVgHfQvBHS4AqUUiErSGGalgtNnLo+SuQ6erRYYNuQFKLrAkkDt
         J5dRpOJ2zDzZhTdsdcOJg8YLSKNtJiHS/pQu7vjVxnyNApmWw0UNmoKD6xdGmH0KcSTg
         BaPbra7HHsvw/0AyeACBAWjmye4uzrKG685dOzm5q/Csxvv0Bsg59Aub76gdixzezjrc
         6u5l9mZ5/GOGZk0ScVRD8r/4cQw4/QS4S/M2tUz9PfO3cNXVjLgfobGbhnTsxtB0jd8I
         G/AA==
X-Gm-Message-State: APjAAAWeObwIUIHpDMnIdgSyXGtU1X/FgAnoM9Ti1MR1a0hAaBSQ+PUL
        ng4ZpeuPKaO+gKO/l6lthW0=
X-Google-Smtp-Source: APXvYqzcu4hI5LmkbPBDefu6PwX2r8t2tQg+JR76N5golagykXp+5E/+A/eeKoBSzdelxhGQ+xiV7Q==
X-Received: by 2002:a17:902:760a:: with SMTP id k10mr39085324pll.83.1562159574618;
        Wed, 03 Jul 2019 06:12:54 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.googlemail.com with ESMTPSA id 201sm5388870pfz.24.2019.07.03.06.12.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 06:12:53 -0700 (PDT)
From:   Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH 01/30] ia64/sn: Use kmemdup rather than duplicating its implementation
Date:   Wed,  3 Jul 2019 21:12:34 +0800
Message-Id: <20190703131234.24533-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memset, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memset.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
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

