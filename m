Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41997C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0558F2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwoImc0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfEBHLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:11:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43663 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfEBHLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:11:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id e67so672730pfe.10;
        Thu, 02 May 2019 00:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24w4jqgdtlrA7O2xMmJS0tVlbeaBr/Rj015fWFSNbZI=;
        b=gwoImc0Tv48Vw2W0H1VZGBT8gNBq33qMavJQKjOfGV10yevNilFZhGl0gdbiLM9Aji
         zgMEAShSDYDNdJd0gJKgtPbSmIsaPrLT9M0fvX/1J1KjVDS5j7sWe7XM/9ttxeH8pUOt
         u40da22XZ3Hz64jTo2aLAJAeX9FZ5izqV9JMK92IgLvFRtMUznQDVbCj+IgV5LfOpORM
         EsN8/b3m+XWkVhhMV4yyw2tstktspnomNHdoP5/c4FWkLETuL3SWEWuWkf0eLyI6JEqh
         AKayfnHCsNEKj6TZqog4LPzN+RTkU4IvFQHcXGGVvm2rOt+mePSRINV2vDeDxhyK34Ev
         6PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24w4jqgdtlrA7O2xMmJS0tVlbeaBr/Rj015fWFSNbZI=;
        b=iCQM/lPWUlwxMtIreDBaPlTBWSXeIm1hOwQ9JJYRFbb8a2dfz6k68UOzVjbCwl+mjZ
         mJcXVZjR6nn/6ntRP//3AZ4eW5ORVloSiqTls43Bbg+SJCnDMSAqPFu5xUnf6FAtkW25
         k9ggWFDVpj6MPjlBX2IBldr+wkBIPNc72wEmeO6j7tkg7GIjggbT9+jWaSF9ZA1nzmlW
         WKr8VvNLTznmyRXXY6VbGeAfFvwwHK01mY6P+AxolmpPuieY09Efe8XpYwPbKRzl2O/E
         HItIDygoZcIUte4rHvMW+0tefNs7/Kc1EZ5PecvEJsYMivzVm17/+9qmNYKP47bsqas5
         evqA==
X-Gm-Message-State: APjAAAUvHF3T3dmmAuEYS/1rSIlPiN6IDTrgp88FD15WQsdnl98NXU/a
        AWSle928rAW5N2tVl/7wv40Dbtp9
X-Google-Smtp-Source: APXvYqyDqayyWGx+CkHDisCCey3/85fmYBPHtLicC/C8zbsIslR/KsAUXOYuQp9DgR9EuhOs0sfSpQ==
X-Received: by 2002:a65:5304:: with SMTP id m4mr2367817pgq.281.1556781080345;
        Thu, 02 May 2019 00:11:20 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:11:19 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 18/27] Documentation: x86: convert orc-unwinder.txt to reST
Date:   Thu,  2 May 2019 15:06:24 +0800
Message-Id: <20190502070633.9809-19-changbin.du@gmail.com>
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

