Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C5AC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8544B20873
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifwIc5Jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfEMUZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:25:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39258 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfEMUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:25:47 -0400
Received: by mail-ed1-f66.google.com with SMTP id e24so19362054edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8cHvGiGICHWvlCnNFZkMnztAt4SRYlh07/8kyTvwxfI=;
        b=ifwIc5Jl9rpjlX3fhAIgxoVxIKu9jCrGdf3een5QIY1Xqo73tsIpJAYvFOijwLaxkL
         kAheog8s30qfF5jlrRapHuVCR2n+QuqW0WA8hXRG/zR5UHG+ykfa+8aknBYKkQC0qdxb
         HWQADKEP3ARn8iMOr6CnDiiAy8nxmw9KSh6w8IkSg1efZJNxgZErO2djBMSuRpJtBQUC
         6089pG1vH7QEJXD2fkErpQRPAcd3xKrXqZ+nthbQukgidqyAQmHPnvOwk01MBXE1fgqA
         tW3qrzl9fbmrFo2SjpwPIMpvIi5MJf1hA7fRWb5em4txLTIEHq5vwZGjVtN8bzxcE9MD
         v+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8cHvGiGICHWvlCnNFZkMnztAt4SRYlh07/8kyTvwxfI=;
        b=K1JzCHVrl26kvH/1Pm+4vZp8MLZ7fDzoLo/80CyQJbFeKsDPr1U3tF1kdtcmHLQoUB
         MeD/14DkGqZaWq07ckfs/zm4azqOhpXY4H4fPV/bCFOHrfWWW6RPyIX2KnyhgXgKS7wJ
         9HfEmf39N7vZ2RhVHD+7fAvP8B7VkMdaPMErIGkoU393VMA9r76EJGwylhD/O+5V0U7h
         u7/j+RLZmA8xYBZp3HExTpfAQQFhi05XFX0ydTGsSEDvzo9uTahqRVjI5EWF35f412pQ
         kGZQQZZDY7Npi9lMKuM/pjdCQK9aVwSSGpK/4PexlUPFSXcQVlzm+bsAK8hDnrG0/YlB
         9PNA==
X-Gm-Message-State: APjAAAXVz/qoY8U91FByb5yalvO9STrD8Ut0MqqR9L8Dey47O8AUeaAQ
        ZoWTsvrxW1dEJ1qtMH8K3e3hs7B/
X-Google-Smtp-Source: APXvYqzXibiukth/hujqJJOXRBf6/xOOtpttfR+325xvztSzuRGh5snE3FdJ73UBAg0wa6NYVmSI7A==
X-Received: by 2002:a17:906:4dc7:: with SMTP id f7mr17120783ejw.207.1557779145347;
        Mon, 13 May 2019 13:25:45 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id k37sm4036076edb.11.2019.05.13.13.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 13:25:44 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
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
        AND DEBUGGING), John Garry <john.garry@huawei.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Sean V Kelley <seanvk.dev@oregontracks.org>
Subject: [PATCH v2 3/3] perf vendor events arm64: Add Cortex-A57 and Cortex-A72 events
Date:   Mon, 13 May 2019 13:25:22 -0700
Message-Id: <20190513202522.9050-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190513202522.9050-1-f.fainelli@gmail.com>
References: <20190513202522.9050-1-f.fainelli@gmail.com>
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

Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
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
index 013155f1eb58..927fcddcb4aa 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -14,6 +14,8 @@
 #Family-model,Version,Filename,EventType
 0x00000000410fd030,v1,arm/cortex-a53,core
 0x00000000420f1000,v1,arm/cortex-a53,core
+0x00000000410fd070,v1,arm/cortex-a57-a72,core
+0x00000000410fd080,v1,arm/cortex-a57-a72,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
-- 
2.17.1

