Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2A6C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80E52077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgAHLnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:43:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:62299 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727613AbgAHLmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:42:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 03:42:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="233576456"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2020 03:42:12 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 15FD85DF; Wed,  8 Jan 2020 13:42:03 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 26/36] mfd: intel_soc_pmic: Add SCU IPC member to struct intel_soc_pmic
Date:   Wed,  8 Jan 2020 14:41:51 +0300
Message-Id: <20200108114201.27908-27-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both PMIC drivers (intel_soc_pmic_mrfld and intel_soc_pmic_bxtwc) will
be using this field going forward to access the SCU IPC instance.

While there add kernel-doc for the intel_soc_pmic structure.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 include/linux/mfd/intel_soc_pmic.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/mfd/intel_soc_pmic.h b/include/linux/mfd/intel_soc_pmic.h
index bfecd6bd4990..bda22d750be6 100644
--- a/include/linux/mfd/intel_soc_pmic.h
+++ b/include/linux/mfd/intel_soc_pmic.h
@@ -13,6 +13,20 @@
 
 #include <linux/regmap.h>
 
+/**
+ * struct intel_soc_pmic - Intel SoC PMIC data
+ * @irq: Interrupt number
+ * @regmap: Pointer to the regmap structure
+ * @irq_chip_data: IRQ chip data for the PMIC itself
+ * @irq_chip_data_pwrbtn: Chained IRQ chip data for the power button
+ * @irq_chip_data_tmu: Chained IRQ chip data for the TMU
+ * @irq_chip_data_bcu: Chained IRQ chip data for the BCU
+ * @irq_chip_data_adc: Chained IRQ chip data for the ADC
+ * @irq_chip_data_chgr: Chained IRQ chip data for the CHGR
+ * @irq_chip_data_crit: Chained IRQ chip data for the CRIT
+ * @dev: Pointer to the PMIC device
+ * @scu: SCU IPC pointer used for IPC operations
+ */
 struct intel_soc_pmic {
 	int irq;
 	struct regmap *regmap;
@@ -24,6 +38,7 @@ struct intel_soc_pmic {
 	struct regmap_irq_chip_data *irq_chip_data_chgr;
 	struct regmap_irq_chip_data *irq_chip_data_crit;
 	struct device *dev;
+	struct intel_scu_ipc_dev *scu;
 };
 
 int intel_soc_pmic_exec_mipi_pmic_seq_element(u16 i2c_address, u32 reg_address,
-- 
2.24.1

