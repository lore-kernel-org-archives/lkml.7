Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16568FA372D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E492921928
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="TwrU+GOQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436984AbfJPUBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:01:20 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39129 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436975AbfJPUBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:01:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id n7so37978901qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=T3XWTOgEP/9W4ZS1E8/VXGGfXzT8jd4exEGR+bMuwFQ=;
        b=TwrU+GOQ941Sbph2SFlImjGbplb/clyAhQMdLITdEqfku17H8sdjTfFUMvAZe4kojq
         4YBgVZ0VBiTp3siA8nE/jqe9SmThHOYeBqzBNcz8IFDf7vf796F/kPBtX4VfC12d9cGF
         Z87WVxZ17F7bODF0yNyx32TQf/Uq2xQTMJQjkPTJhaIYadOcoA+UnpOO4MqsumekXePm
         dnsb99L63dW8eqGMUTHNASV5cIoNW8HlxIKZwH2Oq2DtBbwk8VEm4Kb7drd+R4rQyPl9
         cAk4Ro2mCrP6oNxUCU7i27imKhoBEzF+naSPVz9JYZWlBy9dvkx82EpjYrBvxvcm4UJ8
         tBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3XWTOgEP/9W4ZS1E8/VXGGfXzT8jd4exEGR+bMuwFQ=;
        b=IVX7rhquos456dguGxY/UKt2RqRtD7QOvjzZ3F4matITHn59f/pzw/p+ETY7vrJgiZ
         d6CbiVFcuAvsOmYAIhnnawKet8opUCd2iQpbr2Xh571x72GOmnfwzYnyYBsbHLbPB76e
         67wl0f58YagXVan6NU2jrUjVDCege1Six/7Zopvcxu34UQeHazCzb9TeBXpFDBK1kb25
         LT/Fpxcum7VStBeJztr9mAeF4jlGuuoexbTr6kA2CHzmTgYIAHO3vaczKeu8ekxx1+18
         vfJ/5IlKh39m15iXfdaZnSX1jKa5Yaolu1Vb3svbFk6JIztp2pg4bhAdml+eFWL585GN
         oqbA==
X-Gm-Message-State: APjAAAXQLw4/uv1iggiYqPqton8z4YYxaLM3ENNlJKjSfkQo7GmXI5+M
        daC9PdYhI2bZJo+nkIHwe8dqtA==
X-Google-Smtp-Source: APXvYqxUeYI2VVeNKwOcx1CBf1Vuu9NAWArtbmb0ydUiJoKzSapQ6z4MonpaFLHL7qk8ur/XLUM3Ag==
X-Received: by 2002:ac8:f28:: with SMTP id e37mr47590802qtk.274.1571256076532;
        Wed, 16 Oct 2019 13:01:16 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c204sm13342030qkb.90.2019.10.16.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:01:15 -0700 (PDT)
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
Subject: [PATCH v7 25/25] arm64: kexec: remove head from relocation argument
Date:   Wed, 16 Oct 2019 16:00:34 -0400
Message-Id: <20191016200034.1342308-26-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
References: <20191016200034.1342308-1-pasha.tatashin@soleen.com>
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
index 4147d9d70c1c..4ec01f29718d 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -129,7 +129,6 @@ int main(void)
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
2.23.0

