Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BC3CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0FB21929
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 22:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yue9uHjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732534AbfJXWwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 18:52:22 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:37561 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732383AbfJXWwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:52:07 -0400
Received: by mail-pf1-f202.google.com with SMTP id p2so341560pff.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ut7YUpLvWAiZLonPATqZ5OL9tOEZJcNF7+tDsNdHEWU=;
        b=Yue9uHjmOjCVuztIQPd86DzimLWI+fR6hTvdgEK/61gESlizanN/A26bP9cX7dKHQZ
         oLJaaihwQeZ8TJTaC/aUcwdebnAqYL1UA2240obxSIMDp+j8AnFncQVqEMSmDWOZyolB
         ZdO6BTWxOJWZJrdCoEIXzyAMbQCBE/lBQOUYz7LfURQr9FE/nOgK5wI5aA/YpCOOoAKs
         ulfAhIsP7AvmLnNWY84oHIXlg/HfyhUjn7orwuaGMA3KCGHEhcJBj/YnjJpM4c+XXuZ0
         YSvScvKza86L+Kajd8Kd/l8lRkcS8nw1BRebOUAsJOMUPyf3RTIJKK6kMU656U4CuO/+
         09vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ut7YUpLvWAiZLonPATqZ5OL9tOEZJcNF7+tDsNdHEWU=;
        b=RmfgAAbkFCh/457pNfAngb7UHebQxmvFEKUEYI74oxb80Kqas7t4fR6Vo65/eEnMy+
         tqBJ15Ns4lYMvzmvkTUlayO2W0yxRC4YuoN+8qBtjQ45WEsZAGTbQ+Q4NN5k7BbfB2cJ
         Q3mxRQ91QsFXjcNRZROT/RnKPFv9Ue38ssNGH/arK9OosDAJC+2N3wp/JU0keV+7rhq9
         osEkBkFYfm0jPySa0ZygMqtNxGEg4sYz3isabtt+xR+WW/L+cELGrQ+dnTxw/gkx3BR4
         k5Xk4toUzqIFACmLcmr4dEXYFG8aB9WZg4IXFIC34jEW5LwxB12byqUghiErPcGcFCgj
         lMOA==
X-Gm-Message-State: APjAAAUdG81vyr3OWU8m5mo55b/IhRUoIJ/NNWskTAT7eMNRH6bB9fvr
        YRDi1dAu9xawr+AIH/BcTc+CFd5Z+SEaFCcsC60=
X-Google-Smtp-Source: APXvYqyIrzZDUZW/ai1FBaSFozXCzV2dy/HKURTLyrbV1w3X+deCMyV91eFC953B77j0GjtVKG+bkdsaiwl8eZ9vJk4=
X-Received: by 2002:a63:495b:: with SMTP id y27mr505887pgk.438.1571957526087;
 Thu, 24 Oct 2019 15:52:06 -0700 (PDT)
Date:   Thu, 24 Oct 2019 15:51:23 -0700
In-Reply-To: <20191024225132.13410-1-samitolvanen@google.com>
Message-Id: <20191024225132.13410-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191024225132.13410-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v2 08/17] kprobes: fix compilation without CONFIG_KRETPROBES
From:   samitolvanen@google.com
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
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

kprobe_on_func_entry and arch_kprobe_on_func_entry need to be available
even if CONFIG_KRETPROBES is not selected.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 53534aa258a6..b5e20a4669b8 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1829,6 +1829,25 @@ unsigned long __weak arch_deref_entry_point(void *entry)
 	return (unsigned long)entry;
 }
 
+bool __weak arch_kprobe_on_func_entry(unsigned long offset)
+{
+	return !offset;
+}
+
+bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
+{
+	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
+
+	if (IS_ERR(kp_addr))
+		return false;
+
+	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
+						!arch_kprobe_on_func_entry(offset))
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_KRETPROBES
 /*
  * This kprobe pre_handler is registered with every kretprobe. When probe
@@ -1885,25 +1904,6 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(pre_handler_kretprobe);
 
-bool __weak arch_kprobe_on_func_entry(unsigned long offset)
-{
-	return !offset;
-}
-
-bool kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
-{
-	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
-
-	if (IS_ERR(kp_addr))
-		return false;
-
-	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
-						!arch_kprobe_on_func_entry(offset))
-		return false;
-
-	return true;
-}
-
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret = 0;
-- 
2.24.0.rc0.303.g954a862665-goog

