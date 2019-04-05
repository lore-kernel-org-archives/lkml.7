Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134EAC282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAB3020989
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:51:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQYgA3YA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfDEQvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:51:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfDEQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:51:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id y6so3312408pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 09:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tK0KNzTVBhvFpZw5xzoPtB3t7K3FtWEaK2okedTFVcI=;
        b=ZQYgA3YAkRMhq5gzi3rbnI5lQzj85fNqXGEhJ8lyScqYXiR150zBgfqdG5Wq+NANNN
         C3DAeYOPxllm8Kg4pqJrp/UvIaT+B3JoV+IUdAMxBpfbA0lemV6CFwyhMNS3kIyB+88E
         VUAv2EvDV5GvFd4P/RiOqp8ECuHyjD7jlNuQjNx4q8GMIMjDo0kNOZmmDKFlFlfBwynl
         N1L6BLTN851J43TSZdNtdPNd+Hgs3Tp2Z3ak9GBMgpCqjDsbXLxaMUVMYTS5PB078Hzr
         w7+pNCOb9mA5c3/T6g1iR5V3mfrshHttbeJ2/kZM6t/bDjFr5dS+exhK4soB3+p7NvI2
         M4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tK0KNzTVBhvFpZw5xzoPtB3t7K3FtWEaK2okedTFVcI=;
        b=WFRaYftxM/gLX1/xxmYSXljwPUFDZdMRVRP0omAfjlEFW8O4MtL+WWgxg700Znnvb6
         3hOohV08f9YjMJvZqGw1QioCEUfbjQTYer8M+GaQAMoqbwC3z79hTmJ5F5PGwnyAPVD+
         bgwJbeaGYNpGlkukdbVmpLbCL0o7H3ZhjSNtMIH/h8hdMl51kdSXd28k9xX0HggJItd5
         4EQfvOyMRT+wlNOvLEzl9kRVX3cNxTYPrAyFZBuYzn0iZPPL+m2uI+JyoZD8U7zdDN62
         aQSTmPQLM0uYa6fYXcZQLVxt+fTPVLzp5oykZzT+/czQZFlHJ9LZfxbt7AXWRSWpGfi6
         mzUg==
X-Gm-Message-State: APjAAAVOn8hvg58IxIiAznva5bkEzj4jBmhRyhBCr/ZTMM/VlYa8F++U
        EVkHYSZ2rBk99PZsNphbovR61xOw
X-Google-Smtp-Source: APXvYqxTxI9Rttb1L5DWelq1xjgP2iJnHpxF8ljrPQLKuFLSaP23lm4m8pCvgceA8osyy5WT4kJjbw==
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr13373553plp.99.1554483065706;
        Fri, 05 Apr 2019 09:51:05 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x6sm1713012pfb.171.2019.04.05.09.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 09:51:04 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
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
Subject: [PATCH] perf vendor events arm64: Map Brahma-B53 CPUID to cortex-a53 events
Date:   Fri,  5 Apr 2019 09:50:47 -0700
Message-Id: <20190405165047.15847-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Broadcom's Brahma-B53 CPUs support the same type of events that the
Cortex-A53 supports, recognize its CPUID and map it to the cortex-a53
events.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 59cd8604b0bd..e97c12484bc6 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,6 +13,7 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
+0x00000000420f100[[:xdigit:]],v1,arm/cortex-a53,core
 0x00000000420f5160,v1,cavium/thunderx2,core
 0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
-- 
2.17.1

