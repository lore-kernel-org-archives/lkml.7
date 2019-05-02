Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD10EC04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 636D22085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bNV5jQ1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfEBHKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:10:02 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46434 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfEBHKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:10:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi2so588348plb.13;
        Thu, 02 May 2019 00:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9msnyORFFYmozAX39JVjDSLX0uUa60YbLxatdZe/jc=;
        b=bNV5jQ1rG6gyDNGF+io0LksDhOFiBxdlZw4MjynqcFJJnIVZk7QyqcTKbVCc84ud6X
         0QC02lRusITqGkN0JaRcO13E2YIo5c7wZFJbg6dIj0/XZ9dYPxMdmbV1ZD/qlXtC76QL
         jr8NwlMmggmLUgBHStAicL6lnf3hTHITw4PQq6tT3AgG+UtsgBzcxzbRqPTo+LqxYoJ0
         u9E64WJY1fmQW3B7XQyrUHG/wH1BQO8lUMOgaehyNaCMEsN0bg3D3Oo49RUad0vUD6oP
         GTCALOekgGmx/t/MrNtJNtpA1kmrdpIU6Xm34HzTNvl7UV2oMKjsdn6PlCtfn+4tX5JU
         oTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9msnyORFFYmozAX39JVjDSLX0uUa60YbLxatdZe/jc=;
        b=E5d9gJkGja8QIVjD3TZqJNutDUMsmkVJL8dP9Om29mrhnPma5uelHfRdwLTeE8eYVb
         XIT2Qq2wlobMjPBf1NhEQWEuILSnjDlUOzRV3Il0NTLgP9GOHG6d+6e2F68PPnm0+puO
         oVbFDkcB40ByO9sCF5+rqOUbltkbY5epABe7CQa8/l1vN/2/mpL05/vMpDGN4lCHvBUl
         QKtSGjtSnZtF+2zcZgW5tE3+PLwn3j2TFQ0Yqp3pf+USjRs/1BFiCtJe7Vle7Zxjz3tY
         3WwcSUxwSwjDqstAiJ6nILZkKjcorQLaJizZ5pXiRbYLimstfX16aY+KxJOHkldQ1v/B
         xdLw==
X-Gm-Message-State: APjAAAUVSDhxfCE9F5i8elZR4T3kGxJsXwE7vbEe/yxYuHeDvPJjUVvv
        XJ61CmV4kNZ/CZbI9whAsX4=
X-Google-Smtp-Source: APXvYqyMufBgv2/ambD86pdzz9WgcIqXYY5fR/2MaGEl16egDxpKMExM92utUZD4150oXp4zkZYyMg==
X-Received: by 2002:a17:902:1105:: with SMTP id d5mr2093720pla.311.1556780999720;
        Thu, 02 May 2019 00:09:59 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:09:58 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 03/27] Documentation: x86: convert topology.txt to reST
Date:   Thu,  2 May 2019 15:06:09 +0800
Message-Id: <20190502070633.9809-4-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502070633.9809-1-changbin.du@gmail.com>
References: <20190502070633.9809-1-changbin.du@gmail.com>
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
 .../x86/{topology.txt => topology.rst}        | 92 ++++++++++---------
 2 files changed, 49 insertions(+), 44 deletions(-)
 rename Documentation/x86/{topology.txt => topology.rst} (74%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index d7fc8efac192..da89bf0ad69f 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -9,3 +9,4 @@ x86-specific Documentation
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

