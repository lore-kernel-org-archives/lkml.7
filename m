Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7989C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CAC20709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbfLWORX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:17:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:18203 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfLWORW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="268164201"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Dec 2019 06:17:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5700E27E; Mon, 23 Dec 2019 16:17:17 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>, x86@kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/37] platform/x86: intel_scu_ipc: Remove Lincroft support
Date:   Mon, 23 Dec 2019 17:16:43 +0300
Message-Id: <20191223141716.13727-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moorestown support was removed years ago with by the commit 1a8359e411eb
("x86/mid: Remove Intel Moorestown"). Lincroft is the CPU side chip of
Moorestown and not supported anymore so remove the code from the driver.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/platform/x86/intel_scu_ipc.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index a8be5bcb9832..6c44fe5e55b5 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -58,7 +58,6 @@
 #define IPC_RWBUF_SIZE    20		/* IPC Read buffer Size */
 #define IPC_IOC	          0x100		/* IPC command register IOC bit */
 
-#define PCI_DEVICE_ID_LINCROFT		0x082a
 #define PCI_DEVICE_ID_PENWELL		0x080e
 #define PCI_DEVICE_ID_CLOVERVIEW	0x08ea
 #define PCI_DEVICE_ID_TANGIER		0x11a0
@@ -70,12 +69,6 @@ struct intel_scu_ipc_pdata_t {
 	u8 irq_mode;
 };
 
-static const struct intel_scu_ipc_pdata_t intel_scu_ipc_lincroft_pdata = {
-	.i2c_base = 0xff12b000,
-	.i2c_len = 0x10,
-	.irq_mode = 0,
-};
-
 /* Penwell and Cloverview */
 static const struct intel_scu_ipc_pdata_t intel_scu_ipc_penwell_pdata = {
 	.i2c_base = 0xff12b000,
@@ -677,7 +670,6 @@ static int ipc_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 #define SCU_DEVICE(id, pdata)	{PCI_VDEVICE(INTEL, id), (kernel_ulong_t)&pdata}
 
 static const struct pci_device_id pci_ids[] = {
-	SCU_DEVICE(PCI_DEVICE_ID_LINCROFT,	intel_scu_ipc_lincroft_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_PENWELL,	intel_scu_ipc_penwell_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_CLOVERVIEW,	intel_scu_ipc_penwell_pdata),
 	SCU_DEVICE(PCI_DEVICE_ID_TANGIER,	intel_scu_ipc_tangier_pdata),
-- 
2.24.0

