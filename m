Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0C5C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBA220C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sH1CFh69"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfEFRKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:10:14 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46652 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfEFRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:10:12 -0400
Received: by mail-pl1-f195.google.com with SMTP id bi2so6663091plb.13;
        Mon, 06 May 2019 10:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=894APrpOjqkRmf1J0VMgwVy+KCpHCnfK4NXUp7KFcxc=;
        b=sH1CFh69/1vzhJ4mvrmpiIBYsz/lqzE8RXLBEqSOa7HJa554r5XY2L42UFRDsHOIAj
         YxiTKhOaLsl8gQrDbOMMFfHS0iNMZPCQeIrTXA6K8lBlaaFpTe/Gzcr99pCVN4ByaIKH
         foXk7q9aSZQMUzcontxQ3YnHLCNcsEerM0woPSGMOOIxPwVTV9KSGdGB93v9QELzf4HC
         nP+REXAJVqLIjeD8wwkqEPSe8PYCtHUVs5sptmyx7h1q66XakwaVIAV8/GuWBmckew+W
         nWVPUAfMtZxvUmmvy/U8Q26RHmEmIOBLadl251QF603OKgP/RivV4K8FrN9doHAxBVQa
         S1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=894APrpOjqkRmf1J0VMgwVy+KCpHCnfK4NXUp7KFcxc=;
        b=YTOwPgZGgSy/ZRmw6z7dFeq1lFoXSOwxw+0darUQU0txkb0Dt/Ssagjth+HM/0456N
         qPlOZvm+d75bTioeqtrX0y6lixKMTYkpFO1tAJr4F6fLFYrAD2jGDWU+YTnsjZB7HFBG
         eF+RNPv7JkFRGuYGSFWtq+y4GmKjwc8GPeofxitY5Oj/oyjHbDVc/U4XtnT9pPhaDT5c
         QLwvcFG0XRLzgaeZwziiIOtNJGHP0jaAuTIPmklDAngrGz01pyQ07uFPVKt1nQTFlDOe
         YvqqEAk6eBFXB7XVZ7bl2bJcH4tbprZi2l6YNb6kXs1rzFJluynCAU8foY8sCP4IScju
         oLzw==
X-Gm-Message-State: APjAAAUiamlZa6p69j/mfAauKHucZS4lUXaCsz0ywvvFOZKzabCnMQbD
        xJa19cJK/on6yQ44WrESqrg=
X-Google-Smtp-Source: APXvYqz/kDKcWXY3XQh66mGMF7EYR1+3yVyqrEC3sEy4ivk06uC753yHeBRXTUJA0XqXmxbNu0668Q==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr33768516pla.271.1557162611917;
        Mon, 06 May 2019 10:10:11 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.10.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:10:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 06/27] Documentation: x86: convert entry_64.txt to reST
Date:   Tue,  7 May 2019 01:09:02 +0800
Message-Id: <20190506170923.7117-7-changbin.du@gmail.com>
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

