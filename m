Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75999C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455A32084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXGmROK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDZPem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:34:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41215 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfDZPek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:34:40 -0400
Received: by mail-pl1-f193.google.com with SMTP id d9so1747507pls.8;
        Fri, 26 Apr 2019 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lKxrWq0DPWG2/ldiM614YNjWwPB+5TI6uHMpmONkiyA=;
        b=AXGmROK5mng0JPjiQim8086JiOsc6T3YZ2R2vowg2KygiAieSQeBRzTyJkCP/+tZzP
         svPSPJGD+818NQqG4Hbpc0C7VqXIXNuGEVUzdH3KDvKMGCOoIWG81MboHCJDVpnM2TYB
         5BVuVxDRa1OT80eMgessNEDeDeJM0Gi1RIwxC8uODAb5l7Qyf/PYP6bkYo4ThH71vXDV
         aLXI5QaQvW8tpitc6nmsDrfRGOJQTZ5p6/HizziUPwb5xDFQzTl5XCo8AphKO8pFBUv9
         0juZUpewcg3eyJTcQS+sS4DXBOI8T8bupHPzWzWQJ617WaDKNtz2F32hqLGWuhwMmEHO
         gZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lKxrWq0DPWG2/ldiM614YNjWwPB+5TI6uHMpmONkiyA=;
        b=VJjvs3znmSOdJsSUIjiCaaflu+d9u5VvboyFnhcCjqZuoSsaV+y8mEoXKsSvzDQ337
         reNwdxoTL8X3DpGWj+kWJ3i4Yvigzwgu/f2zHOtBMPdkZF67bb5IeAnVL8JOy5hY8Ugm
         3vU225XQ4WXT9XQESAss9iBb7zfNZz8mKiiAUxxAwzgLUwTe6Pt42b/w+STxbh26Infs
         Nxqzop5S11133o+GhBW7tRknxHUE0FA+wcfR9FxxjHy5RVVP1vy8yPo/uYMojvGPaZiK
         0jIDIJBDYQl91uTdZHCWZ8f5YuqkAw3gu3cHAWBqa89QO4WTpWuX4jWfTzzkc/3KkRs3
         JpyQ==
X-Gm-Message-State: APjAAAWXuk9qf8T5hRE5MQS7sI20yseKhwSs2Z4v0/Rod4vuZeRi/H34
        XD5QmeD1eHCAg+WqFTOxhvI=
X-Google-Smtp-Source: APXvYqzMVILCBiku92Sahm8j5XKvPT9pQa1hs8oiSt9Muzy/viGwnLlpQIi189pLyx3naOwp0XPsHg==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr515276plt.227.1556292879614;
        Fri, 26 Apr 2019 08:34:39 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b1sm29024833pgq.15.2019.04.26.08.34.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:34:38 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 24/27] Documentation: x86: convert x86_64/5level-paging.txt to reST
Date:   Fri, 26 Apr 2019 23:31:47 +0800
Message-Id: <20190426153150.21228-25-changbin.du@gmail.com>
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

