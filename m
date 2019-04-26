Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA13C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0FA6214AE
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r//mM3eN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfDZPcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:32:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35295 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfDZPcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:32:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id t21so1911303pfh.2;
        Fri, 26 Apr 2019 08:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5jjkiJL4nDuKZfOxFqwF/ZDYwX10t+hM0cHd7uXaRQI=;
        b=r//mM3eNoI0HGUGbY/RGurxgpi5itmCIRB6bsDZ2oUnu4HBYbk6VNPbRDI482JKI9p
         GJDeWAfZ18N9nhQ3mXXgx3ErVxgzVMAC0+KI4N4/l5MTvstZWQnhSHKa3x4ShXSonWWr
         EBj00+q9pEmTYnwCc25IjzNxjBNtQHTbzERfnWXODMOPWK3USN3Q+749zrJ9MQOJ/la5
         j0CEgRHhGQnSR59x/Jg+F6jLNefGfBiuQGvHHzsaKSNQgvOdto7hWDGMC697e4cSv3TT
         XngL5z8cHWG12V/PwU06hHpWhiROXzPHPYvREM6mgb+7A8PCOIWkg4UHBprR1KGDSOW5
         6mYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5jjkiJL4nDuKZfOxFqwF/ZDYwX10t+hM0cHd7uXaRQI=;
        b=lwDXDwWwLZpd5I4ozjHpSHcOF2KK3nfRSzE0Tzv02dsctGalbl+2XL9U3vBhq3rwxY
         7aObi5MeRHW1HlfACpel51yBVzV8xlMdnvZZipZHTq3wysquvEv3viCyjIpNRFFEwz9M
         +8nUaT9WHSJ96wSCXue92byNDHymgkYZQt6JMuoom3O7JDfCWtBIigHjsQhvccLnqHz8
         uyj9qKT0ADotYGaqHNkD9A7aKFEsQ/dGTBAOtAblD4Favs0AuIpWRehlFsMUQEUqlO+R
         QPLsIvECvLxI4evsaiqoaPPjqMvcroTOBFyxQ/OzVeD5TanGVDysDaIR0jW4/Kk0+x/n
         l+OA==
X-Gm-Message-State: APjAAAUTFUJfDq/w9fIGcxSl2A6AmN9wOSHTvZP6dSPkzceKcYm+770Z
        mlz3+BHEx26+vZstcjwq49s=
X-Google-Smtp-Source: APXvYqwWETsJgGqSGuuZc7pJ+zfgvNP+iVEeX2WuhU66LJoEbg1FEj5pLgqX+4akmY98VEKsTuNFEw==
X-Received: by 2002:a65:6644:: with SMTP id z4mr11895423pgv.300.1556292750609;
        Fri, 26 Apr 2019 08:32:30 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:32:29 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 03/27] Documentation: x86: convert topology.txt to reST
