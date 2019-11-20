Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54EADC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B9FD2071F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 17:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkqfK8U/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfKTRC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:02:29 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:45029 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729936AbfKTRC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 12:02:27 -0500
Received: by mail-vs1-f74.google.com with SMTP id d75so111725vsc.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9d7hes0bN3fI4cGZa6ncDGHqqVf+/vhZC1EMTLMNG+s=;
        b=OkqfK8U/bs9NFytvicTMZgkFuwG58xfKPZHd4xbHYRLjioZsTADk0yiGQZRzCJeWmk
         oyTJMiyV4XPJKvCD4Bd8w+E2RR/Shm4FkeH113Psx9zggiI5VO8+skCB7Nens2UsVSHV
         D6RJXddev84Dn2XpVME2wolPbV6alt7y6HdMBbwOrrenzInqtxiheQ2Z8eqKoytyQlgX
         qxrm19jKQx1clhfeFuKOSt4qc62dQkCTIbK/DVSOI01ieJ1FiDxSG76vPUcQEfw6c3MY
         Xj4GiXH3liEG+q5kbqSfb52u6UlbWJTjNKooC+YP50zJWm+IzGWPNTHSjEkOCE89O/6M
         X0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9d7hes0bN3fI4cGZa6ncDGHqqVf+/vhZC1EMTLMNG+s=;
        b=cRi7szKOE1TUSHm5OCFxz1tkpHjzYubvJSvzp6o0aHKlpYBF8VKAVqoucFNSIpq7W6
         BsVYY36uaRB0AKcYXMg9GOYx7FmOfZPfEXbvKZj38aWFRmZ9K0FK9tIrpmm+VTBpEOi7
         zGlB9c5GMgE4D4EdCtNynO3yiQ8efOUTVwRQq5XExyV9RsoQEEF2+Oj08c0OecdK/Ch8
         yX1+He8t/l8L5rzvYLU7tGnbQusRAf6ZbBtgFXIIwrhVBHv2+guvSbygNTGDclnd3uqL
         ZbQcFr1WWIgAY1JL1lF8lXUkhtaXM4TYSv/LxOyAI96u666R60unGPvNGZfKTttNsuUG
         KnCg==
X-Gm-Message-State: APjAAAVrqRgq26CQoUkEzOIxbRfk1huHyyERbL2bA3hVJUQBdBmAKNb6
        htva9cnZ059aCMD0DWRWxO4RNvAJeA==
X-Google-Smtp-Source: APXvYqyxOigzxlB2d27QP96L6lyeWRHLa86NyyRTfYiFAk36XbWtE8UienNjyFs4RoQHKdpAF1H7rhbXdg==
X-Received: by 2002:ab0:4e2d:: with SMTP id g45mr2371300uah.29.1574269345276;
 Wed, 20 Nov 2019 09:02:25 -0800 (PST)
Date:   Wed, 20 Nov 2019 18:02:07 +0100
In-Reply-To: <20191120170208.211997-1-jannh@google.com>
Message-Id: <20191120170208.211997-3-jannh@google.com>
Mime-Version: 1.0
References: <20191120170208.211997-1-jannh@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v4 3/4] x86/dumpstack: Split out header line printing from __die()
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
    I think that it's nicer to have KASAN's notes about the
    bug below the first oops line from the kernel.
    This also means that tools that work with kernel oops
    reports can just trigger on the "general protection fault"
    line with the die counter and so on, and just include the
    text from on there, and the KASAN message will automatically
    be included.
    But if you think that the code looks too ugly, I'd be
    happy to change that back and drop this patch from the
    series.
    
    v3:
      new patch
    v4:
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
2.24.0.432.g9d3f5f5b63-goog

