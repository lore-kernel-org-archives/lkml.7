Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD158C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1422087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JScJif31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbfD0Gnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:43:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45685 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfD0Gnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so2559510pls.12;
        Fri, 26 Apr 2019 23:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p6XVxxmeId6Fyrw7m3B0ifgQzW6nhwdk5H1SAhfRKS0=;
        b=JScJif310IMh72ZohwOauSCAwdoUkuEv8bR6xdhJcKtk1RynLwO3Yk/O8uL4tZE53n
         NrQxpNK4N1uzjciA1sdkWWtPp8ycpHXFn7qqLzJr7tYIRLsxhiosMqxmPVmHzIChx8+N
         dySb7k6fhrhmrpcilrlJoW9blvaY3Q+PCSiONh6FBKvoxbL7qSMy7/IzPS7lXjYYk3R/
         KYc3BtX2zUuYUpbQToVTJQ3xLcXFtZGa0gKnazTNuB9oRgES+e5Dt6lyOMWvmuEim8L6
         0oOzDDk8SIoEGUBtvVZ7G2upgHOvvdwFGoH6Y4DMveFflSyOioLkC8F7etEF6M59+eVc
         h1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p6XVxxmeId6Fyrw7m3B0ifgQzW6nhwdk5H1SAhfRKS0=;
        b=LyWYEmbBpNVVbvN9h2qTIWyJbVDxaHuKUcymYtgVieDWwAn4sRTR8C1KMHYF75e7ZL
         y4DA7keD9mModIuM3Bc5+r7jYMJqW5nPDmR44ReLh5QvRhCk7YNysu5AjQea8oPdRvnn
         E7OT7KacbPAhPpz2w47+dtYZSeo95unBtLpoxVh3I3+fK2AgBItnUG+aUBDAPkX9H/N8
         21wHuPAeYxC7lVj9CFIRRmYkfKCCr77xjMBuO3+EGZiQxzZE/VWdzmx6zLyTZoNe+piD
         SPWRwxEn9f77YvGhzWtAH7d90pwPXGuP28jItHvDd48WqGo3SoRog5D8tkKBEgXYZuxl
         23yQ==
X-Gm-Message-State: APjAAAUIvQtvDYpD9Au0UShuWf5YI8brh8QNWzm9xHzyIFxlOhB96IuM
        C8LGFYGZIdxIMi43EX75C5E=
X-Google-Smtp-Source: APXvYqy73yIN4FITPLecL8eRrrVFTQfYnIM8wwU5XCBZXYl3CE93cW/V+JNeu8zKe2r7aDykFyaZUg==
X-Received: by 2002:a17:902:d83:: with SMTP id 3mr52113119plv.125.1556347416975;
        Fri, 26 Apr 2019 23:43:36 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:36 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v6 23/24] mm/tlb: Provide default nmi_uaccess_okay()
Date:   Fri, 26 Apr 2019 16:23:02 -0700
Message-Id: <20190426232303.28381-24-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

x86 has an nmi_uaccess_okay(), but other architectures do not.
Arch-independent code might need to know whether access to user
addresses is ok in an NMI context or in other code whose execution
context is unknown.  Specifically, this function is needed for
bpf_probe_write_user().

Add a default implementation of nmi_uaccess_okay() for architectures
that do not have such a function.

Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/include/asm/tlbflush.h | 2 ++
 include/asm-generic/tlb.h       | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 90926e8dd1f8..dee375831962 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -274,6 +274,8 @@ static inline bool nmi_uaccess_okay(void)
 	return true;
 }
 
+#define nmi_uaccess_okay nmi_uaccess_okay
+
 /* Initialize cr4 shadow for this CPU. */
 static inline void cr4_init_shadow(void)
 {
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b9edc7608d90..480e5b2a5748 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -21,6 +21,15 @@
 #include <asm/tlbflush.h>
 #include <asm/cacheflush.h>
 
+/*
+ * Blindly accessing user memory from NMI context can be dangerous
+ * if we're in the middle of switching the current user task or switching
+ * the loaded mm.
+ */
+#ifndef nmi_uaccess_okay
+# define nmi_uaccess_okay() true
+#endif
+
 #ifdef CONFIG_MMU
 
 /*
-- 
2.17.1

