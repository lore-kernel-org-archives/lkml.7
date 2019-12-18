Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84A80C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56435218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 23:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvPGswJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfLRXMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 18:12:21 -0500
Received: from mail-wr1-f73.google.com ([209.85.221.73]:45152 "EHLO
        mail-wr1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfLRXMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 18:12:19 -0500
Received: by mail-wr1-f73.google.com with SMTP id d8so1496603wrq.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 15:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=O7cRpxVyt8uxMLcyDyuXxaiEb45NcHrYdQjrFEEd8is=;
        b=cvPGswJDDCWWZrQ9HPqf9ZoStjXiGuTN61KVqKFRTF/ugxQS/hxj7FlWuHb/7dRR/0
         Bw8AMJKfchRCkhA0FflSqoIW/fbUNTuZABELRviUTxuBYe6qdHxF/ZHNaJ1i/9h4EQhz
         +o/JTPG67rwkv6AoO/pTlylX9MEI0+7oQmhsNGQCvoxs3UsrO/e9ReQdV2REYnEYqxbx
         yrPb4MLABG4L4OQVFX+asx6Fcsk8NMZEEc1QJGhnMWuxUrtnHK5bDH58u13ocqlmGjXv
         mXmUY/npxI6D8qYLlsz783loophJ8C3MgwePm7yq/tfmeGrwhIm5W6NJXEPeLfZrglOA
         8tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=O7cRpxVyt8uxMLcyDyuXxaiEb45NcHrYdQjrFEEd8is=;
        b=J8NHnNSKe9qf6IqcMaVdFPZINIq8Snc4A0w7GkudQOPb72PwfkmsVFGLOYpOHn12JM
         yMk46R3h4cxvrsNKwd59o1iFfGvNeuc0m33tgtgQ0Qp6vkpBwWpF87NiXcIq2oUWE9q8
         61IJNrdM7uxTqaYkjR2juoXcsx1ZMFAypMTjBg4SQLXmOcZBZj3/CNDF7kxQ6o0ps2j7
         AtNrFpye0rrruPyVN03P30zvTi4tHltivke5MsrXIl/G2FCkbTsP9Wzx08vykFnYOhy2
         Q9pCmRIxgE1LdOwl/DraqKtmcw6XHaHRlhrs88rZRRZND0FC+n9GgRVuYlrLu/BCOMgx
         aYkw==
X-Gm-Message-State: APjAAAU7wUlk3jHiigcG47XLAuy3SwLYnXD57pe+0jzxXMsrWspW6fQm
        Z5JbVkhYIyuiox4qYjs2PwgWGP2udw==
X-Google-Smtp-Source: APXvYqzBhqL5t5GVHOOnngl6Ggq6tOVXgSxy+M5wrhtKJpCIzIHJeM453iRTXK5dgJeLZdE7REmZ1UTtJg==
X-Received: by 2002:adf:81c2:: with SMTP id 60mr5454204wra.8.1576710735282;
 Wed, 18 Dec 2019 15:12:15 -0800 (PST)
Date:   Thu, 19 Dec 2019 00:11:49 +0100
In-Reply-To: <20191218231150.12139-1-jannh@google.com>
Message-Id: <20191218231150.12139-3-jannh@google.com>
Mime-Version: 1.0
References: <20191218231150.12139-1-jannh@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v7 3/4] x86/dumpstack: Introduce die_addr() for die() with #GP
 fault address
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

Split __die() into __die_header() and __die_body(). This allows inserting
extra information below the header line that initiates the bug report.

Introduce a new function die_addr() that behaves like die(), but is for
faults only and uses __die_header()+__die_body() so that a future commit
can print extra information after the header line.

Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v3:
      new patch
    v4-v6:
      no changes
    v7:
     - introduce die_addr() instead of open-coding __die_header()
       and __die_body() calls in traps.c (Borislav)
     - make __die_header() and __die_body() static
     - rewrite commit message

 arch/x86/include/asm/kdebug.h |  1 +
 arch/x86/kernel/dumpstack.c   | 24 +++++++++++++++++++++++-
 arch/x86/kernel/traps.c       |  5 ++++-
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index 75f1e35e7c15..247ab14c6309 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -33,6 +33,7 @@ enum show_regs_mode {
 };
 
 extern void die(const char *, struct pt_regs *,long);
+void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
 extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index e07424e19274..8995bf10c97c 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -365,7 +365,7 @@ void oops_end(unsigned long flags, struct pt_regs *regs, int signr)
 }
 NOKPROBE_SYMBOL(oops_end);
 
-int __die(const char *str, struct pt_regs *regs, long err)
+static void __die_header(const char *str, struct pt_regs *regs, long err)
 {
 	const char *pr = "";
 
@@ -384,7 +384,11 @@ int __die(const char *str, struct pt_regs *regs, long err)
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
 	       IS_ENABLED(CONFIG_PAGE_TABLE_ISOLATION) ?
 	       (boot_cpu_has(X86_FEATURE_PTI) ? " PTI" : " NOPTI") : "");
+}
+NOKPROBE_SYMBOL(__die_header);
 
+static int __die_body(const char *str, struct pt_regs *regs, long err)
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
@@ -410,6 +421,17 @@ void die(const char *str, struct pt_regs *regs, long err)
 	oops_end(flags, regs, sig);
 }
 
+void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr)
+{
+	unsigned long flags = oops_begin();
+	int sig = SIGSEGV;
+
+	__die_header(str, regs, err);
+	if (__die_body(str, regs, err))
+		sig = 0;
+	oops_end(flags, regs, sig);
+}
+
 void show_regs(struct pt_regs *regs)
 {
 	show_regs_print_info(KERN_DEFAULT);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index c8b4ae6aed5b..4c691bb9e0d9 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -621,7 +621,10 @@ do_general_protection(struct pt_regs *regs, long error_code)
 				 "maybe for address",
 				 gp_addr);
 
-		die(desc, regs, error_code);
+		if (hint != GP_NON_CANONICAL)
+			gp_addr = 0;
+
+		die_addr(desc, regs, error_code, gp_addr);
 		return;
 	}
 
-- 
2.24.1.735.g03f4e72817-goog

