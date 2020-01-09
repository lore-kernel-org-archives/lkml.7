Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A0CC282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F86206ED
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 16:04:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hT7sBRTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbgAIQEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 11:04:01 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732819AbgAIQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 11:03:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578585836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qr2r3mp7rftEmxfhLDidcKbFbCYdpKuq3T+a5+/CCqE=;
        b=hT7sBRTdSlAIybvu5DsW8+1W/zlH10hP4+sdVjFIkdhc8PNSzb4w5UqXKBnTsQiEzRXtZb
        5PqIow9dum9yqQZEqDNNB6HofxNP9MPQgU9+ypAWHXbQmxv0hLmGsc1FaNjtYRiFIOpw6w
        GFjlh1DCcXeP/bMt75lhG/v/V6l7v4M=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-h7Tf37yLM9COPN98nm6NLQ-1; Thu, 09 Jan 2020 11:03:55 -0500
X-MC-Unique: h7Tf37yLM9COPN98nm6NLQ-1
Received: by mail-wr1-f72.google.com with SMTP id v17so3034722wrm.17
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 08:03:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qr2r3mp7rftEmxfhLDidcKbFbCYdpKuq3T+a5+/CCqE=;
        b=DJ0TABzGG7HjhgBNzbkkxcP4uCCLOgrg/8uj4aIjowlROrsfK35MriKMttjMGD0bWU
         vZoYvWXIyAS4u4OHRR37MRiDJXrnA3FMPVQJP0A0NxndDFD87rJHtEf2rIyno4y//1jt
         HxSeQ3LWuTgak2C177o09z7yMmXRq6tVAavzq8fUXMflyHvgYPZ0Jh//2K3qrU7IQeyp
         wcLiH4Rxy4EekY5SMoFHm+E5jz2nIiD6Pz2TpruRZZqIuMPDDvXoZ6lopjZ9TKf9w28k
         YzjvTeZqn8sgMX9du65HHD43rMt+EJn5yocJciDZ8X95rhVPWl6+nc1vDBEan/2FihNj
         f/CQ==
X-Gm-Message-State: APjAAAWTfawKe/hJi9cwp/ulkM7NMG4NJsiUffjg7W1B2iQcXyT0hB0h
        /FOYLKhH497pSi11nmLcar5uSHLR5cCIg9KqQXxov2clYqyo2wF2RkAwBSRmrCoRoRJYZ6eE1EK
        XMqWLwqvWJ6YXqL6OJuE4YNYN
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr5598167wmj.165.1578585834090;
        Thu, 09 Jan 2020 08:03:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxxPpfZ8umi6fB7ZYKrURHzWQS31pfkUOU6pTbSf04Fo9JFmyXHY0aoMxvY+j4DAs5z8sDE5A==
X-Received: by 2002:a7b:cb0a:: with SMTP id u10mr5598133wmj.165.1578585833874;
        Thu, 09 Jan 2020 08:03:53 -0800 (PST)
Received: from redfedo.redhat.com (host81-140-166-164.range81-140.btcentralplus.com. [81.140.166.164])
        by smtp.gmail.com with ESMTPSA id m126sm3321546wmf.7.2020.01.09.08.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:03:53 -0800 (PST)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [RFC v5 09/57] objtool: Move registers and control flow to arch-dependent code
Date:   Thu,  9 Jan 2020 16:02:12 +0000
Message-Id: <20200109160300.26150-10-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200109160300.26150-1-jthierry@redhat.com>
References: <20200109160300.26150-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raphael Gault <raphael.gault@arm.com>

