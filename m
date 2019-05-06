Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F08AC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DC62206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXVagYm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfEFRLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:11:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39803 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfEFRLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:11:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so7102902pfg.6;
        Mon, 06 May 2019 10:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAXLPjGujT6Na6Fx5FR5OHTWfQ8Sl9PgNJoSP5Q6+xc=;
        b=LXVagYm4/IHPaFkp97SU/HNUlh5vX9CvZ1BIM6+L5VIafHqZGLD3Y84IciIrxRZMRF
         Hvv5lBoWNRmd8QrAdnAIDHD6a7X94ZuHLw/jBMsLFka75ypSxgwTlxlpCBXQFRO2Cm83
         orY1QyhuyzoYx9TO5QkXC+XytSNoOF7ylblJcTkK7ZuP7Iac4Nvc86jE+hC2MQ6Pt8hn
         2LyHxwQot2Dl30DsLrwG0PMDUaa9bbTNCZXsyxf7a9PmiCm12yntL8pBlPojwRPQsaW2
         BzIBFbDIQr24t93R55ckjcYtMl0+HBbasOAJbxW9EvWhsTTUDmi64JCmbPZJY1NgddmG
         K+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAXLPjGujT6Na6Fx5FR5OHTWfQ8Sl9PgNJoSP5Q6+xc=;
        b=ZNUmsS5ULPuzVertPF4z/32O4V3nF1Qv0Ma8XQ0sCCsG08RZZV0XUy1aTADMi2FXZf
         K5egiLCk+oGGT8dJO6KpUPYVHJ0uNNp74DTLABislJCiN/28rIPxNDdBtBefbpr6YoNu
         Fj0723gPHekgAJTxfpR4alDrCo4MpiLzQpvjIEro56WRF7Ha+L6rx3mfS1c/QU238WT2
         ZSEh9qJAogKobElzIDxdIZV067UwGqCEFq8PtfZ/fZLTs5q3JUSej0gtJfp7T9YrNLB1
         tHvCCVd7b37g/i2c0xy2oEVPezk25fmvUbpFl5FH/35ebmLBuxfKrpcyhxgTFSU2gD9F
         Qodw==
X-Gm-Message-State: APjAAAUMMtjhsFHF34gBVg+ziVbJDR0covcHUggbNeBvPzHyIYVM0g2A
        gTQIEvubdr9gSoG6HNjpvgw=
X-Google-Smtp-Source: APXvYqxkrhpvnm1+Dng/70zJcIW9K2MM2gw1EO0UPCJdz9N37i4W7kv8r08gScI0VwD7isomQn/Xjg==
X-Received: by 2002:a62:bd14:: with SMTP id a20mr33966214pff.107.1557162664209;
        Mon, 06 May 2019 10:11:04 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id h13sm11045680pgk.55.2019.05.06.10.10.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 06 May 2019 10:11:03 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v3 15/27] Documentation: x86: convert pti.txt to reST
Date:   Tue,  7 May 2019 01:09:11 +0800
Message-Id: <20190506170923.7117-16-changbin.du@gmail.com>
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

