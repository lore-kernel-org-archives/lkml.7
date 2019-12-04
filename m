Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E546C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D082073B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NjQ8W05Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728876AbfLDQA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:00:26 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40272 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfLDQAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:00:19 -0500
Received: by mail-qk1-f194.google.com with SMTP id a137so347949qkc.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BuF9kAsg7zDfcrmW+AeEjDBvvgUIdNN48m7WKwFLEPQ=;
        b=NjQ8W05YdjdCeIvOSOYx3wjfSJNJOobpA3c17yvVui1k3d8t2K7RqtU86mEcN8Szx7
         Ny+jGMla7VSh3rjQ80VXpIvNW3Ck2bDv0ttq4S+8c2YwXRL6fsyR6Lkev+ROCBv7TM0h
         rF/g8L2bpc0ZRlVROF4xerVe1SCO4xEtq1FMq6IuTkxZlllQbaw3a8r3s9MizMRjGset
         I9i1uTUUun6MGicBRvcUV7Bb2wcQ8EIxO6sAH0vd7w2iA1lGWF45M9v2ceNk/b/Uv2yn
         tCeFX1DOU3bn04ycwDxbG63Hcccv6KXWQKjR6ARN81S1SLg1YJztrRhIRODFqkj9bij6
         OkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuF9kAsg7zDfcrmW+AeEjDBvvgUIdNN48m7WKwFLEPQ=;
        b=FYS5G2wTz8wGLISo1zU6eBekUfjPTQl8GI9mMTQPrtSMUEqrPLhS1RrJoXqmOb31X2
         TTnvRUY0lIiqn96INnkRkNrnFiSfDpYc24oEIAzzCLE9lku0WVOs4FaMS/qZsmfSoz/c
         ivUpPaBb1SC8b0fcf/TnH5a21ZuKyvaYPSZqYuVASWWvSG55dpJ1R/BaaqTM8UBu4V6X
         X4aSExILJqLgpvbIYTHxj0KcQdkuFFOoVNIPgx/cUVTTp7zTc7JPvVKG4QBFTt/qO6wz
         8iGX75vsq85A9yeYRcUWKwWLMjgyjST+5smLhrzankSvbBSyvYQAxk5iWa5y6d/UwrNb
         T7dg==
X-Gm-Message-State: APjAAAUf9A2BMUmTJ9j/F32Sl8Ob08IPdHhL29IRq3GZqirivyLp3OII
        44F8n9mbIw2YMSVfaqxTs7psbw==
X-Google-Smtp-Source: APXvYqyyV8D1PYFAItU27qvsqV4aL2nD5BfdiIVUg4kS+PmYBpdlTmEAV0SE7aK9iMs6O+J5ih64+Q==
X-Received: by 2002:a37:a9cd:: with SMTP id s196mr3713467qke.264.1575475218073;
        Wed, 04 Dec 2019 08:00:18 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id w21sm4177585qth.17.2019.12.04.08.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 08:00:17 -0800 (PST)
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
Subject: [PATCH v8 25/25] arm64: kexec: remove head from relocation argument
Date:   Wed,  4 Dec 2019 10:59:38 -0500
Message-Id: <20191204155938.2279686-26-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now, that relocation is done using virtual addresses, reloc_arg->head
is not needed anymore.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/include/asm/kexec.h    | 2 --
 arch/arm64/kernel/asm-offsets.c   | 1 -
 arch/arm64/kernel/machine_kexec.c | 1 -
 3 files changed, 4 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index df911a4aa8ce..b3a39736d0db 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -104,7 +104,6 @@ extern const unsigned long kexec_el2_vectors_offset;
 
 /*
  * kern_reloc_arg is passed to kernel relocation function as an argument.
- * head		kimage->head, allows to traverse through relocation segments.
  * entry_addr	kimage->start, where to jump from relocation function (new
  *		kernel, or purgatory entry address).
  * kern_arg0	first argument to kernel is its dtb address. The other
@@ -119,7 +118,6 @@ extern const unsigned long kexec_el2_vectors_offset;
  * copy_len	Number of bytes that need to be copied
  */
 struct kern_reloc_arg {
-	phys_addr_t head;
 	phys_addr_t entry_addr;
 	phys_addr_t kern_arg0;
 	phys_addr_t kern_arg1;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 63060ea51727..097b4df616a2 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -130,7 +130,6 @@ int main(void)
   DEFINE(SDEI_EVENT_PRIORITY,	offsetof(struct sdei_registered_event, priority));
 #endif
 #ifdef CONFIG_KEXEC_CORE
-  DEFINE(KEXEC_KRELOC_HEAD,		offsetof(struct kern_reloc_arg, head));
   DEFINE(KEXEC_KRELOC_ENTRY_ADDR,	offsetof(struct kern_reloc_arg, entry_addr));
   DEFINE(KEXEC_KRELOC_KERN_ARG0,	offsetof(struct kern_reloc_arg, kern_arg0));
   DEFINE(KEXEC_KRELOC_KERN_ARG1,	offsetof(struct kern_reloc_arg, kern_arg1));
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8edcc4be0b15..2e11194b8023 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -174,7 +174,6 @@ int machine_kexec_post_load(struct kimage *kimage)
 	memcpy(reloc_code, kexec_relocate_code_start, kexec_relocate_code_size);
 	kimage->arch.kern_reloc = __pa(reloc_code) + kexec_kern_reloc_offset;
 	kimage->arch.kern_reloc_arg = __pa(kern_reloc_arg);
-	kern_reloc_arg->head = kimage->head;
 	kern_reloc_arg->entry_addr = kimage->start;
 	kern_reloc_arg->kern_arg0 = kimage->arch.dtb_mem;
 	/* Setup vector table only when EL2 is available, but no VHE */
-- 
2.24.0

