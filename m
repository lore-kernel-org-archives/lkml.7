Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38E9C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA6F52077B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 11:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgAHLmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:42:51 -0500
Received: from mga09.intel.com ([134.134.136.24]:62303 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727727AbgAHLmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 06:42:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 03:42:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,409,1571727600"; 
   d="scan'208";a="233576464"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 08 Jan 2020 03:42:13 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 44BE46AA; Wed,  8 Jan 2020 13:42:03 +0200 (EET)
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
Subject: [PATCH v2 31/36] x86/platform/intel-mid: Add empty stubs for intel_scu_devices_[create|destroy]()
Date:   Wed,  8 Jan 2020 14:41:56 +0300
Message-Id: <20200108114201.27908-32-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
References: <20200108114201.27908-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows to call the functions even when CONFIG_X86_INTEL_MID is not
enabled.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 arch/x86/include/asm/intel-mid.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-mid.h b/arch/x86/include/asm/intel-mid.h
index 8e5af119dc2d..de58391bdee0 100644
--- a/arch/x86/include/asm/intel-mid.h
+++ b/arch/x86/include/asm/intel-mid.h
@@ -88,11 +88,17 @@ static inline bool intel_mid_has_msic(void)
 	return (intel_mid_identify_cpu() == INTEL_MID_CPU_CHIP_PENWELL);
 }
 
+extern void intel_scu_devices_create(void);
+extern void intel_scu_devices_destroy(void);
+
 #else /* !CONFIG_X86_INTEL_MID */
 
 #define intel_mid_identify_cpu()	0
 #define intel_mid_has_msic()		0
 
+static inline void intel_scu_devices_create(void) { }
+static inline void intel_scu_devices_destroy(void) { }
+
 #endif /* !CONFIG_X86_INTEL_MID */
 
 enum intel_mid_timer_options {
@@ -115,9 +121,6 @@ extern enum intel_mid_timer_options intel_mid_timer_options;
 #define SFI_MTMR_MAX_NUM		8
 #define SFI_MRTC_MAX			8
 
-extern void intel_scu_devices_create(void);
-extern void intel_scu_devices_destroy(void);
-
 /* VRTC timer */
 #define MRST_VRTC_MAP_SZ		1024
 /* #define MRST_VRTC_PGOFFSET		0xc00 */
-- 
2.24.1