The control flow information and register macro definitions were based on
the x86_64 architecture but should be abstract so that each architecture
can define the correct values for the registers, especially the registers
related to the stack frame (Frame Pointer, Stack Pointer and possibly
Return Address).

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
[J.T. : Added objtool arch specific include to build flags,
        Use SPDX identifier for new header]
Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile                        |  3 ++-
 tools/objtool/arch/x86/include/arch_special.h | 23 +++++++++++++++++++
 tools/objtool/{ => arch/x86/include}/cfi.h    |  0
 tools/objtool/check.h                         |  1 +
 tools/objtool/special.c                       | 19 +--------------
 5 files changed, 27 insertions(+), 19 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch_special.h
 rename tools/objtool/{ => arch/x86/include}/cfi.h (100%)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 24d653e0b6ec..be735e4f27f5 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -37,7 +37,8 @@ all: $(OBJTOOL)
 
 INCLUDES := -I$(srctree)/tools/include \
 	    -I$(srctree)/tools/arch/$(HOSTARCH)/include/uapi \
-	    -I$(srctree)/tools/arch/$(ARCH)/include
+	    -I$(srctree)/tools/arch/$(ARCH)/include \
+	    -I$(srctree)/tools/objtool/arch/$(ARCH)/include
 WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed
 CFLAGS   := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)
 LDFLAGS  += $(LIBELF_LIBS) $(LIBSUBCMD) $(KBUILD_HOSTLDFLAGS)
diff --git a/tools/objtool/arch/x86/include/arch_special.h b/tools/objtool/arch/x86/include/arch_special.h
new file mode 100644
index 000000000000..426178d504a8
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch_special.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _X86_ARCH_SPECIAL_H
+#define _X86_ARCH_SPECIAL_H
+
+#define EX_ENTRY_SIZE		12
+#define EX_ORIG_OFFSET		0
+#define EX_NEW_OFFSET		4
+
+#define JUMP_ENTRY_SIZE		16
+#define JUMP_ORIG_OFFSET	0
+#define JUMP_NEW_OFFSET		4
+
+#define ALT_ENTRY_SIZE		13
+#define ALT_ORIG_OFFSET		0
+#define ALT_NEW_OFFSET		4
+#define ALT_FEATURE_OFFSET	8
+#define ALT_ORIG_LEN_OFFSET	10
+#define ALT_NEW_LEN_OFFSET	11
+
+#define X86_FEATURE_POPCNT (4 * 32 + 23)
+#define X86_FEATURE_SMAP   (9 * 32 + 20)
+
+#endif /* _X86_ARCH_SPECIAL_H */
diff --git a/tools/objtool/cfi.h b/tools/objtool/arch/x86/include/cfi.h
similarity index 100%
rename from tools/objtool/cfi.h
rename to tools/objtool/arch/x86/include/cfi.h
diff --git a/tools/objtool/check.h b/tools/objtool/check.h
index 6d875ca6fce0..af87b55db454 100644
--- a/tools/objtool/check.h
+++ b/tools/objtool/check.h
@@ -11,6 +11,7 @@
 #include "cfi.h"
 #include "arch.h"
 #include "orc.h"
+#include "arch_special.h"
 #include <linux/hashtable.h>
 
 struct insn_state {
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index fdbaa611146d..b8ccee1b5382 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -14,24 +14,7 @@
 #include "builtin.h"
 #include "special.h"
 #include "warn.h"
-
-#define EX_ENTRY_SIZE		12
-#define EX_ORIG_OFFSET		0
-#define EX_NEW_OFFSET		4
-
-#define JUMP_ENTRY_SIZE		16
-#define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		4
-
-#define ALT_ENTRY_SIZE		13
-#define ALT_ORIG_OFFSET		0
-#define ALT_NEW_OFFSET		4
-#define ALT_FEATURE_OFFSET	8
-#define ALT_ORIG_LEN_OFFSET	10
-#define ALT_NEW_LEN_OFFSET	11
-
-#define X86_FEATURE_POPCNT (4*32+23)
-#define X86_FEATURE_SMAP   (9*32+20)
+#include "arch_special.h"
 
 struct special_entry {
 	const char *sec;
-- 
2.21.0

