Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6969C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7642920B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qfcv0jVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfD0Goj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:44:39 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42640 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbfD0GnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:43:21 -0400
Received: by mail-pf1-f196.google.com with SMTP id w25so2743878pfi.9;
        Fri, 26 Apr 2019 23:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNv4uuWY37+QDIo+8eJ5Cs1RQKFygWuhu/mUpTFc+50=;
        b=qfcv0jVylRwgUSdFp0yVo6y3SoCAOjol9XbR7W5+lwraaEg2QoXyt+VrAjGp9wzdAn
         BOm9G9cC4mrsWbrKkWfeWua0CLcUhNFX2UYmr160CAGJNRPhpKunjycWCJnpjaUptQXK
         FymoezD52jYoCa9vw1d8DrTtNcDpUD3gesH2ZoYEwsgq0bZE6tTukM9zPOscjJPRRiHd
         0d0EQKT1ASnMLtYxkgiq4MVCWAUZf/kjKC/u6ibFbPlbEhDhs/jBfSTvPAadE2T4MBPs
         yoHMRLVUDfJJ0O31Q2uS3OPiszz2lAVHUHfzcDpTk8KxpsBn4aqr0vTCALbdk7a/EPYd
         2uWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNv4uuWY37+QDIo+8eJ5Cs1RQKFygWuhu/mUpTFc+50=;
        b=e36XDmzl6UQXWwFVnf1Aho7OYa6xYxx/ohzJMVW9lHybNH2PZQdH8bKlDrUn2puVx/
         HrODl7AvP0qb/38oQYRDHwjENuuFmbysNLhayn7KAjkWNwmzWxpb2p9wZZ80Kko0zlOh
         m33D5qlUf4EpEoI6Yo/raL9lm9KANbzYTczEf8jqvJCW+uQV8cj1zbkIOY30ayPWO6t7
         KMTkHoRxr5yKENMHV86B6bkDzj3rbmHTunDaJ+nLe5iwQLo8qNxwxouY/901FCPIJnuE
         bdsvfOwbpKfu85tnX6J13UwqPSchNti/M6I4yUwYo9OUmbOun9hVf8MKHSlrGLRSum/Y
         xuWQ==
X-Gm-Message-State: APjAAAVic7Kmx599MCiIJZgM1lzjuP0Vyvi5p/aQtl7ZrzCe/B2QJNIR
        z05MD8SrRAYoLHRVtfO0bxk=
X-Google-Smtp-Source: APXvYqxCgMCnuubydaHXfJIDthz2u46RkKoNrhpM9xg9spe5Zm1Eq7YBRg8tloTlDMLwvkBDrQMPvQ==
X-Received: by 2002:a63:7f0b:: with SMTP id a11mr44847434pgd.234.1556347400564;
        Fri, 26 Apr 2019 23:43:20 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id j22sm36460145pfn.129.2019.04.26.23.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 23:43:20 -0700 (PDT)
From:   nadav.amit@gmail.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, hpa@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Nadav Amit <nadav.amit@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux_dti@icloud.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, akpm@linux-foundation.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        will.deacon@arm.com, ard.biesheuvel@linaro.org,
        kristen@linux.intel.com, deneen.t.dock@intel.com,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Nadav Amit <namit@vmware.com>
Subject: [PATCH v6 11/24] x86/kprobes: Set instruction page as executable
Date:   Fri, 26 Apr 2019 16:22:50 -0700
Message-Id: <20190426232303.28381-12-nadav.amit@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426232303.28381-1-nadav.amit@gmail.com>
References: <20190426232303.28381-1-nadav.amit@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Set the page as executable after allocation.  This patch is a
preparatory patch for a following patch that makes module allocated
pages non-executable.

While at it, do some small cleanup of what appears to be unnecessary
masking.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/kprobes/core.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a034cb808e7e..1591852d3ac4 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -431,8 +431,20 @@ void *alloc_insn_page(void)
 	void *page;
 
 	page = module_alloc(PAGE_SIZE);
-	if (page)
-		set_memory_ro((unsigned long)page & PAGE_MASK, 1);
+	if (!page)
+		return NULL;
+
+	/*
+	 * First make the page read-only, and only then make it executable to
+	 * prevent it from being W+X in between.
+	 */
+	set_memory_ro((unsigned long)page, 1);
+
+	/*
+	 * TODO: Once additional kernel code protection mechanisms are set, ensure
+	 * that the page was not maliciously altered and it is still zeroed.
+	 */
+	set_memory_x((unsigned long)page, 1);
 
 	return page;
 }
@@ -440,8 +452,12 @@ void *alloc_insn_page(void)
 /* Recover page to RW mode before releasing it */
 void free_insn_page(void *page)
 {
-	set_memory_nx((unsigned long)page & PAGE_MASK, 1);
-	set_memory_rw((unsigned long)page & PAGE_MASK, 1);
+	/*
+	 * First make the page non-executable, and only then make it writable to
+	 * prevent it from being W+X in between.
+	 */
+	set_memory_nx((unsigned long)page, 1);
+	set_memory_rw((unsigned long)page, 1);
 	module_memfree(page);
 }
 
-- 
2.17.1

