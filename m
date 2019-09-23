Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407D4C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1279920830
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 00:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hXoD43kB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfIWAps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 20:45:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43062 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389939AbfIWApp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 20:45:45 -0400
Received: by mail-pf1-f194.google.com with SMTP id a2so8021553pfo.10
        for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2019 17:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UolwQ0cu1AA/iqmfvkDUCTBOg9ROKFLAkl4FEYmNIH4=;
        b=hXoD43kBut3QYuGcML4svtO79QqkxZYAVBXnKO/MGgHR7hUFpdqDHXUJGqyaVrLgy8
         DV7LV4TDe25ilVZwic5rdkCoG36xzbvnsyDAcZsmn3TF8Zo8azceRpEYc5ClD3aIxN2/
         JunGFRWlnM9kuuljFmHzGYIxjGlCFWRkpdYwwhybOYG5dEcM6CeW40BlGLSIy7ueA3mr
         WFUDYTk7xrOAoLiYIzMoYVBFKibNFwTQOmi2eQeKfo/t5Kj85U18yRcW+yBMTolXDtwa
         ZkDjGGuWYQyeY7/xz4KVbi0dPEV/JWJPsHWL8R85YWjsh1Zl+7xwEExciAZIgcFImdvk
         r9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UolwQ0cu1AA/iqmfvkDUCTBOg9ROKFLAkl4FEYmNIH4=;
        b=h90Fek8m6VVaplBw7YY+Ut95ZFk3HeJ34yr9dbebLpmzbgEN71HDDjvKcinT7Sy5cs
         SbnYMexiFmyAQfca6jS+yXZHQE9OHzRrJ8+kEeM3xATNHW7xV8CBZ4zKjwM0Bbbf53yE
         dVRGrPFmLLltD+tX9IKGFZK1DJqtZIW3w7Hgg7o7N5PsR+TIHKwwm3nSMV17Lmx7mp9F
         tFgQ43LC5G/gVAZzfMUCvTISENUfXEfm7YFwDXHrZLEb4ahignsEASEO70/7nJYXoatl
         Q3eel6i3oWqdYpT5FjnM370BMqVUcI1O0jCs1OT38DbMihXZRbD2G/4rWRj26PqRxvOv
         7TVg==
X-Gm-Message-State: APjAAAW3mAfPHCk9dF3SZ8ivtvd1EwJXyZiWZyNh2M8tF6DTYRUdh+7m
        ADeBTRSVa+AB5tOtlHPT0bPvsQ==
X-Google-Smtp-Source: APXvYqxgCsJWq73K4bZZuZ4ncyptKJaUKhytI6kBAarKqVdUsqYNrPKgHKP33BPUTwHvpg2aedoTFQ==
X-Received: by 2002:a65:5a84:: with SMTP id c4mr26598583pgt.261.1569199543088;
        Sun, 22 Sep 2019 17:45:43 -0700 (PDT)
Received: from localhost.localdomain (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id l7sm9139392pjy.12.2019.09.22.17.45.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Sep 2019 17:45:42 -0700 (PDT)
From:   Vincent Chen <vincent.chen@sifive.com>
To:     linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, vincent.chen@sifive.com
Subject: [PATCH 4/4] riscv: remove the switch statement in do_trap_break()
Date:   Mon, 23 Sep 2019 08:45:17 +0800
Message-Id: <1569199517-5884-5-git-send-email-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
References: <1569199517-5884-1-git-send-email-vincent.chen@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the code more straightforward, replacing the switch statement
with if statement.

Suggested-by: Paul Walmsley <paul.walmsley@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/kernel/traps.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index dd13bc90aeb6..1ac75f7d0bff 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -124,23 +124,24 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 
 asmlinkage void do_trap_break(struct pt_regs *regs)
 {
-	if (!user_mode(regs)) {
+	if (user_mode(regs)) {
+		force_sig_fault(SIGTRAP, TRAP_BRKPT,
+				(void __user *)(regs->sepc));
+		return;
+	}
+#ifdef CONFIG_GENERIC_BUG
+	{
 		enum bug_trap_type type;
 
 		type = report_bug(regs->sepc, regs);
-		switch (type) {
-#ifdef CONFIG_GENERIC_BUG
-		case BUG_TRAP_TYPE_WARN:
+		if (type == BUG_TRAP_TYPE_WARN) {
 			regs->sepc += get_break_insn_length(regs->sepc);
 			return;
-		case BUG_TRAP_TYPE_BUG:
-#endif /* CONFIG_GENERIC_BUG */
-		default:
-			die(regs, "Kernel BUG");
 		}
-	} else
-		force_sig_fault(SIGTRAP, TRAP_BRKPT,
-				(void __user *)(regs->sepc));
+	}
+#endif /* CONFIG_GENERIC_BUG */
+
+	die(regs, "Kernel BUG");
 }
 
 #ifdef CONFIG_GENERIC_BUG
-- 
2.7.4

