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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 844F9C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5319A208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uiiwc03j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfDZPdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:33:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33328 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfDZPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:33:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id y3so908969plp.0;
        Fri, 26 Apr 2019 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UytHbK/UgccrKF2XiktexSNLVuMa3rRCmAQJoran2Is=;
        b=uiiwc03jXRCXUW9bWGmXHa8PVq7q5q/4z7vacLgp+AaCB0HroD/UB+mIcIquYdZaar
         OiHKTj7ylUORAmNf7s3JhI2f1regp2mKmDbC/MgxP2MBLWaESv+gizuO593ulA+XkmSX
         BsftGwXctlMBIOtKoydDGxVHv9rkD89V+u2Td5q1LRSTz+7igbWH4ODwc7qZhJoSzhew
         cuxK+88evvIPFgUD4TQetUa739EnvskmZE9HmWXQhtAlAi9VirdLdVfKDvTVTSDGzGjK
         1nQMGC9K7Vm//rjZod+6EFGL2XLuPwBJY0GvorqEgtPaMJMp8e8V7IGUdhqfvu27/sge
         LUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UytHbK/UgccrKF2XiktexSNLVuMa3rRCmAQJoran2Is=;
        b=Dae8CIZ9n/MsgRxSo61S+WEhAq+5uNh/SZ4wiO9Ei3pPVjn7vGf0rua1NruHuDVYM4
         nNdd4d6RW/h8JVcuc1zm/jgr4828EGGPwDweNwCtfPJ+gH0VeTcNMe+0ZVp1xY+I2JZ1
         YCHsb59HGccHVtmggyUFJw5acLs67R+tM3OBCXsRcMDxI3Nx7RFwBQ6WRfmsQFMM4ENq
         3kUwlAQs7rFfVdl3CO1m7w7F4Hb351vDqbZ8zv621PUGVaPkpaEiRewJC+yMFVt3LmTj
         udwxanQvHZowY6JlGDJ6DSY2q7BIBCqrl7tAQ84nF+jL4yGpKHEmw9RlIKqcmFxTX9rG
         hZjQ==
X-Gm-Message-State: APjAAAX1iAvGJxoNOXGKi6gaFQLPWlx+iVUwcxhKQarn1jQra2fF055G
        WqfsDRLQD2+pc1lhpRnwexw=
X-Google-Smtp-Source: APXvYqxrzT7x7OZTOLWnWZ73TDuVxYfQ3IP4rRim8rbSbWG0C6B7uaWXjNadZqbrl560PLJc65Z2Qg==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr508920plt.227.1556292815170;
        Fri, 26 Apr 2019 08:33:35 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.33.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:33:34 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 15/27] Documentation: x86: convert pti.txt to reST
Date:   Fri, 26 Apr 2019 23:31:38 +0800
Message-Id: <20190426153150.21228-16-changbin.du@gmail.com>
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
 Documentation/x86/index.rst            |  1 +
 Documentation/x86/{pti.txt => pti.rst} | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)
 rename Documentation/x86/{pti.txt => pti.rst} (96%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index a0426ab156bd..1c675cef14d7 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,3 +21,4 @@ Linux x86 Support
    protection-keys
    intel_mpx
    amd-memory-encryption
+   pti
diff --git a/Documentation/x86/pti.txt b/Documentation/x86/pti.rst
similarity index 96%
rename from Documentation/x86/pti.txt
rename to Documentation/x86/pti.rst
index 5cd58439ad2d..4b858a9bad8d 100644
--- a/Documentation/x86/pti.txt
+++ b/Documentation/x86/pti.rst
@@ -1,9 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Page Table Isolation (PTI)
+==========================
+
 Overview
 ========
 
-Page Table Isolation (pti, previously known as KAISER[1]) is a
+Page Table Isolation (pti, previously known as KAISER [1]_) is a
 countermeasure against attacks on the shared user/kernel address
-space such as the "Meltdown" approach[2].
+space such as the "Meltdown" approach [2]_.
 
 To mitigate this class of attacks, we create an independent set of
 page tables for use only when running userspace applications.  When
@@ -60,6 +66,7 @@ Protection against side-channel attacks is important.  But,
 this protection comes at a cost:
 
 1. Increased Memory Use
+
   a. Each process now needs an order-1 PGD instead of order-0.
      (Consumes an additional 4k per process).
   b. The 'cpu_entry_area' structure must be 2MB in size and 2MB
@@ -68,6 +75,7 @@ this protection comes at a cost:
      is decompressed, but no space in the kernel image itself.
 
 2. Runtime Cost
+
   a. CR3 manipulation to switch between the page table copies
      must be done at interrupt, syscall, and exception entry
      and exit (it can be skipped when the kernel is interrupted,
@@ -142,6 +150,7 @@ ideally doing all of these in parallel:
    interrupted, including nested NMIs.  Using "-c" boosts the rate of
    NMIs, and using two -c with separate counters encourages nested NMIs
    and less deterministic behavior.
+   ::
 
 	while true; do perf record -c 10000 -e instructions,cycles -a sleep 10; done
 
@@ -182,5 +191,5 @@ that are worth noting here.
    tended to be TLB invalidation issues.  Usually invalidating
    the wrong PCID, or otherwise missing an invalidation.
 
-1. https://gruss.cc/files/kaiser.pdf
-2. https://meltdownattack.com/meltdown.pdf
+.. [1] https://gruss.cc/files/kaiser.pdf
+.. [2] https://meltdownattack.com/meltdown.pdf
-- 
2.20.1

