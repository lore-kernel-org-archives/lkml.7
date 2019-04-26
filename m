Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E421C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9371208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTkRQ/Y6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfD0Gnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:43:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39792 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbfD0Gnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:39 -0400
Received: by mail-pl1-f196.google.com with SMTP id e92so2571784plb.6;
        Fri, 26 Apr 2019 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TdxUBqKvjD04gvlVW2fqTrr9rgpG7ttN99ifXgy4wJ0=;
        b=fTkRQ/Y6ekEQNK89awlPXt7h4NxMjoecNBAMoo9ta42p80ijXkGhM1UL/BQmQFyWo6
         LJfDPrdOvXO5UvSlwALV9jzgVbZ3dPkOetjmwgngrd6Xv4mjhDuVn4pVdt7q+ACp200R
         xHDNjHe63z2eq8GDtYLwE09uCfrsylk7ZaSgnWZyDkP/bBrVBZQ5DR2PNo0INMO0nJJB
         A8319czkJRDzqjy/YpDHiQ5QMkoO+Q0Ds/GWZq+ooXRPBqH7Yybl6d/xzosC6sOQZDv0
         Hev5YYonTqwLdIPLk/p3TqQ3UvgcH8BaYIQHch4ej87FxDr5lyTtZXPQ+va/opGvDk71
         04vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TdxUBqKvjD04gvlVW2fqTrr9rgpG7ttN99ifXgy4wJ0=;
        b=fwSLJNC2urf2zCXZTQSoC8Qnh8s30laBA5I8Gmpc2Y6UmmoU0XT2zLFi+E0Kr90X/q
         OWATgIQ1+n41lpdipnWpOiKIL1FahETtey4rAiMfC9+ffZEc8wj7qqcPD9T0K9x6Hb2i
         gwpRV5Xd6ftMWhHt0Hyyk5UCLOzD/2/jnNPW8t24EiyfqXt45x98eN9bmAY+1Qr5KHi+
         lFPZ78r06ulIBM8eSrILe8SiKms6ePEQ2GA62Ryq69OuNq3POHcB5GsBU+GehfNyOR3Y
         nMmhqxP0teevO0XDsIAGUer7BDBUUfDTQBwfhQWPACF1Gg0RtCZhBJOVZm7MwTltd34O
         2QLQ==
X-Gm-Message-State: APjAAAUnoJ/5NW9VE51N0M3ZPcd08vSBfp9y5MvLwVFw/VuYcK776E53
        8u0E/ZGS1ZaWbGOT+RYmrMNUEtvIEY4Fjg==
X-Google-Smtp-Source: APXvYqwkqefi+5wlFbKz/qeJ/65fu9i/qlczB3LZREQFaY/+lFjrw+S/8uXGcd/aBtDXpy5vBsJ5Xg==
X-Received: by 2002:a17:902:b715:: with SMTP id d21mr50699394pls.103.1556347418251;
        Fri, 26 Apr 2019 23:43:38 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:37 -0700 (PDT)
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
        Nadav Amit <namit@vmware.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH v6 24/24] bpf: Fail bpf_probe_write_user() while mm is switched
Date:   Fri, 26 Apr 2019 16:23:03 -0700
Message-Id: <20190426232303.28381-25-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

When using a temporary mm, bpf_probe_write_user() should not be able to
write to user memory, since user memory addresses may be used to map
kernel memory.  Detect these cases and fail bpf_probe_write_user() in
such cases.

Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Reported-by: Jann Horn <jannh@google.com>
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 kernel/trace/bpf_trace.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d64c00afceb5..94b0e37d90ef 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -14,6 +14,8 @@
 #include <linux/syscalls.h>
 #include <linux/error-injection.h>
 
+#include <asm/tlb.h>
+
 #include "trace_probe.h"
 #include "trace.h"
 
@@ -163,6 +165,10 @@ BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 	 * access_ok() should prevent writing to non-user memory, but in
 	 * some situations (nommu, temporary switch, etc) access_ok() does
 	 * not provide enough validation, hence the check on KERNEL_DS.
+	 *
+	 * nmi_uaccess_okay() ensures the probe is not run in an interim
+	 * state, when the task or mm are switched. This is specifically
+	 * required to prevent the use of temporary mm.
 	 */
 
 	if (unlikely(in_interrupt() ||
@@ -170,6 +176,8 @@ BPF_CALL_3(bpf_probe_write_user, void *, unsafe_ptr, const void *, src,
 		return -EPERM;
 	if (unlikely(uaccess_kernel()))
 		return -EPERM;
+	if (unlikely(!nmi_uaccess_okay()))
+		return -EPERM;
 	if (!access_ok(unsafe_ptr, size))
 		return -EPERM;
 
-- 
2.17.1

