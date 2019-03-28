Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF84DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B678B2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 16:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gqo+vYhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfC1QaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 12:30:15 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45136 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727565AbfC1QaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 12:30:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id y3so11841319pgk.12;
        Thu, 28 Mar 2019 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CFZdYyIHhQ00FS4s+O0taLbzNPyzTG7Y3/SaqUe4LOg=;
        b=Gqo+vYhRyAoZ8ibwcJ0QfuhV+qixgo7vOAzh6bcoQdkinVC+GPaij/MCwSFWPCKIbq
         j46VAVtUgrRANndEt4IC62nnWDUlyw6VFkNdRz3MlQI6CBPP457bqJjDrAtd1bULf2yX
         E9jJHQESsGTCj7hwWu3mqxgHyHkJ4jW3TwFvEcMc3JIucS+rbWCFpt51X4z47Hkt05ig
         nfU2bN4xy+GQFwUC2HmepY/OQG5U4eW1ggskpIwCN+xCCF77j+SE9mEk1r7fBX7+l7wc
         hJr/Z00mdVEitqD0xlBbwXbS1j5m3yOxc0KJr1kSHGwUtf0rqVy/+dy/XSQ034k3AN2W
         6sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CFZdYyIHhQ00FS4s+O0taLbzNPyzTG7Y3/SaqUe4LOg=;
        b=BXy6MKTBozCHBUKGzfUSL0LZUA54BQRcMy7kcJyKU25mpf3acfYaON0hv0NSsjASt9
         bZ+dX7nXRHTZn7/InxwNtwWxDWphOtjbqT5aGUXbF2FqC224BatxmHJu4fQq4d3XS4yH
         qP3F1CXN/UpWed4ws7BHxuYQp9eTX81WbI9FSav05mitEGpmFaT9e3cwu+oZyN8TubcC
         5KXo7esDN+C7hqNQGJBYWc1dY/y4yghb4Mswd+jjQcLBY372cdQ4pjWl4mAqEBUrQevW
         EOiPfMMljzmAWxcvTjMH7/IMkvgETfAb+s9W0qavBiDEz988lF2Czz3Xvk4iOjrv0q1e
         sBPg==
X-Gm-Message-State: APjAAAU9I5XqNBy32US5z1nSotAn3RUFktiAiRpEfVoKclpgZZSzUip9
        Bf2SXIcYQMYe/2LnIbJj3TU=
X-Google-Smtp-Source: APXvYqwmhPP4Th/ouoogYOvam8y6mslT3kM0skhaxLtY7AAhLbIzTgpIF/3FFlky01RN7NLfI3IlHw==
X-Received: by 2002:a63:1ce:: with SMTP id 197mr40835490pgb.47.1553790612754;
        Thu, 28 Mar 2019 09:30:12 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y12sm42748885pgq.64.2019.03.28.09.30.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 09:30:11 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 20/23] acpi doc: convert acpi/cppc_sysfs.txt to rst format
Date:   Fri, 29 Mar 2019 00:27:18 +0800
Message-Id: <20190328162721.26138-21-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190328162721.26138-1-changbin.du@gmail.com>
References: <20190328162721.26138-1-changbin.du@gmail.com>
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
 .../acpi/{cppc_sysfs.txt => cppc_sysfs.rst}   | 69 ++++++++++---------
 Documentation/acpi/index.rst                  |  1 +
 2 files changed, 38 insertions(+), 32 deletions(-)
 rename Documentation/acpi/{cppc_sysfs.txt => cppc_sysfs.rst} (51%)

diff --git a/Documentation/acpi/cppc_sysfs.txt b/Documentation/acpi/cppc_sysfs.rst
similarity index 51%
rename from Documentation/acpi/cppc_sysfs.txt
rename to Documentation/acpi/cppc_sysfs.rst
index f20fb445135d..e8a13d6e7a6c 100644
--- a/Documentation/acpi/cppc_sysfs.txt
+++ b/Documentation/acpi/cppc_sysfs.rst
@@ -1,5 +1,9 @@
+==================================================
+Collaborative Processor Performance Control (CPPC)
+==================================================
 
-	Collaborative Processor Performance Control (CPPC)
+CPPC
+====
 
 CPPC defined in the ACPI spec describes a mechanism for the OS to manage the
 performance of a logical processor on a contigious and abstract performance
@@ -10,31 +14,28 @@ For more details on CPPC please refer to the ACPI specification at:
 
 http://uefi.org/specifications
 
-Some of the CPPC registers are exposed via sysfs under:
+Some of the CPPC registers are exposed via sysfs under::
 
-/sys/devices/system/cpu/cpuX/acpi_cppc/
+  /sys/devices/system/cpu/cpuX/acpi_cppc/
 
-for each cpu X
+for each cpu X::
 
---------------------------------------------------------------------------------
-
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
-
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
@@ -48,22 +49,26 @@ total 0
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
index 431edc664135..f59e6ddb0f99 100644
--- a/Documentation/acpi/index.rst
+++ b/Documentation/acpi/index.rst
@@ -24,3 +24,4 @@ Linux ACPI (Advanced Configuration and Power Interface)
    aml-debugger
    apei/output_format
    apei/einj
+   cppc_sysfs
-- 
2.20.1