Date:   Fri, 26 Apr 2019 23:31:26 +0800
Message-Id: <20190426153150.21228-4-changbin.du@gmail.com>
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
 .../x86/{topology.txt => topology.rst}        | 92 ++++++++++---------
 2 files changed, 49 insertions(+), 44 deletions(-)
 rename Documentation/x86/{topology.txt => topology.rst} (74%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 8f08caf4fbbb..2033791e53bc 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -9,3 +9,4 @@ Linux x86 Support
    :numbered:
 
    boot
+   topology
diff --git a/Documentation/x86/topology.txt b/Documentation/x86/topology.rst
similarity index 74%
rename from Documentation/x86/topology.txt
rename to Documentation/x86/topology.rst
index 2953e3ec9a02..5176e5315faa 100644
--- a/Documentation/x86/topology.txt
+++ b/Documentation/x86/topology.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
 x86 Topology
 ============
 
@@ -33,14 +36,14 @@ The topology of a system is described in the units of:
     - cores
     - threads
 
-* Package:
-
-  Packages contain a number of cores plus shared resources, e.g. DRAM
-  controller, shared caches etc.
+Package
+=======
+Packages contain a number of cores plus shared resources, e.g. DRAM
+controller, shared caches etc.
 
-  AMD nomenclature for package is 'Node'.
+AMD nomenclature for package is 'Node'.
 
-  Package-related topology information in the kernel:
+Package-related topology information in the kernel:
 
   - cpuinfo_x86.x86_max_cores:
 
@@ -66,40 +69,41 @@ The topology of a system is described in the units of:
   - cpu_llc_id:
 
     A per-CPU variable containing:
-    - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
-    Cache
 
-    - On AMD, the Node ID or Core Complex ID containing the Last Level
-    Cache. In general, it is a number identifying an LLC uniquely on the
-    system.
+      - On Intel, the first APIC ID of the list of CPUs sharing the Last Level
+        Cache
 
-* Cores:
+      - On AMD, the Node ID or Core Complex ID containing the Last Level
+        Cache. In general, it is a number identifying an LLC uniquely on the
+        system.
 
-  A core consists of 1 or more threads. It does not matter whether the threads
-  are SMT- or CMT-type threads.
+Cores
+=====
+A core consists of 1 or more threads. It does not matter whether the threads
+are SMT- or CMT-type threads.
 
-  AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
-  "core".
+AMDs nomenclature for a CMT core is "Compute Unit". The kernel always uses
+"core".
 
-  Core-related topology information in the kernel:
+Core-related topology information in the kernel:
 
   - smp_num_siblings:
 
     The number of threads in a core. The number of threads in a package can be
-    calculated by:
+    calculated by::
 
 	threads_per_package = cpuinfo_x86.x86_max_cores * smp_num_siblings
 
 
-* Threads:
+Threads
+=======
+A thread is a single scheduling unit. It's the equivalent to a logical Linux
+CPU.
 
-  A thread is a single scheduling unit. It's the equivalent to a logical Linux
-  CPU.
+AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
+uses "thread".
 
-  AMDs nomenclature for CMT threads is "Compute Unit Core". The kernel always
-  uses "thread".
-
-  Thread-related topology information in the kernel:
+Thread-related topology information in the kernel:
 
   - topology_core_cpumask():
 
@@ -113,15 +117,15 @@ The topology of a system is described in the units of:
     The cpumask contains all online threads in the core to which a thread
     belongs.
 
-   - topology_logical_package_id():
+  - topology_logical_package_id():
 
     The logical package ID to which a thread belongs.
 
-   - topology_physical_package_id():
+  - topology_physical_package_id():
 
     The physical package ID to which a thread belongs.
 
-   - topology_core_id();
+  - topology_core_id();
 
     The ID of the core to which a thread belongs. It is also printed in /proc/cpuinfo
     "core_id."
@@ -129,41 +133,41 @@ The topology of a system is described in the units of:
 
 
 System topology examples
+========================
 
-Note:
-
-The alternative Linux CPU enumeration depends on how the BIOS enumerates the
-threads. Many BIOSes enumerate all threads 0 first and then all threads 1.
-That has the "advantage" that the logical Linux CPU numbers of threads 0 stay
-the same whether threads are enabled or not. That's merely an implementation
-detail and has no practical impact.
+.. note::
+  The alternative Linux CPU enumeration depends on how the BIOS enumerates the
+  threads. Many BIOSes enumerate all threads 0 first and then all threads 1.
+  That has the "advantage" that the logical Linux CPU numbers of threads 0 stay
+  the same whether threads are enabled or not. That's merely an implementation
+  detail and has no practical impact.
 
-1) Single Package, Single Core
+1) Single Package, Single Core::
 
    [package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 
 2) Single Package, Dual Core
 
-   a) One thread per core
+   a) One thread per core::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 		    -> [core 1] -> [thread 0] -> Linux CPU 1
 
-   b) Two threads per core
+   b) Two threads per core::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 				-> [thread 1] -> Linux CPU 1
 		    -> [core 1] -> [thread 0] -> Linux CPU 2
 				-> [thread 1] -> Linux CPU 3
 
-      Alternative enumeration:
+      Alternative enumeration::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 				-> [thread 1] -> Linux CPU 2
 		    -> [core 1] -> [thread 0] -> Linux CPU 1
 				-> [thread 1] -> Linux CPU 3
 
-      AMD nomenclature for CMT systems:
+      AMD nomenclature for CMT systems::
 
 	[node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
 				     -> [Compute Unit Core 1] -> Linux CPU 1
@@ -172,7 +176,7 @@ detail and has no practical impact.
 
 4) Dual Package, Dual Core
 
-   a) One thread per core
+   a) One thread per core::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 		    -> [core 1] -> [thread 0] -> Linux CPU 1
@@ -180,7 +184,7 @@ detail and has no practical impact.
 	[package 1] -> [core 0] -> [thread 0] -> Linux CPU 2
 		    -> [core 1] -> [thread 0] -> Linux CPU 3
 
-   b) Two threads per core
+   b) Two threads per core::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 				-> [thread 1] -> Linux CPU 1
@@ -192,7 +196,7 @@ detail and has no practical impact.
 		    -> [core 1] -> [thread 0] -> Linux CPU 6
 				-> [thread 1] -> Linux CPU 7
 
-      Alternative enumeration:
+      Alternative enumeration::
 
 	[package 0] -> [core 0] -> [thread 0] -> Linux CPU 0
 				-> [thread 1] -> Linux CPU 4
@@ -204,7 +208,7 @@ detail and has no practical impact.
 		    -> [core 1] -> [thread 0] -> Linux CPU 3
 				-> [thread 1] -> Linux CPU 7
 
-      AMD nomenclature for CMT systems:
+      AMD nomenclature for CMT systems::
 
 	[node 0] -> [Compute Unit 0] -> [Compute Unit Core 0] -> Linux CPU 0
 				     -> [Compute Unit Core 1] -> Linux CPU 1
-- 
2.20.1

