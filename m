Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F378C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF2B2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 04:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHXBa8LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbfCMETu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 00:19:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45263 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfCMETu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 00:19:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id v21so424950pfm.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 21:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=sqag+3/hCSAk4WAl1oE69ZNRhwtloHC+nzkdZ2w98Es=;
        b=BHXBa8LIzscAukrgQntabTAbIQd8zJxbdIEfC4sXBrJdVwbSJWqcV9cL5IQNNK0jVo
         fDslTimcZlJs67sN/n6ni8qCiT/zj9slg0o7prdVVQQ3xrmXu57NzRmTPQ6lEKSxtCF+
         9uWSLVV5BU2SRmG3iJJuSMmoVpnYcgf+T/qIPRFY2+mfSJ4DXD0svGdz12qgSXc2yWXa
         Y6GLX1zVoBakGkasH3qslbpkpj5sJ0dygIG6YiU5JwZ8iEfyKzSZ5R8KZmOrLZ+OhDIO
         0Zf87PKXkqjY2TnIOyDToyrOvYY8TX7/v99p58L9hbCViThFKAhSNrlMBI6Ha3yL2nWI
         3MYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sqag+3/hCSAk4WAl1oE69ZNRhwtloHC+nzkdZ2w98Es=;
        b=grPnERxMfC++YupJhrAhZotTBrq1fu7lD0dnMN1P6VProOuZ5fc+wB5mZA2XvH49Wc
         i5VuxtrdUFLiRr20xbRY/vRqDXQxQpVT8fEeqZ6WIoverYMNMr4riNh6MwiSVbcEcgKJ
         4gaKfInBadVNKZcETb/a/Cdp+UyPhQX+q3NG5Ti7oPJzDxxW1Eh8xeiC+wJ6d4gXax2I
         orFO44Brg82ItfWUrLCI8s2ONqRbSmNbH3Ez4+iGl+7OmNaVXsD3XTm9rUu/z6PLfmxe
         0teNoxbeYzrOPsaG0l1IOIpIJpu8ctYKwFwIWP0l0hFBJbMoAzrcDWx9fbjp/8XZtSOs
         u3WA==
X-Gm-Message-State: APjAAAWIm+CQqDzrI8kWk8YmoFk03WPz4tXJp7LvwdykezFi/f81fqf1
        JHfzba/rIb7BAvwUQnLdiQ==
X-Google-Smtp-Source: APXvYqzpem14Ep3Mnv3mu76GA+zdpag2SlrYVmIRk4tY2ngUz8H9fTc/tTrVa6U2FP15xo6rRLV+lA==
X-Received: by 2002:a63:cd02:: with SMTP id i2mr38511849pgg.111.1552450789057;
        Tue, 12 Mar 2019 21:19:49 -0700 (PDT)
Received: from mylaptop.nay.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h2sm12962933pfo.163.2019.03.12.21.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 21:19:48 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Baoquan He <bhe@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2] x86/boot/KASLR: skip the specified crashkernel reserved region
Date:   Wed, 13 Mar 2019 12:19:31 +0800
Message-Id: <1552450771-8360-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

crashkernel=x@y option may fail to reserve the required memory region if
KASLR puts kernel into the region. To avoid this uncertainty, making KASLR
skip the required region.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Nicolas Pitre <nico@linaro.org>
Cc: Pingfan Liu <kernelfans@gmail.com>
Cc: Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org
---
v1 -> v2: fix some trival format

 arch/x86/boot/compressed/kaslr.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 9ed9709..e185318 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -109,6 +109,7 @@ enum mem_avoid_index {
 	MEM_AVOID_BOOTPARAMS,
 	MEM_AVOID_MEMMAP_BEGIN,
 	MEM_AVOID_MEMMAP_END = MEM_AVOID_MEMMAP_BEGIN + MAX_MEMMAP_REGIONS - 1,
+	MEM_AVOID_CRASHKERNEL,
 	MEM_AVOID_MAX,
 };
 
@@ -240,6 +241,25 @@ static void parse_gb_huge_pages(char *param, char *val)
 	}
 }
 
+/* parse crashkernel=x@y option */
+static void mem_avoid_crashkernel_simple(char *option)
+{
+	unsigned long long crash_size, crash_base;
+	char *cur = option;
+
+	crash_size = memparse(option, &cur);
+	if (option == cur)
+		return;
+
+	if (*cur == '@') {
+		option = cur + 1;
+		crash_base = memparse(option, &cur);
+		if (option == cur)
+			return;
+		mem_avoid[MEM_AVOID_CRASHKERNEL].start = crash_base;
+		mem_avoid[MEM_AVOID_CRASHKERNEL].size = crash_size;
+	}
+}
 
 static void handle_mem_options(void)
 {
@@ -250,7 +270,7 @@ static void handle_mem_options(void)
 	u64 mem_size;
 
 	if (!strstr(args, "memmap=") && !strstr(args, "mem=") &&
-		!strstr(args, "hugepages"))
+		!strstr(args, "hugepages") && !strstr(args, "crashkernel="))
 		return;
 
 	tmp_cmdline = malloc(len + 1);
@@ -286,6 +306,8 @@ static void handle_mem_options(void)
 				goto out;
 
 			mem_limit = mem_size;
+		} else if (strstr(param, "crashkernel")) {
+			mem_avoid_crashkernel_simple(val);
 		}
 	}
 
@@ -414,7 +436,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
 
 	/* We don't need to set a mapping for setup_data. */
 
-	/* Mark the memmap regions we need to avoid */
+	/* Mark the regions we need to avoid */
 	handle_mem_options();
 
 #ifdef CONFIG_X86_VERBOSE_BOOTUP
-- 
2.7.4

