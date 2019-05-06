Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEE9C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9A42053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bz8cgoJ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbfEFRKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:10:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46646 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfEFRKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:10:08 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi2so6662990plb.13;
        Mon, 06 May 2019 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N/f/jIMsYHsxInKx5Thoz667919hjo32hAsH6s5W2Nc=;
        b=bz8cgoJ4IL+PnO8LTT+P4gz3bGjO1o3W9Ds357BZFcZOGSazV6u6u5nlYfrsVgIkFb
         jQliTMbWhSjrr+r4ub42Bcxz4WeYzqwHLDHhTBwfQ0YIbIT5nF7Jz71rfmUdRsFsLNWM
         k/Sn/aWT82OVzxiMdoYFV9AikNSFY8kVX7a1nnmJ9sN/T0D6WzM5rfSANxK0EsMYjduK
         gWGIVca39TlaEa5pSBHGs10R8WgPl1R+niA36zkBih3e1XP9HmiNyJcdFM2sJhLC5KBH
         Gi5iprZbDLUAZePFKip7sLeKvmNObCJLvoWHwhalb1bsAuDHpMmJ8Rk9/c4KyJ5NR2lP
         PPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N/f/jIMsYHsxInKx5Thoz667919hjo32hAsH6s5W2Nc=;
        b=GitJDKtJGxeMkzsY4UDkgmi8ffKoTudpeVkCFfqNg6G9oO1/q1U1tsqE3uIrL9RdfU
         9fsDp+sj9V8ed4bsZ/nhb5PdStKHswKAgLIQ3FrXtgTmUJsZ9NzkySWZ2lo8QTJ1JYHO
         UN9SmK/eQ4IE5mnBp0hWYCo/+At4DLZZglhp3TLqOaGCPw2qtGvHkjo+85bg8yTc1RL+
         CxS1NZqxloinLt4VAuf/5gjKTItPMeU/F/TMkAFnfMx1FANmVzRcg2dDiZdsFhEzBsez
         N9kkxOabp89qpmPoIkD6Cm8eiGqzce/5h77Ry/1IDuVICGQojQuslh0UPERppsaBAgha
         Rf3g==
X-Gm-Message-State: APjAAAV/vT6krCPxjX0m9vlsSIzmaoIQ4HrKUwQABySiKA1GZdc/Un2B
        QebwyrEkpv3Xv2ftyIun5gM=
X-Google-Smtp-Source: APXvYqwfCR4XgxB3J5CI5VsaqkBHBTNnapes4z8Aq8ClBBnhnR7mh838inDjr7z3vsRvXXJOUnUKag==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr34248560plb.203.1557162607460;
        Mon, 06 May 2019 10:10:07 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.10.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:10:06 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 05/27] Documentation: x86: convert kernel-stacks to reST
Date:   Tue,  7 May 2019 01:09:01 +0800
Message-Id: <20190506170923.7117-6-changbin.du@gmail.com>
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

