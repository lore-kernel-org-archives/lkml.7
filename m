Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B26AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 422F8216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAqObh3U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbfEHPXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:23:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36458 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfEHPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:23:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so2598274plr.3;
        Wed, 08 May 2019 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sp5SvL0P5lrU86BpXk5nK8V2Shd1dKoGOnP2voXWJNg=;
        b=LAqObh3USvaQiCtnjT656rhX5lk6JzCgZPIeVCfUSa1gGZoEUC10hHrUFLbRkM7Wgu
         KagKe3n5UPaZJTfJvXCZ4TWZPIdvlcvJB5TTbDpj5FJUfY+3ML+fVWr+DN9IRuXi98Wg
         GXflDkncl8XGkoaS0MnBnIlZt53CwWpVgVfJtJuqiOkqsbyAnXP4IKd+ydGv2I2xDDdA
         jW5dJYF4Gy+o9+GKmgcgNSa94bRm8O77B8BottxarA+oetOrQ4iIflMGmtJE3FE9+7fp
         9ZzEOvs4G/O/7QyA0JBWgcl7N6WtIA5ynLHJPSViXOFchaqiGYIBgmZN93OjowTUC9Ms
         5FsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sp5SvL0P5lrU86BpXk5nK8V2Shd1dKoGOnP2voXWJNg=;
        b=g5LPn0iUkDVtUI5wN9EJLpXdZFpZUW6BUG5dSp7IZXk0N3ci4EJ6VhlFu0ssIIoFmE
         btlWNrcOQuKf4Vfgd037WqDX+WBAQiSLTJI2SrlgaF8MqGkUz9/vDA7blOCgmkAvMjrT
         9R/4soNpAAm47Wzm60cOYoDnU/QhC2/NaBO4bBvpG9meXNrj18YQ8jTV0IAB1ie9He4Q
         X2rUX/Wcf5xFaH6iFdlOdHHtPtF6YPz5YGqUbr34Q+IikWwdLNCQY54idIa47lBiMT49
         IOWwwrIbQHjt7u/bKj+dpXyVlbqU/61RzCX22SdmDvm52tfnsJzOuBFZdfHKnZhez/Ys
         l+ww==
X-Gm-Message-State: APjAAAVce9C8OBMzjIfhNGyf6EhuMXQWTgFh6nNJZEBbnY3igYPL098w
        PsDoKsLDZmapSGQhhR70VVw=
X-Google-Smtp-Source: APXvYqwD1/5OgGHvTkDjDP4iRGRw4GyJ01/O+ox45pjM3YWmHbSoT5E1B7pSoh+YUKl5+qK+iP1ruA==
X-Received: by 2002:a17:902:4283:: with SMTP id h3mr46902969pld.176.1557328996711;
        Wed, 08 May 2019 08:23:16 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.23.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:23:16 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 12/27] Documentation: x86: convert protection-keys.txt to reST
Date:   Wed,  8 May 2019 23:21:26 +0800
Message-Id: <20190508152141.8740-13-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508152141.8740-1-changbin.du@gmail.com>
References: <20190508152141.8740-1-changbin.du@gmail.com>
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

