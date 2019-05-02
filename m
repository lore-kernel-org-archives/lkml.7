Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41020C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0248E20652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 23:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwljnxSc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbfEBXrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 19:47:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45268 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfEBXrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 19:47:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so1898841pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 16:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QJQDgj2CvgU1Nk4JPrhowGXn7xmhLDQsiKE4NE6njlg=;
        b=VwljnxScs8kOqpppHNXPiElhbQ9nIObY2jpqSzvbY6suvhvVUndbVCd+QamdYwW/fT
         uxt+PQiibVuukhj+mp34DCraa44rJl5DDa9F/Q5d8QJ6hi8Gf+bocmytkayFMBjwwSU9
         xiEQ4+u3BGwaIqifI3waz4a0xf+6O9GcxjvXsAg9Tv5Qray0gBnErqLBB7l76e5KrDkb
         q6/PdYHy/1ddM9Ud11M+TqVRW1+l1BBdok3Ssvp5cTxF4gSdnFAJogbY4gX5KJCTvswv
         nmUkMcYFoBWwtVSuvZd6z+iKBToO/4N6QZtRkGaUspco2u9gnAJNRTPa7oZZQLIl8+1W
         B+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QJQDgj2CvgU1Nk4JPrhowGXn7xmhLDQsiKE4NE6njlg=;
        b=iPq04zEl2/9MugtKyfYN8GNhNaHIWB6nA6EQUyrPIouyBLxXHdYiLkhrNwc0/vHf5E
         926dFAvQJgjq8VO4Pdu30DCTpKN7SvNupX79WJQZZwoVymYmcRARZo4cmBT2awUwqWVZ
         dhQgf6iVUz0Gh60rRcxhR0EAasoBaLd+P/mJernJmiZgkGyWEpCPAs67otpWOVZVCrHU
         ckXq4iOwSkHBu+TaSzZSnV/rlXYy3zBADFr61UXTVGXODg/kgaiw6OcO7EcPZJHBFsfJ
         jWzMGgAkTN58l+tV9DaK+QR91fq67fg50+0ECdDpa6VKFgDyGC0r9Rqw0ZsmaEQld6n0
         NuyQ==
X-Gm-Message-State: APjAAAX+QheaUmTauYELfAyiCXse6iMwJIQcYc0ZCL5o1U1OHQBSu7bM
        8hUKGWgrzxM3+HyM1ukO+QeM1EBs
X-Google-Smtp-Source: APXvYqxtfs5PqXcQ8hwoNurV+HvU9aZnW2Qco08IqlP+iQbzW/XMYmtkwHpFHmQRuCWqal2TnAr+xQ==
X-Received: by 2002:a63:fb56:: with SMTP id w22mr6619408pgj.354.1556840843238;
        Thu, 02 May 2019 16:47:23 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id n15sm374798pfb.111.2019.05.02.16.47.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 16:47:21 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PMU PROFILING
        AND DEBUGGING)
Subject: [PATCH v2] perf vendor events arm64: Add Cortex-A57 and Cortex-A72 events
Date:   Thu,  2 May 2019 16:47:04 -0700
Message-Id: <20190502234704.7663-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cortex-A57 and Cortex-A72 both support all ARMv8 recommended events
up to the RC_ST_SPEC (0x91) event with the exception of:

- L1D_CACHE_REFILL_INNER (0x44)
- L1D_CACHE_REFILL_OUTER (0x45)
- L1D_TLB_RD (0x4E)
- L1D_TLB_WR (0x4F)
- L2D_TLB_REFILL_RD (0x5C)
- L2D_TLB_REFILL_WR (0x5D)
- L2D_TLB_RD (0x5E)
- L2D_TLB_WR (0x5F)
- STREX_SPEC (0x6F)

Create an appropriate JSON file for mapping those events and update the
mapfile.csv for matching the Cortex-A57 and Cortex-A72 MIDR to that
file.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Changes in v2:

- added a shared directory for both Cortex-A57 and A72 (Will)
- removed unsupported ARMv8 v3 events (John)

 .../arm/cortex-a57-a72/core-imp-def.json      | 179 ++++++++++++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
 2 files changed, 181 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json

diff --git a/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
new file mode 100644
index 000000000000..0ac9b7927450
--- /dev/null
+++ b/tools/perf/pmu-events/arch/arm64/arm/cortex-a57-a72/core-imp-def.json
@@ -0,0 +1,179 @@
+[
+    {
+        "ArchStdEvent": "L1D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L1D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L2D_CACHE_INVAL",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_RD",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_WR",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_SHARED",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NOT_SHARED",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_NORMAL",
+    },
+    {
+        "ArchStdEvent": "BUS_ACCESS_PERIPH",
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+    },
+    {
+        "ArchStdEvent": "LDREX_SPEC",
+    },
+    {
+        "ArchStdEvent": "STREX_PASS_SPEC",
+    },
+    {
+        "ArchStdEvent": "STREX_FAIL_SPEC",
+    },
+    {
+        "ArchStdEvent": "LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "LDST_SPEC",
+    },
+    {
+        "ArchStdEvent": "DP_SPEC",
+    },
+    {
+        "ArchStdEvent": "ASE_SPEC",
+    },
+    {
+        "ArchStdEvent": "VFP_SPEC",
+    },
+    {
+        "ArchStdEvent": "PC_WRITE_SPEC",
+    },
+    {
+        "ArchStdEvent": "CRYPTO_SPEC",
+    },
+    {
+        "ArchStdEvent": "BR_IMMED_SPEC",
+    },
+    {
+        "ArchStdEvent": "BR_RETURN_SPEC",
+    },
+    {
+        "ArchStdEvent": "BR_INDIRECT_SPEC",
+    },
+    {
+        "ArchStdEvent": "ISB_SPEC",
+    },
+    {
+        "ArchStdEvent": "DSB_SPEC",
+    },
+    {
+        "ArchStdEvent": "DMB_SPEC",
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+    },
+    {
+        "ArchStdEvent": "RC_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "RC_ST_SPEC",
+    },
+]
diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 59cd8604b0bd..69a73957e35c 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,6 +13,8 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
+0x00000000411fd07[[:xdigit:]],v1,arm/cortex-a57-a72,core
+0x00000000410fd08[[:xdigit:]],v1,arm/cortex-a57-a72,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
-- 
2.17.1

