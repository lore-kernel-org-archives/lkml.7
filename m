Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30951C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E58D21569
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 14:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfLWOR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 09:17:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:17844 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfLWOR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 09:17:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Dec 2019 06:17:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,347,1571727600"; 
   d="scan'208";a="211567537"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 23 Dec 2019 06:17:22 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 9CF1C81F; Mon, 23 Dec 2019 16:17:17 +0200 (EET)
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
Subject: [PATCH 10/37] platform/x86: intel_scu_ipc: Drop intel_scu_ipc_io[read|write][8|16]()
Date:   Mon, 23 Dec 2019 17:16:49 +0300
Message-Id: <20191223141716.13727-11-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
References: <20191223141716.13727-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no users for these so we can remove them.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/include/asm/intel_scu_ipc.h | 12 -----
 drivers/platform/x86/intel_scu_ipc.c | 68 ----------------------------
 2 files changed, 80 deletions(-)

diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
index b2dde96e0611..b59afa59a4cb 100644
--- a/arch/x86/include/asm/intel_scu_ipc.h
+++ b/arch/x86/include/asm/intel_scu_ipc.h
@@ -22,24 +22,12 @@
 /* Read single register */
 int intel_scu_ipc_ioread8(u16 addr, u8 *data);
 
-/* Read two sequential registers */
-int intel_scu_ipc_ioread16(u16 addr, u16 *data);
-
-/* Read four sequential registers */
-int intel_scu_ipc_ioread32(u16 addr, u32 *data);
-
 /* Read a vector */
 int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
 
 /* Write single register */
 int intel_scu_ipc_iowrite8(u16 addr, u8 data);
 
-/* Write two sequential registers */
-int intel_scu_ipc_iowrite16(u16 addr, u16 data);
-
-/* Write four sequential registers */
-int intel_scu_ipc_iowrite32(u16 addr, u32 data);
-
 /* Write a vector */
 int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
 
diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
index 997fdac920c6..ba857e54800b 100644
--- a/drivers/platform/x86/intel_scu_ipc.c
+++ b/drivers/platform/x86/intel_scu_ipc.c
@@ -237,40 +237,6 @@ int intel_scu_ipc_ioread8(u16 addr, u8 *data)
 }
 EXPORT_SYMBOL(intel_scu_ipc_ioread8);
 
-/**
- *	intel_scu_ipc_ioread16		-	read a word via the SCU
- *	@addr: register on SCU
- *	@data: return pointer for read word
- *
- *	Read a register pair. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
- *
- *	This function may sleep.
- */
-int intel_scu_ipc_ioread16(u16 addr, u16 *data)
-{
-	u16 x[2] = {addr, addr + 1};
-	return pwr_reg_rdwr(x, (u8 *)data, 2, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
-}
-EXPORT_SYMBOL(intel_scu_ipc_ioread16);
-
-/**
- *	intel_scu_ipc_ioread32		-	read a dword via the SCU
- *	@addr: register on SCU
- *	@data: return pointer for read dword
- *
- *	Read four registers. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
- *
- *	This function may sleep.
- */
-int intel_scu_ipc_ioread32(u16 addr, u32 *data)
-{
-	u16 x[4] = {addr, addr + 1, addr + 2, addr + 3};
-	return pwr_reg_rdwr(x, (u8 *)data, 4, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_R);
-}
-EXPORT_SYMBOL(intel_scu_ipc_ioread32);
-
 /**
  *	intel_scu_ipc_iowrite8		-	write a byte via the SCU
  *	@addr: register on SCU
@@ -287,40 +253,6 @@ int intel_scu_ipc_iowrite8(u16 addr, u8 data)
 }
 EXPORT_SYMBOL(intel_scu_ipc_iowrite8);
 
-/**
- *	intel_scu_ipc_iowrite16		-	write a word via the SCU
- *	@addr: register on SCU
- *	@data: word to write
- *
- *	Write two registers. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
- *
- *	This function may sleep.
- */
-int intel_scu_ipc_iowrite16(u16 addr, u16 data)
-{
-	u16 x[2] = {addr, addr + 1};
-	return pwr_reg_rdwr(x, (u8 *)&data, 2, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
-}
-EXPORT_SYMBOL(intel_scu_ipc_iowrite16);
-
-/**
- *	intel_scu_ipc_iowrite32		-	write a dword via the SCU
- *	@addr: register on SCU
- *	@data: dword to write
- *
- *	Write four registers. Returns 0 on success or an error code. All
- *	locking between SCU accesses is handled for the caller.
- *
- *	This function may sleep.
- */
-int intel_scu_ipc_iowrite32(u16 addr, u32 data)
-{
-	u16 x[4] = {addr, addr + 1, addr + 2, addr + 3};
-	return pwr_reg_rdwr(x, (u8 *)&data, 4, IPCMSG_PCNTRL, IPC_CMD_PCNTRL_W);
-}
-EXPORT_SYMBOL(intel_scu_ipc_iowrite32);
-
 /**
  *	intel_scu_ipc_readvv		-	read a set of registers
  *	@addr: register list
-- 
2.24.0

