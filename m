Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1142EC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B62206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJhmMUqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbfEFRKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:10:54 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42124 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfEFRKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:10:53 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so6751287pgh.9;
        Mon, 06 May 2019 10:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20I5PYxwGLsYlJSdyFGi1cZfbWK6zgDlYzj35GGoIoM=;
        b=YJhmMUqD9ELglDbyTLFk8jRFZGQLU/h0u/pr24cPHW114592nbAcM+Mgx4YpNyHUSF
         qRc8LGkULEEpAWA0wm4I5zfETaeKN5BjOFMZrRjwvqr5cnzgpbmyPRkTHhd5pjEJCVhc
         vHyxcJqMvDOIVo7rqcbvjpVAdTknZXa0/KeM8lqO+/imwe/cRDks3RruauqmZeIERIng
         9bUGZLyfhwDFBVtCTVXbyAHGuB5+1xWAicMWU3eWXKYsEF1K8H4H6n/aOAkIe0hfjtJ8
         A/v38eqHcqOF6NJu701v8f/q3uUvqDNLR37eJfJjmj/jGZ9pqXry6BZ9l6/9BEa9RIlS
         C0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20I5PYxwGLsYlJSdyFGi1cZfbWK6zgDlYzj35GGoIoM=;
        b=CY5HlAkdCfug7mmgjWNKrk4ptzJcOQ18rHxKI7EoADqYt69nDPV7V5/DgPq4HCHZIa
         FhsGPvlJwSGEYYop3c4xwYj2me8q1q6JD+im3PmlGxQhBNbPVbqB+6M8cTU6Xly9dKy4
         i3oZrYVhw7MZldxbnWANz1MXzzM28gKE7IrqheiFnLtOepIVdDQXR3L74DiYU7zuRVY6
         UHc6nucj7vjjHY9AcTQa8JoosY47kI54JUBIpw41mUIdROvoHLuauoef63RYT0kUZVeN
         wA0cZL74V9JAx8otZnWcWlQo02cRR6s/txSBU/q/NQgN7ISof20LgDsH9EdZTakqBvVI
         I+Tg==
X-Gm-Message-State: APjAAAXl95E+U2FweoBfH9H3fN+B7PaV9XZLyLpWfyqmxtE8J1PS+5xv
        xfoVG5zPpW1HTu4lubXtJ5muNunt
X-Google-Smtp-Source: APXvYqyw27HduQq8oiNBfKzYZ1A9xvMbnfrd6zqpxK4dOECFtHkyJs3eq9EQIufyXj1Gt85bZifQzg==
X-Received: by 2002:a63:d347:: with SMTP id u7mr33642944pgi.254.1557162652450;
        Mon, 06 May 2019 10:10:52 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.10.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:10:51 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 13/27] Documentation: x86: convert intel_mpx.txt to reST
