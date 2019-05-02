Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46A1C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837A220873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbQqBaVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfEBHLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:11:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34176 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfEBHLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:11:51 -0400
Received: by mail-pl1-f195.google.com with SMTP id ck18so616657plb.1;
        Thu, 02 May 2019 00:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b71hcILz1f2BsDF7VpHynv0OFLT/ZIfiSJGLjPU43yY=;
        b=YbQqBaVPEsJ/chaMmZLT5aMcZrGCiKU6LW1APVVgLDo8ADBXA88kYpyEuWe3vQjdOR
         Ts8YiKDjcRNM5d9qjhGMA2hOqjtCelk1XeGExwkqWC5GRsjgPDrHpwcZJgy7x3eTNoAU
         /8axjPzIyPmNp1NaZ3tcZG4n9tcvGrhOVYxbMHGgBpc/Subg/W3luYw2QPWphKb5FZ5z
         K/zexXit9HKYopwoa80ytapAdUcRLfoAMR3zQQukNMPUjOLmU6CtS9wi0nxQAQ8uSl5L
         Juxyey+UtwD2zm3VE3bPSjrooxrhE5dULH/477PgSHXlHpFWX4B1M7HfQOzH+KImIgnB
         Bmdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b71hcILz1f2BsDF7VpHynv0OFLT/ZIfiSJGLjPU43yY=;
        b=kQXVMG2Gky6v5tNGG6+d5MSj8qxGrwxlP+lQ1+24SIw3kp7574cxNfeZCUUV4avMOv
         TqZ1ImZugGHqPelQqqf7hsiuuirgg2z+vxjzq/zdqnIQgpNQIQ0Q5gzZGvhjMGhjZWpz
         nSan6UFDuA+ICEP+MI4uVfYMThNIQyUPKJjoZyC/V329rznJJ6rC9JvEafMmJF+isDs4
         rIGh1BLK/upja+7b3wiY4KWzpKLZPASlrmVk3bYuE0WzEZ6joIhoP7W+eUgPtLpMNGEW
         dbeUFLz5lin2RIiqIpOKdo8cbvhsN/l5H0GeLDAoXMWkFk9t0jc2KvkJ5LeK1xHd7Yzr
         OKYg==
X-Gm-Message-State: APjAAAUqO7iZZrG71ZXV0DqNtpzDvxYAOzZH6U6OAaAx4ua9gXd2NZoy
        E6mplxn1vBj6ifHp3o4GohQ=
X-Google-Smtp-Source: APXvYqyzSxuboACVPCytRm9W4IiuMlUBjlm7TSBkmCX/V2zONBmwANZwQigz7eT35nXUtVx8vVT5Qg==
X-Received: by 2002:a17:902:ba8e:: with SMTP id k14mr2163666pls.80.1556781110958;
        Thu, 02 May 2019 00:11:50 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:11:50 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 24/27] Documentation: x86: convert x86_64/5level-paging.txt to reST
Date:   Thu,  2 May 2019 15:06:30 +0800
Message-Id: <20190502070633.9809-25-changbin.du@gmail.com>
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

