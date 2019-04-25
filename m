Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371B8C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AD8206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqkAHy3q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730304AbfDYPdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:33:42 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43138 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfDYPdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:33:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id n8so11269336plp.10;
        Thu, 25 Apr 2019 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0U3DN21jJSHjryo32FyL3BVOe7dtJ75E6Tjlu2mOfww=;
        b=qqkAHy3qqfSAFBFz92IC52pWFnSIUoOnNwhcSJVlhgTyaZkxF7GhYcWIDHdiYcNsfM
         9d3dMTrX4++p9jNFObtVmqJUCbbqPE3WnChz1oBbtMJvW7962ETZG7HG/QWTWPvA77Vl
         B96YxyBXV8v6pd8KLFq/KVei4dTgOdH7D0MHQOWZ+IoZz/hyuwRmKoMe/CfsimhQk6G8
         NmqrzWTqQoh9hjWJhOKgtvDhMAj2SwkY5v55D8Yk6mVTWl7RHf+DAEcPw/kytJvwovM3
         Oj5UI3HpBhB2AYh7dHj8A5pK/cdmZoCGiDvGDmI0PImQkWz358MrR09U7i3mwA+1T9Xq
         5cJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0U3DN21jJSHjryo32FyL3BVOe7dtJ75E6Tjlu2mOfww=;
        b=ofP0KcW4O9uE+CYv2R7jfmmxurlIkioGlimgwmF6GOuVoaIWsnMwikveMyF6sva/fl
         a99IPcQR/a9vhz5Qy9Ja0yRxBxueTQu8kk77hHJa9V8vzqq8QvS8eX8n/8MWYeVYtrcH
         /mwphXo9y1DjMnnRWaCUa/w7TEJZFeb3nTmU1zYXH8qFfRkGvBNBdsMAx1/sfpHxhuKp
         ojGuFWIJ+Crm5yr8GMVVp3SOJhYEb5nqefMxmBfmE0tDPkQEB5QQIfsoqvOlIQZbCnG0
         gh1m5twT+nBmdjo4vp+0fqfMXtz9HytyUrFHxUq/tn0uefRinzsQ7dP2pSn0HFk1WwxP
         piUA==
X-Gm-Message-State: APjAAAWQLmTxtrvDxXyBpT/s/6Nv2k9M1j6dgeLUgutbe0LLpzRhW/B3
        bJxqxGPb9fOI5oAjsYZRYvA=
X-Google-Smtp-Source: APXvYqzi00q2dqHNPbmod0vP3ihHgKlboHkHO/woa6rLQB6YgrpOuAj2RovkltDSUbDAaep9sWFp1Q==
X-Received: by 2002:a17:902:525:: with SMTP id 34mr40408528plf.138.1556206418963;
        Thu, 25 Apr 2019 08:33:38 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id c14sm2643363pgj.94.2019.04.25.08.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 08:33:38 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     rjw@rjwysocki.net, Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v6 21/24] Documentation: ACPI: move cppc_sysfs.txt to admin-guide/acpi and convert to reST
Date:   Thu, 25 Apr 2019 23:31:14 +0800
Message-Id: <20190425153117.16057-22-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190425153117.16057-1-changbin.du@gmail.com>
References: <20190425153117.16057-1-changbin.du@gmail.com>
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