Date:   Tue,  7 May 2019 01:09:09 +0800
Message-Id: <20190506170923.7117-14-changbin.du@gmail.com>
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
 Documentation/x86/index.rst                   |   1 +
 .../x86/{intel_mpx.txt => intel_mpx.rst}      | 120 ++++++++++--------
 2 files changed, 65 insertions(+), 56 deletions(-)
 rename Documentation/x86/{intel_mpx.txt => intel_mpx.rst} (75%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index e2c0db9fcd4e..b5cdc0d889b3 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -19,3 +19,4 @@ x86-specific Documentation
    mtrr
    pat
    protection-keys
+   intel_mpx
diff --git a/Documentation/x86/intel_mpx.txt b/Documentation/x86/intel_mpx.rst
similarity index 75%
rename from Documentation/x86/intel_mpx.txt
rename to Documentation/x86/intel_mpx.rst
index 85d0549ad846..387a640941a6 100644
--- a/Documentation/x86/intel_mpx.txt
+++ b/Documentation/x86/intel_mpx.rst
@@ -1,5 +1,11 @@
-1. Intel(R) MPX Overview
-========================
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================
+Intel(R) Memory Protection Extensions (MPX)
+===========================================
+
+Intel(R) MPX Overview
+=====================
 
 Intel(R) Memory Protection Extensions (Intel(R) MPX) is a new capability
 introduced into Intel Architecture. Intel MPX provides hardware features
@@ -7,7 +13,7 @@ that can be used in conjunction with compiler changes to check memory
 references, for those references whose compile-time normal intentions are
 usurped at runtime due to buffer overflow or underflow.
 
-You can tell if your CPU supports MPX by looking in /proc/cpuinfo:
+You can tell if your CPU supports MPX by looking in /proc/cpuinfo::
 
 	cat /proc/cpuinfo  | grep ' mpx '
 
@@ -21,8 +27,8 @@ can be downloaded from
 http://software.intel.com/en-us/articles/intel-software-development-emulator
 
 
-2. How to get the advantage of MPX
-==================================
+How to get the advantage of MPX
+===============================
 
 For MPX to work, changes are required in the kernel, binutils and compiler.
 No source changes are required for applications, just a recompile.
@@ -84,14 +90,15 @@ Kernel MPX Code:
    is unmapped.
 
 
-3. How does MPX kernel code work
-================================
+How does MPX kernel code work
+=============================
 
 Handling #BR faults caused by MPX
 ---------------------------------
 
 When MPX is enabled, there are 2 new situations that can generate
 #BR faults.
+
   * new bounds tables (BT) need to be allocated to save bounds.
   * bounds violation caused by MPX instructions.
 
@@ -124,37 +131,37 @@ the kernel. It can theoretically be done completely from userspace. Here
 are a few ways this could be done. We don't think any of them are practical
 in the real-world, but here they are.
 
-Q: Can virtual space simply be reserved for the bounds tables so that we
-   never have to allocate them?
-A: MPX-enabled application will possibly create a lot of bounds tables in
-   process address space to save bounds information. These tables can take
-   up huge swaths of memory (as much as 80% of the memory on the system)
-   even if we clean them up aggressively. In the worst-case scenario, the
-   tables can be 4x the size of the data structure being tracked. IOW, a
-   1-page structure can require 4 bounds-table pages. An X-GB virtual
-   area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
-   If we were to preallocate them for the 128TB of user virtual address
-   space, we would need to reserve 512TB+2GB, which is larger than the
-   entire virtual address space today. This means they can not be reserved
-   ahead of time. Also, a single process's pre-populated bounds directory
-   consumes 2GB of virtual *AND* physical memory. IOW, it's completely
-   infeasible to prepopulate bounds directories.
-
-Q: Can we preallocate bounds table space at the same time memory is
-   allocated which might contain pointers that might eventually need
-   bounds tables?
-A: This would work if we could hook the site of each and every memory
-   allocation syscall. This can be done for small, constrained applications.
-   But, it isn't practical at a larger scale since a given app has no
-   way of controlling how all the parts of the app might allocate memory
-   (think libraries). The kernel is really the only place to intercept
-   these calls.
-
-Q: Could a bounds fault be handed to userspace and the tables allocated
-   there in a signal handler instead of in the kernel?
-A: mmap() is not on the list of safe async handler functions and even
-   if mmap() would work it still requires locking or nasty tricks to
-   keep track of the allocation state there.
+:Q: Can virtual space simply be reserved for the bounds tables so that we
+    never have to allocate them?
+:A: MPX-enabled application will possibly create a lot of bounds tables in
+    process address space to save bounds information. These tables can take
+    up huge swaths of memory (as much as 80% of the memory on the system)
+    even if we clean them up aggressively. In the worst-case scenario, the
+    tables can be 4x the size of the data structure being tracked. IOW, a
+    1-page structure can require 4 bounds-table pages. An X-GB virtual
+    area needs 4*X GB of virtual space, plus 2GB for the bounds directory.
+    If we were to preallocate them for the 128TB of user virtual address
+    space, we would need to reserve 512TB+2GB, which is larger than the
+    entire virtual address space today. This means they can not be reserved
+    ahead of time. Also, a single process's pre-populated bounds directory
+    consumes 2GB of virtual *AND* physical memory. IOW, it's completely
+    infeasible to prepopulate bounds directories.
+
+:Q: Can we preallocate bounds table space at the same time memory is
+    allocated which might contain pointers that might eventually need
+    bounds tables?
+:A: This would work if we could hook the site of each and every memory
+    allocation syscall. This can be done for small, constrained applications.
+    But, it isn't practical at a larger scale since a given app has no
+    way of controlling how all the parts of the app might allocate memory
+    (think libraries). The kernel is really the only place to intercept
+    these calls.
+
+:Q: Could a bounds fault be handed to userspace and the tables allocated
+    there in a signal handler instead of in the kernel?
+:A: mmap() is not on the list of safe async handler functions and even
+    if mmap() would work it still requires locking or nasty tricks to
+    keep track of the allocation state there.
 
 Having ruled out all of the userspace-only approaches for managing
 bounds tables that we could think of, we create them on demand in
@@ -167,20 +174,20 @@ If a #BR is generated due to a bounds violation caused by MPX.
 We need to decode MPX instructions to get violation address and
 set this address into extended struct siginfo.
 
-The _sigfault field of struct siginfo is extended as follow:
-
-87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
-88		struct {
-89			void __user *_addr; /* faulting insn/memory ref. */
-90 #ifdef __ARCH_SI_TRAPNO
-91			int _trapno;	/* TRAP # which caused the signal */
-92 #endif
-93			short _addr_lsb; /* LSB of the reported address */
-94			struct {
-95				void __user *_lower;
-96				void __user *_upper;
-97			} _addr_bnd;
-98		} _sigfault;
+The _sigfault field of struct siginfo is extended as follow::
+
+  87		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+  88		struct {
+  89			void __user *_addr; /* faulting insn/memory ref. */
+  90 #ifdef __ARCH_SI_TRAPNO
+  91			int _trapno;	/* TRAP # which caused the signal */
+  92 #endif
+  93			short _addr_lsb; /* LSB of the reported address */
+  94			struct {
+  95				void __user *_lower;
+  96				void __user *_upper;
+  97			} _addr_bnd;
+  98		} _sigfault;
 
 The '_addr' field refers to violation address, and new '_addr_and'
 field refers to the upper/lower bounds when a #BR is caused.
@@ -209,9 +216,10 @@ Adding new prctl commands
 
 Two new prctl commands are added to enable and disable MPX bounds tables
 management in kernel.
+::
 
-155	#define PR_MPX_ENABLE_MANAGEMENT	43
-156	#define PR_MPX_DISABLE_MANAGEMENT	44
+  155	#define PR_MPX_ENABLE_MANAGEMENT	43
+  156	#define PR_MPX_DISABLE_MANAGEMENT	44
 
 Runtime library in userspace is responsible for allocation of bounds
 directory. So kernel have to use XSAVE instruction to get the base
@@ -223,8 +231,8 @@ into struct mm_struct to be used in future during PR_MPX_ENABLE_MANAGEMENT
 command execution.
 
 
-4. Special rules
-================
+Special rules
+=============
 
 1) If userspace is requesting help from the kernel to do the management
 of bounds tables, it may not create or modify entries in the bounds directory.
-- 
2.20.1

