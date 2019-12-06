Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A65C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDD0524679
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 22:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrhxzfWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfLFWOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 17:14:31 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:48106 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfLFWO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 17:14:29 -0500
Received: by mail-pf1-f201.google.com with SMTP id e62so4788594pfh.14
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 14:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8FJHqLK+9qp1SI0ZtY8nP7Vb0Kv4oQj2LgBWqplCpRM=;
        b=FrhxzfWXmzsxE4agp2rhmb4i9ATROH/GqZDqVq2Imv+d8/yhy1TAupBbdgdQuSdfT5
         6nQ5+3t9PECXIMWiDkrxMAiTDpvy1ngzEasXmXrAdNopBfmN/Bna9sPRCkNQn5V572bx
         eywVNSAedzToawJGzxolT5bl0ETab6Tw7CSJ2i0Uja/LPJMZj7f7aPe8T4bfjdxlPjQS
         3rIjn9HdeJXWzsniPYQzRfVJY1BL/sjidsk9JqsZiiFE1dkWT9OuAz7rz3hw05LyvVwP
         aif6TsG/Uxd0YqyKA9qyIH/plzSKaLaWabPJbVwtZIh3ODY4G/YpLNqbHQXB/I8WrOae
         /1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8FJHqLK+9qp1SI0ZtY8nP7Vb0Kv4oQj2LgBWqplCpRM=;
        b=P/MZ48OrMU6DYNWEFjUHsHSjlQVkV44uUyLTrsBHaqRvvoOHiqCcwzSMfLSxTPJA/b
         KuadfhUPXjRfMWPT8M47Cq4O+J87Bx4lhlMt3ApkhBuam6JS7OCVlI31RmmF35l8hEvx
         YCed1R8c/H4RSnNT4TppqrplqF6g3nM5MToHD6Ik8dhhA1whYhgO1zik+g7b2Q56fbxo
         Mi/ZJSeUmfvmDrK8Xe6LCSKxsm7V8zQ/t/F1bdVHhF5yJbzxfiV8wJD61w7P0LR+ZiZY
         8lSomxtm3BUCbm54qyJKlSmkeJkdZotPKtW+edpZ1Q4+U8UHwdMEY9kb6bo6197jn6y1
         UcDg==
X-Gm-Message-State: APjAAAXUiyQ7adXyRYV9xkBP4+CJzcWa8PTyptbehVDywDZXcPTpRcjT
        Iq9NeNtoy6Fy8yV7S2TvfemUgltL1vD+WzeOvjY=
X-Google-Smtp-Source: APXvYqzqfWQ39jRufjAhL7TZCDF47F43HjTHP8BNawKKpBRXjo9R8WHVKYYkig1q6KIkZysnArdkgny3hm72jaBZ4w0=
X-Received: by 2002:a65:6245:: with SMTP id q5mr6050849pgv.347.1575670468844;
 Fri, 06 Dec 2019 14:14:28 -0800 (PST)
Date:   Fri,  6 Dec 2019 14:13:49 -0800
In-Reply-To: <20191206221351.38241-1-samitolvanen@google.com>
Message-Id: <20191206221351.38241-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191206221351.38241-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 13/15] arm64: disable SCS for hypervisor code
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Filter out CC_FLAGS_SCS for code that runs at a different exception
level.

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kvm/hyp/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index ea710f674cb6..17ea3da325e9 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -28,3 +28,6 @@ GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
+
+# remove the SCS flags from all objects in this directory
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
-- 
2.24.0.393.g34dc348eaf-goog

