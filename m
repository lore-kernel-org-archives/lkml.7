Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A307217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 07:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbfEXHjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 03:39:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388911AbfEXHjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 03:39:03 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE2663092663;
        Fri, 24 May 2019 07:38:54 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 164815B689;
        Fri, 24 May 2019 07:38:50 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@kernel.org, bp@alien8.de, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, x86@kernel.org, dyoung@redhat.com,
        Baoquan He <bhe@redhat.com>
Subject: [PATCH v5 3/3] x86/kdump/64: Change the upper limit of crashkernel reservation
Date:   Fri, 24 May 2019 15:38:10 +0800
Message-Id: <20190524073810.24298-4-bhe@redhat.com>
In-Reply-To: <20190524073810.24298-1-bhe@redhat.com>
References: <20190524073810.24298-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 24 May 2019 07:39:03 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restrict kdump to only reserve crashkernel below 64TB.

The reaons is that the kdump may jump from 5-level to 4-level, and if
the kdump kernel is put above 64TB, then the jumping will fail. While the
1st kernel reserves crashkernel region during bootup, we don't know yet
which kind of kernel will be loaded after system bootup, 5-level kernel
or 4-level kernel.

Signed-off-by: Baoquan He <bhe@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/kernel/setup.c | 15 ++++++++++++---
 include/linux/sizes.h   |  1 +
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 08a5f4a131f5..dcbdf54fb5c1 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -453,15 +453,24 @@ static void __init memblock_x86_reserve_range_setup_data(void)
 #define CRASH_ALIGN		SZ_16M
 
 /*
- * Keep the crash kernel below this limit.  On 32 bits earlier kernels
- * would limit the kernel to the low 512 MiB due to mapping restrictions.
+ * Keep the crash kernel below this limit.
+ *
+ * On 32 bits earlier kernels would limit the kernel to the low 512 MiB
+ * due to mapping restrictions.
+ *
+ * On 64bit, kdump kernel need be restricted to be under 64TB, which is
+ * the upper limit of system RAM in 4-level paing mode. Since the kdump
+ * jumping could be from 5-level to 4-level, the jumping will fail if
+ * kernel is put above 64TB, and there's no way to detect the paging mode
+ * of the kernel which will be loaded for dumping during the 1st kernel
+ * bootup.
  */
 #ifdef CONFIG_X86_32
 # define CRASH_ADDR_LOW_MAX	SZ_512M
 # define CRASH_ADDR_HIGH_MAX	SZ_512M
 #else
 # define CRASH_ADDR_LOW_MAX	SZ_4G
-# define CRASH_ADDR_HIGH_MAX	MAXMEM
+# define CRASH_ADDR_HIGH_MAX	SZ_64T
 #endif
 
 static int __init reserve_crashkernel_low(void)
diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index fbde0bc7e882..8651269cb46c 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -47,5 +47,6 @@
 #define SZ_2G				0x80000000
 
 #define SZ_4G				_AC(0x100000000, ULL)
+#define SZ_64T				_AC(0x400000000000, ULL)
 
 #endif /* __LINUX_SIZES_H__ */
-- 
2.17.2

