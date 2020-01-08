Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB04C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8622077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgAHLoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:44:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:51036 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727427AbgAHLmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:42:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 03:42:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="370923778"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 08 Jan 2020 03:42:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1A2E03B6; Wed,  8 Jan 2020 13:42:02 +0200 (EET)
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
Subject: [PATCH v2 05/36] platform/x86: intel_scu_ipc: Drop intel_scu_ipc_i2c_cntrl()
Date:   Wed,  8 Jan 2020 14:41:30 +0300
Message-Id: <20200108114201.27908-6-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no existing users for this functionality so drop it from the
driver completely.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h |  3 --
 drivers/platform/x86/intel_scu_ipc.c | 62 ----------------------------
 2 files changed, 65 deletions(-)

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index 4a8c6e817398..d7bbebf4b729 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -53,9 +53,6 @@ int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
 int intel_scu_ipc_raw_command(int cmd, int sub, u8 *in, int inlen,
 			      u32 *out, int outlen, u32 dptr, u32 sptr);
 
-/* I2C control api */
-int intel_scu_ipc_i2c_cntrl(u32 addr, u32 *data);
-
 /* Update FW version */
 int intel_scu_ipc_fw_update(u8 *buffer, u32 length);
 
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 6c44fe5e55b5..b39680b53387 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -64,28 +64,21 @@
 
 /* intel scu ipc driver data */
 struct intel_scu_ipc_pdata_t {
-	u32 i2c_base;
-	u32 i2c_len;
 	u8 irq_mode;
 };
 
 /* Penwell and Cloverview */
 static const struct intel_scu_ipc_pdata_t intel_scu_ipc_penwell_pdata = {
-	.i2c_base = 0xff12b000,
-	.i2c_len = 0x10,
 	.irq_mode = 1,
 };
 
 static const struct intel_scu_ipc_pdata_t intel_scu_ipc_tangier_pdata = {
-	.i2c_base  = 0xff00d000,
-	.i2c_len = 0x10,
 	.irq_mode = 0,
 };
 
 struct intel_scu_ipc_dev {
 	struct device *dev;
 	void __iomem *ipc_base;
-	void __iomem *i2c_base;
 	struct completion cmd_complete;
 	u8 irq_mode;
 };
@@ -103,9 +96,6 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
 #define IPC_WRITE_BUFFER	0x80
 #define IPC_READ_BUFFER		0x90
 
-#define IPC_I2C_CNTRL_ADDR	0
-#define I2C_DATA_ADDR		0x04
-
 static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
 
 /*
@@ -549,54 +539,6 @@ int intel_scu_ipc_raw_command(int cmd, int sub, u8 *in, int inlen,
 }
 EXPORT_SYMBOL_GPL(intel_scu_ipc_raw_command);
 
-/* I2C commands */
-#define IPC_I2C_WRITE 1 /* I2C Write command */
-#define IPC_I2C_READ  2 /* I2C Read command */
-
-/**
- *	intel_scu_ipc_i2c_cntrl		-	I2C read/write operations
- *	@addr: I2C address + command bits
- *	@data: data to read/write
- *
- *	Perform an an I2C read/write operation via the SCU. All locking is
- *	handled for the caller. This function may sleep.
- *
- *	Returns an error code or 0 on success.
- *
- *	This has to be in the IPC driver for the locking.
- */
-int intel_scu_ipc_i2c_cntrl(u32 addr, u32 *data)
-{
-	struct intel_scu_ipc_dev *scu = &ipcdev;
-	u32 cmd = 0;
-
-	mutex_lock(&ipclock);
-	if (scu->dev == NULL) {
-		mutex_unlock(&ipclock);
-		return -ENODEV;
-	}
-	cmd = (addr >> 24) & 0xFF;
-	if (cmd == IPC_I2C_READ) {
-		writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
-		/* Write not getting updated without delay */
-		usleep_range(1000, 2000);
-		*data = readl(scu->i2c_base + I2C_DATA_ADDR);
-	} else if (cmd == IPC_I2C_WRITE) {
-		writel(*data, scu->i2c_base + I2C_DATA_ADDR);
-		usleep_range(1000, 2000);
-		writel(addr, scu->i2c_base + IPC_I2C_CNTRL_ADDR);
-	} else {
-		dev_err(scu->dev,
-			"intel_scu_ipc: I2C INVALID_CMD = 0x%x\n", cmd);
-
-		mutex_unlock(&ipclock);
-		return -EIO;
-	}
-	mutex_unlock(&ipclock);
-	return 0;
-}
-EXPORT_SYMBOL(intel_scu_ipc_i2c_cntrl);
-
 /*
  * Interrupt handler gets called when ioc bit of IPC_COMMAND_REG set to 1
  * When ioc bit is set to 1, caller api must wait for interrupt handler called
@@ -649,10 +591,6 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	scu->ipc_base = pcim_iomap_table(pdev)[0];
 
-	scu->i2c_base = ioremap_nocache(pdata->i2c_base, pdata->i2c_len);
-	if (!scu->i2c_base)
-		return -ENOMEM;
-
 	err = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_scu_ipc",
 			       scu);
 	if (err)
-- 
2.24.1

