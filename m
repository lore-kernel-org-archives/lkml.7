Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A55C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07162147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 10:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCLKbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 06:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbfCLKbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 06:31:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 44BAF3086268;
        Tue, 12 Mar 2019 10:31:14 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 269F31001E63;
        Tue, 12 Mar 2019 10:31:08 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, bp@alien8.de, hpa@zytor.com, dyoung@redhat.com,
        x86@kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH v3 3/3] x86/kdump/64: Change the upper limit of crashkernel reservation
Date:   Tue, 12 Mar 2019 18:30:51 +0800
Message-Id: <20190312103051.18086-4-bhe@redhat.com>
In-Reply-To: <20190312103051.18086-1-bhe@redhat.com>
References: <20190312103051.18086-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 12 Mar 2019 10:31:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict kdump to only reserve crashkernel below 64TB. Since the kdump
jumping may be from 5-level to 4-level, and the kdump kernel is put
above 64TB in 5-level kernel, then the jumping will fail. And the
crashkernel reservation is done during the 1st kernel bootup, there's
no way to detect the paging mode of kdump kernel at that time.

Hence change the upper limit of crashkernel reservation to 64TB
on x86_64.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/setup.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3d872a527cd9..5508b981f33d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -451,16 +451,26 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #define CRASH_ALIGN		(16 << 20)
 
 /*
- * Keep the crash kernel below this limit.  On 32 bits earlier kernels
- * would limit the kernel to the low 512 MiB due to mapping restrictions.
- * On 64bit, old kexec-tools need to under 896MiB.
+ * Keep the crash kernel below this limit.
+ *
+ * On 32 bits earlier kernels would limit the kernel to the low
+ * 512 MiB due to mapping restrictions.
+ *
+ * On 64bit, old kexec-tools need to be under 896MiB. The later
+ * supports to put kernel above 4G, up to system RAM top. Here
+ * kdump kernel need be restricted to be under 64TB, which is
+ * the upper limit of system RAM in 4-level paing mode. Since
+ * the kdump jumping could be from 5-level to 4-level, the jumping
+ * will fail if kernel is put above 64TB, and there's no way to
+ * detect the paging mode of the kernel which will be loaded for
+ * dumping during the 1st kernel bootup.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	(512 << 20)
 # define CRASH_ADDR_HIGH_MAX	(512 << 20)
 #else
 # define CRASH_ADDR_LOW_MAX	(896UL << 20)
-# define CRASH_ADDR_HIGH_MAX	MAXMEM
+# define CRASH_ADDR_HIGH_MAX	(64UL << 40)
 #endif
 
 static int __init reserve_crashkernel_low(void)
-- 
2.17.2

