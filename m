Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3C7C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C9321530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st8op78A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfEHPW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:22:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46185 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfEHPW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:22:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id t187so6141594pgb.13;
        Wed, 08 May 2019 08:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fT6fKUDneaQnm0YoLlzMM+7vctBScZZAX5mgwPkTNso=;
        b=st8op78A7N8xYkIxzDSyrbj5D1toIGQ3DMGMFn2cNiswE5jYxIWW1nI7g4A7+pHomS
         0LxbSDRRinMl6tAx1Fg6DEi0PfD2h90l0n1UAvYadcRasYOpPzxWGIJAXYbmql++e+IZ
         uBHtcpXBug3EZHQwUFjODIpk1GSZIFjfpJ3bATwUCwEE/iwerEcaa2s3om9ci2emT+Js
         fl3BU3fsYMVwSqKJnmrI0P3qn7VgmwUQfsWL92EtS4fI5DYLh8v9TCT1XK+m0NWubdNt
         +uHYj3RLUzrzjnRjh1kYOLAV3mMvjFSEmS8oGgleHr/hasweoZvAwyJ3a2E1nWIx/cc3
         R+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fT6fKUDneaQnm0YoLlzMM+7vctBScZZAX5mgwPkTNso=;
        b=Fdn7DCKHLY5+hVEVMJvtKaaOz7+XaYbn66M1O4NKutoo1THxctglQZqc0tSR3pb3a8
         Fi8Wkey79tjzKUbcG0tOuHXiKJJ8VmblzPKFQMWE3rtiN3lp2ZzWzNdrW1xCGwuHkx+C
         7x5lMJ/6dE1LjmaNQITbYnF7q5n08zBOwq/rLVSkkr8z1oL+ZaRdX+y7zBpFTEvvY8ER
         57cxYc2lfYs7wpVbqWdzVi1bIFcQxWM20xr8wq+CfQTJzR0kT0e3hor0Ib59DP6ALJoO
         zKXA7AN5f4Hj4HoWjxFg78r8drLEa7ABUP4U9D0XxQIzG9i4kR105mkg28fJ6KFb8xHX
         leTQ==
X-Gm-Message-State: APjAAAVmFMfF58T3FGsz0UHZusy4n68dq47lda8JHOCmGaDZvAudKhKp
        GjEpjVcbZwwoAnY5xam9EOY=
X-Google-Smtp-Source: APXvYqxQorGRjPGbAFXZDi6dsRkSVhtKheOV6m+5xiT2+h4H5NfEWVXcj0XjUV3marmgCLdhV3jqqg==
X-Received: by 2002:a63:564f:: with SMTP id g15mr48187621pgm.258.1557328976834;
        Wed, 08 May 2019 08:22:56 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.22.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:22:56 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 09/27] Documentation: x86: convert tlb.txt to reST
Date:   Wed,  8 May 2019 23:21:23 +0800
Message-Id: <20190508152141.8740-10-changbin.du@gmail.com>
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
 Documentation/x86/index.rst            |  1 +
 Documentation/x86/{tlb.txt => tlb.rst} | 30 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 11 deletions(-)
 rename Documentation/x86/{tlb.txt => tlb.rst} (81%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index e43aa9b31976..c4ea25350221 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -15,3 +15,4 @@ x86-specific Documentation
    entry_64
    earlyprintk
    zero-page
+   tlb
diff --git a/Documentation/x86/tlb.txt b/Documentation/x86/tlb.rst
similarity index 81%
rename from Documentation/x86/tlb.txt
rename to Documentation/x86/tlb.rst
index 6a0607b99ed8..82ec58ae63a8 100644
--- a/Documentation/x86/tlb.txt
+++ b/Documentation/x86/tlb.rst
@@ -1,5 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======
+The TLB
+=======
+
 When the kernel unmaps or modified the attributes of a range of
 memory, it has two choices:
+
  1. Flush the entire TLB with a two-instruction sequence.  This is
     a quick operation, but it causes collateral damage: TLB entries
     from areas other than the one we are trying to flush will be
@@ -10,6 +17,7 @@ memory, it has two choices:
     damage to other TLB entries.
 
 Which method to do depends on a few things:
+
  1. The size of the flush being performed.  A flush of the entire
     address space is obviously better performed by flushing the
     entire TLB than doing 2^48/PAGE_SIZE individual flushes.
@@ -33,7 +41,7 @@ well.  There is essentially no "right" point to choose.
 You may be doing too many individual invalidations if you see the
 invlpg instruction (or instructions _near_ it) show up high in
 profiles.  If you believe that individual invalidations being
-called too often, you can lower the tunable:
+called too often, you can lower the tunable::
 
 	/sys/kernel/debug/x86/tlb_single_page_flush_ceiling
 
@@ -43,7 +51,7 @@ Setting it to 1 is a very conservative setting and it should
 never need to be 0 under normal circumstances.
 
 Despite the fact that a single individual flush on x86 is
-guaranteed to flush a full 2MB [1], hugetlbfs always uses the full
+guaranteed to flush a full 2MB [1]_, hugetlbfs always uses the full
 flushes.  THP is treated exactly the same as normal memory.
 
 You might see invlpg inside of flush_tlb_mm_range() show up in
@@ -54,15 +62,15 @@ Essentially, you are balancing the cycles you spend doing invlpg
 with the cycles that you spend refilling the TLB later.
 
 You can measure how expensive TLB refills are by using
-performance counters and 'perf stat', like this:
+performance counters and 'perf stat', like this::
 
-perf stat -e
-	cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
-	cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
-	cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
-	cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,
-	cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,
-	cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/
+  perf stat -e
+    cpu/event=0x8,umask=0x84,name=dtlb_load_misses_walk_duration/,
+    cpu/event=0x8,umask=0x82,name=dtlb_load_misses_walk_completed/,
+    cpu/event=0x49,umask=0x4,name=dtlb_store_misses_walk_duration/,
+    cpu/event=0x49,umask=0x2,name=dtlb_store_misses_walk_completed/,
+    cpu/event=0x85,umask=0x4,name=itlb_misses_walk_duration/,
+    cpu/event=0x85,umask=0x2,name=itlb_misses_walk_completed/
 
 That works on an IvyBridge-era CPU (i5-3320M).  Different CPUs
 may have differently-named counters, but they should at least
@@ -70,6 +78,6 @@ be there in some form.  You can use pmu-tools 'ocperf list'
 (https://github.com/andikleen/pmu-tools) to find the right
 counters for a given CPU.
 
-1. A footnote in Intel's SDM "4.10.4.2 Recommended Invalidation"
+.. [1] A footnote in Intel's SDM "4.10.4.2 Recommended Invalidation"
    says: "One execution of INVLPG is sufficient even for a page
    with size greater than 4 KBytes."
-- 
2.20.1

