Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84433C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE287208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGw8HXWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfDZPd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:33:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43558 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbfDZPdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:33:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id z9so1789706pgu.10;
        Fri, 26 Apr 2019 08:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j70G0amKcQXuPLeLIbM+m355FLoVLcQ+hAcLiiC/LxY=;
        b=kGw8HXWb2F2NH0sUZg34ijADRtcQ0PLZVxppWcFNUA9vAVfEAe0TW4iWmeijl8256V
         8+SW5omAYJE5NtPmWY2bd+6bnZO5gSJMy6gOZjqYmY3jPBgae2HODbt1brH+7XqeacJo
         QqxKvOsq6jDVGnM0Dz1fQOn+usUn2qqwExt2R0cQ33bvRR+toN/71u5RrQMYNmI4er4M
         dGss2b9Kvk9e5W5D8p4JsjSG6r2mrMRF6uW59rKAXy07Dld8JxObQ5DN6GqflkSBN+Sr
         PZ90WRnPX9boK2gSL2M6LNSfAabHnYl/IJ3MdcII3t1bB8wx1pS8Pfkuqdvj5eqyrI0i
         MuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j70G0amKcQXuPLeLIbM+m355FLoVLcQ+hAcLiiC/LxY=;
        b=IHp3rsSDPid8c0Mv/lk0yLVCmFQuaMgngosbQrXxnG9dj1KYB86FeNEY6+4lJV0VQt
         6b6uZ6jd5Tskls2IPhQy96kDXMXuW3SXtX/TQ19ZU3d7vM1rgK7yb2R93XIIiYhOmfmf
         3k/OSFiliFLLag8oGotwS1DL729r8zeMM7TJa4ueMIrD0jQKTQGu7bXlRn356X+HUlx9
         FfqbGJeowQ9gZcD/tOnnNr2ez6RfKmOT63wMEnvktK5OfbN9fZ3YHXCUVITyn7PdNKiA
         tnVExgTrpdPkQ9gnji4kzL6nH1+w48AGOHUvfIbeZKCV/wnPUxy/JzpHLojhD73rp0iQ
         8k2w==
X-Gm-Message-State: APjAAAXO9AfqX6oECRyknopt64+tr1iYoUHN02jn9BRrErCBCxNemX7s
        LTf8opEMvtJ51uY2iOwDGGw1wVbe
X-Google-Smtp-Source: APXvYqxFaZ05dHpWKzhv+pnkhWyAjdzHmyuBRkeecHuKP5QCrsVDBvm34X978uhpDCmGebLSIASkrw==
X-Received: by 2002:a63:f012:: with SMTP id k18mr45267952pgh.433.1556292834374;
        Fri, 26 Apr 2019 08:33:54 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:33:53 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 18/27] Documentation: x86: convert orc-unwinder.txt to reST
Date:   Fri, 26 Apr 2019 23:31:41 +0800
Message-Id: <20190426153150.21228-19-changbin.du@gmail.com>
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
 .../{orc-unwinder.txt => orc-unwinder.rst}    | 27 ++++++++++---------
 2 files changed, 16 insertions(+), 12 deletions(-)
 rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (93%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 4e9fa2b046df..c41c17906b6d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -14,6 +14,7 @@ Linux x86 Support
    kernel-stacks
    entry_64
    earlyprintk
+   orc-unwinder
    zero-page
    tlb
    mtrr
diff --git a/Documentation/x86/orc-unwinder.txt b/Documentation/x86/orc-unwinder.rst
similarity index 93%
rename from Documentation/x86/orc-unwinder.txt
rename to Documentation/x86/orc-unwinder.rst
index cd4b29be29af..d811576c1f3e 100644
--- a/Documentation/x86/orc-unwinder.txt
+++ b/Documentation/x86/orc-unwinder.rst
@@ -1,8 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
 ORC unwinder
 ============
 
 Overview
---------
+========
 
 The kernel CONFIG_UNWINDER_ORC option enables the ORC unwinder, which is
 similar in concept to a DWARF unwinder.  The difference is that the
@@ -23,12 +26,12 @@ correlate instruction addresses with their stack states at run time.
 
 
 ORC vs frame pointers
----------------------
+=====================
 
 With frame pointers enabled, GCC adds instrumentation code to every
 function in the kernel.  The kernel's .text size increases by about
 3.2%, resulting in a broad kernel-wide slowdown.  Measurements by Mel
-Gorman [1] have shown a slowdown of 5-10% for some workloads.
+Gorman [1]_ have shown a slowdown of 5-10% for some workloads.
 
 In contrast, the ORC unwinder has no effect on text size or runtime
 performance, because the debuginfo is out of band.  So if you disable
@@ -55,7 +58,7 @@ depending on the kernel config.
 
 
 ORC vs DWARF
-------------
+============
 
 ORC debuginfo's advantage over DWARF itself is that it's much simpler.
 It gets rid of the complex DWARF CFI state machine and also gets rid of
@@ -65,7 +68,7 @@ mission critical oops code.
 
 The simpler debuginfo format also enables the unwinder to be much faster
 than DWARF, which is important for perf and lockdep.  In a basic
-performance test by Jiri Slaby [2], the ORC unwinder was about 20x
+performance test by Jiri Slaby [2]_, the ORC unwinder was about 20x
 faster than an out-of-tree DWARF unwinder.  (Note: That measurement was
 taken before some performance tweaks were added, which doubled
 performance, so the speedup over DWARF may be closer to 40x.)
@@ -85,7 +88,7 @@ still be able to control the format, e.g. no complex state machines.
 
 
 ORC unwind table generation
----------------------------
+===========================
 
 The ORC data is generated by objtool.  With the existing compile-time
 stack metadata validation feature, objtool already follows all code
@@ -133,7 +136,7 @@ objtool follows GCC code quite well.
 
 
 Unwinder implementation details
--------------------------------
+===============================
 
 Objtool generates the ORC data by integrating with the compile-time
 stack metadata validation feature, which is described in detail in
@@ -154,7 +157,7 @@ subset of the table needs to be searched.
 
 
 Etymology
----------
+=========
 
 Orcs, fearsome creatures of medieval folklore, are the Dwarves' natural
 enemies.  Similarly, the ORC unwinder was created in opposition to the
@@ -162,7 +165,7 @@ complexity and slowness of DWARF.
 
 "Although Orcs rarely consider multiple solutions to a problem, they do
 excel at getting things done because they are creatures of action, not
-thought." [3]  Similarly, unlike the esoteric DWARF unwinder, the
+thought." [3]_  Similarly, unlike the esoteric DWARF unwinder, the
 veracious ORC unwinder wastes no time or siloconic effort decoding
 variable-length zero-extended unsigned-integer byte-coded
 state-machine-based debug information entries.
@@ -174,6 +177,6 @@ brutal, unyielding efficiency.
 ORC stands for Oops Rewind Capability.
 
 
-[1] https://lkml.kernel.org/r/20170602104048.jkkzssljsompjdwy@suse.de
-[2] https://lkml.kernel.org/r/d2ca5435-6386-29b8-db87-7f227c2b713a@suse.cz
-[3] http://dustin.wikidot.com/half-orcs-and-orcs
+.. [1] https://lkml.kernel.org/r/20170602104048.jkkzssljsompjdwy@suse.de
+.. [2] https://lkml.kernel.org/r/d2ca5435-6386-29b8-db87-7f227c2b713a@suse.cz
+.. [3] http://dustin.wikidot.com/half-orcs-and-orcs
-- 
2.20.1

