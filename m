Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307ECC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4D81208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJhkWf7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfDZPdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:33:19 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35164 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDZPdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:33:18 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so1757984plp.2;
        Fri, 26 Apr 2019 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jhUgUnVwH131/xczA7BMawqjAt3u+4QIhEzyPGkH5gg=;
        b=RJhkWf7sm6bpcSYZUFM7l2vN1+aMdX6QBeCRKTZI5lWZL6wXxsmecJ2XICAWttvrnG
         6BYdIGhmnV0CgNfO7g2zrAZT2ez2+dga6AujhU4eIp9R7CQfdE4KfCB3lsDpt6gY/yBZ
         nNcnQnNK0yJ5fJIpp1R3OcRQHZ68AHp9VYPUS+6bKn707UhS/tAvZtVGajE+TB/tK3rE
         33rKJGih8MsUmp+Ivu7eNaP8KhTwS/BsgSfRiTBHnizuxBpWp01Imi1nOlpu/8o6w0qr
         jq5j4tOmzDCrKsF31HIo3daYv61o3ln0sf7nd+B08b776uvYCrHk+k2H54slC1U50GqM
         peUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jhUgUnVwH131/xczA7BMawqjAt3u+4QIhEzyPGkH5gg=;
        b=YeAaHh5beRkRbjBAQ1ICCKxklj9YhcSw+thwsXzH2s2fpoaqsZcsK9vIPSYqXMwRHk
         6TktS80ZPvAyHJrW968gWpjM/FlHRP6eEbd0g6j9ZhNxINW5898RJPIgXFvxx5ZpWCG4
         k8zhoT7GirAN9C7wN8FB3af0dsmk0epYvsD7gKOoe9OX5XjiMUCVJ7NaU0sHDX710GIV
         GACe0r30DI+zKBfg55waclmHaUEd+ykqaz/88h0uCGjRkD4QKyEfDuwmFRnRzTRYQ5VD
         PptlP3w4ayxUf6w9rE5GGOcFW24lSE+03AVXLpB0oiZwFVGCHV78uBYJqPjE4RO6qCsk
         XIJA==
X-Gm-Message-State: APjAAAWFyFSs+2ZgKbntQDxYyCjZW+OfIRQLDhzHiMZvyzABfb4WFchW
        4eFsX4OE0vrw/V4qAsN+c3c=
X-Google-Smtp-Source: APXvYqw+5MNiJwzvUyNuA4V9hTXMnyJGu6i+Nb+FqIeQP4dX5UtZYoGaeMY4TVdYMRwujv+cQmCGLQ==
X-Received: by 2002:a17:902:28a9:: with SMTP id f38mr46042133plb.295.1556292797359;
        Fri, 26 Apr 2019 08:33:17 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.33.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:33:16 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 12/27] Documentation: x86: convert protection-keys.txt to reST
Date:   Fri, 26 Apr 2019 23:31:35 +0800
Message-Id: <20190426153150.21228-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426153150.21228-1-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 Documentation/x86/index.rst                   |  1 +
 ...rotection-keys.txt => protection-keys.rst} | 33 ++++++++++++-------
 2 files changed, 22 insertions(+), 12 deletions(-)
 rename Documentation/x86/{protection-keys.txt => protection-keys.rst} (83%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index e06b5c0ea883..576628b121cc 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -18,3 +18,4 @@ Linux x86 Support
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

