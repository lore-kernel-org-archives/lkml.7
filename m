Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815FCC5DF63
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C16921D7D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 23:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p/+qormW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbfKEX46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:56:58 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40505 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387632AbfKEX4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 18:56:53 -0500
Received: by mail-pf1-f202.google.com with SMTP id h67so8202651pfb.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SBPjjox/K0nQBp9p/UReaX06mOCKZA5VG5oKrHSRp3U=;
        b=p/+qormWzpAk/hn6fTIAq1GD6e0WQRag5NF7NjqAhGo5V+9tCeqWxMigwtXWt/lGNp
         q9buszXWKYVWoziPQLZS51iBSuLA1nUdgVLAfYt05cUtAWebiilSqti+DjDN8Q0UKshx
         57MAdb8441Kh4kMQAc47B2g6uSc/jktWoSENQoAO1SfBArC0JfH71OE1ZC9X88wFzf7D
         1zKwIMNiGpyq7Ox2PdBV9bj7qpbfLeuEOQjRxH+b5fzmSdlQBlgmJqQb6wUCW+t/kkJd
         W22heVjnv5z8zfiAr2e8BVc/Krx9f9PGp3snmyjgH+VW1d5sU1rFDMtHZ42LB6knm6uR
         i+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SBPjjox/K0nQBp9p/UReaX06mOCKZA5VG5oKrHSRp3U=;
        b=HqTT0+ynIKw6E4V0b5+iwDDqZ7QUquJBPmXYeHB9sChD54q5da/4DmcyF7kiieqGbP
         A+rDlyoijypPpyO/yKSOJJ3uo8zZra0SuS4pYuzULtd5pes7PDKQfuVUXnN6J6OqpZwj
         FcE+989C4aNRt0T7FmMWb4LGQoJvBvUONtOfyDIqALRJBmFwTXNSBPY70VR9EPA3/TEx
         VGkoS1E1BLayVoVWq8wdKtlIYoOBIkqYGAcYpifZf26v2vfzzXvE8soL6tnSKfTL0QMH
         QFvXLPPLnmOKqySO/9XcxLrdDqM35x4f3DEhJ6P4JTv0ZnkDNojlNvCTw8lUzzq3w0LH
         qArw==
X-Gm-Message-State: APjAAAV3ZoLwnfUP9ALqf401Lq57ToMCe34K44r0Eef2V7Q0Jw/vqKVE
        /47bg0UdWpoE9XP7XHoFUEpJONagdQSkJjRtznc=
X-Google-Smtp-Source: APXvYqwMtHOZMoB23ssF7JNCZzaMw12LgXJO1Cx/fyHqurm8wqZn755XqIGbFFeB1mv3cEwMcIBCpgy6byzfZbrNKqg=
X-Received: by 2002:a63:6483:: with SMTP id y125mr5619534pgb.444.1572998212169;
 Tue, 05 Nov 2019 15:56:52 -0800 (PST)
Date:   Tue,  5 Nov 2019 15:56:07 -0800
In-Reply-To: <20191105235608.107702-1-samitolvanen@google.com>
Message-Id: <20191105235608.107702-14-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191105235608.107702-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v5 13/14] arm64: disable SCS for hypervisor code
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

