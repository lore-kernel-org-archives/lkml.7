Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD7CC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B7F42086D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 05:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TVsneAi4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfF1FVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:21:08 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45477 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbfF1FVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 01:21:07 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5S5KYY9614701
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 27 Jun 2019 22:20:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5S5KYY9614701
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561699235;
        bh=f3/e2qVro/uDu+DipMcO/vFVf9VuacxNZspNTim3nIo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TVsneAi4dwyWSiMUlmrn33zDxk7CfF/D9PxFSSfvB6wbkF1D1JoLQLAOwjRfXugwu
         VEQMFMyDnDw0l/FuBi01vrK788cPf8j4s8srHYm4ab6dk0+ClMQ0JVjIDMVOPUSgXp
         xcUipZXBu+YY4pa5qZYB6JEmRup3UlLIuMJcNp2IXaVW4KrfmizmfuqT88oQpcEFqS
         jl81JzmzaZghDPeXQTihVSzoi0drt9wAvyvY8hvSqF8RG4NRTdYok00OFYjt/HFn5d
         kXQfhXN74VNXnePXbzZkxNkCt36K2ZnOtgGfZn/xtWhfC1/HPXhRcYupl/+d8anCxP
         dk4xyMmmFHfnw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5S5KYQA614696;
        Thu, 27 Jun 2019 22:20:34 -0700
Date:   Thu, 27 Jun 2019 22:20:34 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Baoquan He <tipbot@zytor.com>
Message-ID: <tip-8ff80fbe7e9870078b1cc3c2cdd8f3f223b333a9@git.kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, dyoung@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, bhe@redhat.com
Reply-To: kirill.shutemov@linux.intel.com, dyoung@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, bhe@redhat.com,
          linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190524073810.24298-4-bhe@redhat.com>
References: <20190524073810.24298-4-bhe@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/kdump/64: Restrict kdump kernel reservation to
 <64TB
Git-Commit-ID: 8ff80fbe7e9870078b1cc3c2cdd8f3f223b333a9
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8ff80fbe7e9870078b1cc3c2cdd8f3f223b333a9
Gitweb:     https://git.kernel.org/tip/8ff80fbe7e9870078b1cc3c2cdd8f3f223b333a9
Author:     Baoquan He <bhe@redhat.com>
AuthorDate: Fri, 24 May 2019 15:38:10 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 28 Jun 2019 07:14:59 +0200

x86/kdump/64: Restrict kdump kernel reservation to <64TB

Restrict kdump to only reserve crashkernel below 64TB.

The reaons is that the kdump may jump from a 5-level paging mode to a
4-level paging mode kernel. If a 4-level paging mode kdump kernel is put
above 64TB, then the kdump kernel cannot start.

The 1st kernel reserves the kdump kernel region during bootup. At that
point it is not known whether the kdump kernel has 5-level or 4-level
paging support.

To support both restrict the kdump kernel reservation to the lower 64TB
address space to ensure that a 4-level paging mode kdump kernel can be
loaded and successfully started.

[ tglx: Massaged changelog ]

Signed-off-by: Baoquan He <bhe@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Dave Young <dyoung@redhat.com>
Cc: bp@alien8.de
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/20190524073810.24298-4-bhe@redhat.com

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
