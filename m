Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52F4C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7499720873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc10kqEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEBHKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:10:17 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43678 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfEBHKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:10:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id n8so597091plp.10;
        Thu, 02 May 2019 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=894APrpOjqkRmf1J0VMgwVy+KCpHCnfK4NXUp7KFcxc=;
        b=Gc10kqEErmW0o7lpiVqtyI/UVcB0bjuOkHly6o1Sb+ikTR0sxN6sd401SQXojeF7Lp
         NJWVC5g0kW7BEVKiw5AeNckxAM01i8l8YWePtY0iKd1zFo/WyY14N44VQ7SYdpgoVWNY
         +ARXzf9G5qEpWbNjSu3dqykzY0Z0Mo1xThZ5kkCrQ8cXVPoI+kA6pgkf1SVFOv+XrLvB
         pClBEkd1lf3lDk53VwouD0gwVFF+YmoeX0w8U4t6Am119HAzvXgxMzRi30p6kW3C9EWR
         A5+WYucS04Fts3U0Oi5s4Z9ExOcHSxhIa/w7IJYO7T63uYd8q/PyQPIbtw7f9F3S/GFU
         +rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=894APrpOjqkRmf1J0VMgwVy+KCpHCnfK4NXUp7KFcxc=;
        b=EX33M16t/QnBJ4JgZwXojxjsiz48yiYjH9WwxpbXHRc3PqqkZTVNgCL2BFn2EN0OZT
         mx/3VufPobA306MjhWaFKfD/ZokxJzQEj90Pey4D7fQB59ETvAmvC8sPaHkm3w/QzVW3
         WmO4IWuhV5A9/IB5Bwh2uR9/0wj8lyr8E2fxHpKuVFQOrpRn8gxGZjVaUcjIyRBjd4dg
         ipNjFmxskqfU+2hEX9CLrH9m3C2hNb8CFz6SOPtJnUD0CXYBlJ27idBJadUgBQb97FoV
         t+qAKdl2O4g4f/x4FR0qD7eVAIJm3rBOVRWqmQO8s1eeyNuIepo70YXLy2YVVisDBYeX
         gcLQ==
X-Gm-Message-State: APjAAAWfHVXkbeK7beHnqivKin4uD79iL8xBgI1xKrxScIOjUNJT2bex
        NUnmxTBb3NQa5AthC1C7lg0=
X-Google-Smtp-Source: APXvYqyy1ig90URNZUla/Bfb5BSRCEEhNxiRbJbVHnDqZ3w4s2FkjirQ2pgFD3/NlJrRQ/N0imPb0Q==
X-Received: by 2002:a17:902:2ba6:: with SMTP id l35mr2120155plb.56.1556781015152;
        Thu, 02 May 2019 00:10:15 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.10.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:10:13 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 06/27] Documentation: x86: convert entry_64.txt to reST
Date:   Thu,  2 May 2019 15:06:12 +0800
Message-Id: <20190502070633.9809-7-changbin.du@gmail.com>
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

