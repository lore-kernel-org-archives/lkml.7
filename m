Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5371E2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 10:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbfC2KK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:10:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35401 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfC2KKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 06:10:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2TAA5eX3738879
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 29 Mar 2019 03:10:05 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2TAA5e93738874;
        Fri, 29 Mar 2019 03:10:05 -0700
Date:   Fri, 29 Mar 2019 03:10:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Matteo Croce <tipbot@zytor.com>
Message-ID: <tip-f560bd19d2fe0e54851d706b72acbc6f2eed3567@git.kernel.org>
Cc:     mcroce@redhat.com, ard.biesheuvel@linaro.org, hpa@zytor.com,
        bp@suse.de, tglx@linutronix.de, mingo@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-efi@vger.kernel.org, mojha@codeaurora.org
Reply-To: linux-kernel@vger.kernel.org, x86@kernel.org,
          linux-efi@vger.kernel.org, mojha@codeaurora.org,
          mcroce@redhat.com, ard.biesheuvel@linaro.org, hpa@zytor.com,
          bp@suse.de, tglx@linutronix.de, mingo@kernel.org,
          mingo@redhat.com
In-Reply-To: <20190328114233.27835-1-mcroce@redhat.com>
References: <20190328114233.27835-1-mcroce@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/realmode: Make set_real_mode_mem() static
 inline
Git-Commit-ID: f560bd19d2fe0e54851d706b72acbc6f2eed3567
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

Commit-ID:  f560bd19d2fe0e54851d706b72acbc6f2eed3567
Gitweb:     https://git.kernel.org/tip/f560bd19d2fe0e54851d706b72acbc6f2eed3567
Author:     Matteo Croce <mcroce@redhat.com>
AuthorDate: Thu, 28 Mar 2019 12:42:33 +0100
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Fri, 29 Mar 2019 10:16:27 +0100

x86/realmode: Make set_real_mode_mem() static inline

Remove the unused @size argument and move it into a header file, so it
can be inlined.

 [ bp: Massage. ]

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-efi <linux-efi@vger.kernel.org>
Cc: platform-driver-x86@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190328114233.27835-1-mcroce@redhat.com
---
 arch/x86/include/asm/realmode.h | 6 +++++-
 arch/x86/platform/efi/quirks.c  | 2 +-
 arch/x86/realmode/init.c        | 9 +--------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 63b3393bd98e..c53682303c9c 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -77,7 +77,11 @@ static inline size_t real_mode_size_needed(void)
 	return ALIGN(real_mode_blob_end - real_mode_blob, PAGE_SIZE);
 }
 
-void set_real_mode_mem(phys_addr_t mem, size_t size);
+static inline void set_real_mode_mem(phys_addr_t mem)
+{
+	real_mode_header = (struct real_mode_header *) __va(mem);
+}
+
 void reserve_real_mode(void);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 458a0e2bcc57..a25a9fd987a9 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -449,7 +449,7 @@ void __init efi_free_boot_services(void)
 		 */
 		rm_size = real_mode_size_needed();
 		if (rm_size && (start + rm_size) < (1<<20) && size >= rm_size) {
-			set_real_mode_mem(start, rm_size);
+			set_real_mode_mem(start);
 			start += rm_size;
 			size -= rm_size;
 		}
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 47d097946872..7dce39c8c034 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -15,13 +15,6 @@ u32 *trampoline_cr4_features;
 /* Hold the pgd entry used on booting additional CPUs */
 pgd_t trampoline_pgd_entry;
 
-void __init set_real_mode_mem(phys_addr_t mem, size_t size)
-{
-	void *base = __va(mem);
-
-	real_mode_header = (struct real_mode_header *) base;
-}
-
 void __init reserve_real_mode(void)
 {
 	phys_addr_t mem;
@@ -40,7 +33,7 @@ void __init reserve_real_mode(void)
 	}
 
 	memblock_reserve(mem, size);
-	set_real_mode_mem(mem, size);
+	set_real_mode_mem(mem);
 }
 
 static void __init setup_real_mode(void)
