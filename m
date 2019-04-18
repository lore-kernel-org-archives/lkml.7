Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC314C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC720675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611161;
	bh=eZ7balOe1P4dCh2PtPSrsGbrsHZB00FQdELE53Dv6Js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QKwd6xZBQ2id2WTqYMYIqiiaxrjltZQ8y/8IKSBRYnjKZFnMafaWCRAsssjdewit0
	 BRUXdAYkoAiTuXzHvPp5MrFx2C0p+OPZsePaOTus5DAL0lF7LFG3SLWsMyQRd2syjU
	 pVCY3x1FxfGEPPDi96VEAQvifpFQO5laD7z+yW1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404329AbfDRSMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:12:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404300AbfDRSMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:12:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CDE620652;
        Thu, 18 Apr 2019 18:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611157;
        bh=eZ7balOe1P4dCh2PtPSrsGbrsHZB00FQdELE53Dv6Js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SQae3m99fKu+ztQFke0qn1tJ7iPNoTPtkDScLTMm0dyquwyNy32VawSYO4Cz5RzGC
         PshcXR+HmZGM4Wl1Y+U4dn8GC8YCzt71nNpo5wOkvlGPztN34aw6M6Wg4Dl7/PszA1
         0ltOoVw48cq9mDVYKrhoh4hH8776mDKjy3VYiCvQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "David E. Box" <david.e.box@linux.intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>,
        Sasha Levin <sashal@kernel.org>,
        russianneuromancer <russianneuromancer@ya.ru>
Subject: [PATCH 5.0 81/93] platform/x86: intel_pmc_core: Quirk to ignore XTAL shutdown
Date:   Thu, 18 Apr 2019 19:57:59 +0200
Message-Id: <20190418160445.178163032@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 238f9c11351f8af8534ae0318b4d9acc77b09ee8 ]

On some platforms such as HP Elite-x2-1013-g3, the platform BIOS
enforces XTAL to remain off before S0ix state can be achieved. This may
not be optimum when we want to enable use cases like Low Power Audio,
Wake on Voice etc which always need 24mhz clock.

This introduces a new quirk to allow S0ix entry when all other
conditions except for XTAL clock are good on a given platform. The extra
power consumed by XTAL clock is about 2mw but it saves much more
platform power compared to the system that remains in just PC10.

Link: https://bit.ly/2UmnrFf
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201579
Tested-by: "David E. Box" <david.e.box@linux.intel.com>
Reported-and-tested-by: russianneuromancer <russianneuromancer@ya.ru>
Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel_pmc_core.c | 34 +++++++++++++++++++++++++++
 drivers/platform/x86/intel_pmc_core.h |  5 ++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index c37e74ee609d..a9cbe5be277b 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -15,6 +15,7 @@
 #include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -139,6 +140,7 @@ static const struct pmc_reg_map spt_reg_map = {
 	.pm_cfg_offset = SPT_PMC_PM_CFG_OFFSET,
 	.pm_read_disable_bit = SPT_PMC_READ_DISABLE_BIT,
 	.ltr_ignore_max = SPT_NUM_IP_IGN_ALLOWED,
+	.pm_vric1_offset = SPT_PMC_VRIC1_OFFSET,
 };
 
 /* Cannonlake: PGD PFET Enable Ack Status Register(s) bitmap */
@@ -751,6 +753,37 @@ static const struct pci_device_id pmc_pci_ids[] = {
 	{ 0, },
 };
 
+/*
+ * This quirk can be used on those platforms where
+ * the platform BIOS enforces 24Mhx Crystal to shutdown
+ * before PMC can assert SLP_S0#.
+ */
+int quirk_xtal_ignore(const struct dmi_system_id *id)
+{
+	struct pmc_dev *pmcdev = &pmc;
+	u32 value;
+
+	value = pmc_core_reg_read(pmcdev, pmcdev->map->pm_vric1_offset);
+	/* 24MHz Crystal Shutdown Qualification Disable */
+	value |= SPT_PMC_VRIC1_XTALSDQDIS;
+	/* Low Voltage Mode Enable */
+	value &= ~SPT_PMC_VRIC1_SLPS0LVEN;
+	pmc_core_reg_write(pmcdev, pmcdev->map->pm_vric1_offset, value);
+	return 0;
+}
+
+static const struct dmi_system_id pmc_core_dmi_table[]  = {
+	{
+	.callback = quirk_xtal_ignore,
+	.ident = "HP Elite x2 1013 G3",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "HP Elite x2 1013 G3"),
+		},
+	},
+	{}
+};
+
 static int __init pmc_core_probe(void)
 {
 	struct pmc_dev *pmcdev = &pmc;
@@ -792,6 +825,7 @@ static int __init pmc_core_probe(void)
 		return err;
 	}
 
+	dmi_check_system(pmc_core_dmi_table);
 	pr_info(" initialized\n");
 	return 0;
 }
diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
index 1a0104d2cbf0..9bc16d7d2917 100644
--- a/drivers/platform/x86/intel_pmc_core.h
+++ b/drivers/platform/x86/intel_pmc_core.h
@@ -25,6 +25,7 @@
 #define SPT_PMC_MTPMC_OFFSET			0x20
 #define SPT_PMC_MFPMC_OFFSET			0x38
 #define SPT_PMC_LTR_IGNORE_OFFSET		0x30C
+#define SPT_PMC_VRIC1_OFFSET			0x31c
 #define SPT_PMC_MPHY_CORE_STS_0			0x1143
 #define SPT_PMC_MPHY_CORE_STS_1			0x1142
 #define SPT_PMC_MPHY_COM_STS_0			0x1155
@@ -135,6 +136,9 @@ enum ppfear_regs {
 #define SPT_PMC_BIT_MPHY_CMN_LANE2		BIT(2)
 #define SPT_PMC_BIT_MPHY_CMN_LANE3		BIT(3)
 
+#define SPT_PMC_VRIC1_SLPS0LVEN			BIT(13)
+#define SPT_PMC_VRIC1_XTALSDQDIS		BIT(22)
+
 /* Cannonlake Power Management Controller register offsets */
 #define CNP_PMC_SLPS0_DBG_OFFSET		0x10B4
 #define CNP_PMC_PM_CFG_OFFSET			0x1818
@@ -217,6 +221,7 @@ struct pmc_reg_map {
 	const int pm_read_disable_bit;
 	const u32 slps0_dbg_offset;
 	const u32 ltr_ignore_max;
+	const u32 pm_vric1_offset;
 };
 
 /**
-- 
2.19.1



