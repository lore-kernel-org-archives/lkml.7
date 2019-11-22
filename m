Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0007C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A893C2071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 18:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpZcy7Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfKVSz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:55:27 -0500
Received: from mail-ua1-f74.google.com ([209.85.222.74]:53771 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbfKVSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 13:55:27 -0500
Received: by mail-ua1-f74.google.com with SMTP id 14so251239uar.20
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2019 10:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SHVXHEGGxuqIpcBFwRHv/uk1e/S46AumK4IMAmbp/ok=;
        b=cpZcy7CysRjVvEDBLriAw2P8/TU3cURqwBXnEv93B2t8l2xennSUdwg+CVfdB/gtFG
         fz8XtCFW0omCKPALWsT8iEKNvDcc2WzAa1h4wn8dmhXwwLbzyh7qRBwxDvwZ1MG4MXar
         TBLfcYUcznuWLGge0/XpeHXBj5Xmuy5Vdzy674qVErgGxUoHo+NNnvgQoTK4FikfXZjq
         B83jZXaoG++9UGZQl4PRYdgJfAV61M9O77iZe7MRy0pREg0kFwJE0FoMNy8AejyOOAWG
         Lpd6WqHkYN/K4PEOq2ZpUJ7Sn7oFXgWVqndd0MLXYT1vs7Sh159nYv9wwxbCIi8fjmTL
         ZrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SHVXHEGGxuqIpcBFwRHv/uk1e/S46AumK4IMAmbp/ok=;
        b=NrRkLqsSMqZhmuEpCIj4snoWpGrO7L8k8KqDItFpmmHwpsJEjB/eOfNZ95z8qZINKG
         T0oJE1zWbYbQ+Nl6DO8B4Jm/On6RDGGk5qK9P/05rd1uH3heOCRc2akW/lqUhffCnGz8
         gc8zAmBouWmJbO9fhQ/FDo7zuS0BCUgw9c5t36wvfQGFaHD4A0yXGjrjqAVZszjcLxpt
         w1h9NBUy15bsiHvD1XEwu+BqaIf4W6b6nJLniTI62U2wcj51cYhCyODpQcr/0Jfzb0ne
         QyLgCwbUJtOS0hWTTxeWdytHqh32qKIdxSOZ79nOBl49yH8uLdq8SXjsnX1EhsOWPAhd
         W3/A==
X-Gm-Message-State: APjAAAUd/KavxqZDm7sHatVR13XBjsRL8UF7DaxnTL7Q1HJyLIzuFaKE
        MJaHFEYig6Y7HBYSJT2HB5sgJ1hOdS/Hu4wAraM=
X-Google-Smtp-Source: APXvYqx4/R+aTfQ5J2UOyQ8A6PVE1oEdqepMp2ZpOkKUSoKn8ky/RxzbEAbFNxLLKrHVeZxdmSe4geTa/pyPcfKpv8E=
X-Received: by 2002:a1f:e0c2:: with SMTP id x185mr10557825vkg.6.1574448926211;
 Fri, 22 Nov 2019 10:55:26 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:55:21 -0800
Message-Id: <20191122185522.20582-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH] arm: explicitly place .fixup in .text
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     linux@armlinux.org.uk
Cc:     nico@fluxnic.net, clang-built-linux@googlegroups.com,
        manojgupta@google.com, natechancellor@gmail.com,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kees Cook <keescook@chromium.org>

There's an implicit dependency on the section ordering of the orphaned
section .fixup that can break arm_copy_from_user if the linker places
the .fixup section before the .text section. Since .fixup is not
explicitly placed in the existing ARM linker scripts, the linker is free
to order it anywhere with respect to the rest of the sections.

Multiple users from different distros (Raspbian, CrOS) reported kernel
panics executing seccomp() syscall with Linux kernels linked with LLD.

Documentation/x86/exception-tables.rst alludes to the ordering
dependency. The relevant quote:

```
NOTE:
Due to the way that the exception table is built and needs to be ordered,
only use exceptions for code in the .text section.  Any other section
will cause the exception table to not be sorted correctly, and the
exceptions will fail.

Things changed when 64-bit support was added to x86 Linux. Rather than
double the size of the exception table by expanding the two entries
from 32-bits to 64 bits, a clever trick was used to store addresses
as relative offsets from the table itself. The assembly code changed
from::

    .long 1b,3b
  to:
          .long (from) - .
          .long (to) - .

and the C-code that uses these values converts back to absolute addresses
like this::

        ex_insn_addr(const struct exception_table_entry *x)
        {
                return (unsigned long)&x->insn + x->insn;
        }
```

Since the addresses stored in the __ex_table are RELATIVE offsets and
not ABSOLUTE addresses, ordering the fixup anywhere that's not
immediately preceding .text causes the relative offset of the faulting
instruction to be wrong, causing the wrong (or no) address of the fixup
handler to looked up in __ex_table.

x86 and arm64 place the .fixup section near the end of the .text
section; follow their pattern.

Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linux/issues/282
Link: https://bugs.chromium.org/p/chromium/issues/detail?id=1020633#c36
Reported-by: Manoj Gupta <manojgupta@google.com>
Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Debugged-by: Nick Desaulniers <ndesaulniers@google.com>
Worded-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Manoj Gupta <manojgupta@google.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
---
 arch/arm/kernel/vmlinux.lds.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/vmlinux.lds.h b/arch/arm/kernel/vmlinux.lds.h
index 8247bc15addc..e130f7668cf0 100644
--- a/arch/arm/kernel/vmlinux.lds.h
+++ b/arch/arm/kernel/vmlinux.lds.h
@@ -74,6 +74,7 @@
 		LOCK_TEXT						\
 		HYPERVISOR_TEXT						\
 		KPROBES_TEXT						\
+		*(.fixup)						\
 		*(.gnu.warning)						\
 		*(.glue_7)						\
 		*(.glue_7t)						\
-- 
2.24.0.432.g9d3f5f5b63-goog

