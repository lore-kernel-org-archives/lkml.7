Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D7FC33CA3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257012087F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbgAHLmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:42:18 -0500
Received: from mga07.intel.com ([134.134.136.100]:63961 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727526AbgAHLmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:42:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 03:42:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="271806942"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jan 2020 03:42:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id BAEEB56D; Wed,  8 Jan 2020 13:42:02 +0200 (EET)
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
Subject: [PATCH v2 19/36] platform/x86: intel_pmc_ipc: Make intel_pmc_ipc_simple_command() static
Date:   Wed,  8 Jan 2020 14:41:44 +0300
Message-Id: <20200108114201.27908-20-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is not called outside of intel_pmc_ipc.c so we can make it
static instead.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/include/asm/intel_pmc_ipc.h | 6 ------
 drivers/platform/x86/intel_pmc_ipc.c | 3 +--
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
index 3b2e8b461520..b4f804877651 100644
--- a/arch/x86/include/asm/intel_pmc_ipc.h
+++ b/arch/x86/include/asm/intel_pmc_ipc.h
@@ -31,7 +31,6 @@
 
 #if IS_ENABLED(CONFIG_INTEL_PMC_IPC)
 
-int intel_pmc_ipc_simple_command(int cmd, int sub);
 int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen, u32 dptr, u32 sptr);
 int intel_pmc_ipc_command(u32 cmd, u32 sub, u8 *in, u32 inlen,
@@ -43,11 +42,6 @@ int intel_pmc_gcr_write(u32 offset, u32 data);
 
 #else
 
-static inline int intel_pmc_ipc_simple_command(int cmd, int sub)
-{
-	return -EINVAL;
-}
-
 static inline int intel_pmc_ipc_raw_cmd(u32 cmd, u32 sub, u8 *in, u32 inlen,
 		u32 *out, u32 outlen, u32 dptr, u32 sptr)
 {
diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
index 9229c7a16536..53551f5474a7 100644
--- a/drivers/platform/x86/intel_pmc_ipc.c
+++ b/drivers/platform/x86/intel_pmc_ipc.c
@@ -404,7 +404,7 @@ static int intel_pmc_ipc_check_status(void)
  *
  * Return:	an IPC error code or 0 on success.
  */
-int intel_pmc_ipc_simple_command(int cmd, int sub)
+static int intel_pmc_ipc_simple_command(int cmd, int sub)
 {
 	int ret;
 
@@ -419,7 +419,6 @@ int intel_pmc_ipc_simple_command(int cmd, int sub)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(intel_pmc_ipc_simple_command);
 
 /**
  * intel_pmc_ipc_raw_cmd() - IPC command with data and pointers
-- 
2.24.1

