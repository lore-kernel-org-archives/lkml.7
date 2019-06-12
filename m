Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AFAC31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE8821019
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440145AbfFLPxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:53:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46846 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409452AbfFLPxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:53:15 -0400
Received: from turingmachine.home (unknown [IPv6:2804:431:d719:d9b5:d711:794d:1c68:5ed3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tonyk)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 0E7D52808F4;
        Wed, 12 Jun 2019 16:53:10 +0100 (BST)
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        kernel@collabora.com, akpm@linux-foundation.org,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 2/2] docs: kmemleak: add more documentation details
Date:   Wed, 12 Jun 2019 12:52:31 -0300
Message-Id: <20190612155231.19448-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190612155231.19448-1-andrealmeid@collabora.com>
References: <20190612155231.19448-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wikipedia now has a main article to "tracing garbage collector" topic.
Change the URL and use the reStructuredText syntax for hyperlinks and add
more details about the use of the tool. Add a section about how to use
the kmemleak-test module to test the memory leak scanning.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
Changes in v2: none

 Documentation/dev-tools/kmemleak.rst | 48 +++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index e6f51260ff32..3621cd5e1eef 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -2,8 +2,8 @@ Kernel Memory Leak Detector
 ===========================
 
 Kmemleak provides a way of detecting possible kernel memory leaks in a
-way similar to a tracing garbage collector
-(https://en.wikipedia.org/wiki/Garbage_collection_%28computer_science%29#Tracing_garbage_collectors),
+way similar to a `tracing garbage collector
+<https://en.wikipedia.org/wiki/Tracing_garbage_collection>`_,
 with the difference that the orphan objects are not freed but only
 reported via /sys/kernel/debug/kmemleak. A similar method is used by the
 Valgrind tool (``memcheck --leak-check``) to detect the memory leaks in
@@ -15,10 +15,13 @@ Usage
 
 CONFIG_DEBUG_KMEMLEAK in "Kernel hacking" has to be enabled. A kernel
 thread scans the memory every 10 minutes (by default) and prints the
-number of new unreferenced objects found. To display the details of all
-the possible memory leaks::
+number of new unreferenced objects found. If the ``debugfs`` isn't already
+mounted, mount with::
 
   # mount -t debugfs nodev /sys/kernel/debug/
+
+To display the details of all the possible scanned memory leaks::
+
   # cat /sys/kernel/debug/kmemleak
 
 To trigger an intermediate memory scan::
@@ -72,6 +75,9 @@ If CONFIG_DEBUG_KMEMLEAK_DEFAULT_OFF are enabled, the kmemleak is
 disabled by default. Passing ``kmemleak=on`` on the kernel command
 line enables the function. 
 
+If you are getting errors like "Error while writing to stdout" or "write_loop:
+Invalid argument", make sure kmemleak is properly enabled.
+
 Basic Algorithm
 ---------------
 
@@ -218,3 +224,37 @@ the pointer is calculated by other methods than the usual container_of
 macro or the pointer is stored in a location not scanned by kmemleak.
 
 Page allocations and ioremap are not tracked.
+
+Testing with kmemleak-test
+--------------------------
+
+To check if you have all set up to use kmemleak, you can use the kmemleak-test
+module, a module that deliberately leaks memory. Set CONFIG_DEBUG_KMEMLEAK_TEST
+as module (it can't be used as bult-in) and boot the kernel with kmemleak
+enabled. Load the module and perform a scan with::
+
+        # modprobe kmemleak-test
+        # echo scan > /sys/kernel/debug/kmemleak
+
+Note that the you may not get results instantly or on the first scanning. When
+kmemleak gets results, it'll log ``kmemleak: <count of leaks> new suspected
+memory leaks``. Then read the file to see then::
+
+        # cat /sys/kernel/debug/kmemleak
+        unreferenced object 0xffff89862ca702e8 (size 32):
+          comm "modprobe", pid 2088, jiffies 4294680594 (age 375.486s)
+          hex dump (first 32 bytes):
+            6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
+            6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b a5  kkkkkkkkkkkkkkk.
+          backtrace:
+            [<00000000e0a73ec7>] 0xffffffffc01d2036
+            [<000000000c5d2a46>] do_one_initcall+0x41/0x1df
+            [<0000000046db7e0a>] do_init_module+0x55/0x200
+            [<00000000542b9814>] load_module+0x203c/0x2480
+            [<00000000c2850256>] __do_sys_finit_module+0xba/0xe0
+            [<000000006564e7ef>] do_syscall_64+0x43/0x110
+            [<000000007c873fa6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
+        ...
+
+Removing the module with ``rmmod kmemleak_test`` should also trigger some
+kmemleak results.
-- 
2.22.0

