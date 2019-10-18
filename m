Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF1FCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF90C222BD
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 16:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JytSfSIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502738AbfJRQL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:11:58 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43839 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502531AbfJRQLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 12:11:16 -0400
Received: by mail-pf1-f201.google.com with SMTP id i187so4977972pfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 09:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O8IkwU6sBVUF8FqvV1I5skAqoYbhLBF9oLtPiANlCGQ=;
        b=JytSfSIKC9plsUuL7Anvr6QOhk8r1uFIhvXpVGgpoIt+Pceeda3VIOzbcA7+0/BsI2
         zIOFDZDlBlALPUkKw3QeckVXjlO15PINjv6We8JOgEFa99U5KrlSx7XXOz6Nx0YB48ik
         JUIvMysSkaZBaFFzF9YCNL6v7dsTQWajujUMHj1WzB/oICg2lLsquw3Vw81wZ9YrRh+I
         eqZjR6qEmEq1xmlqn4gPhCaDAzL6Ck5jxkdyZpOLHnnw7A9jN+Xtb/99WqHJGyBIz0eH
         RHpYhCrhAeYHu1mm3FYIj4Y1yIWOuV3/oL+MaGiwsAiiSjet6tZhPh7Y20s53JxWp6Uo
         RIpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O8IkwU6sBVUF8FqvV1I5skAqoYbhLBF9oLtPiANlCGQ=;
        b=sPhmHWWb9p0wIRC6jNMicqvPczC/A32oLCqiW+k8YDqVsMmeHdJSPWVaX/3g0Iv52a
         g2Xk9IOYrXXeky9eQWknoEsWC2mhOreFP43HMzzVCVVxp5vkvioxHoRuVmqH+jIvTYAS
         vPl5yYHFlOi+0+eE1cgKw31ZgDjHodrHaJVNEsbjFAD1rGsymQR1a2nLx3/AqNRSVlXT
         +YFrOHKjFMGWUEotF5LXaSuPMOg5Mt2tjZuQTzfxsHeu0dFWiF7J9dXNL9tndfRnM998
         wi1nsxLsoDZZ4yDU2bArmd0Lb62oGxkUyOUbc5+7W+vBcVdOp8HBCMHsM08uFPuG8u3g
         OaXw==
X-Gm-Message-State: APjAAAUC+yVswk2LgVRh17RtjP9/HLW9HIR+Q6Ed98u3r1GdNyn8Us8E
        k2Fp0f0HF/c/lkZohIsg8kbn9189b/uP85moyfo=
X-Google-Smtp-Source: APXvYqxCc4imQBOuO4slIZxb1lJUVZnQFeO3XHf/hzNVQOpLbC+EVQgHSML0nT8J+/sJkR2vVeisW1XnmtFkqXhxt3k=
X-Received: by 2002:a65:68c1:: with SMTP id k1mr11253965pgt.286.1571415075496;
 Fri, 18 Oct 2019 09:11:15 -0700 (PDT)
Date:   Fri, 18 Oct 2019 09:10:25 -0700
In-Reply-To: <20191018161033.261971-1-samitolvanen@google.com>
Message-Id: <20191018161033.261971-11-samitolvanen@google.com>
Mime-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH 10/18] kprobes: fix compilation without CONFIG_KRETPROBES
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
2.23.0.866.gb869b98d4c-goog

