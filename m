Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1553CC606C6
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D4C218A0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XsOl+a4R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391208AbfGHRtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:49:45 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37162 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390873AbfGHRtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:49:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id g15so8061815pgi.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zk4/OPGo86ftMBdGr+5okqxNxr1xkvSdReLqcT2u18A=;
        b=XsOl+a4RAnXCWhNEVRPeVMhX4ouKgXngCNqnfUxMciMui+pL4rHn4H1iwCHUjJmJIC
         2ElaPOflyt6/Xi//KGH/Fy7duud9Gy23ek+J89nJPK8tVN1aiJv5zeg2ri/hk0NA12K1
         l48hzBjCqkjo8vewPUND3AMeDcQR6+1oul5jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zk4/OPGo86ftMBdGr+5okqxNxr1xkvSdReLqcT2u18A=;
        b=H7h7V/nWzTRzK7Raq77kSb2tTyVNmiSt1uhfnz3SMClXP2YGlum/1ihV1ElSw36jDm
         KVLSZDuO4G1a8AATaCE/VJfQwthsXdPxNeq02LbE5LBtGufj+lGxiqeQfW7B64SYfPAX
         tPfddo3CebZbHI1veuVFVwC7XeYyYoiHLCv6rmwzDAgtMJYQcIrgXAHqcIKkLWGfTz5E
         tznGlcrrY37EcTYQhxzWbXit1bgT0gRnlGdNetLKyfyQRT3p2tSAFxKUFG+JfzTv8y5c
         FvRDcqyV4zXNuAGv0YI7Ex0BECQNm9o8Dd7+VJNePlf9hZPcMUbPWn9ajpvbseNM/AZ+
         oBZQ==
X-Gm-Message-State: APjAAAXvYu505/glfoOWBj72QfKfQ3NB2cgHycD9r3j4zFnSpgrLjNXT
        e8dzTcF+MBJMWoEnsNinbzMbuQ==
X-Google-Smtp-Source: APXvYqwGon64A3Eg43O0xpcjziuFJrMuP/ARJjBIDsIb1lPDikUr28nYvEkK1nyoH64klte1o9Y66Q==
X-Received: by 2002:a63:7e1d:: with SMTP id z29mr25328202pgc.346.1562608180745;
        Mon, 08 Jul 2019 10:49:40 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id j1sm20151686pfe.101.2019.07.08.10.49.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 08 Jul 2019 10:49:40 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Alok Kataria <akataria@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 10/11] x86/paravirt: Adapt assembly for PIE support
Date:   Mon,  8 Jul 2019 10:49:03 -0700
Message-Id: <20190708174913.123308-11-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190708174913.123308-1-thgarnie@chromium.org>
References: <20190708174913.123308-1-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if PIE is enabled, switch the paravirt assembly constraints to be
compatible. The %c/i constrains generate smaller code so is kept by
default.

Position Independent Executable (PIE) support will allow to extend the
KASLR randomization range below 0xffffffff80000000.

Signed-off-by: Thomas Garnier <thgarnie@chromium.org>
Acked-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/paravirt_types.h | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 946f8f1f1efc..5ec59abc5cb5 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -343,9 +343,25 @@ extern struct paravirt_patch_template pv_ops;
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
 
+#ifdef CONFIG_X86_PIE
+#define paravirt_opptr_call "a"
+#define paravirt_opptr_type "p"
+
+/*
+ * Alternative patching requires a maximum of 7 bytes but the relative call is
+ * only 6 bytes. If PIE is enabled, add an additional nop to the call
+ * instruction to ensure patching is possible.
+ * */
+#define PARAVIRT_CALL_POST  "nop;"
+#else
+#define paravirt_opptr_call "c"
+#define paravirt_opptr_type "i"
+#define PARAVIRT_CALL_POST  ""
+#endif
+
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
-	[paravirt_opptr] "i" (&(pv_ops.op))
+	[paravirt_opptr] paravirt_opptr_type (&(pv_ops.op))
 #define paravirt_clobber(clobber)		\
 	[paravirt_clobber] "i" (clobber)
 
@@ -384,9 +400,10 @@ int paravirt_disable_iospace(void);
  * offset into the paravirt_patch_template structure, and can therefore be
  * freely converted back into a structure offset.
  */
-#define PARAVIRT_CALL					\
-	ANNOTATE_RETPOLINE_SAFE				\
-	"call *%c[paravirt_opptr];"
+#define PARAVIRT_CALL						\
+	ANNOTATE_RETPOLINE_SAFE					\
+	"call *%" paravirt_opptr_call "[paravirt_opptr];"	\
+	PARAVIRT_CALL_POST
 
 /*
  * These macros are intended to wrap calls through one of the paravirt
-- 
2.22.0.410.gd8fdbe21b5-goog

