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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4367C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B4B921744
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbXGYgX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfEFRLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:11:24 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34368 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEFRLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:11:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so6774533pgt.1;
        Mon, 06 May 2019 10:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24w4jqgdtlrA7O2xMmJS0tVlbeaBr/Rj015fWFSNbZI=;
        b=lbXGYgX2SjLqR/3eM6MalVqaPWqlbWoXVr4I4oSlgIRnle6n0T9Ui9wN4yVJ5ICd5g
         zM31OjzgCS8rUA+HH3beAy8aEP6h46iYNKsrcsU6y79nXd0EHRU62NTnqSZRsuQmaW+G
         9/WtvtrICVssBTHw25/YTJGz3r7uKEE48SDdw2XrUAX8bkx6o1VdYa61QqC36DRSACrk
         xcJh5LN4rgZwKEmGWY391Cp+4x1X1Js9wESVsHzuF+t49L4tZtrgDy1GAMXg4WTi5OvI
         YAKAboXTWOI+2b7ACRTmOStw/5LAY+JmeO9c00Z6BS+WjyRuiTB9NlYlPsDkaTUfRxM+
         op3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24w4jqgdtlrA7O2xMmJS0tVlbeaBr/Rj015fWFSNbZI=;
        b=PEC04bLEyhL2W3HG88+jeFuKm/kjVJXzifx4LylbSE4nhGtVR5NY/1IEw5OnTmgCy3
         7zU/qS7vA6ktS/LO4R4P6oS5NemTQn2y5a7UL4Zc9sxlTa2R+iHwcSqBva65xCWeeqDv
         pHgyqGft6vs6QguacrP3C9OQRZyusw8pTwdedLoV5LVjvbVVQDfuvizQYh7ng8GOrvhi
         74kE4UF2SwEOAQW47J2enWU/v+a0RZ4sYvG01HHl6ekNlGa5X7QU64FHQM9FLJPvmRme
         A70R1M6mNjlgO4Tm3guTwyGPZrVoBzisNEaQKxE0qIqtWsuJmbCVKxNckMlIzWq66KlQ
         A3zQ==
X-Gm-Message-State: APjAAAXazq4pirkehwHLeh4LU6oErjftMSpX2NYWwAepkALv7cpwJeX0
        M7cci76gujdRbIjmGzUSDsU=
X-Google-Smtp-Source: APXvYqx8AzgwBIq2Ae+NTyC43YLanHhb8OCbFvyQw902cgCiqrXbvonae2WKtvySX+G23PUEaSh26A==
X-Received: by 2002:a63:f813:: with SMTP id n19mr5308296pgh.273.1557162682699;
        Mon, 06 May 2019 10:11:22 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.11.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:11:22 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 18/27] Documentation: x86: convert orc-unwinder.txt to reST
Date:   Tue,  7 May 2019 01:09:14 +0800
Message-Id: <20190506170923.7117-19-changbin.du@gmail.com>
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
 .../{orc-unwinder.txt => orc-unwinder.rst}    | 27 ++++++++++---------
 2 files changed, 16 insertions(+), 12 deletions(-)
 rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (93%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 6e3c887a0c3b..453557097743 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -14,6 +14,7 @@ x86-specific Documentation
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

