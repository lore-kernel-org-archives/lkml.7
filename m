Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A05BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F98821871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvvJafig"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfC2ANx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:13:53 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41486 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfC2ANu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:13:50 -0400
Received: by mail-pl1-f195.google.com with SMTP id y5so124613plk.8;
        Thu, 28 Mar 2019 17:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T6kgspEF8PIDceQ0jPnCRK8GVIOE4U8rFsAvya7rp2A=;
        b=gvvJafigcbzfn/tMIGeKvHBD26DTOfKPZlNBSc6Z8e/rbpDYHJvXYyWrwNflE296V9
         2TjOzk0OiphYxOkRKDLOsoEtxM/3JtAYLsqeq2OVdoJjifeWRga/x3DRzrllxubtWSr9
         UbsOwPplz0e7L8mepKJla7PnxExFBSsYxkUP7ebVPah1//e4viPl/H71/wFvD44sH5EM
         /c69NVy142oNkIlxY604z4FLsVfHwF15ZdMwMIv9xMsVCD/1sqo9pg714uu9kNq3wjSb
         XB4tNbYSTHTj9Z4zhwQ5/f6olFaYjH2O3h5OvXaVRD8lQoA5MGx1Fr7/qMzU+qoIMrcE
         Lehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T6kgspEF8PIDceQ0jPnCRK8GVIOE4U8rFsAvya7rp2A=;
        b=rlEzlBAmf5lu8U5Ik+hSompq+r+C6JpMPkhffJUstWePnGbOWxNbxMXI/l7VptQQ9F
         d6exUWpCeecydH4f3fAc6Bs3bn8Ks/H3hJikp4hzhrPpVAuCNWVJKal4k0t6gBOq52DE
         pRi7iCNxxhgvEGKONUfiO4gNQVLRXdV4IVjUj65ikaz3o5Kd15OEVYT7UrSXr1w+/OMx
         mqkh3FVzIWDCP37xitsOijXVOcNJMCUcDNZvciBXWPZXi58+ErZApcuiOchDUC2XsQD8
         Fbsqgp20+xn5PinKEZV5eBT//aanxjX/rPnRYq2Kdf2gsI3nCyRGpIWi3p5VhQWXifKo
         triw==
X-Gm-Message-State: APjAAAUw2krjIxCofOZPf8Li18Byl37yQ4xBpK2zV6O0K5HSHvXzqoa/
        /ELsZRHuP3LeHTs9kgMDkLk=
X-Google-Smtp-Source: APXvYqzSZg878DZzn0IbG6uY8syDV5uboNQPZB3oquFXXdARsGXl/tMgaYuWsWRJMLgXKjKYWd0bqA==
X-Received: by 2002:a17:902:361:: with SMTP id 88mr46376076pld.78.1553818429904;
        Thu, 28 Mar 2019 17:13:49 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id f125sm432488pfc.91.2019.03.28.17.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 17:13:49 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 21/24] acpi doc: convert acpi/cppc_sysfs.txt to rst format
Date:   Fri, 29 Mar 2019 08:11:32 +0800
Message-Id: <20190329001135.15847-22-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190329001135.15847-1-changbin.du@gmail.com>
References: <20190329001135.15847-1-changbin.du@gmail.com>
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
 .../acpi/{cppc_sysfs.txt => cppc_sysfs.rst}   | 71 ++++++++++---------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 40 insertions(+), 32 deletions(-)
 rename Documentation/acpi/{cppc_sysfs.txt => cppc_sysfs.rst} (51%)

diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/acpi/cppc_sysfs.rst
similarity index 51%
rename from Documentation/acpi/cppc_sysfs.txt
rename to Documentation/acpi/cppc_sysfs.rst
index f20fb445135d..a4b99afbe331 100644
--- a/Documentation/acpi/cppc_sysfs.txt
+++ b/Documentation/acpi/cppc_sysfs.rst
@@ -1,5 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-	Collaborative Processor Performance Control (CPPC)
+==================================================
+Collaborative Processor Performance Control (CPPC)
+==================================================
+
+CPPC
+====
 
 CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
 performance of a logical processor on a contigious and abstract performance
@@ -10,31 +16,28 @@ For more details on CPPC please refer to the ACPI specification at:
 
 http://uefi.org/specifications
 
-Some of the CPPC registers are exposed via sysfs under:
-
-/sys/devices/system/cpu/cpuX/acpi_cppc/
-
-for each cpu X
+Some of the CPPC registers are exposed via sysfs under::
 
---------------------------------------------------------------------------------
+  /sys/devices/system/cpu/cpuX/acpi_cppc/
 
-$ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
-/sys/devices/system/cpu/cpu0/acpi_cppc/:
-total 0
--r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
--r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
--r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
--r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
+for each cpu X::
 
---------------------------------------------------------------------------------
+  $ ls -lR  /sys/devices/system/cpu/cpu0/acpi_cppc/
+  /sys/devices/system/cpu/cpu0/acpi_cppc/:
+  total 0
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 highest_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_freq
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_nonlinear_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 lowest_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_freq
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 nominal_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 reference_perf
+  -r--r--r-- 1 root root 65536 Mar  5 19:38 wraparound_time
 
 * highest_perf : Highest performance of this processor (abstract scale).
-* nominal_perf : Highest sustained performance of this processor (abstract scale).
+* nominal_perf : Highest sustained performance of this processor
+  (abstract scale).
 * lowest_nonlinear_perf : Lowest performance of this processor with nonlinear
   power savings (abstract scale).
 * lowest_perf : Lowest performance of this processor (abstract scale).
@@ -48,22 +51,26 @@ total 0
 * feedback_ctrs : Includes both Reference and delivered performance counter.
   Reference counter ticks up proportional to processor's reference performance.
   Delivered counter ticks up proportional to processor's delivered performance.
-* wraparound_time: Minimum time for the feedback counters to wraparound (seconds).
+* wraparound_time: Minimum time for the feedback counters to wraparound
+  (seconds).
 * reference_perf : Performance level at which reference performance counter
   accumulates (abstract scale).
 
---------------------------------------------------------------------------------
 
-		Computing Average Delivered Performance
+Computing Average Delivered Performance
+=======================================
+
+Below describes the steps to compute the average performance delivered by
+taking two different snapshots of feedback counters at time T1 and T2.
+
+  T1: Read feedback_ctrs as fbc_t1
+      Wait or run some workload
 
-Below describes the steps to compute the average performance delivered by taking
-two different snapshots of feedback counters at time T1 and T2.
+  T2: Read feedback_ctrs as fbc_t2
 
-T1: Read feedback_ctrs as fbc_t1
-    Wait or run some workload
-T2: Read feedback_ctrs as fbc_t2
+::
 
-delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
-reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
+  delivered_counter_delta = fbc_t2[del] - fbc_t1[del]
+  reference_counter_delta = fbc_t2[ref] - fbc_t1[ref]
 
-delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
+  delivered_perf = (refernce_perf x delivered_counter_delta) / reference_counter_delta
diff --git a/Documentation/acpi/index.rst b/Documentation/acpi/index.rst
index bdd82615fef6..91aeed814ea9 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -26,3 +26,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    aml-debugger
    apei/output_format
    apei/einj
+   cppc_sysfs
-- 
2.20.1

