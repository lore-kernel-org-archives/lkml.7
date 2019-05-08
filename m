Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31ED8C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E772320989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rH/qiAZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfEHPX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:23:58 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36167 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfEHPX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:23:56 -0400
Received: by mail-pf1-f193.google.com with SMTP id v80so10673730pfa.3;
        Wed, 08 May 2019 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24w4jqgdtlrA7O2xMmJS0tVlbeaBr/Rj015fWFSNbZI=;
        b=rH/qiAZi+JW6v0WAgwiNnAU9FVpDQhmGGaVkHmDmoHZMKmEJa0owtTK9gQfUVfg5JL
         FjCb+zy3YpkbTFDO9UshwWjZZAdBUnURec78lF7byRFp8nUNdk2PxzSXIeT99rRfrvFP
         at1rxkvcAxbMeZvHasM0Fb1QFCiqE3oEnEie8iDu67b+GLrocM7Y5MJVgdWX6bJXd+pC
         Kt6MG1HzEXTXsLMNa+c68umSgwxC4XI8XrzzgvEgig4ScCm65MsmFccb65ciBkQGXUq2
         4wfg/jRTZa+6/capUnaVs/3JsmTbjmc+YfQUK+k8tx6YW/z3q1gltnHPUJ+ibecnsSjY
         4yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24w4jqgdtlrA7O2xMmJS0tVlbeaBr/Rj015fWFSNbZI=;
        b=qdLx+BGQ8+IIODBQ6wyI99i53y0pnJKMcGdx51+yVLosLVvAdmx0Lq4WHTtMTbCkgR
         HMNVqiZkO9xUwI2XRVajcdiisAgcwpeib5/O7L7i/Gf7N4QZ9Qzf6OOKTyBi+O0UBUWs
         P16+F1h5lkEtQomNA7/NdJJyG8LZhod+pmh1j1i8HJsCqAvNdYNtiYQSpJwYUpXoq4WJ
         gBF4EWBCzDgLXxYEmLMgcfsc0HWfcsaI0cNeRrzGGBwQbLDVITIOlzuL3g59gZeJGQ7p
         1QzuX0cNydVtOtuFyuTgd6TD+tQHCiws7WthTh/jrPiE/ICu3xsBHrH/bPyVpp33jN21
         Dlgg==
X-Gm-Message-State: APjAAAVyshJU5ZsoxmO9kjz65gTgn9IkmGfhFhfFZCwRIKJ/u57+WYXd
        EOcTIOTQdvGIF91+TwKzQbQ30RE0
X-Google-Smtp-Source: APXvYqyYr0wBzzqNAoE4JBauSUfRywOFT5MrzbESVEV0SMdy6GiQY+481x+NfsACbNoHd6YTMkXQcQ==
X-Received: by 2002:aa7:8493:: with SMTP id u19mr30699550pfn.233.1557329035776;
        Wed, 08 May 2019 08:23:55 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.23.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:23:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 18/27] Documentation: x86: convert orc-unwinder.txt to reST
Date:   Wed,  8 May 2019 23:21:32 +0800
Message-Id: <20190508152141.8740-19-changbin.du@gmail.com>
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

