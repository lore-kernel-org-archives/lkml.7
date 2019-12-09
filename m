Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417AC43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36D8D2077B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c7JyKFkn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbfLIOb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:31:58 -0500
Received: from mail-yb1-f201.google.com ([209.85.219.201]:46916 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLIOb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:31:57 -0500
Received: by mail-yb1-f201.google.com with SMTP id o85so6026929yba.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=g+A0f45IRCzFODlDzia7ir2GSqO4sEP6+0Dk2zsbcZc=;
        b=c7JyKFknTNoFsHHfV3KI79yc7otJiU8Uz/Q+2FvsP3x9h+G6tmVlpGhHKoOdu2d65j
         Hd4+fu0uAAQ7pQEwo3z6fZ1Jp/Se0SpE0/c4FF4Ya3uZK0Bqg9XwCaEv/dpZvIURG8Pe
         k+bcuwbBYP5YUyckQ02q6j2hEjugYyu2j67ALaM/lY7NCfl8+Mc65my5QZj/R591IOrj
         BFtsxJtu4lOii7oXXL+Cwwg4Z7SDH2cnbsLGseXXnfbNRmHdvnaiQfZJzGu2XZZDpcz7
         RhFewKOfWUJArec5v99iM2cBTWJTlFKm6Lvvuf1e60sj6qEPbkAzE+MwOPXHTD7ojX2a
         lVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=g+A0f45IRCzFODlDzia7ir2GSqO4sEP6+0Dk2zsbcZc=;
        b=ZIksCEueP1b1wXAqeL8WRtSO7WYLDsDZrDCr6/iQBQQCMLd3BGmdkndJPk9tN4/vyG
         vkPR3TfpYL3Iwd+Lf7feuy1r8VQxepsMh+xOmdR/oOBaKXjWLa0nh9tzS5gcxfbcJF24
         Ik37ie52omcVKit509WrZLqFdAuZyMF2PiAIIRV1G2suJeWPMwTQLpwvczLA1bXryo0t
         H07z2MdvH2G02fjfnOCqLYWvjPGp6OUIcbmQv7b8/F5TQamYP2DsRWUzlAPK8B/acoF4
         lpO8I88OufwFVYXPbaevDct2MOC3x8g5Gntk8NxxFYibPFJHs2PnmKXFk8V31c25d5Gk
         omXw==
X-Gm-Message-State: APjAAAWpkV9Deiebr6i7ZL4YRokIg1ri+RVP/ba0tynW0bpvumoaxNKQ
        eG72do7s83zVfDLAoqBFxnh4pCdUDA==
X-Google-Smtp-Source: APXvYqyK/KjJfZTmF8ECFTWDYve4nQpqx/VwFvDfyifPSevI5QfkqRGYwen/G9KnghiNCY7NBR9JXBh7Gw==
X-Received: by 2002:a5b:350:: with SMTP id q16mr19288549ybp.392.1575901916740;
 Mon, 09 Dec 2019 06:31:56 -0800 (PST)
Date:   Mon,  9 Dec 2019 15:31:19 +0100
In-Reply-To: <20191209143120.60100-1-jannh@google.com>
Message-Id: <20191209143120.60100-3-jannh@google.com>
Mime-Version: 1.0
References: <20191209143120.60100-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
Subject: [PATCH v6 3/4] x86/dumpstack: Split out header line printing from __die()
From:   Jann Horn <jannh@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        jannh@google.com
Cc:     linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split __die() into __die_header() and __die_body(). This allows callers to
insert extra information below the header line that initiates the bug
report.

This can e.g. be used by __die() callers to allow KASAN to print additional
information below the header line of the bug report.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v3:
      new patch
    v4-v6:
      no changes

 arch/x86/include/asm/kdebug.h |  3 +++
 arch/x86/kernel/dumpstack.c   | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index 75f1e35e7c15..a0050fabce42 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -33,6 +33,9 @@ enum show_regs_mode {
 };
 
 extern void die(const char *, struct pt_regs *,long);
+extern void __die_header(const char *str, struct pt_regs *regs, long err);
+extern int __must_check __die_body(const char *str, struct pt_regs *regs,
+				   long err);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
 extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index e07424e19274..6436f3f5f803 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -365,7 +365,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 }
 NOKPROBE_SYMBOL(oops_end);
 
-int __die(const char *str, struct pt_regs *regs, long err)
+void __die_header(const char *str, struct pt_regs *regs, long err)
 {
 	const char *pr = "";
 
@@ -384,7 +384,11 @@ int __die(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
 	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
+}
+NOKPROBE_SYMBOL(__die_header);
 
+int __die_body(const char *str, struct pt_regs *regs, long err)
+{
 	show_regs(regs);
 	print_modules();
 
@@ -394,6 +398,13 @@ int __die(const char *str, struct pt_regs *regs, long err)
 
 	return 0;
 }
+NOKPROBE_SYMBOL(__die_body);
+
+int __die(const char *str, struct pt_regs *regs, long err)
+{
+	__die_header(str, regs, err);
+	return __die_body(str, regs, err);
+}
 NOKPROBE_SYMBOL(__die);
 
 /*
-- 
2.24.0.393.g34dc348eaf-goog

