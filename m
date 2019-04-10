Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE411C10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B698B21741
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfDJBzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:55:46 -0400
Received: from mga02.intel.com ([134.134.136.20]:19659 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfDJBzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:55:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 18:55:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,331,1549958400"; 
   d="scan'208";a="141425152"
Received: from aubrey-lkp.sh.intel.com ([10.239.97.113])
  by orsmga003.jf.intel.com with ESMTP; 09 Apr 2019 18:55:40 -0700
From:   Aubrey Li <aubrey.li@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com
Cc:     ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, aubrey.li@intel.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH v14 3/3] Documentation/filesystems/proc.txt: add AVX512_elapsed_ms
Date:   Wed, 10 Apr 2019 09:53:25 +0800
Message-Id: <20190410015326.24500-3-aubrey.li@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190410015326.24500-1-aubrey.li@linux.intel.com>
References: <20190410015326.24500-1-aubrey.li@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added AVX512_elapsed_ms in /proc/<pid>/status. Report it
in Documentation/filesystems/proc.txt

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Linux API <linux-api@vger.kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/filesystems/proc.txt | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 66cad5c86171..c4a9e48681ad 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -207,6 +207,7 @@ read the file /proc/PID/status:
   Speculation_Store_Bypass:       thread vulnerable
   voluntary_ctxt_switches:        0
   nonvoluntary_ctxt_switches:     1
+  AVX512_elapsed_ms:	8
 
 This shows you nearly the same information you would get if you viewed it with
 the ps  command.  In  fact,  ps  uses  the  proc  file  system  to  obtain its
@@ -224,7 +225,7 @@ asynchronous manner and the value may not be very precise. To see a precise
 snapshot of a moment, you can see /proc/<pid>/smaps file and scan page table.
 It's slow but very precise.
 
-Table 1-2: Contents of the status files (as of 4.19)
+Table 1-2: Contents of the status files (as of 5.1)
 ..............................................................................
  Field                       Content
  Name                        filename of the executable
@@ -289,6 +290,32 @@ Table 1-2: Contents of the status files (as of 4.19)
  Mems_allowed_list           Same as previous, but in "list format"
  voluntary_ctxt_switches     number of voluntary context switches
  nonvoluntary_ctxt_switches  number of non voluntary context switches
+ AVX512_elapsed_ms           time elapsed since last AVX512 usage recorded
+
+ AVX512_elapsed_ms:
+ ------------------
+  If AVX512 is supported on the machine, this entry shows the milliseconds
+  elapsed since the last time AVX512 usage was recorded. The recording
+  happens on a best effort basis when a task is scheduled out. This means
+  that the value depends on two factors:
+
+    1) The time which the task spent on the CPU without being scheduled
+       out. With CPU isolation and a single runnable task this can take
+       several seconds.
+
+    2) The time since the task was scheduled out last. Depending on the
+       reason for being scheduled out (time slice exhausted, syscall ...)
+       this can be arbitrary long time.
+
+  As a consequence the value cannot be considered precise and authoritative
+  information. The application which uses this information has to be aware
+  of the overall scenario on the system in order to determine whether a
+  task is a real AVX512 user or not.
+
+  A special value of '-1' indicates that no AVX512 usage was recorded, thus
+  the task is unlikely an AVX512 user, but depends on the workload and the
+  scheduling scenario, it also could be a false negative mentioned above.
+
 ..............................................................................
 
 Table 1-3: Contents of the statm files (as of 2.6.8-rc3)
-- 
2.21.0

