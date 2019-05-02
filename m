Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A42C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBC72085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xj9wvu/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfEBHLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:11:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34103 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfEBHLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:11:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck18so615785plb.1;
        Thu, 02 May 2019 00:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAXLPjGujT6Na6Fx5FR5OHTWfQ8Sl9PgNJoSP5Q6+xc=;
        b=Xj9wvu/sdmDisAwYpAw4EuInNNPgHsMvheqhZ7h7EyF1oIPFs2yhJuDenCQk43p2E3
         7+9mpBVgOvDcTHSdah4n1VyVchpnDO9rllSQOc5sy4AH4LWgAZcZ0gtTiyh0bsv72waz
         T2R8ebYk3pjZl3rC9smphDAdNCXBoK4rpU19KWUhD6XskZHIW/b7TO+Dw859ZOYMQLVf
         fOGMP1+0XiXcLZK1fvBWgHsbxmOM+A98SlbeyuNW2/1BfxNnjRfm3qjbsyfLCc2Sz5bo
         dZZUSseyukMet3pMxdLa48BtCC/sh4eFtFk9fkDkocNORxyB8AU8YVtpUH89RDJuhrah
         VJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAXLPjGujT6Na6Fx5FR5OHTWfQ8Sl9PgNJoSP5Q6+xc=;
        b=mEtOIZdneFnOsbsMQGBPO2V5GTc/bhxxZB7BSOKAQq0uiLplvi8ltne/vw3DLyZYda
         zE5jvWdgnYht6NfOp0OL4s42CFwA9115Rq+LoDbUJ+CUaVEf6dCDsxPaPgaLrkxvcOOY
         DqjKk0ZAcSwy7mP3zTCSJhdYfJpl+L55uS061+Pk7/heSKZvdApvxTRXUNvW9Ge9JpCA
         tRP07mS/GKeBPuBO2H/wGQ+zWaLSCJXVKA9219vT6c+jmwYd2PZPqcqlIMScLP1CaYBl
         sBbp3wJR7OaPFrwAv/p1LN1IQxjz4rPxlWtFXYnACBA8TLCsE5ZoNunKI+pCNyHBoGOz
         bePQ==
X-Gm-Message-State: APjAAAV4U7haovC/tUEemtQmpYrVDtz4PxTogTO/2h22Fn0wtG4i71jt
        6uj98sbdIKJvnADkDmj4+tY=
X-Google-Smtp-Source: APXvYqwPNCQsCbtTSoHyxqNT14LxxzcG3AvGIeO9s+YSeRcA4tV0FzxIZawLlLKspiovWONtIu6qrA==
X-Received: by 2002:a17:902:324:: with SMTP id 33mr2108195pld.246.1556781062321;
        Thu, 02 May 2019 00:11:02 -0700 (PDT)
Received: from laptop.DHCP ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id u24sm4686976pfh.91.2019.05.02.00.10.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 00:11:01 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH v2 15/27] Documentation: x86: convert pti.txt to reST
Date:   Thu,  2 May 2019 15:06:21 +0800
Message-Id: <20190502070633.9809-16-changbin.du@gmail.com>
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

