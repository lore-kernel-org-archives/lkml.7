Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEB0C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C615A21901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUZxXuMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403858AbfDXR4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:56:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38912 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389582AbfDXR4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:56:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id i17so9692502pfo.6;
        Wed, 24 Apr 2019 10:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0U3DN21jJSHjryo32FyL3BVOe7dtJ75E6Tjlu2mOfww=;
        b=nUZxXuMHmHZjTQe7hXTfvhdb6ZxSf4CDP9pLxD2VyjX1+Ci95iAR6w4C5zKJ9QFXco
         fw4zxblIgzZjSY+Aq/PY2bd9axwQcCCgAZj2fLB7mKS7L5DXbxQ66Ok47p8qhUObY6VN
         JKG5YshwCAWFmhAaCH27cfw3rEBBAVQdtSCNliWDvnWxkImR6mmtR6afo1NIu7b5ArbG
         wkJ4NuWTJiD/2lGGcA03tEazAgNa3Zd1UN38HJRwRMkwNUFDQ+CR0tAQPzi1XjyIAlAd
         pgQeUWuiRue7c77EfrPqKT3bMDbuL5P7SN1OH3IGYNnC5HlMr6VHVTTL2tMnrikIrXA1
         f1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0U3DN21jJSHjryo32FyL3BVOe7dtJ75E6Tjlu2mOfww=;
        b=VpKUH8by1O9jQfOpWIFDBJI406D8SLAgLQ8OlEu5jIe82Zt7jrzbVUVQhrdwU0UVDr
         EwO5RurqTb2ucq14BvIrXVRxoesuoFrKOrb2W9gLCfvWPPJEnjuVFsbC858XDGqyfkfw
         3FlGVbxCWQ+6a3ZB1vW26AUsMe+979b7S3BH5et/slLB9X6Nfd0elw51qGopaxVFe244
         lLtcLhheHuBKTjVDoLw+RWVJ4WZvCjYoUq98rJdl8v9vrLgQAP6LRajjyK/iQvIiGehu
         lxEpHH1OUAOeP8oetJR3fyxGd0y/LDXMqEBGqvd52NmiEWMuPbSrQ4QQzjIWgb1NYwCH
         VUtg==
X-Gm-Message-State: APjAAAVF7uHWZyUdcv5RJPpQHFaH4e745nG9JuO2yaJgndjRiYFAh058
        Kc/yw9GgEvdV0b2vrD7DQxQ=
X-Google-Smtp-Source: APXvYqzUKdtoZrrcHYf0m3S+m3GOQIyalLZXRUiP86e3g6c/QnoG4upYiUZoi+K8ppKg6A8GFvSsJg==
X-Received: by 2002:a62:6444:: with SMTP id y65mr35093192pfb.56.1556128592689;
        Wed, 24 Apr 2019 10:56:32 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id 6sm29275630pfp.143.2019.04.24.10.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:56:31 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v5 20/23] Documentation: ACPI: move cppc_sysfs.txt to admin-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 01:53:03 +0800
Message-Id: <20190424175306.25880-21-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190424175306.25880-1-changbin.du@gmail.com>
References: <20190424175306.25880-1-changbin.du@gmail.com>
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
 .../acpi/cppc_sysfs.rst}                      | 71 ++++++++++---------
 Documentation/admin-guide/acpi/index.rst      |  1 +
 2 files changed, 40 insertions(+), 32 deletions(-)
 rename Documentation/{acpi/cppc_sysfs.txt => admin-guide/acpi/cppc_sysfs.rst} (51%)

diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/admin-guide/acpi/cppc_sysfs.rst
similarity index 51%
rename from Documentation/acpi/cppc_sysfs.txt
rename to Documentation/admin-guide/acpi/cppc_sysfs.rst
index f20fb445135d..a4b99afbe331 100644
--- a/Documentation/acpi/cppc_sysfs.txt
+++ b/Documentation/admin-guide/acpi/cppc_sysfs.rst
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
diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
index d68e9914c5ff..9049a7b9f065 100644
--- a/Documentation/admin-guide/acpi/index.rst
+++ b/Documentation/admin-guide/acpi/index.rst
@@ -10,3 +10,4 @@ the Linux ACPI support.
 
    initrd_table_override
    dsdt-override
+   cppc_sysfs
-- 
2.20.1

