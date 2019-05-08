Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0F8C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000DE216C8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TulSky3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbfEHPWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:22:34 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38628 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727432AbfEHPWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:22:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id a59so10081580pla.5;
        Wed, 08 May 2019 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/f/jIMsYHsxInKx5Thoz667919hjo32hAsH6s5W2Nc=;
        b=TulSky3SYg/4G3hUPiUzGKtrb+TYBV3UL8O3xahHeO8MQ2lbzbGUNyWDR3OC+pxIHe
         whJIHU/bPJ4yc9GYPtWYnyH+2HRq17mv23f7cBxHF35HiEFm4WT1E+I6OPDIh4tgXOXB
         i9Pn5IdxKyzZaHemOgSNoZdtjAo2YmLQuePbck2wtT3MGNvq1Bbs2RHyoyivKkDZKSY0
         A/vNZUGu1JV/KnNKDqWIXJSGLy5XK1FOsj0ws84M7evsaDCukHBJfVDZOo05+ZshUaxH
         W4Vaf4R1AklxnEVn0Y+w4E8+KXQ/LA/qMXFr40CjVdRlFY3ze9P07rVFjnG0AdF1Jmir
         RZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/f/jIMsYHsxInKx5Thoz667919hjo32hAsH6s5W2Nc=;
        b=TOhpUhLRHHOFUw7D+cce16X/3FCeHqaTm3luM2TaK7l1o6GN/Q+n7vFu4iNY0i5GUH
         mTluO1nDtmB+z6v/xbhpnSUKvb8JqOfc1mPBXuQHAkgVtf6Wr/PzPymDLwD4eg8BX/Zc
         v9Jil7+uQNJWmdaPXv/81I6yMdAq6vq2T4IHYEwOaqdHzDsxjhdK7C7rzIqz4Ja6aM3a
         E5zaA2H+zL2v0Ewr9amCH5YvkU7WQc+vKxHj1fW7qgrwtW3FlR+2ltWoH/BqGDPeuzI9
         DfCPE1ebo4q64WltdthV/k9x6EuUKUwNJInl56dkIdzfpzXMnaXdx82nbPk/Q/jOoeAR
         kd9Q==
X-Gm-Message-State: APjAAAUX/q+Luyir8PP2MxuRNFGLBTW2npBGCi2P6U7qFOB0i3OZrhY9
        i/bat6EfpUycHgCIw6d9UDU=
X-Google-Smtp-Source: APXvYqzK7Y/YrdwK6aHEqqz93IsmbLdGG4lIbpDoA96iU7sVKuzWMKBZjNX/A0/R5JC/uWQw35COMA==
X-Received: by 2002:a17:902:50ec:: with SMTP id c41mr48403572plj.244.1557328951512;
        Wed, 08 May 2019 08:22:31 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.22.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:22:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 05/27] Documentation: x86: convert kernel-stacks to reST
Date:   Wed,  8 May 2019 23:21:19 +0800
Message-Id: <20190508152141.8740-6-changbin.du@gmail.com>
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
 .../x86/{kernel-stacks => kernel-stacks.rst}  | 20 ++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)
 rename Documentation/x86/{kernel-stacks => kernel-stacks.rst} (92%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index c855b730bab4..f6f4e0fc79f2 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -11,3 +11,4 @@ x86-specific Documentation
    boot
    topology
    exception-tables
+   kernel-stacks
diff --git a/Documentation/x86/kernel-stacks b/Documentation/x86/kernel-stacks.rst
similarity index 92%
rename from Documentation/x86/kernel-stacks
rename to Documentation/x86/kernel-stacks.rst
index 9a0aa4d3a866..c7c7afce086f 100644
--- a/Documentation/x86/kernel-stacks
+++ b/Documentation/x86/kernel-stacks.rst
@@ -1,5 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+Kernel Stacks
+=============
+
 Kernel stacks on x86-64 bit
----------------------------
+===========================
 
 Most of the text from Keith Owens, hacked by AK
 
@@ -57,7 +63,7 @@ IST events with the same code to be nested.  However in most cases, the
 stack size allocated to an IST assumes no nesting for the same code.
 If that assumption is ever broken then the stacks will become corrupt.
 
-The currently assigned IST stacks are :-
+The currently assigned IST stacks are:
 
 * DOUBLEFAULT_STACK.  EXCEPTION_STKSZ (PAGE_SIZE).
 
@@ -98,7 +104,7 @@ For more details see the Intel IA32 or AMD AMD64 architecture manuals.
 
 
 Printing backtraces on x86
---------------------------
+==========================
 
 The question about the '?' preceding function names in an x86 stacktrace
 keeps popping up, here's an indepth explanation. It helps if the reader
@@ -108,7 +114,7 @@ arch/x86/kernel/dumpstack.c.
 Adapted from Ingo's mail, Message-ID: <20150521101614.GA10889@gmail.com>:
 
 We always scan the full kernel stack for return addresses stored on
-the kernel stack(s) [*], from stack top to stack bottom, and print out
+the kernel stack(s) [1]_, from stack top to stack bottom, and print out
 anything that 'looks like' a kernel text address.
 
 If it fits into the frame pointer chain, we print it without a question
@@ -136,6 +142,6 @@ that look like kernel text addresses, so if debug information is wrong,
 we still print out the real call chain as well - just with more question
 marks than ideal.
 
-[*] For things like IRQ and IST stacks, we also scan those stacks, in
-    the right order, and try to cross from one stack into another
-    reconstructing the call chain. This works most of the time.
+.. [1] For things like IRQ and IST stacks, we also scan those stacks, in
+       the right order, and try to cross from one stack into another
+       reconstructing the call chain. This works most of the time.
-- 
2.20.1

