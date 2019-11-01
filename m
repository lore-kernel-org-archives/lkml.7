Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2048DCA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C7E218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 22:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jD7UphcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfKAWMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 18:12:54 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:34557 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfKAWMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 18:12:38 -0400
Received: by mail-pl1-f201.google.com with SMTP id u9so1473108plq.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2019 15:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SBPjjox/K0nQBp9p/UReaX06mOCKZA5VG5oKrHSRp3U=;
        b=jD7UphcOofzvzp+Fej+FGAYX3qlgaInC3q6riheK3W8LCKmKWtfTlTrJ/vzD4a19an
         +Hcrv+tkq9TdRVKgDOaa6Ic5PZn6XxN9+vLYJmvkleDiug2F9Tcj89ldzM4/Wx0mDp22
         mgzUKliuIEQOx7CwzvE6V9myvgkQNgKcVgCutPLeSHS/wibMi+2JvOa+OCv75/Nwje2O
         8oWep5ZzzzdxjS5LcG8wINg1XSm4eYtuiQytGXDC4/Up/8zjkIUOQ+XAAMs0f9WdxGw6
         GvK3uzJndPpvEwWoClt/0ppEIta5+qJS7qlUvBidggYVVp60p9g8sBe1C+92bc/icYtq
         Aalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SBPjjox/K0nQBp9p/UReaX06mOCKZA5VG5oKrHSRp3U=;
        b=FVbrZL+C+EyiMBFjGHu1SvkHj1LhQxILQcyLjFVKHXRaVFk6lCVgX0uq+wJOdkeRbh
         ohQt4Ydtu8lnn3v8hbQQbOnESjN1w5kVcc4bU0nEe+n3/yYeHWRCWsXQcebL1sfoX5IP
         Ko/n7YcZhtydby9qMp0oMbhpbiqCddFKJu+WciTL+33xrC82IB/OneSHB9PKINIQV4m6
         D90rklIAFfNtbe00q+Nq241kUQht/qUakfk13ENaF94zD08iYG/0CKqmoSTXgRAozpVz
         d+kFsOaO8w9W/X8TVeasPZPhPjojLA0gcwnIGWrHDMFwDs5ycGm3FK35asz0SEOPnydh
         brKg==
X-Gm-Message-State: APjAAAWLi0K9vHeslq31vAR0tD5SqP86uS9oL7umld74EQkVU2BFhG6W
        E42RnGfcySal7Uxvgy0bY/lEFsIi3/GTsHgammk=
X-Google-Smtp-Source: APXvYqxqSMUGI9UyircMqSL5QLFPtKAtuhwEXcqXTbAsf4XrCTVNUwTxLrj6ufv4Kgs0IKAfQNkuo4iX4Ohmpxbq4g8=
X-Received: by 2002:a63:4525:: with SMTP id s37mr16212936pga.148.1572646357518;
 Fri, 01 Nov 2019 15:12:37 -0700 (PDT)
Date:   Fri,  1 Nov 2019 15:11:49 -0700
In-Reply-To: <20191101221150.116536-1-samitolvanen@google.com>
Message-Id: <20191101221150.116536-17-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191101221150.116536-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v4 16/17] arm64: disable SCS for hypervisor code
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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
2.24.0.rc1.363.gb1bccd3e3d-goog

