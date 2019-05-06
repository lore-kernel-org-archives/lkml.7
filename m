Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93368C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6105C2053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nz1xc3O1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfEFRKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:10:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33642 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfEFRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:10:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id z28so7114231pfk.0;
        Mon, 06 May 2019 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sp5SvL0P5lrU86BpXk5nK8V2Shd1dKoGOnP2voXWJNg=;
        b=nz1xc3O1AYLYRMLPtFLKNUGl0apXS+AfaQ+XUOBA8OHWiqAlmSZg3WNostzfBDvl2t
         dJbjh42lKCMTQiNoz5VQsoEeA6fWbrdmyo3HvW/w1Q6EyFwhybW7E3wiR5FeOe6mhH1f
         i16dOKmV6VpHceGTEDYrGSMfb1216vSq7/xPK1JjaALhxXZBk+mSaVv4TtwjZVOJx4ip
         XsEIiJ28OGB1q1q0nOFM+4XkcLo9BrWNFERaKkIGiZ8gWXfg1HLYvq/itHI5/bqtTYJv
         O8RE62LGI0xM4G70vkYinKDFINn4FgRdabEL5ZqW5K1rQETVEAntJk4nCCy0vJ2MOTbD
         Wqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sp5SvL0P5lrU86BpXk5nK8V2Shd1dKoGOnP2voXWJNg=;
        b=RN9Is07PfHUXnrYb8SAzd1X7pyE6RE0YnH2eRaNV0f6wqp0MQuKqiK/7pcHGPAH9vb
         +b+synaXBcuvrRzR7TGQITHE0xQA+hqR67qdor1j4d56iuCaU0jdzRz/b2g35ZNfXLhv
         oawzDrQjUDy94WMbUIFRCpGfggiLl4gQABFp1VaOi02pp3qLp4CBupEHlZ3Tcu2ooLq+
         gMkajqL9UxIWo8lC2XPdgnd6sE3zPn0tG+syA3k6TYV7SBHzK5wbUOP8Q5SljoQdjigR
         DGvLb/HjrfSQBjrlPwyBwc0qilNSVVCNpmyam1hji53DVFrJU2k8/5P+uhSO8nqBuZkK
         LuIA==
X-Gm-Message-State: APjAAAUvx025Vysp/WMGkA3DC7fJOWaCsjOsTYMhj/4Us/4qKTSKkPwp
        nf/f6K827L59vl/yD4fkg2g=
X-Google-Smtp-Source: APXvYqw90L6Bz8JoyoNaUt+kAnPKH8oQwa/Im4A03HrQQgdTJl12boLn3n73jY1rAFGEYfTkhZo1rg==
X-Received: by 2002:a62:2506:: with SMTP id l6mr18398486pfl.250.1557162646416;
        Mon, 06 May 2019 10:10:46 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.10.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:10:45 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 12/27] Documentation: x86: convert protection-keys.txt to reST
Date:   Tue,  7 May 2019 01:09:08 +0800
Message-Id: <20190506170923.7117-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190506170923.7117-1-changbin.du@gmail.com>
References: <20190506170923.7117-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/x86/index.rst                   |  1 +
 ...rotection-keys.txt => protection-keys.rst} | 33 ++++++++++++-------
 2 files changed, 22 insertions(+), 12 deletions(-)
 rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index f7012e4afacd..e2c0db9fcd4e 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -18,3 +18,4 @@ x86-specific Documentation
    tlb
    mtrr
    pat
+   protection-keys
diff --git a/Documentation/x86/protection-keys.txt b/Documentation/x86/protection-keys.rst
similarity index 83%
rename from Documentation/x86/protection-keys.txt
rename to Documentation/x86/protection-keys.rst
index ecb0d2dadfb7..49d9833af871 100644
--- a/Documentation/x86/protection-keys.txt
+++ b/Documentation/x86/protection-keys.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Memory Protection Keys
+======================
+
 Memory Protection Keys for Userspace (PKU aka PKEYs) is a feature
 which is found on Intel's Skylake "Scalable Processor" Server CPUs.
 It will be avalable in future non-server parts.
@@ -23,9 +29,10 @@ even though there is theoretically space in the PAE PTEs.  These
 permissions are enforced on data access only and have no effect on
 instruction fetches.
 
-=========================== Syscalls ===========================
+Syscalls
+========
 
-There are 3 system calls which directly interact with pkeys:
+There are 3 system calls which directly interact with pkeys::
 
 	int pkey_alloc(unsigned long flags, unsigned long init_access_rights)
 	int pkey_free(int pkey);
@@ -37,6 +44,7 @@ pkey_alloc().  An application calls the WRPKRU instruction
 directly in order to change access permissions to memory covered
 with a key.  In this example WRPKRU is wrapped by a C function
 called pkey_set().
+::
 
 	int real_prot = PROT_READ|PROT_WRITE;
 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE);
@@ -45,43 +53,44 @@ called pkey_set().
 	... application runs here
 
 Now, if the application needs to update the data at 'ptr', it can
-gain access, do the update, then remove its write access:
+gain access, do the update, then remove its write access::
 
 	pkey_set(pkey, 0); // clear PKEY_DISABLE_WRITE
 	*ptr = foo; // assign something
 	pkey_set(pkey, PKEY_DISABLE_WRITE); // set PKEY_DISABLE_WRITE again
 
 Now when it frees the memory, it will also free the pkey since it
-is no longer in use:
+is no longer in use::
 
 	munmap(ptr, PAGE_SIZE);
 	pkey_free(pkey);
 
-(Note: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
- An example implementation can be found in
- tools/testing/selftests/x86/protection_keys.c)
+.. note:: pkey_set() is a wrapper for the RDPKRU and WRPKRU instructions.
+          An example implementation can be found in
+          tools/testing/selftests/x86/protection_keys.c.
 
-=========================== Behavior ===========================
+Behavior
+========
 
 The kernel attempts to make protection keys consistent with the
-behavior of a plain mprotect().  For instance if you do this:
+behavior of a plain mprotect().  For instance if you do this::
 
 	mprotect(ptr, size, PROT_NONE);
 	something(ptr);
 
-you can expect the same effects with protection keys when doing this:
+you can expect the same effects with protection keys when doing this::
 
 	pkey = pkey_alloc(0, PKEY_DISABLE_WRITE | PKEY_DISABLE_READ);
 	pkey_mprotect(ptr, size, PROT_READ|PROT_WRITE, pkey);
 	something(ptr);
 
 That should be true whether something() is a direct access to 'ptr'
-like:
+like::
 
 	*ptr = foo;
 
 or when the kernel does the access on the application's behalf like
-with a read():
+with a read()::
 
 	read(fd, ptr, 1);
 
-- 
2.20.1

