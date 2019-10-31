Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9A3CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F62E20873
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 16:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ghjlrkb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfJaQrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 12:47:45 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:51022 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfJaQrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 12:47:06 -0400
Received: by mail-pg1-f201.google.com with SMTP id r24so4769356pgj.17
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 09:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ut7YUpLvWAiZLonPATqZ5OL9tOEZJcNF7+tDsNdHEWU=;
        b=Ghjlrkb1pnfNur1PCuCrGu3KmSL84JUhV/VRyXQlGUkgpAsmk5kMXvp57Mk7EYOtSq
         L/8VDDHfXZ3KUDC1xcym7naR9TXkHtFoyXvddQwvFISLnm28nEJXtrhVKjiDWc99o+wm
         bIXKaCoHuKC2xbc2hbdVG9x55NXltyby/oVTLxiYMqg5L3AXj+Jse9QRq7ocqCtz8Woo
         EwpS6ecvA2GO0JpKJUVbqL7jZeQw+99QXy+fwi9BAQMGs5rPs+dkXDB42GUWcoOq+vfR
         K9Q0cwMWNIBZXS43c69SS1vt9YQQD9Wr2zCStwQNshudap8C/A8PTXXPpqKAD3KVELa9
         kr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ut7YUpLvWAiZLonPATqZ5OL9tOEZJcNF7+tDsNdHEWU=;
        b=r/Y7VVGfJiKakQ7bly/yUgv4ylbRccf0k+nUdg8vUoHc6QrW71P42/zsoJkHoxUgaZ
         h/l2chKKN96pEw9GdqfdnguznNuf54nepG1QASJlMUdy9KAt+Tbvf3qXpIp0ykE6CSYA
         wkLgQKWiBpckvd7JRJ8XDlV0m5DybaqlaEHeoAl4Jltg2VHi4+aPBin1x/hzmdq/NpgG
         IvJfuRmfJAYX7kQQrC4RBJLfewUlScFBTzihKBOlgQsMYpiZRJktwYrTRW73KEwczgNz
         ty53ZY/cQhThM67vocOv4pcyFwkj+st1uc+ofJtkJm+FUGAoLJdzitSOn4YmrX8/2k3F
         T68Q==
X-Gm-Message-State: APjAAAUKP6XUmJQtqGA5BzCWMoXCGfa5t1rFLJl0QO3XiuoqzXwdtVMz
        d9S6qi/6a4rc6565JGEOBEvpHP+1RuZUpyKxf9A=
X-Google-Smtp-Source: APXvYqymaacyz4eRHwtAvxRw6d3+sUW8PqKg+fCQUsJPaPuhQFDN545Kov10eZWMR0T+MDCojgj91Rt4gt/RgGRC9ik=
X-Received: by 2002:a63:151:: with SMTP id 78mr7160557pgb.95.1572540425150;
 Thu, 31 Oct 2019 09:47:05 -0700 (PDT)
Date:   Thu, 31 Oct 2019 09:46:28 -0700
In-Reply-To: <20191031164637.48901-1-samitolvanen@google.com>
Message-Id: <20191031164637.48901-9-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com> <20191031164637.48901-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
Subject: [PATCH v3 08/17] kprobes: fix compilation without CONFIG_KRETPROBES
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

