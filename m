Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED20AC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CA42173B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDn2+nW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfEHPWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:22:39 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34288 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfEHPWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:22:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so10281116pgt.1;
        Wed, 08 May 2019 08:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=894APrpOjqkRmf1J0VMgwVy+KCpHCnfK4NXUp7KFcxc=;
        b=YDn2+nW73kggpJVEGViqDkyNgT4jTwx9VBpGipglBFplCmGlrfEHhDMkApiDfzToee
         zwC8KWQT55zfuwBf/KxlvHBbYif1caUgobMy6znympRQLrpQOd1ySBcjnGEqOq73i7S1
         eFe+ZjYbqWWhbNb7Xmt9RX/dL5d/3pJs6AsZdsTW1pi2J/OeW569D+DMZli1FGoSIYjQ
         i92D6Z0vgEzS9/b66ZlWs7epvuV873yinI+VoSi/WrAF+texlPWUVFqZpwCaRjdoqd2k
         fF5rw9wxK41je8DoQ7nbwMEIsvcpWaSPigzYWk4ICjbsV+3urSsT5n9Jj+p+PKlAlV6y
         V8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=894APrpOjqkRmf1J0VMgwVy+KCpHCnfK4NXUp7KFcxc=;
        b=a3EnYBfLywXqdMqBTc2x5HRL/XcLnUSdx2zCin52fXNIhb8xnCz5PfRCkW+JhNSFzR
         Pk5HxnSPJ2SJn7W/e5KdVTXXL++LnsG+qazIT684YbH2pXChlYlVYD/2BNQBck/hEvZW
         aftrReuy6Xyl7bjAyiLYPi7Eyn4wxzulviYdEYHQscKQTJ5UCtL9/xMDboMAmVCSEEkr
         Smb7pNv21qqkda+ldKtCIklfOLK1yR2HLQwPZluZYyh04fE9cAxJuLXeijGxZYPd8vXb
         ifu/iJuTkM0QiOwsWO/g4GE7h6XRe67ANn79OLuC41z6dsnEfMoVCBtUsFrzxFLR5MkS
         wrxQ==
X-Gm-Message-State: APjAAAU4PrhWtUAm9z9+SomT7KG3q7QQyKSli5McNAy0B7xxp1zcB7lH
        tfsfpYU+9vKSZa6uaK8nLQY=
X-Google-Smtp-Source: APXvYqymlmITXcufyfjdEvPxjgY+SZH4VtzDxQL8iYskmF2U9JCaxdaggXcH38QiBAalknoNa+wxWg==
X-Received: by 2002:a63:1654:: with SMTP id 20mr48256654pgw.166.1557328957725;
        Wed, 08 May 2019 08:22:37 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.22.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:22:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 06/27] Documentation: x86: convert entry_64.txt to reST
Date:   Wed,  8 May 2019 23:21:20 +0800
Message-Id: <20190508152141.8740-7-changbin.du@gmail.com>
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
index f6f4e0fc79f2..0e3e73458738 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -12,3 +12,4 @@ x86-specific Documentation
    topology
    exception-tables
    kernel-stacks
+   entry_64
-- 
2.20.1

