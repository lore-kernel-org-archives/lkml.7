Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C070C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5103206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 19:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gqg94NNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388295AbfG3TN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 15:13:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33339 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388279AbfG3TNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:13:25 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so30339264pfq.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2019 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4p7Yl4EvALrNapOIPblFQ4RqIFxBJYtmcwuhdJ36a4M=;
        b=gqg94NNJOdf9cHSR+XH6US+L0jKiqTwG0Xmx1oLuP1Hhp+nDgjGFTPn60im+Ecit12
         y/IVI2h60aZld1+y9XWSydA3vMe0xeJM9dR6rAMy+Kp7VanoIic5nQjtZLeRn6MaGJms
         8PRL5H4oh61RS+rUbxcD5n83K03BRRSwK4xJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4p7Yl4EvALrNapOIPblFQ4RqIFxBJYtmcwuhdJ36a4M=;
        b=DMhK60qiqeRUTBJqcl3YvkGBWnSjq+eE165I1lUXo7C/I5vZ4czt7dBJcVZMFrjLKs
         eIViijrotDqVrfUZU88r3qdDQdlGATtK7u/kAgLesZU+PsgzUd6tyNRzIv5s7vtM+X2g
         zYnhaBKeow9GsV0Ab0kw3oL4goQK3vk75C0scXBzFEdNpwXjeKJIVz1+E/OzRzJU0HEE
         t+cCoBKfbupZYQbmfR62fisFR5gyDJmJnXIPvKgvXqaMnDP0tY3mvSbMobkh9Cw7l0Zo
         lQfAeSIWlmDpTWlRezPoSWyGTtKFZ/JjjhU39j1Yb1smKzkfVFfiTBpaBGtZrgz+2RBH
         g7Kg==
X-Gm-Message-State: APjAAAUAn2mxUOeeprUFnOyz+ldtGjU4LyVObboCs51qsSFMymGGvtpd
        4tCyW1xu/rr/MCVpHMmWeQyVxw==
X-Google-Smtp-Source: APXvYqwoE5YtV9czMWqYh5jaOXzzNfppyGGX1LntKX22Zkz6VcJhYSb1VjmmI91pfMMS60cxTSLgPQ==
X-Received: by 2002:aa7:9407:: with SMTP id x7mr44914613pfo.163.1564514004448;
        Tue, 30 Jul 2019 12:13:24 -0700 (PDT)
Received: from skynet.sea.corp.google.com ([2620:0:1008:1100:c4b5:ec23:d87b:d6d3])
        by smtp.gmail.com with ESMTPSA id n89sm84649540pjc.0.2019.07.30.12.13.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 12:13:23 -0700 (PDT)
From:   Thomas Garnier <thgarnie@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     kristen@linux.intel.com, keescook@chromium.org,
        Thomas Garnier <thgarnie@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/11] x86/paravirt: Adapt assembly for PIE support
Date:   Tue, 30 Jul 2019 12:12:54 -0700
Message-Id: <20190730191303.206365-11-thgarnie@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190730191303.206365-1-thgarnie@chromium.org>
References: <20190730191303.206365-1-thgarnie@chromium.org>
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
index 70b654f3ffe5..fd7dc37d0010 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -338,9 +338,25 @@ extern struct paravirt_patch_template pv_ops;
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
+ */
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
 
@@ -379,9 +395,10 @@ int paravirt_disable_iospace(void);
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
2.22.0.770.g0f2c4a37fd-goog

