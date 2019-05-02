Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEB5C04AA8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7D42085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlblcxRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfEBHKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:10:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41962 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBHKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:10:10 -0400
Received: by mail-pf1-f194.google.com with SMTP id 188so676203pfd.8;
        Thu, 02 May 2019 00:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/f/jIMsYHsxInKx5Thoz667919hjo32hAsH6s5W2Nc=;
        b=TlblcxRhUchFbs6DOWvUl5HDUqd7UDbs1NZgVsAEaFffeEK/1y6dV954YwOHhPgZQz
         dMqtkZepsMl6mj3MHp+0d7W02ZNViImhWo8fYc/pAdsuHqSLb8Qq53XrCNVXlTEDUe78
         2zSxW0M0ocW8ery7nE2kEt3nrfo+J8EEc1cZLTahFyfgFSdzx1wp8K0L3ONYEOXg8Zje
         xJ0gYBsDJsXe2/IypXuaehgqfBVZzJ/JYkSGSJk7I0ye5CWOsmYrfhCiNb60yItgISNl
         2Du28bAy+hNvpKL5tuE5cWCsPH4cpICFQ76ofPXnEBV4Tp4AXc0R1RY9QnnZ4pZe06lM
         lW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/f/jIMsYHsxInKx5Thoz667919hjo32hAsH6s5W2Nc=;
        b=pavrWXX4nWhDpebT5WAbVY8MBjqSwZDjZs8daa7tzZiyeZrAxC3/DYdKfGZA6y3pjx
         bT+XSCt9jaFzB4P6w5ApiVCkZZxqBMERgfrSWS9PEpq1IgTJiHOKbSyF+opUYSiOHRLW
         2L6MC2pT0jZEBS8htxznuzUvrg/ySISippRZ6yzO+lM2LxhkHR2otMmgD3ZVoOJT2UsS
         WYxrzKkQMfVZAO38zm1/9bxui4MmfB27PCtrH/9Nz3RYDzKNm/YH04G4W1n9QP6TKUZg
         odhLdqhRRUrlIZO26SmrndqrYpEyKdIchdiaSIV6DTzzKB2w79U2nNtp+KtUkyoBQSgo
         giGw==
X-Gm-Message-State: APjAAAUGSTOEszQ+bs3/XV86DZXUizT2x1SDoHZE4tNc4M4DMJHq8smP
        05Mr/+pS2uEWK7gbCrz9HiM=
X-Google-Smtp-Source: APXvYqxP1volOUYlJYdcISiJ2mk9piPnzU0SrX9tMZF+X1g0nru+4+Hjp4ls+tkP/3L0wHxZVYV+7Q==
X-Received: by 2002:a62:4554:: with SMTP id s81mr2561825pfa.66.1556781010211;
        Thu, 02 May 2019 00:10:10 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:10:09 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 05/27] Documentation: x86: convert kernel-stacks to reST
Date:   Thu,  2 May 2019 15:06:11 +0800
Message-Id: <20190502070633.9809-6-changbin.du@gmail.com>
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

