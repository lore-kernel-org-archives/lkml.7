Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC34C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4FE20989
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 15:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5Nd5BHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbfEHPXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 11:23:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46304 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfEHPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 11:23:36 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi2so10079568plb.13;
        Wed, 08 May 2019 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAXLPjGujT6Na6Fx5FR5OHTWfQ8Sl9PgNJoSP5Q6+xc=;
        b=M5Nd5BHqYcBd/mWEiA2LT0/ZSzvqj0aTRHOWCu/h0/SmAFwKeNVcIr2kX518axJcfR
         w9K3J3nkuzIpOiXEekhBnfgxJF2kE3su0vW3VAbDcDoCejZC64yzyVcyankjbDoIi27T
         31NCFhlShslKFTwF+8tn+C6s3D7ihTvNYyTSzH0DdgYiMXFxRo+e2pFLSxarFGw6A2LM
         pdEpdlOH6fXNzgFJ7yBlzsoiHgn1INOTnxuikpTXGT0Cb4DJSFshBhaQ2RNrS2yQPh6X
         zpaT3KO2o9iwVmELa0zMts+YAD+yacBRuHpOJHfI0HBash7f0/PhyrtG6kwIB08ipiKe
         rlRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAXLPjGujT6Na6Fx5FR5OHTWfQ8Sl9PgNJoSP5Q6+xc=;
        b=mj5nlu6xqmIzQlpxGdKSZDsDCdrPBzsSIGN/77YF/iqoPRzCDKUvjagQFC2EAS/PkQ
         ILtTq5qVpuXvxvzLOPqfk0ey5DBGuLurEafrA3ipiWLs3t+P18EawikJfDuIY0LsaewU
         yhvWDBOtSDi3iW0igAXO6i1XwmkgcSGEDrpd+Y5xsHKm2JzvR4eldZhMm6XvGmcpcSLb
         i9GDTbSdkAhKPakYOcYE1GAVvV6e5V+MLmAZHx8fEbPFmCnCKf/KBrZ+goFn/PRV8sXO
         t/drJeXEQfLYI0xuxt5knsEGhNw4Z36cICx6qJCfuYzr0WcubttEaZH7mOwpOZTMt/tp
         BROQ==
X-Gm-Message-State: APjAAAWW9bD95imtPiDK9VN9ZheRGYxmsRbfbPYoAUUkSBCNXo0yUHd/
        sF9EwH+0EIAF5YagqvSif+4=
X-Google-Smtp-Source: APXvYqwKeesKakHlWFGL/q/Hy1jkTzryvsdBHBQpBtkwgcc+SJwh9D9LXR/t9Uv9K19fvZMngwCtbw==
X-Received: by 2002:a17:902:8bca:: with SMTP id r10mr48118847plo.67.1557329015780;
        Wed, 08 May 2019 08:23:35 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id o73sm7459360pfi.137.2019.05.08.08.23.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 08 May 2019 08:23:35 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v4 15/27] Documentation: x86: convert pti.txt to reST
Date:   Wed,  8 May 2019 23:21:29 +0800
Message-Id: <20190508152141.8740-16-changbin.du@gmail.com>
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
 Documentation/x86/index.rst            |  1 +
 Documentation/x86/{pti.txt => pti.rst} | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)
 rename Documentation/x86/{pti.txt => pti.rst} (96%)

diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index 85f1f44cc8ac..6719defc16f8 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -21,3 +21,4 @@ x86-specific Documentation
    protection-keys
    intel_mpx
    amd-memory-encryption
+   pti
diff --git a/Documentation/x86/pti.txt b/Documentation/x86/pti.rst
similarity index 96%
rename from Documentation/x86/pti.txt
rename to Documentation/x86/pti.rst
index 5cd58439ad2d..4b858a9bad8d 100644
--- a/Documentation/x86/pti.txt
+++ b/Documentation/x86/pti.rst
@@ -1,9 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Page Table Isolation (PTI)
+==========================
+
 Overview
 ========
 
-Page Table Isolation (pti, previously known as KAISER[1]) is a
+Page Table Isolation (pti, previously known as KAISER [1]_) is a
 countermeasure against attacks on the shared user/kernel address
-space such as the "Meltdown" approach[2].
+space such as the "Meltdown" approach [2]_.
 
 To mitigate this class of attacks, we create an independent set of
 page tables for use only when running userspace applications.  When
@@ -60,6 +66,7 @@ Protection against side-channel attacks is important.  But,
 this protection comes at a cost:
 
 1. Increased Memory Use
+
   a. Each process now needs an order-1 PGD instead of order-0.
      (Consumes an additional 4k per process).
   b. The 'cpu_entry_area' structure must be 2MB in size and 2MB
@@ -68,6 +75,7 @@ this protection comes at a cost:
      is decompressed, but no space in the kernel image itself.
 
 2. Runtime Cost
+
   a. CR3 manipulation to switch between the page table copies
      must be done at interrupt, syscall, and exception entry
      and exit (it can be skipped when the kernel is interrupted,
@@ -142,6 +150,7 @@ ideally doing all of these in parallel:
    interrupted, including nested NMIs.  Using "-c" boosts the rate of
    NMIs, and using two -c with separate counters encourages nested NMIs
    and less deterministic behavior.
+   ::
 
 	while true; do perf record -c 10000 -e instructions,cycles -a sleep 10; done
 
@@ -182,5 +191,5 @@ that are worth noting here.
    tended to be TLB invalidation issues.  Usually invalidating
    the wrong PCID, or otherwise missing an invalidation.
 
-1. https://gruss.cc/files/kaiser.pdf
-2. https://meltdownattack.com/meltdown.pdf
+.. [1] https://gruss.cc/files/kaiser.pdf
+.. [2] https://meltdownattack.com/meltdown.pdf
-- 
2.20.1

