Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD659C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3FC2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbhJcu1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbfDZPcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:32:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41059 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfDZPcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:32:46 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so1745054pls.8;
        Fri, 26 Apr 2019 08:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qw8iXfD3ItYngoQYik6Jp498D9sHvHA3oeNnrYYHbk4=;
        b=fbhJcu1fG3OoONfHlhroaCt4w35XyEL5Fz9jSI8bcoiIQbYGvjbKPMT5TH71zVzc4q
         KQEXfRHIRCKPAcivQQaVVHkQwemG9xmcbm3WkoY4XN+0K6TiguCQjgA4ilc3q4CX8OIR
         P7Q/AeMwLfwn+WNZ/63FLraCp+PeX7GMlelcq5wsm3u3unOUwRnAMZbB8UiPX6ZhZlEm
         cT/c+4d6KFyOS2zoW1NbPLWvjYmEijdTD/8vIdDBqGEDvJR1E3rXDtGyxDjeyR5puORt
         RjG9Mqqkulne++QEBLZ6iv4NGScYU871KdY317nchCLPZ8ocCRV2CIKH02Ua9o6s57Qc
         D6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qw8iXfD3ItYngoQYik6Jp498D9sHvHA3oeNnrYYHbk4=;
        b=i8I2/uPRBkjffgBkh/WTywVWW7x+Z/uv+whgIPqGMJVfOk9aaRyD4pPKjyVTItuCqF
         ted5z3bWIDO2rTnGrnMso930bCZELEWPp7ZxbN7x4XcYq4NO39ZIGVI5+jQ/p0m8Wbvt
         H52z4KgZCbbdBlsdJtpElCQIS5RZiz9TFkXaJ5JxPynmLFGmiQ8FnROAC6wI+S1Jdoxy
         vs1rYYP6sDG9R3eAGTJXOa8bzI18UTowlxYlXz0OG+QhavsecQr6CIkDPHYAfuutCDBe
         pEM8umnapCMONq8lUts1o/J/KLyvxQ0w9uHm63rd3dBeTQBTcAiIQU+2PoHuXIA9Rtix
         55Mg==
X-Gm-Message-State: APjAAAXuCNLfFWc3R98+bLZVcRInLgIArgDY9KZBRFkWtxTzdf7cZM0V
        08wCdwxF+ng/BcbM+s2FT34=
X-Google-Smtp-Source: APXvYqxXWUREqCKF57ycqs65HZcNJIa6R+UZEfCR7D4k2cNb+Ngkz+g1LaaDcgv3y/uJWz0rz74hzQ==
X-Received: by 2002:a17:902:29e9:: with SMTP id h96mr27823553plb.258.1556292765921;
        Fri, 26 Apr 2019 08:32:45 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.32.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:32:45 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 06/27] Documentation: x86: convert entry_64.txt to reST
Date:   Fri, 26 Apr 2019 23:31:29 +0800
Message-Id: <20190426153150.21228-7-changbin.du@gmail.com>
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
 Documentation/x86/{entry_64.txt => entry_64.rst} | 12 +++++++++---
 Documentation/x86/index.rst                      |  1 +
 2 files changed, 10 insertions(+), 3 deletions(-)
 rename Documentation/x86/{entry_64.txt => entry_64.rst} (95%)

diff --git a/Documentation/x86/entry_64.txt b/Documentation/x86/entry_64.rst
similarity index 95%
rename from Documentation/x86/entry_64.txt
rename to Documentation/x86/entry_64.rst
index c1df8eba9dfd..a48b3f6ebbe8 100644
--- a/Documentation/x86/entry_64.txt
+++ b/Documentation/x86/entry_64.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+Kernel Entries
+==============
+
 This file documents some of the kernel entries in
 arch/x86/entry/entry_64.S.  A lot of this explanation is adapted from
 an email from Ingo Molnar:
@@ -59,7 +65,7 @@ Now, there's a secondary complication: there's a cheap way to test
 which mode the CPU is in and an expensive way.
 
 The cheap way is to pick this info off the entry frame on the kernel
-stack, from the CS of the ptregs area of the kernel stack:
+stack, from the CS of the ptregs area of the kernel stack::
 
 	xorl %ebx,%ebx
 	testl $3,CS+8(%rsp)
@@ -67,7 +73,7 @@ stack, from the CS of the ptregs area of the kernel stack:
 	SWAPGS
 
 The expensive (paranoid) way is to read back the MSR_GS_BASE value
-(which is what SWAPGS modifies):
+(which is what SWAPGS modifies)::
 
 	movl $1,%ebx
 	movl $MSR_GS_BASE,%ecx
@@ -76,7 +82,7 @@ The expensive (paranoid) way is to read back the MSR_GS_BASE value
 	js 1f   /* negative -> in kernel */
 	SWAPGS
 	xorl %ebx,%ebx
-1:	ret
+  1:	ret
 
 If we are at an interrupt or user-trap/gate-alike boundary then we can
 use the faster check: the stack will be a reliable indicator of
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 489f4f4179c4..8a666c5abc85 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -12,3 +12,4 @@ Linux x86 Support
    topology
    exception-tables
    kernel-stacks
+   entry_64
-- 
2.20.1

