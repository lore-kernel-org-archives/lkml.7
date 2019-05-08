Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F7FC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930A120989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUf5kPx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbfEHPYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:24:37 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41159 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfEHPYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:24:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id z3so6564937pgp.8;
        Wed, 08 May 2019 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b71hcILz1f2BsDF7VpHynv0OFLT/ZIfiSJGLjPU43yY=;
        b=AUf5kPx0Tmfu3xXyJgA+NOYA8dG6WANaUtWI+BufsQBfQ2oVwiWc3NkSKWq2sSR53J
         EcniU5rSGC7WcxZleI03Joe6Wu9kmpia8ytMp6iUg3OUctENSUmYzQ4+bARmMQ4oHNIU
         GvM5OxbqSKyo1KKjJdcZ7LL5yNydarv0FWAbARD4QbJF+Cs3HM5/iI0kE2qYH6uX5kYR
         A6C+RhBjdGEMUY/9FRo2KjsONnh5GxD74wV/W8AquKrVqUQ5ioR37TxKKRHjdnvW7xDb
         NaQ75XeKFniqNsPPmZDb6QyPTL/y81EuNqdHPdDO9vq3TTpKerQ9aFVtkmzBLSTN3NyV
         U6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b71hcILz1f2BsDF7VpHynv0OFLT/ZIfiSJGLjPU43yY=;
        b=LKRnLfsC7DxXEky+yDqUFBpPUW6nrVPynzUpT6YAaogpB7YrrAw4CX/ihANmmSLMYn
         TkNZnoJM5/yk8UXk/dIrYzimw3MKToo99M/420qv7GIFZe20iUaCf2E0a9qAIwaUgota
         RmWQaJglCJwGi0PLexyGk2LD5kjYLGdntUBPFhRwilDehfZvhrb1HUKZUx1cBzHZh4lz
         xqQfYH408xb7WdoIpjiTqqnG2buH47l7C4S0n3nLpJxOsrBF9UdK49Dg8UGMA0Ydegls
         OPXSAA2RGCbBimd5uM5WIGrdETkHh8FpjhH2MKYSSTaVwQrLgJCMjmMS4ImMOnwu4Q++
         f6FA==
X-Gm-Message-State: APjAAAW0SCkbIQ3ybr/+mAw8eDs/werLaUwu5bbv1NnBM4aaGsjactFT
        O1d8dn/N4uiJBBUYyQ6tYZY=
X-Google-Smtp-Source: APXvYqwaNB/l8fZn/OAcwwo7V+MGdmUdO5M7OwTJckAfjNpQsECLdUgVRBzyifZQdREoHhzjj6kojA==
X-Received: by 2002:a63:9dc8:: with SMTP id i191mr46540197pgd.91.1557329074298;
        Wed, 08 May 2019 08:24:34 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.24.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:24:33 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 24/27] Documentation: x86: convert x86_64/5level-paging.txt to reST
Date:   Wed,  8 May 2019 23:21:38 +0800
Message-Id: <20190508152141.8740-25-changbin.du@gmail.com>
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
 .../{5level-paging.txt => 5level-paging.rst}     | 16 +++++++++++-----
 Documentation/x86/x86_64/index.rst               |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)
 rename Documentation/x86/x86_64/{5level-paging.txt => 5level-paging.rst} (91%)

diff --git a/Documentation/x86/x86_64/5level-paging.txt b/Documentation/x86/x86_64/5level-paging.rst
similarity index 91%
rename from Documentation/x86/x86_64/5level-paging.txt
rename to Documentation/x86/x86_64/5level-paging.rst
index 2432a5ef86d9..ab88a4514163 100644
--- a/Documentation/x86/x86_64/5level-paging.txt
+++ b/Documentation/x86/x86_64/5level-paging.rst
@@ -1,5 +1,11 @@
-== Overview ==
+.. SPDX-License-Identifier: GPL-2.0
 
+==============
+5-level paging
+==============
+
+Overview
+========
 Original x86-64 was limited by 4-level paing to 256 TiB of virtual address
 space and 64 TiB of physical address space. We are already bumping into
 this limit: some vendors offers servers with 64 TiB of memory today.
@@ -16,16 +22,17 @@ QEMU 2.9 and later support 5-level paging.
 Virtual memory layout for 5-level paging is described in
 Documentation/x86/x86_64/mm.txt
 
-== Enabling 5-level paging ==
 
+Enabling 5-level paging
+=======================
 CONFIG_X86_5LEVEL=y enables the feature.
 
 Kernel with CONFIG_X86_5LEVEL=y still able to boot on 4-level hardware.
 In this case additional page table level -- p4d -- will be folded at
 runtime.
 
-== User-space and large virtual address space ==
-
+User-space and large virtual address space
+==========================================
 On x86, 5-level paging enables 56-bit userspace virtual address space.
 Not all user space is ready to handle wide addresses. It's known that
 at least some JIT compilers use higher bits in pointers to encode their
@@ -58,4 +65,3 @@ One important case we need to handle here is interaction with MPX.
 MPX (without MAWA extension) cannot handle addresses above 47-bit, so we
 need to make sure that MPX cannot be enabled we already have VMA above
 the boundary and forbid creating such VMAs once MPX is enabled.
-
diff --git a/Documentation/x86/x86_64/index.rst b/Documentation/x86/x86_64/index.rst
index 4b65d29ef459..7b8c82151358 100644
--- a/Documentation/x86/x86_64/index.rst
+++ b/Documentation/x86/x86_64/index.rst
@@ -10,3 +10,4 @@ x86_64 Support
    boot-options
    uefi
    mm
+   5level-paging
-- 
2.20.1

