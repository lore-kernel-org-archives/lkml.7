Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615E9FA372B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345FC21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aP7fs4fa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437004AbfJPUB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38243 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436961AbfJPUBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:01:15 -0400
Received: by mail-qt1-f196.google.com with SMTP id j31so37991329qta.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uFvf/fXznSnIHF7tnFK87S0+X7xt7Kheg1PwfwzAB1w=;
        b=aP7fs4faRfvESpCSQvMzu2kYpom8AcZbECTaP6g9QcH2usBGWsH6vHV95nyhtBjABo
         7+fY57pBpeIcsukuKgcsw4e1zLLFY8fUa+03K3SyOUSkR5UcQSGip8n9VevkPK5PoY8W
         CLcIwncsSdUOUj3YNrok1BWN2YYnbnMWquAJGTlpeSvsKscjcXkrvJcoG9bFYucZgiFA
         KNuYCVyXVpKTmJBLmxjlmPdhRKi2DkgrcAQnL4RoNVM8DYhKwRBNi3iVkyFzsLMHScmy
         HhnUoDK3HO5Gz8GL2R7sSj2PXmXBc+lfOAW52ffPN2A8BZ9B2FCL/xGE5mROZRipMeyb
         iEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uFvf/fXznSnIHF7tnFK87S0+X7xt7Kheg1PwfwzAB1w=;
        b=IQIZXLDFOUQOSN/bf4EK9tOE6Pg7tm2gmpUNOYNLfheX0Syz1yaJb7hHFa52BAbsXU
         VULhCvsKXfKbGfGN0XlbG5Fp5hkDkdkbim9hvt4MhRd3ZaXwqsPNAjYntyutyvjM37Cp
         Px5KbG/0/+Ukpl6a4+WkBOL6hujU5YUdeg7PuE31OFiTquC/6cc2femlIALmS9iTjdSK
         d7oWYfh3AUU5owyjwe/ZW0bY4Qjlf8QFw1niI/8Pnj2bRHPk8IavSizm2LCwJuzkI19T
         I2DBVlEas2vGegTNcXG34kfEwzjOwBB47v5t7Q99FL2TFGrN+0/1NBFaYpWAZ/6aFBXu
         dMVw==
X-Gm-Message-State: APjAAAVTDxR/N0Vj6BGSPVYdUFBfUknDEWDoIyuafaiLf3aRqr3xpr2/
        X2A3BdGnLK2praZpMRbIUBj+pw==
X-Google-Smtp-Source: APXvYqyQE0hatidBKOwaY2TrTHlSI+T2qJiEPKvWKsbUagw1I5BzNoRHbfRQOkaJ2BZWJ8GKry4SMQ==
X-Received: by 2002:aed:3fdb:: with SMTP id w27mr47685828qth.223.1571256073488;
        Wed, 16 Oct 2019 13:01:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:01:12 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, bhsharma@redhat.com, linux-mm@kvack.org,
        mark.rutland@arm.com, steve.capper@arm.com, rfontana@redhat.com,
        tglx@linutronix.de
Subject: [PATCH v7 23/25] arm64: kexec: configure trans_pgd page table for kexec
Date:   Wed, 16 Oct 2019 16:00:32 -0400
Message-Id: <20191016200034.1342308-24-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure a page table located in kexec-safe memory that has
the following mappings:

1. identity mapping for text of relocation function with executable
   permission.
2. identity mapping for argument for relocation function.
3. linear mappings for all source ranges
4. linear mappings for all destination ranges.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    |  14 ++++
 arch/arm64/kernel/asm-offsets.c   |   5 ++
 arch/arm64/kernel/machine_kexec.c | 104 +++++++++++++++++++++++++++++-
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 414a0a41a60a..df911a4aa8ce 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -98,6 +98,10 @@ extern const unsigned long kexec_kern_reloc_offset;
 extern const unsigned long kexec_el2_vectors_offset;
 #endif
 
+#define KEXEC_SRC_START	PAGE_OFFSET
+#define KEXEC_DST_START	(PAGE_OFFSET + \
+			((UL(0xffffffffffffffff) - PAGE_OFFSET) >> 1) + 1)
+
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
  * head		kimage->head, allows to traverse through relocation segments.
@@ -108,6 +112,11 @@ extern const unsigned long kexec_el2_vectors_offset;
  * el2_vector	If present means that relocation routine will go to EL1
  *		from EL2 to do the copy, and then back to EL2 to do the jump
  *		to new world.
+ * trans_ttbr0	idmap for relocation function and its argument
+ * trans_ttbr1	linear map for source/destination addresses.
+ * src_addr	linear map for source pages.
+ * dst_addr	linear map for destination pages.
+ * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
 	phys_addr_t head;
@@ -117,6 +126,11 @@ struct kern_reloc_arg {
 	phys_addr_t kern_arg2;
 	phys_addr_t kern_arg3;
 	phys_addr_t el2_vector;
+	phys_addr_t trans_ttbr0;
+	phys_addr_t trans_ttbr1;
+	void *src_addr;
+	void *dst_addr;
+	unsigned long copy_len;
 };
 
 #define ARCH_HAS_KIMAGE_ARCH
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index ad7764d68904..4147d9d70c1c 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -136,6 +136,11 @@ int main(void)
   DEFINE(KEXEC_KRELOC_KERN_ARG2,	offsetof(struct kern_reloc_arg, kern_arg2));
   DEFINE(KEXEC_KRELOC_KERN_ARG3,	offsetof(struct kern_reloc_arg, kern_arg3));
   DEFINE(KEXEC_KRELOC_EL2_VECTOR,	offsetof(struct kern_reloc_arg, el2_vector));
