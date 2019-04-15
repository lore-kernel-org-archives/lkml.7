Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F80EC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CC8218A1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555353949;
	bh=zV+L8fu2E1eV0Y+Fd7rC4gJXSkZRpWLe0Fd2xS3GM+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=afqBrGDUVTRcaDieJCtRUBS1BqorkYaSbpR631YvplvwuB3ANmfrhrkYZ+AAuMoSQ
	 bVeiKRflveTFGQS9ES6TYu/DCIaFSwf9E9DplWoCk6FHRwUMAy2Wwx+jvrzGCO9y8t
	 e9qxkVfGsCZ2a6xsaml3ThaKpKlYrwKfr9tHBfVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfDOSpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 14:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728434AbfDOSpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 14:45:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A6F2087C;
        Mon, 15 Apr 2019 18:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555353945;
        bh=zV+L8fu2E1eV0Y+Fd7rC4gJXSkZRpWLe0Fd2xS3GM+k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFOBdE6FB5EMieHAJ+Cq3ZNWCBfHfjU0NOBHIkHR2d0eT6/bo2z/tMEtUJZqmA6px
         Xmijr/s8Yj7x+MDOROFGlsI5Iv6zsDFE6b5TVnfq2Np/+wWwDrvOcr3wQwVHldXI1a
         /yqc/mIuOtF7MiBJfwW5ox98ubo1mAz15x2rIXPw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 14/76] powerpc/64s: Patch barrier_nospec in modules
Date:   Mon, 15 Apr 2019 20:43:38 +0200
Message-Id: <20190415183711.746568294@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183707.712011689@linuxfoundation.org>
References: <20190415183707.712011689@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 815069ca57c142eb71d27439bc27f41a433a67b3 upstream.

Note that unlike RFI which is patched only in kernel the nospec state
reflects settings at the time the module was loaded.

Iterating all modules and re-patching every time the settings change
is not implemented.

Based on lwsync patching.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/setup.h  |  7 +++++++
 arch/powerpc/kernel/module.c      |  6 ++++++
 arch/powerpc/kernel/security.c    |  2 +-
 arch/powerpc/lib/feature-fixups.c | 16 +++++++++++++---
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 709f4e739ae8..a225b5c42e76 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -52,6 +52,13 @@ enum l1d_flush_type {
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
 void do_barrier_nospec_fixups(bool enable);
+extern bool barrier_nospec_enabled;
+
+#ifdef CONFIG_PPC_BOOK3S_64
+void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
+#else
+static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
+#endif
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 30b89d5cbb03..d30f0626dcd0 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,6 +72,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
+
+	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
+	if (sect != NULL)
+		do_barrier_nospec_fixups_range(barrier_nospec_enabled,
+				  (void *)sect->sh_addr,
+				  (void *)sect->sh_addr + sect->sh_size);
 #endif
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index 8b1cf9c81b82..34d436fe2498 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -15,7 +15,7 @@
 
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
 
-static bool barrier_nospec_enabled;
+bool barrier_nospec_enabled;
 
 static void enable_barrier_nospec(bool enable)
 {
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index f82ae6bb2365..a1222c441df5 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -278,14 +278,14 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 						: "unknown");
 }
 
-void do_barrier_nospec_fixups(bool enable)
+void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
 {
 	unsigned int instr, *dest;
 	long *start, *end;
 	int i;
 
-	start = PTRRELOC(&__start___barrier_nospec_fixup),
-	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+	start = fixup_start;
+	end = fixup_end;
 
 	instr = 0x60000000; /* nop */
 
@@ -304,6 +304,16 @@ void do_barrier_nospec_fixups(bool enable)
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
 
+void do_barrier_nospec_fixups(bool enable)
+{
+	void *start, *end;
+
+	start = PTRRELOC(&__start___barrier_nospec_fixup),
+	end = PTRRELOC(&__stop___barrier_nospec_fixup);
+
+	do_barrier_nospec_fixups_range(enable, start, end);
+}
+
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
-- 
2.19.1



