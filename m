Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39EB6C282E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167D42184E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 00:05:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbfEYAF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 20:05:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:36241 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfEYAFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 20:05:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2019 17:05:17 -0700
X-ExtLoop1: 1
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga005.jf.intel.com with ESMTP; 24 May 2019 17:05:17 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@amacapital.net>,
        "Andrew Cooper" <andrew.cooper3@citrix.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 5/5] x86/umwait: Document umwait control sysfs interfaces
Date:   Fri, 24 May 2019 16:56:02 -0700
Message-Id: <1558742162-73402-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com>
References: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since two new sysfs interface files are created for umwait control, add
an ABI document entry for the files:
	/sys/devices/system/cpu/umwait_control/enable_c0_2
	/sys/devices/system/cpu/umwait_control/max_time

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 1528239f69b2..bbf65ae447ff 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -538,3 +538,24 @@ Description:	Intel Energy and Performance Bias Hint (EPB)
 
 		This attribute is present for all online CPUs supporting the
 		Intel EPB feature.
+
+What:		/sys/devices/system/cpu/umwait_control
+		/sys/devices/system/cpu/umwait_control/enable_c0_2
+		/sys/devices/system/cpu/umwait_control/max_time
+Date:		May 2019
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Umwait control
+
+		enable_c0_2: Read/write interface to control umwait C0.2 state
+			Read returns C0.2 state status:
+				0: C0.2 is disabled
+				1: C0.2 is enabled
+
+			Write 'Yy1' or [oO][nN] for on to enable C0.2 state.
+			Write 'Nn0' or [oO][fF] for off to disable C0.2 state.
+
+		max_time: Read/write interface to control umwait maximum time
+			  in TSC-quanta that the CPU can reside in either C0.1
+			  or C0.2 state. The time is represented as an unsigned
+			  integer decimal value. Bits[1:0] are ignore.
+			  A zero value indicates no maximum time.
-- 
2.19.1