+  DEFINE(KEXEC_KRELOC_TRANS_TTBR0,	offsetof(struct kern_reloc_arg, trans_ttbr0));
+  DEFINE(KEXEC_KRELOC_TRANS_TTBR1,	offsetof(struct kern_reloc_arg, trans_ttbr1));
+  DEFINE(KEXEC_KRELOC_SRC_ADDR,	offsetof(struct kern_reloc_arg, src_addr));
+  DEFINE(KEXEC_KRELOC_DST_ADDR,	offsetof(struct kern_reloc_arg, dst_addr));
+  DEFINE(KEXEC_KRELOC_COPY_LEN,	offsetof(struct kern_reloc_arg, copy_len));
 #endif
   return 0;
 }
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index ac6ade7c96ff..8edcc4be0b15 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -20,6 +20,7 @@
 #include <asm/mmu.h>
 #include <asm/mmu_context.h>
 #include <asm/page.h>
+#include <asm/trans_pgd.h>
 
 #include "cpu-reset.h"
 
@@ -70,10 +71,102 @@ static void *kexec_page_alloc(void *arg)
 	return page_address(page);
 }
 
+/*
+ * Map source segments starting from KEXEC_SRC_START, and map destination
+ * segments starting from KEXEC_DST_START, and return size of copy in
+ * *copy_len argument.
+ * Relocation function essentially needs to do:
+ * memcpy(KEXEC_DST_START, KEXEC_SRC_START, copy_len);
+ */
+static int map_segments(struct kimage *kimage, pgd_t *pgdp,
+			struct trans_pgd_info *info,
+			unsigned long *copy_len)
+{
+	unsigned long *ptr = 0;
+	unsigned long dest = 0;
+	unsigned long src_va = KEXEC_SRC_START;
+	unsigned long dst_va = KEXEC_DST_START;
+	unsigned long len = 0;
+	unsigned long entry, addr;
+	int rc;
+
+	for (entry = kimage->head; !(entry & IND_DONE); entry = *ptr++) {
+		addr = entry & PAGE_MASK;
+
+		switch (entry & IND_FLAGS) {
+		case IND_DESTINATION:
+			dest = addr;
+			break;
+		case IND_INDIRECTION:
+			ptr = __va(addr);
+			if (rc)
+				return rc;
+			break;
+		case IND_SOURCE:
+			rc = trans_pgd_map_page(info, pgdp, __va(addr),
+						src_va, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			rc = trans_pgd_map_page(info, pgdp, __va(dest),
+						dst_va, PAGE_KERNEL);
+			if (rc)
+				return rc;
+			dest += PAGE_SIZE;
+			src_va += PAGE_SIZE;
+			dst_va += PAGE_SIZE;
+			len += PAGE_SIZE;
+		}
+	}
+	*copy_len = len;
+
+	return 0;
+}
+
+static int mmu_relocate_setup(struct kimage *kimage, void *reloc_code,
+			      struct kern_reloc_arg *kern_reloc_arg)
+{
+	struct trans_pgd_info info = {
+		.trans_alloc_page	= kexec_page_alloc,
+		.trans_alloc_arg	= kimage,
+	};
+
+	pgd_t *trans_ttbr0 = kexec_page_alloc(kimage);
+	pgd_t *trans_ttbr1 = kexec_page_alloc(kimage);
+	int rc;
+
+	if (!trans_ttbr0 || !trans_ttbr1)
+		return -ENOMEM;
+
+	rc = map_segments(kimage, trans_ttbr1, &info,
+			  &kern_reloc_arg->copy_len);
+	if (rc)
+		return rc;
+
+	/* Map relocation function va == pa */
+	rc = trans_pgd_map_page(&info, trans_ttbr0,  reloc_code,
+				__pa(reloc_code), PAGE_KERNEL_EXEC);
+	if (rc)
+		return rc;
+
+	/* Map relocation function argument va == pa */
+	rc = trans_pgd_map_page(&info, trans_ttbr0, kern_reloc_arg,
+				__pa(kern_reloc_arg), PAGE_KERNEL);
+	if (rc)
+		return rc;
+
+	kern_reloc_arg->trans_ttbr0 = phys_to_ttbr(__pa(trans_ttbr0));
+	kern_reloc_arg->trans_ttbr1 = phys_to_ttbr(__pa(trans_ttbr1));
+	kern_reloc_arg->src_addr = (void *)KEXEC_SRC_START;
+	kern_reloc_arg->dst_addr = (void *)KEXEC_DST_START;
+
+	return 0;
+}
+
 int machine_kexec_post_load(struct kimage *kimage)
 {
 	void *reloc_code = page_to_virt(kimage->control_code_page);
 	struct kern_reloc_arg *kern_reloc_arg = kexec_page_alloc(kimage);
+	int rc = 0;
 
 	if (!kern_reloc_arg)
 		return -ENOMEM;
@@ -89,9 +182,18 @@ int machine_kexec_post_load(struct kimage *kimage)
 		kern_reloc_arg->el2_vector = __pa(reloc_code)
 						+ kexec_el2_vectors_offset;
 	}
+
+	/*
+	 * If relocation is not needed, we do not need to enable MMU in
+	 * relocation routine, therefore do not create page tables for
+	 * scenarios such as crash kernel
+	 */
+	if (!(kimage->head & IND_DONE))
+		rc = mmu_relocate_setup(kimage, reloc_code, kern_reloc_arg);
+
 	kexec_image_info(kimage);
 
-	return 0;
+	return rc;
 }
 
 
-- 
2.23.0

