Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F373FC31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4201217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 16:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfFNQqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 12:46:32 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:42108 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfFNQqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 12:46:32 -0400
Received: from anisse-station.iliad.local (unknown [213.36.7.13])
        by smtp3-g21.free.fr (Postfix) with ESMTPS id 2882B13F8B6;
        Fri, 14 Jun 2019 18:46:03 +0200 (CEST)
From:   Anisse Astier <aastier@freebox.fr>
To:     Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Rich Felker <dalias@aerifal.cx>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Ricardo Salveti <ricardo@foundries.io>,
        Anisse Astier <aastier@freebox.fr>
Subject: [PATCH v2] arm64/sve: <uapi/asm/ptrace.h> should not depend on <uapi/linux/prctl.h>
Date:   Fri, 14 Jun 2019 18:46:00 +0200
Message-Id: <20190614164600.36966-1-aastier@freebox.fr>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190613163801.21949-1-aastier@freebox.fr>
References: <20190613163801.21949-1-aastier@freebox.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise this will create userspace build issues for any program
(strace, qemu) that includes both <sys/prctl.h> (with musl libc) and
<linux/ptrace.h> (which then includes <asm/ptrace.h>), like this:

	error: redefinition of 'struct prctl_mm_map'
	 struct prctl_mm_map {

See https://github.com/foundriesio/meta-lmp/commit/6d4a106e191b5d79c41b9ac78fd321316d3013c0
for a public example of people working around this issue.

Copying the defines is a bit imperfect here, but better than creating a
whole other header for just two defines that would never change, as part
of the kernel ABI.

Fixes: 43d4da2c45b2 ("arm64/sve: ptrace and ELF coredump support")
Cc: stable@vger.kernel.org
Signed-off-by: Anisse Astier <aastier@freebox.fr>
---
Changes since v1:
 - made a bit more explicit that we copied defined symbols, in commit
   and code.
 - Use Fixes: tag in commit message

Thanks to Dave Martin and Will Deacon for the review.

---
 arch/arm64/include/uapi/asm/ptrace.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/uapi/asm/ptrace.h b/arch/arm64/include/uapi/asm/ptrace.h
index d78623acb649..438759e7e8a7 100644
--- a/arch/arm64/include/uapi/asm/ptrace.h
+++ b/arch/arm64/include/uapi/asm/ptrace.h
@@ -65,8 +65,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/prctl.h>
-
 /*
  * User structures for general purpose, floating point and debug registers.
  */
@@ -113,10 +111,10 @@ struct user_sve_header {
 
 /*
  * Common SVE_PT_* flags:
- * These must be kept in sync with prctl interface in <linux/ptrace.h>
+ * These must be kept in sync with prctl interface in <linux/prctl.h>
  */
-#define SVE_PT_VL_INHERIT		(PR_SVE_VL_INHERIT >> 16)
-#define SVE_PT_VL_ONEXEC		(PR_SVE_SET_VL_ONEXEC >> 16)
+#define SVE_PT_VL_INHERIT		((1 << 17) /* PR_SVE_VL_INHERIT */ >> 16)
+#define SVE_PT_VL_ONEXEC		((1 << 18) /* PR_SVE_SET_VL_ONEXEC */ >> 16)
 
 
 /*
-- 
2.19.1

