Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C4C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CF4B21783
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dAo0QIHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729342AbfJBTRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:17:11 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44142 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbfJBTRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:17:11 -0400
Received: by mail-ed1-f67.google.com with SMTP id r16so154892edq.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2019 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oGOfktdveo5ZtuoH4C6yPHNIwcTv3+DyM2wCB4zh4U=;
        b=dAo0QIHTfhTRnlYtaeL9gFzX3qDzreXEhE4rf+FJms1XQb84amNAa8vp3so/P0rIps
         KN84SQ3T51eDvLkMPS8292geBjpXywMAmzx7uOca+jx9ndkr9cbGzz/16GXRurF3Dp6o
         dsodWB+N7/WQ/Jyv3/I1NxxsGTV5AUsJZqCBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4oGOfktdveo5ZtuoH4C6yPHNIwcTv3+DyM2wCB4zh4U=;
        b=IbRK1vZ5gcuYA+x7AAZcdMu0zzr0FCLnnwn4t3jdAVl/pkYWETGqBZuj0Vde7CyXaG
         JGj9gf1dbmt3VAJFQc/yXS+6dDdc4NZmrEsgOfNFvuErzr2s/DFUUBUVQMljuJpAolc0
         WFqEDOOuMLkVaJxnq8efzvQZsMql+h2xp0/YJzsGyHONOt6g+dXQnhKQBvg4wNtV7ITn
         POXNoVe3uTTq2Y6E6LFHWAp5kWZyIkG1Bd6+n1pi3DgSt6guowuGIKGeQI/sS72gWY6S
         /w/G4n8MARiLqJ6+sqh0EZQSgZFeOqCQO4FSewUuwpkVJIlxZtmTBfE+nt5kGUEsuoOd
         JrvA==
X-Gm-Message-State: APjAAAVGhIsbPGQAdCtDsz9QsBzIQe0sHxQdnrQytJmmpkPoXtmFpZcP
        aTD4UFTIqBPdKpPaQnYS1H9nmAq75go=
X-Google-Smtp-Source: APXvYqxc21q3xZdpLrf1tkXfKo6ihP3vYlwZE7tC9X2U0uFDnrfeLpnWv9df3JAOYj1FrucG4bfITw==
X-Received: by 2002:a17:906:1394:: with SMTP id f20mr4650214ejc.274.1570043829050;
        Wed, 02 Oct 2019 12:17:09 -0700 (PDT)
Received: from kpsingh-kernel.localdomain (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id p19sm7996edq.31.2019.10.02.12.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 12:17:08 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v2] samples/bpf: Add a workaround for asm_inline
Date:   Wed,  2 Oct 2019 21:16:52 +0200
Message-Id: <20191002191652.11432-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

This was added in:

  commit eb111869301e ("compiler-types.h: add asm_inline definition")

and breaks samples/bpf as clang does not support asm __inline.

Co-developed-by: Florent Revest <revest@google.com>
Signed-off-by: Florent Revest <revest@google.com>
Signed-off-by: KP Singh <kpsingh@google.com>
---

Changes since v1:

- Dropped the rename from asm_workaround.h to asm_goto_workaround.h
- Dropped the fix for task_fd_query_user.c as it is updated in
  https://lore.kernel.org/bpf/20191001112249.27341-1-bjorn.topel@gmail.com/

 samples/bpf/asm_goto_workaround.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/asm_goto_workaround.h b/samples/bpf/asm_goto_workaround.h
index 7409722727ca..7048bb3594d6 100644
--- a/samples/bpf/asm_goto_workaround.h
+++ b/samples/bpf/asm_goto_workaround.h
@@ -3,7 +3,8 @@
 #ifndef __ASM_GOTO_WORKAROUND_H
 #define __ASM_GOTO_WORKAROUND_H
 
-/* this will bring in asm_volatile_goto macro definition
+/*
+ * This will bring in asm_volatile_goto and asm_inline macro definitions
  * if enabled by compiler and config options.
  */
 #include <linux/types.h>
@@ -13,5 +14,15 @@
 #define asm_volatile_goto(x...) asm volatile("invalid use of asm_volatile_goto")
 #endif
 
+/*
+ * asm_inline is defined as asm __inline in "include/linux/compiler_types.h"
+ * if supported by the kernel's CC (i.e CONFIG_CC_HAS_ASM_INLINE) which is not
+ * supported by CLANG.
+ */
+#ifdef asm_inline
+#undef asm_inline
+#define asm_inline asm
+#endif
+
 #define volatile(x...) volatile("")
 #endif
-- 
2.20.1

